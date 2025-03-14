from pathlib import Path


data_to_process = [
    "CALIFICACIONES", "JOIN"]

# data_to_process = [
    # "NOMINAL", "INASISTENCIAS", "CALIFICACIONES", "JOIN"]


last_year = 2024

# Paths
MAIN_DIR = 'data_envio_jun_2024'

path_nominal = {
    2023: Path(MAIN_DIR, "2023","NOMINAL", "10-2023-OCTUBRE.csv"),
    2024: Path(MAIN_DIR, "2024","NOMINAL","05_MAYO_2024_NOMINAL.csv"),
}

path_inasistencias = {
    2023: list(Path(MAIN_DIR, "2023", "ASISTENCIA").rglob("*.csv")),
    2024: list(Path(MAIN_DIR, "2024", "ASISTENCIA").rglob("*.csv"))
}

path_calificaciones = {
    2023: list(Path(MAIN_DIR, "2023", "CALIFICACIONES").rglob("*.csv")),
    2024: list(Path(MAIN_DIR, "2024", "CALIFICACIONES").rglob("*.csv")),
}

path_rate = {
    #2021: list(Path(MAIN_DIR, "RATE", "2021").rglob("*RATE ALUMNOS*.csv")),
    # 2022: list(Path(MAIN_DIR, "RATE", "2022_n").rglob("*RATE ALUMNOS*.csv")),
    # 2023: list(Path(MAIN_DIR, "RATE", "2023_n").rglob("*RATE ALUMNOS*.csv")),
}

output_name = ""

output_dir = "dataframes"

# Nominal
niveles = [
    "Primario",
    "Secundario Orientado",
    "Secundario Técnico",
    "Primario Nacional",
]

year_born_cut = 2000
edad_cut = 5

# columnas_nominal = ['Alumno_ID', 'Persona_ID', 'Sexo', 'Fecha Nacimiento', 'calle', 'número', 'piso', 'barrio', 'manzana', 'casa', 'código postal', 'localidad alumno', 'departamento alumno', 'persona_id_madre', 'fecha nacimiento madre', 'fecha defunción madre', 'ocupación madre', 'nivel de estudio madre', 'calle madre', 'número madre', 'piso madre', 'barrio madre', 'manzana madre', 'casa madre', 'código postal madre', 'localidad madre', 'departamento madre', 'persona_id_padre', 'fecha nacimiento padre',
# 'fecha defunción padre', 'ocupación padre', 'nivel de estudio padre', 'calle padre', 'número padre', 'piso padre', 'barrio padre', 'manzana padre', 'casa padre', 'código postal padre', 'localidad padre', 'departamento padre', 'persona_id_tutor', 'fecha nacimiento tutor', 'fecha defunción tutor', 'ocupación tutor', 'nivel de estudio tutor', 'calle tutor', 'número tutor', 'piso tutor', 'barrio tutor', 'manzana tutor', 'casa tutor', 'código postal tutor', 'localidad tutor', 'departamento tutor']

filtrar_causa_sale = [
    "TRASLADO A OTRA PROVINCIA O PAÍS",
    "PASÓ A EDUCACIÓN DE JOVENES Y ADULTOS", "PASÓ A EDUCACIÓN ESPECIAL",
    "PRIVACIÓN DE LA LIBERTAD", "TRASLADO A OTRO CONTEXTO DE ENCIERRO",
    "FALLECIMIENTO", "*** ELIMINAR POR DATOS ERRONEOS ***"
]

# Calificaciones
recuperaciones = [
    "Complementario Diciembre",
    "Compensatorio Diciembre",
    "Complementario Febrero",
    "Recuperación Saberes Marzo",
    "Compensatorio Marzo ",
    "Compensatorio Marzo",
]

# Inasistencias

