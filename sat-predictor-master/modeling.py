from itertools import product
from pathlib import Path
import pickle
from catboost import CatBoostClassifier, Pool
import numpy as np
import pandas as pd
from sklearn.metrics import auc, classification_report, roc_curve
from IPython import embed
from config import experiments, random_seed
from utils import colloc, flatten
from tqdm import tqdm
import json
from sklearn.utils.class_weight import compute_class_weight

pd.DataFrame.colloc = colloc

DEBUG = True


def compute_metrics(y_true, y_score, y_pred, pos_label):
    d = flatten(classification_report(y_true, y_pred, output_dict=True))
    fpr, tpr, thresholds = roc_curve(y_true, y_score, pos_label=pos_label)
    roc_auc = auc(fpr, tpr)
    d["roc_auc"] = roc_auc
    d["fpr"] = fpr
    d["tpr"] = tpr
    d["thresholds"] = thresholds
    return d


def train(X_train,
          y_train,
          cat_features,
          select_features=None,
          class_weights=None):
    if DEBUG:
        print("Training")
    
    # Modifica los pesos de las clases
    if isinstance(class_weights, dict):
        print("Using Class Weights", class_weights)
    elif class_weights is not None:
        classes = np.unique(y_train)
        weights = compute_class_weight(class_weight='balanced',
                                       classes=classes,
                                       y=y_train)
        class_weights = dict(zip(classes, weights))
        print("Using Class Weights", class_weights)

    else:
        class_weights = None

    model = CatBoostClassifier(random_seed=random_seed,
                               class_weights=class_weights)
    if select_features is None:
        model.fit(X_train, y_train, cat_features, logging_level="Silent")
    else:
        selection_result = model.select_features(
            Pool(X_train, y_train, cat_features=cat_features),
            features_for_select=X_train.columns,
            num_features_to_select=select_features,
            logging_level="Silent",
            train_final_model=True,
        )
        print(selection_result)
    return model


def evaluate(model,
             X_train,
             y_train,
             X_test,
             y_test,
             test_separate_rows_by=None):
    if DEBUG:
        print("Evaluate")
    classes = model.classes_
    sets = {"train": (X_train, y_train), "test": (X_test, y_test)}
    if test_separate_rows_by is not None:
        for field in test_separate_rows_by:
            for k, ixs in X_test.groupby(field).indices.items():
                sets[f"test_{field}_" + str(k)] = (X_test.iloc[ixs],
                                                   y_test.iloc[ixs])

    results = []
    for k, g in sets.items():
        print("Eval set", k)
        X, y = g
        y_proba = model.predict_proba(X)
        y_score = model.predict(X, prediction_type="RawFormulaVal")
        y_pred = classes[y_proba.argmax(1)]
        if DEBUG:
            print("Metrics")
        metrics = compute_metrics(y, y_proba[:, 1], y_pred, classes[1])
        results.append({
            "probs":
            pd.concat(
                [pd.DataFrame(y_proba, y.index, columns=model.classes_), pd.DataFrame(y_score, y.index, columns=["score"]), y],
                axis=1),
            "classes":
            classes,
            "metrics":
            metrics,
            "eval_set":
            k,
        })
    return results


