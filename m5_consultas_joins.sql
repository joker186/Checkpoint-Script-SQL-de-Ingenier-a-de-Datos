USE VENTAS_TECH_DB;

--Consulta 1 — Vista base del proyecto (INNER JOIN)
SELECT 
    v.fecha_venta,
    c.id_cliente,
    c.nombre_cliente,
    c.ciudad,
    p.id_producto,
    p.nombre_producto AS descripcion_producto,
    p.id_categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas v
INNER JOIN clientes c 
    ON v.id_cliente = c.id_cliente
INNER JOIN productos p 
    ON v.id_producto = p.id_producto;

--Consulta 2 — Clientes sin ventas (LEFT JOIN)
SELECT 
    c.nombre_cliente,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v 
    ON c.id_cliente = v.id_cliente
WHERE v.id_cliente IS NULL;

--Consulta 3 — Productos sin ventas (LEFT JOIN)
SELECT 
    p.nombre_producto,
    p.id_categoria,
    p.precio
FROM productos p
LEFT JOIN ventas v 
    ON p.id_producto = v.id_producto
WHERE v.id_producto IS NULL;

--Consulta 4 — Consolidado por canal (UNION ALL)

SELECT canal, SUM(total) AS total_consolidado
FROM (
    SELECT 'Online' AS canal, cantidad * precio_unitario AS total
    FROM ventas
    WHERE fecha_venta < '2024-03-10'

    UNION ALL

    SELECT 'Presencial' AS canal, cantidad * precio_unitario AS total
    FROM ventas
    WHERE fecha_venta >= '2024-03-10'
) AS consolidado
GROUP BY canal
ORDER BY canal