tipos_inasistencia = {'asistencia': ['Asistencia'],
                      'faltas': ['faltasReales'],
                      'ausencia_justificada': ['2_Inasistencia_Si_Justificada_contraturno_Si',
                                               '8_Presente_NC_Si_Justificada_contraturno_Si',
                                               '11_Ausente_Tardanza_Si_Justificada_contraturno_Si',
                                               '13_Ausente_Retiro_Si_Justificada_contraturno_Si',
                                               '17_Tardanza+10m,Retiro+10m_Si_Justificada_contraturno_Si',
                                               '26_Ausente_Si_Justificada_contraturno_Si',
                                               '26_Ausente_Si_Justificada_contraturno_Si',
                                               '27_Ausente_Caso_confirmado_COVID_Si_Justificada_contraturno_Si',
                                               '28_Ausente_Caso_sospechoso_COVID_Con_síntomas_Si_Justificada_contraturno_Si',
                                               '34_Ausente_No_Presencial_Si_Justificada_contraturno_Si',
                                               '2_Inasistencia_Si_Justificada_contraturno_No',
                                               '8_Presente_NC_Si_Justificada_contraturno_No',
                                               '11_Ausente_Tardanza_Si_Justificada_contraturno_No',
                                               '13_Ausente_Retiro_Si_Justificada_contraturno_No',
                                               '17_Tardanza+10m,Retiro+10m_Si_Justificada_contraturno_No',
                                               '26_Ausente_Si_Justificada_contraturno_No',
                                               '26_Ausente_Si_Justificada_contraturno_No',
                                               '27_Ausente_Caso_confirmado_COVID_Si_Justificada_contraturno_No',
                                               '34_Ausente_No_Presencial_Si_Justificada_contraturno_No',
                                               '2a',
                                               '8c',
                                               '11a',
                                               '13a',
                                               '17a',
                                               '26a',
                                               '26a',
                                               '27a',
                                               '28a',
                                               '34a',
                                               '2b',
                                               '8d',
                                               '11b',
                                               '13b',
                                               '17b',
                                               '26b',
                                               '26b',
                                               '27b',
                                               '34b'],
                      'tardanza_retiro_justificada': ['3_Tardanza_Si_Justificada_contraturno_Si',
                                                      '4_Retiro_Si_Justificada_contraturno_Si',
                                                      '10_Tardanza+10m_Si_Justificada_contraturno_Si',
                                                      '12_Retiro+10m_Si_Justificada_contraturno_Si',
                                                      '14_Tardanza,Retiro_Si_Justificada_contraturno_Si',
                                                      '15_Tardanza+10m,Retiro_Si_Justificada_contraturno_Si',
                                                      '16_Tardanza,Retiro+10m_Si_Justificada_contraturno_Si',
                                                      '3_Tardanza_Si_Justificada_contraturno_No',
                                                      '4_Retiro_Si_Justificada_contraturno_No',
                                                      '10_Tardanza+10m_Si_Justificada_contraturno_No',
                                                      '12_Retiro+10m_Si_Justificada_contraturno_No',
                                                      '14_Tardanza,Retiro_Si_Justificada_contraturno_No',
                                                      '15_Tardanza+10m,Retiro_Si_Justificada_contraturno_No',
                                                      '16_Tardanza,Retiro+10m_Si_Justificada_contraturno_No',
                                                      '3a',
                                                      '4a',
                                                      '10a',
                                                      '12a',
                                                      '14a',
                                                      '15a',
                                                      '16a',
                                                      '3b',
                                                      '4b',
                                                      '10b',
                                                      '12b',
                                                      '14b',
                                                      '15b',
                                                      '16b'],
                      'tardanza_retiro_injustificada': ['3_Tardanza_No_Justificada_contraturno_No',
                                                        '4_Retiro_No_Justificada_contraturno_No',
                                                        '10_Tardanza+10m_No_Justificada_contraturno_No',
                                                        '12_Retiro+10m_No_Justificada_contraturno_No',
                                                        '14_Tardanza,Retiro_No_Justificada_contraturno_No',
                                                        '15_Tardanza+10m,Retiro_No_Justificada_contraturno_No',
                                                        '16_Tardanza,Retiro+10m_No_Justificada_contraturno_No',
                                                        '3_Tardanza_No_Justificada_contraturno_Si',
                                                        '4_Retiro_No_Justificada_contraturno_Si',
                                                        '10_Tardanza+10m_No_Justificada_contraturno_Si',
                                                        '12_Retiro+10m_No_Justificada_contraturno_Si',
                                                        '14_Tardanza,Retiro_No_Justificada_contraturno_Si',
                                                        '15_Tardanza+10m,Retiro_No_Justificada_contraturno_Si',
                                                        '16_Tardanza,Retiro+10m_No_Justificada_contraturno_Si',
                                                        '3d',
                                                        '4d',
                                                        '10d',
                                                        '12d',
                                                        '14d',
                                                        '15d',
                                                        '16d',
                                                        '3c',
                                                        '4c',
                                                        '10c',
                                                        '12c',
                                                        '14c',
                                                        '15c',
                                                        '16c'],
                      'ausencia_injustificada': ['2_Inasistencia_No_Justificada_contraturno_No',
                                                 '8_Presente_NC_No_Justificada_contraturno_No',
                                                 '11_Ausente_Tardanza_No_Justificada_contraturno_No',
                                                 '13_Ausente_Retiro_No_Justificada_contraturno_No',
                                                 "17_Tardanza+10m,Retiro+10m_No_Justificada_contraturno_No'",
                                                 '17_Tardanza+10m,Retiro+10m_No_Justificada_contraturno_No',
                                                 '26_Ausente_No_Justificada_contraturno_No',
                                                 '28_Ausente_Caso_sospechoso_COVID_Con_síntomas_No_Justificada_contraturno_No',
                                                 '34_Ausente_No_Presencial_No_Justificada_contraturno_No',
                                                 '2_Inasistencia_No_Justificada_contraturno_Si',
                                                 '8_Presente_NC_No_Justificada_contraturno_Si',
                                                 '11_Ausente_Tardanza_No_Justificada_contraturno_Si',
                                                 '13_Ausente_Retiro_No_Justificada_contraturno_Si',
                                                 '17_Tardanza+10m,Retiro+10m_No_Justificada_contraturno_Si',
                                                 '26_Ausente_No_Justificada_contraturno_Si',
                                                 '27_Ausente_Caso_confirmado_COVID_No_Justificada_contraturno_Si',
                                                 '28_Ausente_Caso_sospechoso_COVID_Con_síntomas_No_Justificada_contraturno_Si',
                                                 '34_Ausente_No_Presencial_No_Justificada_contraturno_Si',
                                                 '2d',
                                                 '8b',
                                                 '11d',
                                                 '13d',
                                                 '17d',
                                                 '17d',
                                                 '26d',
                                                 '28d',
                                                 '34d',
                                                 '2c',
                                                 '8a',
                                                 '11c',
                                                 '13c',
                                                 '17c',
                                                 '26c',
                                                 '27c',
                                                 '28c',
                                                 '34c'],
                      'sin_falta': ['7-Fuerza mayor',
                                    '9-No corresponde',
                                    '18-No corresponde',
                                    '19-No debe asistir',
                                    '20-Retira - Inclemencias climáticas',
                                    '21-Retira - Problemas familiares',
                                    '22-Retira - Otros',
                                    '23-No debe asistir - Inclemencias climáticas',
                                    '24-No debe asistir - Problemas Edilicios',
                                    '25-No debe asistir - Otros',
                                    '29-Presente No Presencial',
                                    '30-Presente No Presencial - Alternancia',
                                    '31-Presente No Presencial - Cuarentena - Contacto Estrecho Escolar',
                                    '32-Presente No Presencial - Cuarentena - Contacto Estrecho No Escolar',
                                    '33-Presente No Presencial - Persona en grupo de riesgo',
                                    '7a',
                                    '9a',
                                    '18a',
                                    '19a',
                                    '20a',
                                    '21a',
                                    '22a',
                                    '23a',
                                    '24a',
                                    '25a',
                                    '29a',
                                    '30a',
                                    '31a',
                                    '32a',
                                    '33a']}

