from IPython import embed
import pandas as pd
import numpy as np
from pathlib import Path
import argparse
from tqdm import tqdm
from itertools import product
from utils import (
    checkstatus,
    colloc,
    nan_mes,
    resumen_anual,
    resumen_mes,
    diff_lists,
    detect_encoding_and_sep,
)

from config import (
    data_to_process,
    niveles,
    output_name,
    tipos_inasistencia,
    prop_inasistencias,
    recuperaciones,
    year_born_cut,
    edad_cut,
    filtrar_causa_sale,
    data_to_process,
    path_nominal,
    path_rate,
    path_inasistencias,
    path_calificaciones,
    output_dir,
    categorical_columns,
    numerical_columns,
    inasistencia_columns,
    calificaciones_columns,
    esperadas_calificaciones,
    esperadas_inasistencias,
    esperadas_rate,
    esperadas_nominal,
)

pd.DataFrame.colloc = colloc

# TODO: traducir prints
# TODO: dtype dict para cargar inasistencias csv


def calificaciones(df):

    def fn(x):
        return np.digitize(x, x.quantile([0, 0.333, 0.666]).values).astype(int)

    df["ratio_ausencia"] = df["asistencia"].map(
        lambda x: list(x).count("Ausente") / len(x)
    )
    df["n_ausencia"] = df["asistencia"].map(lambda x: list(x).count("Ausente"))
    df["notas"] = df["notas"].map(lambda x: np.array(list(map(float, x.split(",")))))
    df["mes_ultima_fecha"] = df["fecha_evaluacion"].map(lambda x: pd.to_datetime(x.split(",")[-1]).month)
    df["promedio2"] = df["notas"].map(
        lambda x: x[x != 0].mean() if any(x != 0) else np.nan
    )
    df["promedio_Q3"] = df.groupby(["materia", "ID_escuela_"])["promedio2"].transform(
        fn
    )
    df["materia2"] = df["materia"].replace("Lengua y Literatura", "Lengua")
    df["asistencia"] = df["asistencia"].map(lambda x: x.split(","))

    df["descripcion_evaluacion"] = df["descripcion_evaluacion"].map(
        lambda x: x.split(",")
    )
    df["recuperaciones"] = df["descripcion_evaluacion"].map(
        lambda x: sum([e in recuperaciones for e in x])
    )

    dfx = df.groupby(["Alumno_ID", "materia2"])["promedio_Q3"].mean().round()
    # Ratio ausencia por meses con datos
    dfy1 = (
        df.groupby(["Alumno_ID", "materia2"])["cantidad de evaluaciones ausentes"].sum()
        / df.groupby(["Alumno_ID", "materia2"])["mes_ultima_fecha"].sum()
    )
    dfy1.name = "ratio_ausencia_mes"
    dfy2 = df.groupby(["Alumno_ID", "materia2"])["cantidad de evaluaciones ausentes"].sum()
    dfy2.name = "ausencias"
    dfw = df.groupby(["Alumno_ID", "materia2"])["mes_ultima_fecha"].sum()
    dfw.name = "mes_ultima_fecha"
    dfz = df.groupby(["Alumno_ID", "materia2"])["recuperaciones"].sum()
    dfg = pd.concat([dfx, dfy1, dfy2, dfw, dfz], axis=1)
    dfg = dfg.unstack()
    cols = [f"{x[1]}_{x[0]}" for x in dfg.columns]
    dfg.columns = cols

    return dfg


