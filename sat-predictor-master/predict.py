from itertools import product
import json
from pathlib import Path
import pickle
import numpy as np
import pandas as pd
from IPython import embed
from tqdm import tqdm
from catboost import CatBoostClassifier


def semaforo(proba, umbrales_semaforo):
    for k, (th1, th2) in umbrales_semaforo.items():
        if proba >= th1 and proba < th2:
            return k


def main(args):

    umbrales_semaforo = {
        'verde': (0.0, args.umbrales[0]),
        'amarillo': (args.umbrales[0], args.umbrales[1]),
        'rojo': (args.umbrales[1], 1.0)
    }

    model = CatBoostClassifier()
    model.load_model(args.modelo)
    with open(args.columns, "r", encoding='utf-8') as fp:
        columns = json.load(fp)

    print('Cargando archivos')
    if args.join is not None:
        df = pd.read_csv(args.join,
                         index_col=[0, 1],
                         keep_default_na=False,
                         na_values=[""],
                         encoding='utf8')
        
        print("Len df", len(df))
        sm = sum(df.index.duplicated())
        if sm > 0:
            print(f'Alumno_ID duplicados: {sm}, conservando una entrada por Alumno_ID')
            df = df[~df.index.duplicated(keep="last")]

            print("Len df", len(df))
    else:
        df_ina = pd.read_csv(args.inasistencias,
                             index_col=[0, 1],
                             keep_default_na=False,
                             na_values=[""],
                             encoding='utf8')
        df_nom = pd.read_csv(args.nominal,
                             index_col=[0, 1],
                             keep_default_na=False,
                             na_values=[""],
                             encoding='utf8')
        df_cal = pd.read_csv(args.calificaciones,
                             index_col=[0, 1],
                             keep_default_na=False,
                             na_values=[""],
                             encoding='utf8')

        df_rate = pd.read_csv(args.rate,
                              index_col=[0, 1],
                              keep_default_na=False,
                              na_values=[""],
                              encoding='utf8')

        sm = sum(df_nom.index.get_level_values(1).duplicated())
        if sm > 0:
            print(
                f'Alumno_ID duplicados: {sm}, conservando una entrada por Alumno_ID'
            )
            df_nom = df_nom[~df_nom.index.duplicated(keep="last")]

        df = df_nom
        df = df.join(df_ina, how='inner')
        df = df.join(df_cal, how='left')
        df = df.join(df_rate, how='left')

    # Fill NaN with 'NA' in categorical columns
    df.loc[:, columns['categorical_columns']] = df.loc[:, columns[
        'categorical_columns']].fillna('NA')

    print('Realizando predicción', len(df))
    X = df[columns['categorical_columns'] + columns['numerical_columns']]

    y_proba = model.predict_proba(X)
    y_proba = pd.DataFrame(y_proba, index=df.index, columns=model.classes_)

    col_semaforo = f'semaforo_{args.umbrales[0]}_{args.umbrales[1]}'
    y_proba[col_semaforo] = y_proba['abandono'].map(
        lambda x: semaforo(x, umbrales_semaforo))

    y_proba = y_proba.join(df['ID_escuela'])
    por_escuela = y_proba.groupby('ID_escuela')['abandono'].mean().sort_values(
        ascending=False)
    por_escuela.name = 'probabilidad_abandono_promedio'
    por_escuela = pd.concat([
        por_escuela,
        y_proba.groupby('ID_escuela')[col_semaforo].value_counts().unstack()[[
            'verde', 'amarillo', 'rojo'
        ]]
    ],
                            axis=1)

    por_escuela.to_csv(Path(args.output_dir, 'predict_output_escuelas.csv'),
                       encoding='utf8')

    y_proba.to_csv(Path(args.output_dir, 'predict_output.csv'),
                   encoding='utf8')


if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser(description='Predict')
    parser.add_argument("--modelo")
    parser.add_argument("--columns")
    parser.add_argument("--calificaciones")
    parser.add_argument("--nominal")
    parser.add_argument("--inasistencias")
    parser.add_argument("--rate")
    parser.add_argument("--join")
    parser.add_argument("--umbrales", nargs=2, type=float)
    parser.add_argument("--output_dir", default='.')

    args = parser.parse_args()

    main(args)