prop_inasistencias = {"faltas/asistencia": [],  "todo_nan":[]}

#############################################################################################################
#Columnas de archivos que se esperan
esperadas_calificaciones = ["ID_escuela_","Alumno_ID","Persona_ID","curso_","division_","materia",
                           "cantidad de evaluaciones","cantidad de evaluaciones ausentes","asistencia","notas",
                           "descripcion_evaluacion","fecha_evaluacion","suma_notas","promedio"]

esperadas_nominal = ["Alumno_ID","Persona_ID","Sexo","Fecha Nacimiento","Edad","Curso","Division","causa-entra",
                    "causa-sale","localidad alumno","departamento alumno","Turno","Modalidad","Nivel","Gestion","Supervisión",
                    "ID_escuela","CUE","subcue","Número_escuela","Anexo","Número_Anexo","Nombre_Escuela","Departamento",
                    "Localidad","zona","AMBITO","Regional","latitud","longitud","persona_id_madre","fecha nacimiento madre",
                    "fecha defunción madre","ocupación madre","nivel de estudio madre","localidad madre","departamento madre",
                    "persona_id_padre","fecha nacimiento padre","fecha defunción padre","ocupación padre","nivel de estudio padre",
                    "localidad padre","departamento padre","persona_id_tutor","fecha nacimiento tutor","fecha defunción tutor",
                    "ocupación tutor","nivel de estudio tutor","localidad tutor","departamento tutor"]

