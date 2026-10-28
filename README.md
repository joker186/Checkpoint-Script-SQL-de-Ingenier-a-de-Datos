# RetailPro — Checkpoint SQL de Ingeniería de Datos

Script SQL para la construcción del esquema normalizado de ventas (`Ventas_Tech_DB`) y consultas de negocio sobre ese esquema, como parte del proyecto RetailPro del curso de Data Analytics.

## Estructura del repositorio

| Archivo | Contenido |
|---|---|
| `ventas_tech_db.sql` | DDL + seed data: crea las tablas `categorias`, `clientes`, `productos` y `ventas`, con sus relaciones (FK), y carga datos iniciales de ejemplo (4 categorías, 6 clientes, 7 productos, 10 ventas de marzo 2024). |
| `m4_consultas_negocio.sql` | Consultas de negocio: resumen ejecutivo mensual, ranking de productos (Top 5), clientes recurrentes, y meses por encima/debajo del promedio. |
| `m5_consultas_joins.sql` | Consultas con joins: vista base del proyecto (INNER JOIN), clientes sin ventas (LEFT JOIN), productos sin ventas (LEFT JOIN), y totales por canal (UNION ALL). |

## Esquema de datos

Relaciones: una categoría tiene muchos productos; un cliente y un producto pueden tener muchas ventas.

- **categorias**: `id_categoria` (PK), `nombre_categoria`, `descripcion`
- **clientes**: `id_cliente` (PK), `nombre_cliente`, `email` (único), `ciudad`, `fecha_registro`
- **productos**: `id_producto` (PK), `nombre_producto`, `id_categoria` (FK), `precio`, `stock`, `activo`
- **ventas**: `id_venta` (PK), `id_cliente` (FK), `id_producto` (FK), `cantidad`, `precio_unitario`, `fecha_venta`

## Uso

1. Ejecutar `ventas_tech_db.sql` en SQL Server para crear la base `Ventas_Tech_DB` y cargar los datos de ejemplo.
2. Ejecutar `m4_consultas_negocio.sql` para las métricas de negocio.
3. Ejecutar `m5_consultas_joins.sql` para las vistas con joins.

## Notas conocidas

- La consulta de ranking de productos en `m4_consultas_negocio.sql` usa `SELECT TOP 5`, por lo que no refleja el 100% de la facturación del período. Esto se detectó en la práctica: para marzo 2024, el ranking Top 5 sumaba $6.084 mientras el resumen ejecutivo mensual reportaba $6.444 — una diferencia de $360 correspondiente al producto 4, excluido del Top 5. Queda documentado como limitación conocida, no como bug silencioso.
- El corte de fecha usado en la consulta de "totales por canal" (`2024-03-10`) es una regla fija definida en el script, no un dato real de canal de venta.

## Relación con el proyecto RetailPro

Este repo cubre la capa de base de datos y consultas SQL (Pre-entregas 4 y 5). El resto del proyecto RetailPro se construye en Power BI sobre el mismo dataset: Checkpoint 1 (limpieza en Power Query) y Checkpoint 2 (modelo de relaciones + medidas DAX), que luego alimentan el proyecto integrador final.

## Autor

Felipe Cardona — Proyecto RetailPro, curso de Data Analytics.