def calificaciones_mensuales(df, year, _output_dir):
    df["materia2"] = df["materia"].replace("Lengua y Literatura", "Lengua")

    # Opción que no andaba
    # cols = [
    #     'asistencia', 'notas', 'descripcion_evaluacion', 'fecha_evaluacion'
    # ]
    cols = ["notas", "fecha_evaluacion"]
    for col in cols:
        df[col + "_list"] = df[col].map(lambda x: x.split(","))
    cols = [c + "_list" for c in cols]
    dfm = df[["Alumno_ID", "ID_escuela_", "materia2"] + cols].explode(cols)
    dfm["fecha_evaluacion_list"] = pd.to_datetime(dfm["fecha_evaluacion_list"])
    dfm["notas_list"] = dfm["notas_list"].astype(float)

    dfs = []
    for mes in (
        pd.date_range(start=str(year) + "-03-01", end=str(year) + "-12-01")
        .to_period("M")
        .unique()
    ):
        hasta = dfm[dfm["fecha_evaluacion_list"] < mes.end_time]
        notas = hasta.groupby(["Alumno_ID", "ID_escuela_", "materia2"])[
            "notas_list"
        ].mean()
        ratio_ausencia = (
            hasta.groupby(["Alumno_ID", "materia2"])["asistencia_list"]
            .value_counts()
            .unstack()
            .fillna(0)
        )
        ratio_ausencia = (ratio_ausencia["Ausente"] / ratio_ausencia.sum(1)).unstack()
        recuperacion = (
            hasta.groupby(["Alumno_ID", "materia2"])["descripcion_evaluacion_list"]
            .value_counts()
            .unstack()
        )

        recuperacion = (
            recuperacion[list(set(recuperacion.columns).intersection(recuperaciones))]
            .sum(1)
            .unstack()
        )

        def fn(x):
            return np.digitize(x, x.quantile([0, 0.333, 0.666]).values).astype(int)

        notas = hasta.groupby(["Alumno_ID", "ID_escuela_", "materia2"])[
            "notas_list"
        ].mean()
        promedio_Q3 = (
            notas.reset_index(1).groupby(["materia2", "ID_escuela_"]).transform(fn)
        )
        promedio_Q3 = (
            promedio_Q3.groupby(["Alumno_ID", "materia2"])
            .mean()
            .unstack()["notas_list"]
        )

        dfx = pd.concat(
            [ratio_ausencia, recuperacion, promedio_Q3],
            keys=["_ratio_ausencia", "_recuperaciones", "_promedio_Q3"],
            axis=1,
        )
        dfx.columns = [b + a for a, b in dfx.columns]
        dfx["mes"] = mes.month
        dfs.append(dfx)
    dfmeses = pd.concat(dfs)

    df = pd.concat(dfm)
    df["año"] = year
    df = df.set_index("año", append=True).swaplevel().sort_index()
    outpath = Path(_output_dir, f"calificaciones_mensuales_{year}{output_name}.csv")
    if not outpath.parent.exists():
        outpath.parent.mkdir(exist_ok=True)
    print("Salvando calificaciones mensuales", year, outpath)
    df.to_csv(outpath)

    return dfmeses


def inasistencias(df):

    # Toma columnas 1_* o 11_* etc... + Asistencia y faltasReales
    columnas_tipos_inasistencias = list(
        df.iloc[0:1].filter(regex="(\d|\d\d)\-*").columns
    )

    if len(columnas_tipos_inasistencias) == 0:
        columnas_tipos_inasistencias = list(
            df.iloc[0:1].filter(regex="(\d|\d\d)\w$").columns
        )

    columnas_tipos_inasistencias = columnas_tipos_inasistencias + [
        "Asistencia",
        "faltasReales",
    ]

    dups = df.duplicated()
    print(df["añofile"].iloc[0], "duplicateds", dups.sum())
    if dups.sum() > 0:
        df = df[~dups]

    # Reformat "-"" -> 0 (no se necesita más?)
    # df[columnas_tipos_inasistencias] = df[
    #     columnas_tipos_inasistencias].replace(
    #         to_replace="^\-+$", value=0, regex=True)

    # To float (read csv decimal=",")
    # df[columnas_tipos_inasistencias] = df[columnas_tipos_inasistencias].applymap(lambda x: float(
    #         x.replace(",", ".")) if isinstance(x, str) else float(x))

    df["año"] = df["año-mes"].map(lambda x: int(str(x)[:4]))
    df["mes"] = df["año-mes"].map(lambda x: int(str(x)[4:6]))
    df["Alumno_ID"] = df["Alumno_ID"].astype(int)
    df["cDia"] = df["cDia"].astype(int)
    df["previo_ingreso_posterior_egreso_suma"] = df.loc[
        :, df.columns.str.contains("^5-") | df.columns.str.contains("^6-")
    ].sum(1)
    df["cDia_menos_pipe"] = df["cDia"] - df["previo_ingreso_posterior_egreso_suma"]

    print("Normaliza inasistencias")
    for tipo, cols in tipos_inasistencia.items():
        cols_ = list(set(cols).intersection(columnas_tipos_inasistencias))
        df[tipo] = df[cols_].sum(1) / df["cDia"]

    df["faltas/asistencia"] = df["faltas"] / (df["asistencia"].replace(0, np.NaN))
    df["todo_nan"] = df[tipos_inasistencia.keys()].isna().all(1)

    df_ausente = df.set_index(keys=["Alumno_ID", "año", "mes"])[
        list(tipos_inasistencia.keys()) + list(prop_inasistencias.keys())
    ]

    return df_ausente