esperadas_rate = ["Escuela_ID","CUE","subcue","Número_escuela","Anexo","Número_Anexo","Nombre_Escuela","Nivel","Gestión",
                 "Supervisión","Departamento","Localidad","zona","AMBITO","Regional","Alumno_ID","Persona_ID","curso",
                 "division","RATE_ALUMNO_ID","Fecha de Carga","MES","¿El estudiante necesita recursos tecnológicos para resolver sus",
                 "¿Qué tipo de recurso necesita 1?","¿Qué tipo de recurso necesita 2?","¿Qué tipo de recurso necesita 3?",
                 "¿Qué nivel de vinculación tiene el estudiante con la escuela?","¿Está siendo abordado por SOE?",
                 "¿Está siendo abordado por DOAITE?","¿Está siendo abordado por APOYO PSICOPEDAGOGICO?",
                 "¿Necesita abordaje específico?","¿El estudiante recibe apoyo pedagógico complementario?","Recibe apoyo de:",
                 "¿Necesita apoyo escolar complementario para fortalecer sus saber","¿Esta recibiendo un abordaje específico para la revinculación?",
                 "¿Necesita un abordaje específico?","Seleccione si asistió a alguno de los siguientes talleres"]

esperadas_inasistencias = ["Alumno_ID","Persona_ID","Escuela_ID","Curso","División","Nivel",
                           "Gestión","Supervisión","CUE","subcue","Número_escuela","Anexo",
                           "Departamento","Localidad","año-mes","cDia","Asistencia","faltasReales",
                           "fecha cierre asistencia","cerró_asistencia..??","2_Inasistencia_Si_Justificada_contraturno_Si",
                           "2_Inasistencia_Si_Justificada_contraturno_No","2_Inasistencia_No_Justificada_contraturno_Si",
                           "2_Inasistencia_No_Justificada_contraturno_No","2_Inasistencia_NC_Justificada_contraturno_Si",
                           "2_Inasistencia_NC_Justificada_contraturno_No","3_Tardanza_Si_Justificada_contraturno_Si",
                           "3_Tardanza_Si_Justificada_contraturno_No","3_Tardanza_No_Justificada_contraturno_Si",
                           "3_Tardanza_No_Justificada_contraturno_No","4_Retiro_Si_Justificada_contraturno_Si",
                           "4_Retiro_Si_Justificada_contraturno_No","4_Retiro_No_Justificada_contraturno_Si",
                           "4_Retiro_No_Justificada_contraturno_No","5_Previo_ingreso_NC_Justificada_contraturno_Si",
                           "5_Previo_ingreso_NC_Justificada_contraturno_No","6_Posterior_egreso_NC_Justificada_contraturno_Si",
                           "6_Posterior_egreso_NC_Justificada_contraturno_No","6_Posterior_egreso_No_Justificada_contraturno_Si",
                           "6_Posterior_egreso_No_Justificada_contraturno_No","6_Posterior_egreso_Si_Justificada_contraturno_Si",
                           "6_Posterior_egreso_Si_Justificada_contraturno_No","8_Presente_NC_No_Justificada_contraturno_Si",
                           "8_Presente_NC_No_Justificada_contraturno_No","8_Presente_NC_Si_Justificada_contraturno_Si",
                           "8_Presente_NC_Si_Justificada_contraturno_No","10_Tardanza+10m_Si_Justificada_contraturno_Si",
                           "10_Tardanza+10m_Si_Justificada_contraturno_No","10_Tardanza+10m_No_Justificada_contraturno_Si",
                           "10_Tardanza+10m_No_Justificada_contraturno_No","11_Ausente_Tardanza_Si_Justificada_contraturno_Si",
                           "11_Ausente_Tardanza_Si_Justificada_contraturno_No","11_Ausente_Tardanza_No_Justificada_contraturno_Si",
                           "11_Ausente_Tardanza_No_Justificada_contraturno_No","12_Retiro+10m_Si_Justificada_contraturno_Si",
                           "12_Retiro+10m_Si_Justificada_contraturno_No","12_Retiro+10m_No_Justificada_contraturno_Si",
                           "12_Retiro+10m_No_Justificada_contraturno_No","13_Ausente_Retiro_Si_Justificada_contraturno_Si",
                           "13_Ausente_Retiro_Si_Justificada_contraturno_No","13_Ausente_Retiro_No_Justificada_contraturno_Si",
                           "13_Ausente_Retiro_No_Justificada_contraturno_No","14_Tardanza,Retiro_Si_Justificada_contraturno_Si",
                           "14_Tardanza,Retiro_Si_Justificada_contraturno_No","14_Tardanza,Retiro_No_Justificada_contraturno_Si",
                           "14_Tardanza,Retiro_No_Justificada_contraturno_No","15_Tardanza+10m,Retiro_Si_Justificada_contraturno_Si",
                           "15_Tardanza+10m,Retiro_Si_Justificada_contraturno_No","15_Tardanza+10m,Retiro_No_Justificada_contraturno_Si",
                           "15_Tardanza+10m,Retiro_No_Justificada_contraturno_No","16_Tardanza,Retiro+10m_Si_Justificada_contraturno_Si",
                           "16_Tardanza,Retiro+10m_Si_Justificada_contraturno_No","16_Tardanza,Retiro+10m_No_Justificada_contraturno_Si",
                           "16_Tardanza,Retiro+10m_No_Justificada_contraturno_No","17_Tardanza+10m,Retiro+10m_Si_Justificada_contraturno_Si",
                           "17_Tardanza+10m,Retiro+10m_Si_Justificada_contraturno_No","17_Tardanza+10m,Retiro+10m_No_Justificada_contraturno_Si",
                           "17_Tardanza+10m,Retiro+10m_No_Justificada_contraturno_No","26_Ausente_Si_Justificada_contraturno_Si",
                           "26_Ausente_Si_Justificada_contraturno_No","26_Ausente_No_Justificada_contraturno_Si","26_Ausente_No_Justificada_contraturno_No",
                           "26_Ausente_NC_Justificada_contraturno_Si","26_Ausente_NC_Justificada_contraturno_No","27_Ausente_Caso_confirmado_COVID_Si_Justificada_contraturno_Si",
                           "27_Ausente_Caso_confirmado_COVID_Si_Justificada_contraturno_No","27_Ausente_Caso_confirmado_COVID_No_Justificada_contraturno_Si",
                           "27_Ausente_Caso_confirmado COVID_No_Justificada_contraturno_No","27_Ausente_Caso_confirmado_COVID_NC_Justificada_contraturno_Si",
                           "27_Ausente_Caso_confirmado_COVID_NC_Justificada_contraturno_No","28_Ausente_Caso_sospechoso_COVID_Con_síntomas_Si_Justificada_contraturno_Si",
                           "28_Ausente_Caso sospechoso_COVID_Con_síntomas_Si_Justificada_contraturno_No","28_Ausente_Caso_sospechoso_COVID_Con_síntomas_No_Justificada_contraturno_Si",
                           "28_Ausente_Caso_sospechoso_COVID_Con_síntomas_Si_Justificada_contraturno_Si","28_Ausente_Caso sospechoso_COVID_Con_síntomas_Si_Justificada_contraturno_No",
                           "28_Ausente_Caso_sospechoso_COVID_Con_síntomas_No_Justificada_contraturno_Si","28_Ausente_Caso_sospechoso_COVID_Con_síntomas_No_Justificada_contraturno_No",
                           "28_Ausente_Caso_sospechoso_COVID_Con_síntomas_NC_Justificada_contraturno_Si","28_Ausente_Caso_sospechoso_COVID_Con_síntomas_NC_Justificada_contraturno_No",
                           "34_Ausente_No_Presencial_Si_Justificada_contraturno_Si","34_Ausente_No_Presencial_Si_Justificada_contraturno_No","34_Ausente_No_Presencial_No_Justificada_contraturno_Si",
                           "34_Ausente_No_Presencial_No_Justificada_contraturno_No","34_Ausente_No_Presencial_NC_Justificada_contraturno_Si","34_Ausente_No_Presencial_NC_Justificada_contraturno_No",
                           "1-Resumen mensual","7-Fuerza mayor","9-No corresponde","18-No corresponde","19-No debe asistir","20-Retira - Inclemencias climáticas",
                           "21-Retira - Problemas familiares","22-Retira - Otros","23-No debe asistir - Inclemencias climáticas","24-No debe asistir - Problemas Edilicios","25-No debe asistir - Otros",
                           "29-Presente No Presencial","30-Presente No Presencial - Alternancia","31-Presente No Presencial - Cuarentena - Contacto Estrecho Escolar",
                           "32-Presente No Presencial - Cuarentena - Contacto Estrecho No Escolar","33-Presente No Presencial - Persona en grupo de riesgo"]
