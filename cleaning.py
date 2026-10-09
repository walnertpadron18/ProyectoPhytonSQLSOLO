import pandas as pd


def agregar_anio(df):
    """Crea la columna AÑO (número entero) a partir de TIME_PERIOD_CODE."""
    df = df.copy()
    df["AÑO"] = df["TIME_PERIOD_CODE"].str[:4].astype(int)
    return df

## Filtrar turistas desde el año 2020 al 2025 
def filtrar_turistas(df, anio_inicio=2020, anio_fin=2025, medida="TURISTAS"):
    """Devuelve una copia con las filas del rango de años y la medida indicados."""
    filtro = (
        (df["AÑO"] >= anio_inicio)
        & (df["AÑO"] <= anio_fin)
        & (df["MEDIDAS_CODE"] == medida)
    )
    return df[filtro].copy()


## Modificar nombre de columnas

# cleaning.py

COLUMNAS = [
    "TIME_PERIOD_CODE",
    "TIME_PERIOD#es",
    "TIPO_VIAJERO#es",
    "LUGAR_RESIDENCIA#es",
    "LUGAR_RESIDENCIA_CODE",
    "TERRITORIO#es",
    "OBS_VALUE",
]

NOMBRES_COLUMNAS = {
    "TIME_PERIOD_CODE": "periodo_codigo",
    "TIME_PERIOD#es": "mes_año",
    "TIPO_VIAJERO#es": "tipo_viajero",
    "LUGAR_RESIDENCIA#es": "lugar_residencia",
    "LUGAR_RESIDENCIA_CODE": "lugar_residencia_code",
    "TERRITORIO#es": "isla_destino",
    "OBS_VALUE": "num_turistas",
}


def preparar_proyecto(df, columnas=COLUMNAS, nombres=NOMBRES_COLUMNAS):
    """Selecciona las columnas indicadas y las renombra."""
    faltan = [c for c in columnas if c not in df.columns]
    if faltan:
        raise KeyError(f"Faltan columnas en el DataFrame: {faltan}")

    return df[columnas].rename(columns=nombres)


COLUMNAS_AGRUPAR = [
    "periodo_codigo",
    "mes_año",
    "tipo_viajero",
    "lugar_residencia",
    "lugar_residencia_code",
    "isla_destino",
]
## Suma 
def agregar_turistas(df, agrupar_por=COLUMNAS_AGRUPAR, valor="num_turistas"):
    """Suma `valor` para cada combinación de las columnas de agrupación."""
    faltan = [c for c in agrupar_por + [valor] if c not in df.columns]
    if faltan:
        raise KeyError(f"Faltan columnas en el DataFrame: {faltan}")

    return df.groupby(agrupar_por, as_index=False)[valor].sum()


URL_CLIMA = "https://archive-api.open-meteo.com/v1/archive"


def pedir_clima(latitud, longitud, inicio="2020-01-01", fin="2025-07-31",
                zona="Atlantic/Canary"):
    """Pide a Open-Meteo el clima diario de un punto y lo devuelve como DataFrame."""
    params = {
        "latitude": float(latitud),
        "longitude": float(longitud),
        "start_date": inicio,
        "end_date": fin,
        "daily": "temperature_2m_mean,precipitation_sum,sunshine_duration",
        "timezone": zona,
    }
    r = requests.get(URL_CLIMA, params=params, timeout=30)
    r.raise_for_status()

    dias = pd.DataFrame(r.json()["daily"])
    dias["time"] = pd.to_datetime(dias["time"])
    return dias


def clima_mensual(dias):
    """Pasa el clima diario a mensual: temperatura media, lluvia total y sol total."""
    dias = dias.copy()
    dias["periodo"] = dias["time"].dt.to_period("M").dt.to_timestamp()

    return dias.groupby("periodo", as_index=False).agg(
        temp_media=("temperature_2m_mean", "mean"),
        lluvia_total=("precipitation_sum", "sum"),
        sol_total=("sunshine_duration", "sum"),
    )