def rate(df):
    # Normalizar nombres de las columnas
    cols = list(df.columns)
    colsl = []
    for col in cols:
        colsl.append(col.lower())
    df.columns = colsl
    df.columns = df.columns.str.replace(r"¿", "?")

    # Quitar las columnas que no usamos
    col_repetidas = [
        "id",
        "cue",
        "subcue",
        "numero_escuela",
        "anexo",
        "numero_anexo",
        "escuela",
        "nivel",
        "gestion",
        "supervisión",
        "departamento",
        "localidad",
        "zona",
        "ambito",
        "regional",
        "curso",
        "division",
        "rate alumno id",
        "fecha de carga",
    ]
    for colrep in col_repetidas:
        try:
            df.drop(colrep, axis=1, inplace=True)
        except:
            pass

    df = df.rename(columns={"alumno_id": "Alumno_ID"})

    # Agregar año y mes
    df["mes"] = df["mes"].astype("str")
    df = df[~(df["mes"].map(len) != 6)].copy()
    df["año"] = df["mes"].map(lambda x: int(x[:4]))
    try:
        df["mes"] = df["mes"].map(lambda x: int(x[4:]))
    except:
        embed()

    # Pasar las columnas a dummies
    df["dispositivo"] = df["?qué tipo de recurso necesita 1?"] == "Dispositvo"
    df["conectividad_hogar"] = (
        df["?qué tipo de recurso necesita 2?"]
        == "Conectividad en su hogar (acceso a internet)"
    )
    df["conectividad_zona"] = (
        df["?qué tipo de recurso necesita 3?"]
        == "Cobertura de conectivdad en la zona donde vive (para zonas a las que no llega señal de internet)"
    )
    df["soe"] = df["?está siendo abordado por soe?"].replace(
        {"Si": 1, "No": 0, "-": np.nan}
    )
    df["doaite"] = df["?está siendo abordado por doaite?"].replace(
        {"Si": 1, "No": 0, "-": np.nan}
    )
    df["apoyo_psicopedagogico"] = df[
        "?está siendo abordado por apoyo psicopedagogico?"
    ].replace({"Si": 1, "No": 0, "-": np.nan})
    df["apoyo_interno"] = df["recibe apoyo de:"].replace(
        {
            "Un programa interno de la escuela": 1,
            "Otra Insitucion": 0,
            "universidad": 0,
            "-": np.nan,
        }
    )
    df["apoyo_otra_institucion"] = df["recibe apoyo de:"].replace(
        {
            "Un programa interno de la escuela": 0,
            "Otra Insitucion": 1,
            "universidad": 0,
            "-": np.nan,
        }
    )
    df["apoyo_universidad"] = df["recibe apoyo de:"].replace(
        {
            "Un programa interno de la escuela": 0,
            "Otra Insitucion": 0,
            "universidad": 1,
            "-": np.nan,
        }
    )

    if (
        "?el estudiante necesita recursos tecnológicos para resolver sus tareas escolares?"
        in df.columns
    ):
        df["recursos_tecnologicos"] = df[
            "?el estudiante necesita recursos tecnológicos para resolver sus tareas escolares?"
        ].replace({"Si": 1, "No": 0, "-": np.nan})
        df.drop(
            [
                "?el estudiante necesita recursos tecnológicos para resolver sus tareas escolares?"
            ],
            axis=1,
            inplace=True,
        )
    elif (
        "?el estudiante necesita recursos tecnológicos para resolver sus" in df.columns
    ):
        df["recursos_tecnologicos"] = df[
            "?el estudiante necesita recursos tecnológicos para resolver sus"
        ].replace({"Si": 1, "No": 0, "-": np.nan})
        df.drop(
            ["?el estudiante necesita recursos tecnológicos para resolver sus"],
            axis=1,
            inplace=True,
        )
    else:
        print(
            "ERROR: Revisar el nombre de la columna: ?El estudiante necesita recursos tecnológicos para resolver..."
        )
        return

    if (
        "?necesita apoyo escolar complementario para fortalecer sus saberes prioritarios?"
        in df.columns
    ):
        df["necesita_apoyo"] = df[
            "?necesita apoyo escolar complementario para fortalecer sus saberes prioritarios?"
        ].replace({"Si": 1, "No": 0, "-": np.nan})
        df.drop(
            [
                "?necesita apoyo escolar complementario para fortalecer sus saberes prioritarios?"
            ],
            axis=1,
            inplace=True,
        )
    elif (
        "?necesita apoyo escolar complementario para fortalecer sus saber" in df.columns
    ):
        df["necesita_apoyo"] = df[
            "?necesita apoyo escolar complementario para fortalecer sus saber"
        ].replace({"Si": 1, "No": 0, "-": np.nan})
        df.drop(
            ["?necesita apoyo escolar complementario para fortalecer sus saber"],
            axis=1,
            inplace=True,
        )
    else:
        print(
            "ERROR: Revisar el nombre de la columna: ?Necesita apoyo escolar complementario para fortalecer..."
        )
        return

    if "?necesita abordaje específico?" in df.columns:
        df["apoyo_especifico"] = df["?necesita abordaje específico?"].replace(
            {"Si": 1, "No": 0, "-": np.nan}
        )
        df.drop(["?necesita abordaje específico?"], axis=1, inplace=True)
    elif "?necesita un abordaje específico?" in df.columns:
        df["apoyo_especifico"] = df["?necesita un abordaje específico?"].replace(
            {"Si": 1, "No": 0, "-": np.nan}
        )
        df.drop(["?necesita un abordaje específico?"], axis=1, inplace=True)
    else:
        print(
            "ERROR: Revisar el nombre de la columna: ?necesita (((un))) abordaje específico?"
        )
        return

    if "?esta recibiendo un abordaje específico para la revinculación?" in df.columns:
        df.drop(
            ["?esta recibiendo un abordaje específico para la revinculación?"],
            axis=1,
            inplace=True,
        )

    # Pasar columna a ordinal (en el orden de las dummies, más es peor)
    df["vinculacion"] = df[
        "?qué nivel de vinculación tiene el estudiante con la escuela?"
    ].replace({"Permanente": 1, "Intermitente": 2, "Escasa o nula": 3, "-": np.nan})

    # Tiro columnas viejas
    df.drop(
        [
            "?qué tipo de recurso necesita 1?",
            "?qué tipo de recurso necesita 2?",
            "?qué tipo de recurso necesita 3?",
            "?qué nivel de vinculación tiene el estudiante con la escuela?",
            "?está siendo abordado por soe?",
            "?está siendo abordado por doaite?",
            "?está siendo abordado por apoyo psicopedagogico?",
            "?el estudiante recibe apoyo pedagógico complementario?",
            "recibe apoyo de:",
        ],
        axis=1,
        inplace=True,
    )

    # Paso todo a enteros
    df = df.astype(
        {
            "dispositivo": "int32",
            "conectividad_hogar": "int32",
            "conectividad_zona": "int32",
        }
    )

    return df


