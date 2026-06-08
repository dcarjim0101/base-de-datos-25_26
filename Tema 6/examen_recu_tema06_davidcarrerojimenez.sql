-- examen recuperacion tema 6
-- David Carrero Jimenez

-- 1. Insertar autor
-- Insertar un nuevo autor en la base de datos con los siguientes datos:

-- Nombre: Miguel de Cervantes
-- Nacionalidad: España
-- Email: miguelcervantes@gmail.com
-- Fecha de nacimiento: 1547-09-29
-- Fecha de defunción: 1616-04-23
-- Premios: Cervantes

USE geslibros;

INSERT INTO autores (id, nombre, nacionalidad, email, fecha_nac, fecha_def, premios) VALUES
(8, 'Miguel de Cervantes', 'España', 'miguelcervantes@gmail.com', '1547-09-29', '1616-04-23', 'Cervantes');


-- 2. Insertar libro
-- Insertar un nuevo libro en la base de datos con los siguientes datos:

-- Autor: Miguel de Cervantes (el insertado en el ejercicio anterior)
-- Editorial: Anaya
-- ISBN: 9788469604625
-- EAN: 9788888200014
-- Título: Don Quijote de la Mancha
-- Precio de coste: 15.00 €
-- Precio de venta: 22.50 €
-- Stock: 20 unidades
-- Stock mínimo: 5, Stock máximo: 30
-- Fecha de edición: 2016-10-12

INSERT INTO libros (id, autor_id, editorial_id, isbn, ean, titulo, precio_coste, precio_venta, stock, stock_min, stock_max, fecha_edicion) VALUES
(20, 8, 6, '9788469604625', '9788888200014', 'Don Quijote de la Mancha', '15.00 €', '22.50 €', 20, 5, 30, '2016-10-12');


-- 3. Insertar - Libros_Temas
-- Insertar los registros necesarios en la tabla libros_temas para asociar el libro insertado anteriormente con las temáticas de Novela e Historia.

INSERT INTO libros_temas (libro_id, tema_id)
VALUES
(
    (SELECT id FROM libros WHERE titulo = 'Don Quijote de la Mancha'),
    (SELECT id FROM temas WHERE tema = 'Novela')
);

INSERT INTO libros_temas (libro_id, tema_id)
VALUES
(
    (SELECT id FROM libros WHERE titulo = 'Don Quijote de la Mancha'),
    (SELECT id FROM temas WHERE tema = 'Historia')
);


-- 4. Update - Libros
-- Actualizar el precio de venta de todos los libros de la editorial Anaya incrementándolo en un 10%.

UPDATE libros SET precio_venta = precio_venta * 1.10
WHERE editorial_id = (
    SELECT id
    FROM editoriales
    WHERE nombre = 'Anaya'
);


-- 5. Update - Libros
-- Incrementar el stock máximo en 5 unidades para todos aquellos libros cuyo stock actual sea inferior al stock mínimo.

UPDATE libros SET stock_max = stock_max + 5 WHERE stock < stock_min;


-- 6. Delete - Autores
-- Eliminar de la base de datos todos los autores que no tengan ningún libro asociado en la tabla libros.

DELETE FROM autores
WHERE id NOT IN (
    SELECT autor_id
    FROM libros
    WHERE autor_id IS NOT NULL
);


-- 7. Script - Clientes
-- Mostrar aquellos clientes cuya dirección de email pertenezca al dominio "correo.es" y que estén ubicados en la provincia de Guadalajara.
-- Tablas: clientes, provincias Condición: email contenga el dominio correo.es y provincia sea Guadalajara Columnas: id, nombre, dirección, c_postal, nif, telefono y email Orden: nombre

SELECT id, nombre, direccion, c_postal, nif, telefono, email
FROM clientes c
JOIN provincias p
	ON c.provincia_id = p.id
WHERE email LIKE '%correo.es' AND provincia = 'Guadalajara'
ORDER BY nombre;


-- 8. Script - Libros
-- Mostrar los libros editados entre 2012 y 2014 (ambos incluidos) cuyo precio de venta sea inferior a 20 €.
-- Tablas: libros, autores, editoriales Condición: fecha_edicion entre 2012 y 2014, precio_venta inferior a 20 € Columnas: id, título, autor, editorial, fecha_edicion, precio_coste, precio_venta Orden: fecha_edicion de más reciente a más antigua

SELECT
    l.id, 
    l.titulo, 
    a.nombre AS autor, 
    e.nombre AS editorial, 
    l.fecha_edicion, 
    l.precio_coste, 
    l.precio_venta
FROM libros l
JOIN autores a
	ON l.autor_id = a.id
JOIN editoriales e
	ON l.editorial_id = e.id
WHERE YEAR(l.fecha_edicion) BETWEEN 2012 AND 2014 AND l.precio_venta < 20
ORDER BY l.fecha_edicion DESC;


