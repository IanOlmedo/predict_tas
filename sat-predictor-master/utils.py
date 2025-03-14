import collections
from itertools import product
import pandas as pd
import numpy as np
from tqdm import tqdm
from config import last_year, tipos_inasistencia, prop_inasistencias
import chardet

def colloc(df, col, vals, negative=False):
    if not isinstance(vals, list):
        vals = [vals]
    mask = df[col].isin(vals)
    if negative:
        output = df[~mask]
    else:
        output = df[mask]
    return output


def flatten(d, parent_key='', sep='_'):
    items = []
    for k, v in d.items():
        new_key = parent_key + sep + k if parent_key else k
        if isinstance(v, collections.abc.MutableMapping):
            items.extend(flatten(v, new_key, sep=sep).items())
        else:
            items.append((new_key, v))
    return dict(items)


def diff_lists(l1, l2):
    intersection = set(l1).intersection(l2)
    l1ml2 = set(l1) - set(l2)
    l2ml1 = set(l2) - set(l1)
    return intersection, l1ml2, l2ml1


def types_summary(df):
    data = []
    for c in df.select_dtypes(include=[object]):
        stringnumber = df[c].map(lambda x: x.isnumeric()
                                 if isinstance(x, str) else False).sum()
        stringnotnumber = df[c].map(lambda x: not x.isnumeric()
                                    if isinstance(x, str) else False).sum()
        #     numbernotna = df_all[c].map(lambda x: True if isinstance(x,(int,float,np.ndarray)) and pd.notna(x) else False).sum()
        guiones = df[c].str.contains('^\-+$').sum()
        nans = df[c].isna().sum()
        data.append({
            'col': c,
            'guiones': guiones,
            'NaN': nans,
            'stringnumber': stringnumber,
            'stringnotnumber': stringnotnumber
        })

    for c in df.select_dtypes(exclude=[object]):
        data.append({'col': c, 'NaN': df[c].isna().sum()})
    return pd.DataFrame(data).set_index('col').T


def checkConsecutive(l):
    n = len(l) - 1
    return (sum(np.diff(sorted(l)) == 1) >= n)


def checkstatus(g):
    ds = []
    for i in range(0, len(g)):
        d = {}
        x = g.iloc[i]
        if x['año'] == last_year:
            d['status'] = 'nsnc'
        elif x['grado'] >= 12:
            d['status'] = 'termino'
        elif i + 1 == len(g):
            d['status'] = 'abandono'
        else:
            d['status'] = 'ok'

        d['año'] = x['año']
        if i > 0:
            gradconsec = checkConsecutive(g['grado'].iloc[:i + 1].tolist())
            añoconsec = checkConsecutive(g['año'].iloc[:i + 1].tolist())
            if gradconsec and not añoconsec:
                d['extra'] = 'perdio_año'
            elif not gradconsec and añoconsec:
                d['extra'] = 'repitio_año'
        ds.append(d)
    return ds


def make_partitions(df,
                    partitions,
                    stratify_columns,
                    independent_columns=None,
                    random_seed=None):

    np.random.seed(random_seed)

    if isinstance(partitions, int):
        partitions = [1.0 / partitions for p in range(partitions - 1)]
    elif sum(partitions) >= 1:
        raise Exception('Partitions proportions must sum less than 1')
    partitions.append(1 - sum(partitions))

    n_sets = len(partitions)

    partidx = {i: [] for i in range(n_sets)}

    if independent_columns is not None:
        groups = df.groupby(stratify_columns).groups.items()
        dist = {k: len(v) * np.array(partitions) for k, v in groups}
        part = {k: np.zeros(n_sets) for k, v in groups}

        for k, g in tqdm(df.groupby(independent_columns)):
            diffs = []
            for i, r in g.iterrows():
                group = tuple(r[stratify_columns].to_list())
                diffs.append(dist[group] - part[group])
            pix = np.max(np.array(diffs), 0).argmax()
            gix = np.max(np.array(diffs), 1).argmax()
            partidx[pix].extend(g.index)
            group = tuple(g.iloc[gix][stratify_columns].to_list())
            part[group][pix] += len(g)
    else:
        for k, g in df.groupby(stratify_columns):
            ix = np.random.permutation(
                sum([[i] * int(np.ceil(len(g) * p))
                     for i, p in enumerate(partitions)], []))[:len(g)]
            for i in range(n_sets):
                partidx[i].extend(g[ix == i].index)
    return partidx