def nominal(df):
    df.replace(to_replace="^\-+$", value=np.NaN, regex=True, inplace=True)
    dups = df.duplicated()
    print(df["file"].iloc[0], "Filas duplicadas", dups.sum())
    if dups.sum() > 0:
        df = df[~dups]

    print(df["file"].iloc[0], "filas:", len(df))

    # Filtra nivel
    df = df.colloc("Nivel", niveles).copy()

    print(df["file"].iloc[0], "Filtra niveles, filas:", len(df))

    if "causa-sale" in df.columns:

        # Filtra alumnos con traslados y casos erroneos
        ids = []
        for cs in filtrar_causa_sale:
            ids.extend(df[df["causa-sale"] == cs]["Alumno_ID"].unique())
        df = df[~df["Alumno_ID"].isin(ids)].copy()
        print(df["file"].iloc[0], "Filtra por causa sale", "filas:", len(df))

    df["nivel_educativo"] = df["Nivel"].map(
        {
            "Primario": "Primario",
            "Primario Nacional": "Primario",
            "Secundario Orientado": "Secundario",
            "Secundario Técnico": "Secundario",
        }
    )

    # Filtra alumnos con más de un nivel educativo (a futuro abría que usar la edad si se puede)
    x = (df.groupby("Alumno_ID")["nivel_educativo"].value_counts().unstack() > 0).sum(1)
    ids = x[x > 1].index
    print(df["file"].iloc[0], "Alumnos con nivel educativo duplicado:", len(ids))
    df = df[~df["Alumno_ID"].isin(ids)]
    print(df["file"].iloc[0], "filas:", len(df))

    # Filtra edad y sin datos de nacimiento
    df = df[
        (~df["Fecha Nacimiento"].isna()) & (df["Fecha Nacimiento"] != str(0))
    ].copy()

    df["Fecha Nacimiento"] = pd.to_datetime(df["Fecha Nacimiento"])

    df["año_nacimiento"] = df["Fecha Nacimiento"].map(lambda x: x.year)

    df["mes_nacimiento"] = df["Fecha Nacimiento"].map(lambda x: x.month)
    df["mes_nacimiento"] = df["mes_nacimiento"].astype(int)

    df = df[df["año_nacimiento"] > year_born_cut]

    df["edad"] = (
        pd.to_datetime(str(df["año"].iloc[0]) + "-12-31") - df["Fecha Nacimiento"]
    ).map(lambda x: x.days) / 365.25

    df = df[df["edad"] > edad_cut]
    print(df["file"].iloc[0], "Filtra por edad", "filas:", len(df))

    # Zona a categoría
    df["zona_cat"] = df["zona"].map(
        lambda x: int(x[:-1]) if isinstance(x, str) and "%" in x else x
    )

    # Zona a número
    df["zona_numero"] = df["zona"].map(
        lambda x: float(x[:-1]) if isinstance(x, str) and "%" in x else 0
    )

    # Codigo Madre, Padre, Tutor
    ix = np.where(
        (
            ~df[["persona_id_madre", "persona_id_padre", "persona_id_tutor"]].isna()
        ).values
    )
    code = np.array(["M", "P", "T"])
    tmp = np.empty((len(df), 3), dtype=str)
    tmp[ix[0], ix[1]] = code[ix[1]]

    df["datos_responsables"] = list(map(lambda x: "".join(x), tmp))

    # Grado de 1 a 13
    mask = df["Nivel"].isin(niveles) & df["Curso"].isin(
        ["7°", "6°", "5°", "4°", "3°", "2°", "1°"]
    )
    df = df[mask].copy()

    print(df["file"].iloc[0], "Filtra niveles y cursos", "filas:", len(df))

    df["grado"] = 0
    mask = df["nivel_educativo"] == "Primario"
    df.loc[mask, "grado"] = df.loc[mask, "Curso"].map(lambda x: int(x[:-1])).astype(int)

    mask = df["nivel_educativo"] == "Secundario"
    df.loc[mask, "grado"] = (
        df.loc[mask, "Curso"].map(lambda x: int(x[:-1]) + 7).astype(int)
    )

    # Sobreedad
    df["sobreedad"] = (
        (
            pd.to_datetime(str(df["año"].iloc[0]) + "-06-30") - df["Fecha Nacimiento"]
        ).map(lambda x: x.days)
        / 365.25
        - df["grado"]
        - 5
    )

    df["sobreedad_entero"] = df["sobreedad"].map(np.floor)
    df["sobreedad_fraccion"] = df["sobreedad"].map(lambda x: np.modf(x)[0])

    # Filtra los que repitieron más de 5 veces, y los que están adelantados más de un año
    df = df[(df["sobreedad"] > -1) | (df["sobreedad"] < 5)]

    print(
        df["file"].iloc[0],
        "Filtra los que repitieron más de 5 veces",
        "filas:",
        len(df),
    )

    # Proporción masculinos por curso

    def fn(x):
        y = x.value_counts()
        if "Masculino" in y:
            return y["Masculino"] / len(x)
        else:
            return 0

    df["prop_masc"] = df.groupby(["ID_escuela", "Curso", "Division", "Turno"])[
        "Sexo"
    ].transform(fn)

    df["n_tutores"] = df.groupby("Alumno_ID")["persona_id_tutor"].transform(
        lambda x: x.nunique()
    )

    return df


