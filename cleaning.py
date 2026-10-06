import pandas as pd



##Renombrar columnas CSV
def renombrar_columnas(df):
    return df.rename(columns={
        "TIME_PERIOD#es": "periodo",
        "TIPO_VIAJERO#es": "tipo_de_viajero",
        "LUGAR_RESIDENCIA#es": "residencia",
        "LUGAR_RESIDENCIA_CODE": "codigo_residencia",
        "TERRITORIO#es": "territorio_viaje",
    })

## llamar a la funcion
df = renombrar_columnas(df)

print(df.columns.tolist())   