-- 9. Script - Libros
-- Mostrar los libros de temática Informática cuyo precio de venta sea inferior al precio medio de todos los libros de la base de datos.
-- Tablas: libros, autores, editoriales, libros_temas, temas Condición: temática Informática y precio_venta menor que el promedio general Columnas: id, título, autor, editorial, tema, precio_coste, precio_venta Orden: precio_venta de menor a mayor Notas: se precisa subconsulta con función AVG()

SELECT 
    l.id, 
    l.titulo, 
    a.nombre AS autor, 
    e.nombre AS editorial, 
    t.tema, l.precio_coste, 
    l.precio_venta
FROM libros l
JOIN autores a
	ON l.autor_id = a.id
JOIN editoriales e
	ON l.editorial_id = e.id
JOIN libros_temas lt
	ON l.id = lt.libro_id
JOIN temas t
	ON lt.tema_id = t.id
WHERE t.tema = 'Informática'
AND l.precio_venta < (
	SELECT AVG(precio_venta) FROM libros
)
ORDER BY l.precio_venta;


-- 10. Script - Libros
-- Mostrar los libros cuyo stock sea inferior al stock mínimo (es decir, que están por debajo del nivel mínimo de existencias).
-- Tablas: libros, autores, editoriales Condición: stock < stock_min Columnas: id, título, autor, editorial, stock, stock_min, stock_max Orden: stock de menor a mayor

SELECT
    l.id, 
    l.titulo, 
    a.nombre AS autor, 
    e.nombre AS editorial, 
    l.stock, 
    l.stock_min, 
    l.stock_max
FROM libros l
JOIN autores a
	ON l.autor_id = a.id
JOIN editoriales e
	ON l.editorial_id = e.id
WHERE l.stock < l.stock_min
ORDER BY l.stock;


-- 11. Script - ventas
-- Mostrar las 5 ventas con mayor importe total realizadas en el año 2014.
-- Tablas: ventas, clientes Condición: sólo las del año 2014 Columnas: id, nombre cliente, fecha de la venta, importe_bruto, importe_iva e importe_total Orden: por importe total de mayor a menor

SELECT
    v.id,
    c.nombre AS cliente,
    v.fecha,
    v.importe_bruto,
    v.importe_iva,
    v.importe_total
FROM ventas v
JOIN clientes c
	ON v.cliente_id = c.id
WHERE YEAR(v.fecha) = 2014
ORDER BY v.importe_total DESC
LIMIT 5;


-- 12. Script - Libros
-- Mostrar los libros que nunca han sido vendidos (no aparecen en ninguna línea de venta).
-- Tablas: libros, autores, editoriales, lineasventas Condición: libros sin registros en lineasventas Columnas: id, título, autor, editorial, stock, precio_venta Orden: título Notas: se precisa subconsulta con NOT IN o LEFT JOIN con IS NULL

SELECT
    l.id,
    l.titulo,
    a.nombre AS autor,
    e.nombre AS editorial,
    l.stock, 
    l.precio_venta
FROM libros l
JOIN autores a
	ON l.autor_id = a.id
JOIN editoriales e
	ON l.editorial_id = e.id
WHERE l.id NOT IN (
	SELECT libro_id FROM lineasventas
)
ORDER BY l.titulo;


-- 13. Script - ventas por editorial
-- Mostrar el número de libros vendidos y el importe total facturado agrupado por editorial.
-- Tablas: ventas, lineasventas, libros, editoriales Condición: todas las editoriales con ventas registradas Columnas: id de la editorial, nombre de la editorial, número de libros vendidos, importe total Orden: importe total de mayor a menor Notas: se precisa GROUP BY y funciones de agregación COUNT() y SUM()

SELECT
    e.id,
    e.nombre AS editorial,
    COUNT(*) AS num_libros_vendidos,
    SUM(lv.importe_total) AS importe_total
FROM editoriales e
JOIN libros l
	ON e.id = l.editorial_id
JOIN lineasventas lv
	ON l.id = lv.libro_id
JOIN ventas v
	ON lv.venta_id = v.id
GROUP BY e.id, e.nombre
ORDER BY importe_total DESC;


-- 14. Script - estadisticas de clientes
-- Mostrar el número de ventas realizadas, el importe mínimo, el importe máximo y el importe medio de las ventas por cada cliente.
-- Tablas: ventas, clientes Condición: todos los clientes que tengan al menos una venta Columnas: id del cliente, nombre del cliente, número de ventas, importe mínimo, importe máximo, importe medio Orden: número de ventas de mayor a menor Notas: se precisa GROUP BY y funciones de agregación COUNT(), MIN(), MAX() y AVG()

SELECT
    c.id,
    c.nombre,
    COUNT(*) AS num_ventas
    MIN(v.importe_total) AS importe_minimo,
    MAX(v.importe_total) AS importe_maximo,
    AVG(v.importe_total) AS importe_medio
FROM clientes c
JOIN ventas v
	ON c.id = v.cliente_id
GROUP BY c.id, c.nombre
ORDER BY num_ventas DESC;