def main(args):
    _data_to_process = []
    output_name_1 = None
    if args.año is not None and args.output_dir is not None:
        año = args.año
        _output_dir = args.output_dir

        # TODO assert que existan archivos dentro de las carpetas

        if args.nominal is not None:
            _data_to_process.append("NOMINAL")
            _path_nominal = {año: Path(args.nominal)}

        if args.inasistencias is not None:
            _data_to_process.append("INASISTENCIAS")
            _path_inasistencias = {año: list(Path(args.inasistencias).glob("*.csv"))}
        if args.calificaciones is not None:
            _data_to_process.append("CALIFICACIONES")
            _path_calificaciones = {año: list(Path(args.calificaciones).glob("*.csv"))}
        if args.rate is not None:
            _data_to_process.append("RATE")
            _path_rate = {año: list(Path(args.rate).glob("*RATE ALUMNOS*.csv"))}
        if args.join is not None:
            _data_to_process.append("JOIN")

        # TODO: comment
        if args.mes is not None:
            _path_tmp = []
            for p in _path_rate[año]:
                if int(p.stem[:2]) <= int(args.mes):
                    _path_tmp.append(p)
            _path_rate[año] = _path_tmp

            _path_tmp = []
            for p in _path_inasistencias[año]:
                if int(p.stem[:2]) <= int(args.mes):
                    _path_tmp.append(p)
            _path_inasistencias[año] = _path_tmp

            output_name_1 = f"_hasta_mes_{args.mes}"

    elif (
        args.nominal is None
        and args.inasistencias is None
        and args.calificaciones is None
        and args.año is None
        and args.rate is None
    ):
        print("Usando config")
        _data_to_process = data_to_process
        _path_nominal = path_nominal
        _path_inasistencias = path_inasistencias
        _path_calificaciones = path_calificaciones
        _path_rate = path_rate
        _output_dir = output_dir
    else:
        raise Exception("TODO")

    if "NOMINAL" in _data_to_process:
        dfs = []
        for year in _path_nominal:
            print("Preprocessing nominal data for year", year)
            path = _path_nominal[year]
            print("Checking the encoding of the file")
            encoding, sep = detect_encoding_and_sep(path)
            df = pd.read_csv(path, encoding=encoding, sep=sep, low_memory=False)
            # Chequear que las columnas sean las que esperamos
            if not all(df.columns == esperadas_nominal):
                print(
                    "WARNING: Las columnas del archivo NOMINAL no son iguales a las esperadas."
                )
            df["file"] = path.name
            df["año"] = year
            df = nominal(df)
            dfs.append(df)
        df = pd.concat(dfs)

        if df["año"].nunique() > 1:
            mask = ~df[["Alumno_ID", "año", "grado"]].duplicated()
            status = (
                df[mask][["Alumno_ID", "año", "grado"]]
                .sort_values(["Alumno_ID", "año"])
                .groupby("Alumno_ID")[["año", "grado"]]
                .apply(checkstatus)
                .explode()
            )

            status = pd.DataFrame(status.tolist(), index=status.index).set_index(
                "año", append=True
            )

            df = df.set_index(["Alumno_ID", "año"]).join(status)
            df = df.swaplevel().sort_index()
        else:
            df = df.set_index(["año", "Alumno_ID"]).sort_index()
        if output_name_1 is not None:
            outpath = Path(_output_dir, "nominal" + output_name_1 + ".csv")
        else:
            outpath = Path(_output_dir, "nominal" + output_name + ".csv")
        if not outpath.parent.exists():
            outpath.parent.mkdir(exist_ok=True)
        print("Saving nominal data to", outpath)
        df.to_csv(outpath)
        del df

    if "INASISTENCIAS" in _data_to_process:
        dfs = []
        for year in _path_inasistencias:
            print("Preprocessing inasistencias data for year", year)
            _dfs = []
            for p in _path_inasistencias[year]:
                print("Checking the encoding of the file")
                encoding, sep = detect_encoding_and_sep(p)
                df = pd.read_csv(
                    p, encoding=encoding, sep=sep, low_memory=True, decimal=","
                )
                # Chequear que las columnas sean las que esperamos
                # try:
                #     assert all(df.columns == esperadas_inasistencias)
                # except:
                #     print( diff_lists(list(df.columns), esperadas_inasistencias) )
                #     raise Exception("WARNING: Las columnas del archivo INASISTENCIAS no son iguales a las esperadas.")
                df["file"] = p.name
                df["añofile"] = year
                _dfs.append(df)

            df = pd.concat(_dfs)
            df = inasistencias(df)
            dfs.append(df)
        df_inamen = pd.concat(dfs).sort_index()
        outpath = Path(_output_dir, "inasistencias_mensuales" + output_name + ".csv")
        if not outpath.parent.exists():
            outpath.parent.mkdir(exist_ok=True)
        print("Salvando inasistencias mensuales", outpath)
        df_inamen.to_csv(outpath)

        df_inamen["mes"] = df_inamen.index.get_level_values(2)

        df_ina = resumen_mes(df_inamen.copy())
        outpath = Path(_output_dir, "inasistencias_summary_mes" + output_name + ".csv")
        if not outpath.parent.exists():
            outpath.parent.mkdir(exist_ok=True)
        print("Salvando inasistencias resumen por mes", outpath)
        df_ina.to_csv(outpath)

        # df_ina = nan_mes(df_inamen.copy())
        # outpath = Path(_output_dir,
        #                "inasistencias_nan_mes_" + output_name + ".csv")
        # if not outpath.parent.exists():
        #     outpath.parent.mkdir(exist_ok=True)
        # print("Salvando inasistencias nan-mes", outpath)
        # df_ina.to_csv(outpath)

        df_ina = resumen_anual(df_inamen.copy())
        outpath = Path(_output_dir, "inasistencias_summary" + output_name + ".csv")
        if not outpath.parent.exists():
            outpath.parent.mkdir(exist_ok=True)
        print("Salvando inasistencias resumen", outpath)
        df_ina.to_csv(outpath)

        del df_inamen
        del df_ina

    if "RATE" in _data_to_process:
        dfs = []
        for year in _path_rate:
            print("Preprocessing RATE data for year", year)
            _dfs = []
            for p in _path_rate[year]:
                print("Checking the encoding of the file")
                encoding, sep = detect_encoding_and_sep(p)
                df = pd.read_csv(p, encoding=encoding, sep=sep, low_memory=True)

                # Chequear que las columnas sean las que esperamos
                if not all(df.columns == esperadas_rate):
                    print(
                        "WARNING: Las columnas del archivo RATE no son iguales a las esperadas."
                    )

                df = rate(df)
                print(
                    f'{p.name} mes:{df["mes"][0]}, alumnos:{len(df["Alumno_ID"])}, null:{sum(df["Alumno_ID"].isnull())}'
                )
                _dfs.append(df)

                if len(df["mes"].unique()) != 1:
                    print(
                        "WARNING: Hay más de un mes en este archivo (%d)."
                        % len(df["mes"].unique())
                    )
                    print(df["mes"].unique())
                    print(sum(df["mes"] == 0))

                if int(p.stem.split("-")[0]) != df["mes"][0]:
                    print("WARNING: No es el mes que dice el archivo")

            df = pd.concat(_dfs)
            dfs.append(df)

        df = pd.concat(dfs).set_index(["año", "Alumno_ID"]).sort_index()

        outpath = Path(_output_dir, "rate_mensuales" + output_name + ".csv")
        if not outpath.parent.exists():
            outpath.parent.mkdir(exist_ok=True)
        print("Saving rate data to", outpath)
        df.to_csv(outpath)

        # Resumen estadístico de RATE por alumno
        print("Summary")
        _df_mes = df.groupby(["año", "Alumno_ID"])["mes"].count()

        cols = [
            "dispositivo",
            "conectividad_hogar",
            "conectividad_zona",
            "soe",
            "doaite",
            "apoyo_psicopedagogico",
            "recursos_tecnologicos",
            "necesita_apoyo",
            "apoyo_especifico",
            "vinculacion",
        ]

        df_rate_summary = df.groupby(["año", "Alumno_ID"])[cols].mean()
        df_rate_summary["meses"] = _df_mes

        outpath = Path(_output_dir, "rate_summary" + output_name + ".csv")
        if not outpath.parent.exists():
            outpath.parent.mkdir(exist_ok=True)
        print("Saving rate summary data to", outpath)
        df_rate_summary.to_csv(outpath)

        del df
        del df_rate_summary

    if "CALIFICACIONES" in _data_to_process:

        dfs = []
        for year in _path_calificaciones:
            print("Preprocessing calificaciones data for year", year)
            _dfs = []
            for p in _path_calificaciones[year]:
                print("Checking the encoding of the file")
                encoding, sep = detect_encoding_and_sep(p)
                df = pd.read_csv(p, encoding=encoding, sep=sep, low_memory=False)
                _dfs.append(df)
                # Chequear que las columnas sean las que esperamos
                if not all(df.columns == esperadas_calificaciones):
                    print(
                        "WARNING: Las columnas del archivo CALIFICACIONES no son iguales a las esperadas."
                    )
            df = pd.concat(_dfs)

            df_summary = calificaciones(df.copy())
            df_summary["año"] = year
            dfs.append(df_summary)

        df = pd.concat(dfs)
        df = df.set_index("año", append=True).swaplevel().sort_index()
        outpath = Path(_output_dir, "calificaciones_summary" + output_name + ".csv")
        if not outpath.parent.exists():
            outpath.parent.mkdir(exist_ok=True)
        print("Salvando calificaciones resumen data", outpath)
        df.to_csv(outpath)
        del df, df_summary

        for year in _path_calificaciones:
            print("Preprocessing calificaciones data for year", year)
            _dfs = []
            for p in _path_calificaciones[year]:
                print("Checking the encoding of the file")
                encoding, sep = detect_encoding_and_sep(p)
                df = pd.read_csv(p, encoding=encoding, sep=sep, low_memory=False)
                _dfs.append(df)
            df = pd.concat(_dfs)

            df["comas_fechas"] = df["fecha_evaluacion"].map(lambda x: x.count(","))
            df["comas_notas"] = df["notas"].map(lambda x: x.count(","))
            df["comas_asistencia"] = df["asistencia"].map(lambda x: x.count(","))
            df["comas_descripcion_evaluacion"] = df["descripcion_evaluacion"].map(
                lambda x: x.count(",")
            )

            print("Notas == Fechas?")
            print((df["comas_notas"] == df["comas_fechas"]).value_counts())
            print("Asistencia == Fechas?")
            print((df["comas_asistencia"] == df["comas_fechas"]).value_counts())
            print("descripcion_evaluacion == Fechas?")
            print(
                (
                    df["comas_descripcion_evaluacion"] == df["comas_fechas"]
                ).value_counts()
            )

            try:
                calificaciones_mensuales(df.copy(), year, _output_dir)
            except:
                print(year, "listas de calificaciones de diferente tamaño")
                pass

    if "JOIN" in _data_to_process:
        print("Leyendo para Join")
        print("Lee nominal")
        outpath = Path(_output_dir, "nominal" + output_name + ".csv")
        df_nom = pd.read_csv(outpath, index_col=[0, 1])

        print("Lee calificaciones")
        outpath = Path(_output_dir, "calificaciones_summary" + output_name + ".csv")
        df_cal = pd.read_csv(outpath, index_col=[0, 1])

        print(
            df_cal.reset_index(level=0)
            .groupby("año")["Lengua_promedio_Q3"]
            .value_counts(dropna=False, normalize=True)
            .unstack()
        )

        print(
            df_cal.reset_index(level=0)
            .groupby("año")["Matemática_promedio_Q3"]
            .value_counts(dropna=False, normalize=True)
            .unstack()
        )

        print("Lee inasistencias")
        outpath = Path(_output_dir, "inasistencias_summary" + output_name + ".csv")
        df_ina = pd.read_csv(outpath, index_col=[0, 1])

        print("Lee rate")
        outpath = Path(_output_dir, "rate_summary" + output_name + ".csv")
        if outpath.exists():
            df_rate = pd.read_csv(outpath, index_col=[0, 1])
        else:
            df_rate = None

        print("Join")

        df = df_nom

        df = df.join(df_ina, how="inner")
        df = df.join(df_cal, how="inner")
        if df_rate is not None:
            df = df.join(df_rate, how="left")

        columns = {
            "categorical_columns": categorical_columns,
            "numerical_columns": numerical_columns
            + inasistencia_columns
            + calificaciones_columns,
        }

        df.loc[:, columns["categorical_columns"]] = df.loc[
            :, columns["categorical_columns"]
        ].fillna("NA")

        outpath = Path(_output_dir, "join" + output_name + ".csv")
        if not outpath.parent.exists():
            outpath.parent.mkdir(exist_ok=True)

        print("Salva")
        df.to_csv(outpath)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Preprocess")

    parser.add_argument("--calificaciones", default=None)
    parser.add_argument("--nominal", default=None)
    parser.add_argument("--inasistencias", default=None)
    parser.add_argument("--rate", default=None)
    parser.add_argument("--año", default=None)
    parser.add_argument("--mes", default=None)
    parser.add_argument("--join", default=None, action="store_true")
    parser.add_argument("--output_dir", default=".")
    args = parser.parse_args()

    main(args)
