-- examen tema 06
-- David Carrero Jiménez

-- uso la base de datos
USE geslibros;

-- 1. insertar libro.
INSERT INTO libros (
    autor_id,
    editorial_id,
    isbn,
    ean,
    titulo,
    precio_coste,
    precio_venta,
    stock,
    stock_min,
    stock_max,
    fecha_edicion
) VALUES (
    2,
    4,
    '9788408096528',
    '9788888199587',
    'El Retrato de Dorian Gray',
    18.00,
    24.00,
    12,
    5,
    25,
    '2015-03-15'
);

-- 2. insertar libros_temas
INSERT INTO libros_temas (libro_id, tema_id) VALUES
    (20, 3),
    (20, 9);

-- 3. insertar - ventas
INSERT INTO ventas (cliente_id, fecha) VALUES
	(1, '2014-05-10');

-- 4. insertar - lineas ventas
INSERT INTO lineasventas (venta_id, libro_id, cantidad, precio) VALUES
(15, 3, 1, 12.95),
(15, 7, 2, 18.50);

-- 5. update - libros
UPDATE libros SET precio_venta = precio_venta * 1.15 WHERE editoriales = 'Editorial Planeta, S.A.U.';

-- 6. update - libros
UPDATE libros SET stock = stock * 0.8 WHERE stock > 15;

-- 7. delete - libros
DELETE FROM libros WHERE tema_id = 'Viajes';

-- 8. script - clientes
SELECT 
    cliente.id,
    cliente.nombre,
    cliente.direccion,
    cliente.c_postal,
    cliente.nif,
    cliente.telefono,
    cliente.email
FROM clientes
INNER JOIN provincias 
    ON clientes.id_provincia = provincia.id
WHERE 
    clientes.email LIKE '%@gmail.com'
    AND provincias.provincia = 'Guadalajara'
ORDER BY 
    clientes.nombre;

-- 9. script - ventas
SELECT 
    venta.id,
    cliente.nombre AS nombre_cliente,
    venta.fecha,
    venta.importe_bruto,
    venta.importe_iva,
    venta.importe_total
FROM ventas
INNER JOIN clientes
    ON ventas.id_cliente = clientes.id
WHERE YEAR(ventas.fecha) = 2013
ORDER BY ventas.importe_total ASC
LIMIT 5;

-- 10. script - libros
SELECT 
    l.id,
    l.titulo,
    CONCAT(a.nombre, ' ', a.apellidos) AS autor,
    e.nombre AS editorial,
    l.stock,
    l.precio_coste,
    l.precio_venta
FROM libros l
INNER JOIN autores a ON l.id_autor = a.id
INNER JOIN editoriales e ON l.id_editorial = e.id
WHERE l.anio_publicacion = 2014
  AND l.stock < 10
ORDER BY l.titulo;

-- 11. script - libros
SELECT 
    libros.id,
    libros.titulo,
    CONCAT(autores.nombre, ' ', autores.apellidos) AS autor,
    editoriales.nombre AS editorial,
    temas.nombre AS tema,
    l.precio_coste,
    l.precio_venta
FROM libros
INNER JOIN autores ON libros.id_autor = autores.id
INNER JOIN editoriales ON libros.id_editorial = editoriales.id
INNER JOIN libros_temas ON libros.id = libros_temas.id_libro
INNER JOIN temas ON lt.id_tema = temas.id
WHERE temas.nombre = 'Novela'
  AND libros.precio_venta > 20
ORDER BY libros.titulo;

-- 12. script - libros
SELECT 
    libros.id,
    libros.titulo,
    CONCAT(autores.nombre, ' ', autores.apellidos) AS autor,
    editoriales.nombre AS editorial,
    libros.precio_venta
FROM libros
INNER JOIN autores ON libros.id_autor = autores.id
INNER JOIN editoriales ON libros.id_editorial = editoriales.id
WHERE libros.precio_venta > (
    SELECT AVG(precio_venta)
    FROM libros
)
ORDER BY libros.precio_venta DESC;

-- 13. script - ventas
SELECT
	clientes.id,
    clientes.nombre,
    ventas.id,
    ventas.importe_total
FROM ventas
INNER JOIN clientes ON clientes.id_venta = ventas.id
WHERE ventas.importe_total 
ORDER BY numero_ventas

-- 14. script - estadisticas de ventas por libro