########################################################################################################################
# Partitioning

N = 5
partitions = [{
    "name": f"N5_year2023",
    "años": [2023],
    "proportions": [1 / N for i in range(N - 1)],
    "stratify_columns": ["Nivel", "Departamento", "status"],
    "independent_columns": "Alumno_ID",
    "nominal_path":"dataframes/nominal.csv"
}]

########################################################################################################################
# Modeling

random_seed = 123456

categorical_columns = [
    "Sexo",
    "localidad alumno",
    "departamento alumno",
    "ocupación madre",
    "nivel de estudio madre",
    "ocupación padre",
    "nivel de estudio padre",
    "Departamento",
    "Localidad",
    "zona_cat",
    "AMBITO",
    "Regional",
    "Turno",
    "Modalidad",
    "Nivel",
    "nivel_educativo",
    "Gestion",
    "mes_nacimiento",
    "datos_responsables",
    "n_tutores",
]

calificaciones_columns = [
    "Lengua_promedio_Q3",
    "Matemática_promedio_Q3",
    "Lengua_ratio_ausencia_mes",
    "Matemática_ratio_ausencia_mes",
    "Lengua_ausencias",
    "Matemática_ausencias",
    "Lengua_mes_ultima_fecha",
    "Matemática_mes_ultima_fecha",
    "Lengua_recuperaciones",
    "Matemática_recuperaciones",
]

