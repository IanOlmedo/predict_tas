# Predictor de ITE

## **Instalación**

* Instalar Miniconda para el sistema operativo donde se quiera correr el modelo con una versión de Python 3.8 o superior: https://conda.io/projects/conda/en/latest/user-guide/install/index.html .
* Crear un entorno virtual: <br>
```conda create -n myenv python```
* Instalar las dependencias necesarias con el siguiente comando: <br>
```pip install -r requirements.txt```
## **Estructura de carpetas** 

```
├── ASISTENCIA
│   └── 2022
│       ├── 03-MARZO ASISTENCIA 2022.csv
│       ├── 04-ABRIL ASISTENCIA 2022.csv
│       ├── 05-MAYO ASISTENCIA 2022.csv
│       ├── 06-JUNIO ASISTENCIA 2022.csv
│       └── 07-JULIO ASISTENCIA 2022.csv
├── RATE_ALUMNO
│   └── 2022
│       ├── 03-MARZO RATE ALUMNO 2022.csv
│       ├── 04-ABRIL RATE ALUMNO 2022.csv
│       ├── 05-MAYO RATE ALUMNO 2022.csv
│       ├── 06-JUNIO RATE ALUMNO 2022.csv
│       └── 07-JULIO RATE ALUMNO 2022.csv
├── CALIFICACIONES
│   └── 2022
│       ├── 2022 - CALIFICACIONES LENGUA.csv
│       ├── 2022 - CALIFICACIONES LENGUA Y LITERATURA.csv
│       └── 2022 - CALIFICACIONES MATEMATICA.csv
└── NOMINAL
    └── 2022
        └── 2022 - NOMINAL.csv
```

## **Ejecución**
```
python preprocess.py --calificaciones ruta/CALIFICACIONES/2022 --nominal ruta/NOMINAL/2022.csv --inasistencias ruta/ASISTENCIA/2022 --rate ruta/RATE/2022 --join --año 2022 --output_dir test2022
```

```
python predict.py --model model_checkpoints/DATOS_FINAL_NOMINAL_CALIFICACIONES_INASISTENCIA_ANUAL_RATE_2021_0.catboost --columns model_checkpoints/DATOS_FINAL_NOMINAL_CALIFICACIONES_INASISTENCIA_ANUAL_RATE_2021_cols.json --join test2022/join.csv --output_dir test2022 --umbrales 0.2 0.8
```

```
python visualization.py --predict test2022/predict_output.csv --join test2022/join.csv --output_dir test2022
```

# Entrenar Modelo

Indicar en ```config.py``` las rutas a los datos de los años que se quieran usar  

```
python preprocess.py
python modeling.py
```