def split_train(X,
                y,
                partitions,
                xval=None,
                train_parts=None,
                test_parts=None,
                categorical_features=None,
                select_features=None,
                train_separate_rows_by=None,
                test_separate_rows_by=None,
                class_weights=None):

    test_train_iterations = []
    if xval is not None:
        for test in xval:
            test_train_iterations.append({
                "train": [t for t in xval if t != test],
                "test": [test]
            })

    elif train_parts is not None and test_parts is not None:
        test_train_iterations.append({
            "train": train_parts,
            "test": test_parts
        })
    else:
        raise ValueError("No valid partition, xval or train/test")

    results = []
    models = []

    print("Test Train iterations:", test_train_iterations)
 
    file = Path(partitions)
    #escribir que cree las particiones
    with open(file, "rb") as f:
        partitions = pickle.load(f)

    for tt in test_train_iterations:
        print('Train Test Iteration', tt)
        ix_train = sum([partitions[t] for t in tt["train"]], [])
        ix_test = sum([partitions[t] for t in tt["test"]], [])

        # esto es mejorable
        mask_train = pd.MultiIndex.from_tuples([
            (idx[0], idx[1]) for idx in X.index
        ]).isin(ix_train)
        mask_tests = pd.MultiIndex.from_tuples([
            (idx[0], idx[1]) for idx in X.index
        ]).isin(ix_test)

        X_train, X_test, y_train, y_test = (
            X[mask_train].copy(),
            X[mask_tests].copy(),
            y[mask_train].copy(),
            y[mask_tests].copy(),
        )

        if DEBUG:
            print("Filas train:", len(X_train), "Filas val:", len(X_test))
            print("Class unbalance Train")
            print(y_train.value_counts() / len(y_train) * 100)
            print("Class unbalance Val")
            print(y_test.value_counts() / len(y_test) * 100)

        sets = {}

        if train_separate_rows_by is not None:
            for k, ixs in X_train.groupby(
                    train_separate_rows_by).indices.items():
                sets[k] = (X_train.iloc[ixs], y_train.iloc[ixs])

        if len(sets.keys()) > 1 or len(sets.keys()) == 0:
            sets["all"] = (X_train, y_train)
        print(f"sets: {sets}")

        for k, g in sets.items():
            print("Train set", k)
            X_, y_ = g
            model = train(X_,
                          y_,
                          cat_features=categorical_features,
                          select_features=select_features,
                          class_weights=class_weights)

            feature_importance = (pd.DataFrame(
                model.get_feature_importance(),
                index=X_train.columns,
                columns=["feature_importance"],
            ).sort_values("feature_importance").to_dict()["feature_importance"]
                                  )

            results_ = evaluate(
                model,
                X_,
                y_,
                X_test,
                y_test,
                test_separate_rows_by=test_separate_rows_by,
            )
        
            for r in results_:
                r["train_set"] = k
                r["train_folds"] = tt["train"]
                r["test_folds"] = tt["test"]
                r["feature_importance"] = feature_importance
                r["test_train"] = tt
            print(f"resultado: {results_}")
        
            results.append(results_)
         
            models.append({
                "model": model,
                "train_set": k,
                "train_folds": tt["train"],
            })
    return results, models



def run_experiment(df, experiment):

    if DEBUG:
        print("\nExperiment:", experiment["name"])
    numerical_columns = experiment["numerical_columns"]
    categorical_columns = experiment["categorical_columns"]

    if "nivel_educativo" not in categorical_columns:
        df = df.set_index(["nivel_educativo"], append=True)

    xval = experiment.get("xval")
    train_parts = experiment.get("train")
    test_parts = experiment.get("test")
    partitions = experiment.get("partitions")
    class_weights = experiment.get("class_weights")

    test_separate_rows_by = experiment.get("test_separate_rows_by")
    if test_separate_rows_by is not None:
        if not isinstance(test_separate_rows_by, (list, tuple)):
            test_separate_rows_by = [test_separate_rows_by]

    df.loc[:, categorical_columns] = df.loc[:,
                                            categorical_columns].fillna("NA")

    print("Categorical:", categorical_columns)
    print("Numeric:", numerical_columns)

    if experiment.get("remove_nan_numeric"):
        df = df[~df[numerical_columns].isna().any(1)]
        print("Remove entries with with NaN in numeric columns")
        print("Filas:", len(df))

    if experiment.get("remove_from_cols"):
        for col, data in experiment["remove_from_cols"].items():
            df = df[~df[col].isin(data)]
            print(f"Remove entries with {data} from {col}")
        print("Filas:", len(df))

    categorical_features = list(range(len(categorical_columns)))

    cols = categorical_columns + numerical_columns

    X = df[cols]
    y = df["status"]

    results = []

    if experiment.get("shuffle_labels"):
        y_tmp = y.sample(frac=1.0)
        y_tmp.index = y.index
        results += split_train(
            X,
            y_tmp,
            partitions=partitions,
            xval=xval,
            train_parts=train_parts,
            test_parts=test_parts,
            categorical_features=categorical_features,
            train_separate_rows_by=experiment.get("train_separate_rows_by"),
            test_separate_rows_by=test_separate_rows_by,
            class_weights=class_weights,
        )
        for r in results:
            r["shuffle_labels"] = True

    results_, models = split_train(
        X,
        y,
        categorical_features=categorical_features,
        select_features=experiment.get("select_features"),
        partitions=partitions,
        xval=xval,
        train_parts=train_parts,
        test_parts=test_parts,
        train_separate_rows_by=experiment.get("train_separate_rows_by"),
        test_separate_rows_by=test_separate_rows_by,
        class_weights=class_weights,
    )

    results += results_

    if experiment.get("shuffle_labels"):
        for r in results:
            if not "shuffle_labels" in r:
                r["shuffle_labels"] = False

    #for r in results:
    #    r["name"] = experiment["name"]

    outpath = Path(f"model_results/{experiment['name']}.pkl")
    if not outpath.parent.exists():
        outpath.parent.mkdir(exist_ok=True)

    with open(outpath, "wb") as fp:
        pickle.dump(results, fp)

    outpath = Path(f"model_checkpoints/{experiment['name']}_cols.json")
    if not outpath.parent.exists():
        outpath.parent.mkdir(exist_ok=True)

    with open(outpath, "w", encoding="utf8") as fp:
        json.dump(
            {
                "categorical_columns": categorical_columns,
                "numerical_columns": numerical_columns,
            },
            fp,
            ensure_ascii=False,
        )

    with open(f"model_checkpoints/{experiment['name']}.data", "w") as fp:
        for i, model in enumerate(models):
            model["model"].save_model(
                f"model_checkpoints/{experiment['name']}_{i}.catboost")
            fp.write(
                f"{i}, train_set: {model['train_set']}, train_folds: {model['train_folds']}\n"
            )


