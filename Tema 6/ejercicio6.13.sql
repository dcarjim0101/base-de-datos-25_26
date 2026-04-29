-- actividad 6.13 Repaso

-- 1. Script - clientes
SELECT clientes.id, clientes.nombre, clientes.direccion, clientes.nif, clientes.telefono, clientes.email
FROM clientes
WHERE clientes.poblacion = 'Ubrique'
AND clientes.email LIKE '%ieslosremedios.org%'
ORDER BY clientes.nombre;

-- 2. Script - ventas
SELECT ventas.id, clientes.nombre, ventas.fecha, ventas.importe_bruto, ventas.importe_iva, ventas.importe_total
FROM ventas
JOIN clientes ON ventas.cliente_id = clientes.id
WHERE YEAR(ventas.fecha) = 2014
ORDER BY ventas.importe_total DESC
LIMIT 3;

-- 3. Script - libros
SELECT libros.id, libros.titulo, autores.nombre, editoriales.nombre, libros.stock, libros.precio_coste, libros.precio_venta
FROM libros
JOIN autores ON libros.autor_id = autores.id
JOIN editoriales ON libros.editorial_id = editoriales.id
WHERE libros.stock BETWEEN 10 AND 20
AND YEAR(libros.fecha_edicion) = 2011
ORDER BY libros.id;

-- 4. Script - libros
SELECT libros.id, libros.titulo, autores.nombre, editoriales.nombre, libros.stock, libros.precio_coste, libros.precio_venta
FROM libros
JOIN autores ON libros.autor_id = autores.id
JOIN editoriales ON libros.editorial_id = editoriales.id
WHERE (libros.titulo LIKE '%PHP%' OR libros.titulo LIKE '%Bases de Datos%')
AND libros.precio_venta < 30
ORDER BY libros.id;

-- 5. Script - libros
SELECT libros.id, libros.titulo, autores.nombre, editoriales.nombre, libros.stock, libros.precio_coste, libros.precio_venta,
(libros.precio_venta - libros.precio_coste) AS margen_beneficio
FROM libros
JOIN autores ON libros.autor_id = autores.id
JOIN editoriales ON libros.editorial_id = editoriales.id
WHERE editoriales.nombre = 'Anaya'
OR editoriales.nombre = 'Alfaguara'
ORDER BY margen_beneficio DESC;

-- 6. Script - libros
SELECT libros.id, libros.titulo, autores.nombre, editoriales.nombre, libros.stock, libros.precio_coste, libros.precio_venta
FROM libros
JOIN autores ON libros.autor_id = autores.id
JOIN editoriales ON libros.editorial_id = editoriales.id
WHERE libros.precio_coste = (
    SELECT libros.precio_coste
    FROM libros
    WHERE libros.titulo = 'Camboya'
)
ORDER BY libros.id;

-- 7. Script - ventas
SELECT clientes.id, clientes.nombre,
COUNT(ventas.id) AS numero_ventas,
MAX(ventas.importe_total) AS venta_maxima,
MIN(ventas.importe_total) AS venta_minima,
SUM(ventas.importe_total) AS suma_total
FROM ventas
JOIN clientes ON ventas.cliente_id = clientes.id
WHERE YEAR(ventas.fecha) = 2014
GROUP BY clientes.id, clientes.nombre
ORDER BY suma_total;

-- 8. Script - ventas de editoriales
SELECT editoriales.id, editoriales.nombre,
SUM(lineasventas.cantidad) AS numero_libros_vendidos,
SUM(lineasventas.importe) AS importe_total_vendido
FROM ventas
JOIN lineasventas ON ventas.id = lineasventas.venta_id
JOIN libros ON lineasventas.libro_id = libros.id
JOIN editoriales ON libros.editorial_id = editoriales.id
GROUP BY editoriales.id, editoriales.nombre
ORDER BY importe_total_vendido DESC;

-- 9. view - ventas editoriales
CREATE VIEW ventas_editoriales AS
SELECT editoriales.id, editoriales.nombre,
SUM(lineasventas.cantidad) AS numero_libros_vendidos,
SUM(lineasventas.importe) AS importe_total_vendido
FROM ventas
JOIN lineasventas ON ventas.id = lineasventas.venta_id
JOIN libros ON lineasventas.libro_id = libros.id
JOIN editoriales ON libros.editorial_id = editoriales.id
GROUP BY editoriales.id, editoriales.nombre;

-- 10. insertar - libro
INSERT INTO libros (isbn, ean, titulo, autor_id, editorial_id, precio_coste, precio_venta, stock, stock_min, stock_max, fecha_edicion)
VALUES (
'9788448180833',
'9788888199586',
'Nuevo libro de prueba',
1,
5,
15.00,
25.00,
10,
2,
20,
'2024-01-01'
);

-- 11. insertar - libros_temas
INSERT INTO libros_temas (libro_id, tema_id) VALUES
(20, 3),
(20, 9),
(20, 7);

-- 12. insertar - lineas ventas y ventas
INSERT INTO ventas (cliente_id, fecha, importe_bruto, importe_iva, importe_total)
VALUES (1, '2024-05-01', 100.00, 21.00, 121.00);

-- 13. update  - libros
UPDATE libros
SET libros.precio_venta = libros.precio_venta * 1.10
WHERE libros.editorial_id = (
    SELECT editoriales.id
    FROM editoriales
    WHERE editoriales.nombre = 'Anaya'
);

-- 14. update - libros
UPDATE libros
SET libros.precio_venta = libros.precio_venta * 0.70
WHERE libros.id NOT IN (
    SELECT lineasventas.libro_id
    FROM lineasventas
    JOIN ventas ON lineasventas.venta_id = ventas.id
    WHERE YEAR(ventas.fecha) = 2014
);

-- 15. delete - libros
DELETE FROM libros
WHERE libros.id IN (
    SELECT libros_temas.libro_id
    FROM libros_temas
    WHERE libros_temas.tema_id = (
        SELECT temas.id
        FROM temas
        WHERE temas.tema = 'Belleza'
    )
);