numerical_columns = [
    "prop_masc",
    "sobreedad",
    "sobreedad_entero",
    "sobreedad_fraccion",
    "grado",
    "zona_numero",
]
inasistencia_columns_simple = [
    "faltas/asistencia_mean",
    "faltas/asistencia_std",
    "faltas/asistencia_max",
    "faltas/asistencia_min",
    "todo_nan_mean",
    "todo_nan_std",
    "todo_nan_max",
    "todo_nan_min"
]

inasistencia_columns = [
    "asistencia_mean",
    "asistencia_std",
    "asistencia_max",
    "asistencia_min",
    "faltas_mean",
    "faltas_std",
    "faltas_max",
    "faltas_min",
    "ausencia_justificada_mean",
    "ausencia_justificada_std",
    "ausencia_justificada_max",
    "ausencia_justificada_min",
    "ausencia_injustificada_mean",
    "ausencia_injustificada_std",
    "ausencia_injustificada_max",
    "ausencia_injustificada_min",
    "sin_falta_mean",
    "sin_falta_std",
    "sin_falta_max",
    "sin_falta_min"
]

rate_columns = [
    'dispositivo', 'conectividad_hogar', 'conectividad_zona', 'soe', 'doaite',
    'apoyo_psicopedagogico', 'recursos_tecnologicos', 'necesita_apoyo',
    'apoyo_especifico', 'vinculacion'
]

experiments = [
       {
        "name":
        "JUNIO2024_NOMINAL_CALIFICACIONES_INASISTENCIASIMPLE_ANUAL",
        "partitions":
        "partitions/partitions_N5_year2023.pkl",
        # "xval": [0, 1, 2, 3, 4],
        "train": [0,1,2,3],
        "test": [4],
        "años": [2023],
        "categorical_columns":
        categorical_columns,
        "numerical_columns":
        numerical_columns + inasistencia_columns_simple + calificaciones_columns,
        "test_separate_rows_by": ["año","nivel_educativo"],
        "train_separate_rows_by": "año",
        "inasistencias_path":
        "dataframes/inasistencias_summary.csv",
        "nominal_path":
        "dataframes/nominal.csv",
        "calificaciones_path":
        "dataframes/calificaciones_summary.csv",
    }
   
]