def main(args):

    for experiment in experiments:
        print(f"Usando años {experiment['años']}")

        nominal_path = experiment.get('nominal_path')
        if nominal_path is not None:
            df_nom = pd.read_csv(nominal_path, index_col=[0, 1])
            df_nom = df_nom[df_nom.index.get_level_values(0).isin(
                experiment["años"])].copy()
            print("Nom ids", len(df_nom.index.get_level_values(1).unique()))
        else:
            raise Exception('Nominal path no declarado')

        df_nom = df_nom[df_nom.index.get_level_values(0).isin(
            experiment["años"])].copy()
        ids_nom = df_nom.index.get_level_values(1).unique()

        inasistencias_path = experiment.get('inasistencias_path')
        if inasistencias_path is not None:
            df_ina = pd.read_csv(inasistencias_path, index_col=[0, 1])
            df_ina = df_ina[df_ina.index.get_level_values(0).isin(
                experiment["años"])].copy()
            # alumnos_ids de inasistencia
            ids_ina = df_ina.index.get_level_values(1).unique()
            print("Ina ids", len(df_ina.index.get_level_values(1).unique()))
        else:
            df_ina = None
            ids_ina = None

        calificaciones_path = experiment.get('calificaciones_path')
        if calificaciones_path is not None:
            df_cal = pd.read_csv(calificaciones_path, index_col=[0, 1])
            df_cal = df_cal[df_cal.index.get_level_values(0).isin(
                experiment["años"])].copy()
            print("Cal ids", len(df_cal.index.get_level_values(1).unique()))
        else:
            df_cal = None

        rate_path = experiment.get('rate_path')
        if rate_path is not None:
            df_rate = pd.read_csv(rate_path, index_col=[0, 1])
            df_rate = df_rate[df_rate.index.get_level_values(0).isin(
                experiment["años"])].copy()
            print("Rate ids", len(df_rate.index.get_level_values(1).unique()))
        else:
            df_rate = None

        if ids_ina is not None:
            ids = list(set(ids_ina).intersection(set(ids_nom)))
            print("Alumno IDs intersección nominal e inasistencias", len(ids))
        else:
            ids = ids_nom

        df = df_nom
        if df_ina is not None:
            df = df.join(df_ina, how="inner")

        if df_cal is not None:
            df = df.join(df_cal, how="left")

        if df_rate is not None:
            df = df.join(df_rate, how="left")

        del df_nom, df_ina, df_cal, df_rate

        print("Join")
        print("Filas:", len(df))
        print("Columnas", list(df.columns))

        # Two class classification, status ok or abandono
        df = df.colloc("status", ["ok", "abandono"])
        print("\nTwo class classification, status ok or abandono", "Filas:",
              len(df))
        run_experiment(df, experiment)


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description="Modeling")
    args = parser.parse_args()

    main(args)