def resumen_anual(df_inamen):
    cols = list(tipos_inasistencia.keys()) + list(prop_inasistencias.keys())
    df_ina = df_inamen.groupby(["Alumno_ID", "año"
                                ])[cols].agg(["mean", "std", "max", "min"])
    df_ina.index = df_ina.index.swaplevel(0, 1)
    df_ina.columns = map(
        lambda x: str(x).replace("', '", "_").replace("('", "").replace(
            "')", ""),
        list(df_ina.columns),
    )
    return df_ina


def nan_mes(df_inamen):
    dfx = df_inamen.set_index("mes", append=True).unstack()
    dfx.columns = dfx.columns.swaplevel()
    dfx = dfx.sort_index(axis=1)
    df_inamen = dfx.swaplevel().sort_index()
    del dfx

    def fn(X, n, k):
        xs = []
        xs.append(X.copy())
        for i in range(k, n * k, k):
            xs.append(X[:, :-i])
            a = np.empty((X.shape[0], i))
            a.fill(np.nan)
            xs.append(a)
        xs = np.hstack(xs)
        xs = xs.reshape(X.shape[0] * n, X.shape[1])
        return xs

    X = fn(
        df_inamen.values,
        len(df_inamen.columns.levels[0]),
        len(df_inamen.columns.levels[1]),
    )
    index = list(
        map(
            lambda x: tuple(list(x[0]) + [x[1]]),
            list(
                product(
                    df_inamen.index,
                    np.arange(len(df_inamen.columns.levels[0]), dtype=int),
                )),
        ))
    index = pd.MultiIndex.from_tuples(index)
    index.names = ["año", "Alumno_ID", "mes_aug"]
    df_ina = pd.DataFrame(X, index=index,
                          columns=df_inamen.columns).reset_index(level=2)
    return df_ina


def resumen_mes(df_inamen):
    cols = list(tipos_inasistencia.keys()) + list(prop_inasistencias.keys())
    dfs = []
    for k in tqdm(list(range(3, 13))):
        dfx = (df_inamen[df_inamen["mes"] <= k].groupby(
            ["Alumno_ID", "año"])[cols].agg(["mean", "std", "max", "min"]))
        dfx["mes_aug"] = k
        dfs.append(dfx)
    df_ina = pd.concat(dfs)
    df_ina.index = df_ina.index.swaplevel(0, 1)
    df_ina.columns = map(
        lambda x: str(x).replace("', '", "_").replace("('", "").replace(
            "')", ""),
        list(df_ina.columns),
    )

    df_ina = df_ina.rename(columns={"mes_aug_": "mes_aug"})
    df_ina = df_ina.set_index("mes_aug", append=True).sort_index()
    return df_ina


##### Detectar el encoding y el sep

def detect_encoding_and_sep(file_path):
    with open(file_path, "rb") as file:
        content = file.read()
    result = chardet.detect(content)
    encoding = result["encoding"]
    
    content_str = content.decode(encoding)
    #Leemos las primeras lineas para detectar el separador
    first_lines = content_str.splitlines()[:10]    
    possible_separators = [";", ",", "|", "\t"]
    for separator in possible_separators:
        if all(separator in line for line in first_lines):       
            return encoding, separator       
    return encoding, ";"

#Encontrar thresholds óptimos
def find_thresholds(probabilities, truth, target_red = 0.9, target_yellow = 0.5):
    data = list(zip(probabilities, truth))
    sorted_data = sorted(data, key=lambda x: x[0], reverse=True)

    true_positives = 0
    false_positives = 0
    num_total = 0
    first_threshold = None
    second_threshold = None

    # Probar diferentes thresholds
    for prob, label in sorted_data:
        if label == 1:
            true_positives += 1
        else:
            false_positives += 1
        num_total += 1    
        tpr = true_positives / num_total
    
        # Chequear si llegamos al porcentaje pedido
        if tpr >= target_red:
            first_threshold = prob
    #Buscar el segundo threshold
    true_positives = 0
    false_positives = 0
    num_total = 0
    for prob, label in sorted_data:
        # No considerar aquellas que ya fueron clasificadas
        if label == 1 and prob < first_threshold:
            true_positives += 1
        elif label == 0 and prob < first_threshold:
            false_positives += 1

        num_total += 1    
        tpr = true_positives / num_total

        if tpr >= target_yellow:
            second_threshold = prob     

    return first_threshold, second_threshold