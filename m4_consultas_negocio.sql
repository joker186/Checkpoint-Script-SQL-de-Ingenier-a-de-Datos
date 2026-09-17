--Consulta 1 — Resumen ejecutivo mensual

SELECT 
    MONTH(fecha_venta) AS mes, -- no se uso EXTRACT(MONTH FROM fecha_venta) como esta en la plataforma porque uso SQL Server. 
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

--Consulta 2 — Ranking de productos

SELECT TOP 5
    id_producto,
    SUM(cantidad) AS total_unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;


--Consulta 3 — Clientes recurrentes

SELECT 
    id_cliente,
    COUNT(*) AS cantidad_compras,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;

--Consulta 4 — Meses por encima/por debajo del promedio

WITH ventas_mensuales AS (
    SELECT 
        MONTH(fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_mes
    FROM ventas
    GROUP BY MONTH(fecha_venta)
)
SELECT 
    mes,
    total_mes,
    CASE 
        WHEN total_mes >= (SELECT AVG(total_mes) FROM ventas_mensuales) THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_promedio
FROM ventas_mensuales
ORDER BY mes;

--Comentarios:

--1. El total de ventas de marzo fue $6444 con un total de 10 ventas con un ticket promedio de $644.40

--2. el producto 2 es el más vendido durante el mes de marzo con 13 unidades vendidas pero el producto 1 
--   que solo tuvo 3 ventas es mas rentable porque genero un total de $3600.

--3. Todos los clientes hicieron por lo menos dos compras al mes pero los clientes 1 y 5 fueron los que superaron el promedio de ventas.

--4. Marzo estuvo por encima del promedio mensual general respeto al periodo de 12 meses.


