Título del proyecto
Análisis Estratégico del Flujo Turístico y el multidestino en Canarias (2020–2025)

Objetivo del proyecto
El objetivo de este proyecto es analizar la evolución de las llegadas de turistas a Canarias, diferenciando entre destinos principales y secundarios. Con ello, busco identificar patrones de movilidad interinsular y dependencia de mercados emisores para optimizar la promoción turística de las islas.

Contexto del negocio
Empresa: Consejería de Turismo / Promotora del Sector Turístico Canario (Caso aplicado con datos reales).

Desafío: Alta concentración de demanda en islas principales (Tenerife y Gran Canaria) y vulnerabilidad a cambios en mercados clave como Reino Unido y Alemania.

Decisiones a tomar: Dónde asignar el presupuesto publicitario internacional, cómo incentivar el turismo interinsular hacia islas no capitalinas (como La Palma) y qué mercados diversificar.

Dataset
Fuente: Instituto Canario de Estadística (ISTAC) — Operación FRONTUR-Canarias (Matriz E16028B_000011).

Variables principales:

TIME_PERIOD: Periodo de tiempo mensual (desde 2010 hasta 2024).

LUGAR_RESIDENCIA: País de origen del turista (ej. Reino Unido, Alemania, España).

TERRITORIO: Isla de destino (Tenerife, Gran Canaria, Lanzarote, Fuerteventura, La Palma).

TIPO_VIAJERO: Clasificación entre Turista Total, Turista Principal y Turista Secundario.

OBS_VALUE: Número de turistas o tasa de variación asociada.

Notas sobre calidad del dato
Se detectaron registros vacíos (NaN) en la categoría de Turistas secundarios para islas menores o periodos concretos, debidos a muestras pequeñas (menos de 20 observaciones según notas del ISTAC).

En el análisis se filtraron los totales generales para evitar la doble contabilización entre mercados locales y globales.

Preguntas clave
¿Cuáles son los principales mercados emisores de turistas hacia cada isla?

¿Qué proporción de turistas visita más de una isla (turistas secundarios) y qué islas se benefician más de este flujo?

¿Cómo ha evolucionado la recuperación del volumen turístico tras la pandemia?

Proceso de análisis
Limpieza y transformación: Filtrado de registros en Python (pandas) para separar cifras absolutas de tasas de variación, y tratamiento de valores nulos.

Exploración de datos (EDA): Agregación temporal por años/meses e islas para identificar estacionalidad.

Metodología aplicada:

Análisis de dependencia de mercado: Cálculo de la cuota de mercado por país de residencia.

Resultados / Insights
Dominio de Reino Unido y Alemania: Representan más del 50% del total de visitantes internacionales. 

Estacionalidad estable: El volumen se mantiene robusto todo el año, con picos marcados en los meses de invierno para el mercado nórdico y alemán, y en verano para el mercado nacional.

Recomendaciones de negocio
Promover paquetes "Multi-Isla": Crear incentivos o alianzas con aerolíneas y navieras locales para conectar paquetes de estancia combinada (ej. Tenerife + La Palma o Gran Canaria + Fuerteventura).

Diversificación de mercados: Incrementar la inversión publicitaria en mercados emergentes del centro y norte de Europa para reducir la dependencia directa de Reino Unido.

Campañas específicas por isla: Orientar la promoción de islas no capitalinas hacia el turista que ya está alojado en las islas principales como excursión de 1 o 2 días.

Limitaciones
El dataset no incluye el gasto medio por turista ni la duración media de la estancia, lo que impide medir el impacto económico exacto de los turistas secundarios frente a los principales.

Al ser datos agregados mensualmente, no se pueden rastrear los itinerarios individuales de los viajeros entre islas.

Próximos pasos
Cruzar esta información con las tablas de gasto turístico del ISTAC (EGATUR) para calcular el valor monetario de cada tipo de turista.

Crear un modelo predictivo con Prophet o ARIMA para proyectar la llegada de turistas por isla en los próximos 12 meses.

Cómo replicar el proyecto
Código y Análisis: Todo el código en Python utilizado para la limpieza y los gráficos está disponible en mi repositorio de GitHub: [enlace-a-tu-github].

Dataset Original: Se puede descargar directamente desde la API del ISTAC mediante el código de matriz E16028B_000011.