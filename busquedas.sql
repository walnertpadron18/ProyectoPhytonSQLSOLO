-- Media de turistas que viajan a canarias por mes
WITH mensual AS (
    SELECT t.periodo, SUM(t.turistas) AS turistas
    FROM turismo t
    JOIN tipo_viajero tv ON tv.id_tipo_viajero = t.id_tipo_viajero
    WHERE tv.tipo_de_viajero = 'Turista'
    GROUP BY t.periodo
)
SELECT MONTH(periodo) AS mes,
       ROUND(AVG(turistas)) AS media_turistas
FROM mensual
GROUP BY MONTH(periodo)
ORDER BY mes;

-- Media de paises que hacen turismo en invierno y verano

SELECT r.residencia,
       ROUND(AVG(CASE WHEN MONTH(t.periodo) IN (11,12,1,2,3) THEN t.turistas END)) AS media_invierno,
       ROUND(AVG(CASE WHEN MONTH(t.periodo) IN (6,7,8)       THEN t.turistas END)) AS media_verano
FROM turismo t
JOIN residencia r    ON r.codigo_residencia = t.codigo_residencia
JOIN tipo_viajero tv ON tv.id_tipo_viajero  = t.id_tipo_viajero
WHERE tv.tipo_de_viajero = 'Turista'
GROUP BY r.residencia
ORDER BY r.residencia;

-- Calcular los paises que mas viajan a canarias

SELECT r.residencia,
       SUM(t.turistas) AS turistas,
       ROUND(100 * SUM(t.turistas) / SUM(SUM(t.turistas)) OVER (), 1) AS porcentaje
FROM turismo t
JOIN residencia r    ON r.codigo_residencia = t.codigo_residencia
JOIN tipo_viajero tv ON tv.id_tipo_viajero  = t.id_tipo_viajero
WHERE tv.tipo_de_viajero = 'Turista'           
GROUP BY r.residencia
ORDER BY turistas DESC;


-- primer turismo luego de la pandemia

SELECT t.periodo,
       SUM(CASE WHEN r.residencia LIKE 'España%' THEN t.turistas END)  AS nacionales,
       SUM(CASE WHEN r.residencia NOT LIKE 'España%' THEN t.turistas END) AS internacionales
FROM turismo t
JOIN residencia r    ON r.codigo_residencia = t.codigo_residencia
JOIN tipo_viajero tv ON tv.id_tipo_viajero  = t.id_tipo_viajero
WHERE tv.tipo_de_viajero = 'Turista'          
  AND YEAR(t.periodo) IN (2020, 2021)
GROUP BY t.periodo
ORDER BY t.periodo;
