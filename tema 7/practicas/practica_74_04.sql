-- actividad 7.4 Base de datos
-- David Carrero Jiménez

USE geslibros;

-- 1. Incluye en una transacción un proceso que realice las siguientes actualizaciones:
START TRANSACTION;
UPDATE libros SET precio_venta = precio_venta * 0.9
WHERE id IN (SELECT libro_id FROM libros_temas WHERE tema_id =
(SELECT id FROM temas WHERE tema = 'Novela'));

-- los libros de la editorial anaya se incrementan el precio un 6%
UPDATE libros SET precio_venta = precio_venta * 1.06
WHERE editorial_id = (SELECT id FROM editoriales WHERE nombre LIKE '%Anaya%');

-- resto de las editoriales se reduce un 4,5%
UPDATE libros SET precio_venta = precio_venta * 0.955
WHERE editorial_id != (SELECT id FROM editoriales WHERE nombre LIKE '%Anaya%');

-- 2. finalizar transaccion deshaciendo los cambios anteriores
ROLLBACK;

-- 3. inicia una nueva transaccion que contenga las siguientes operaciones
-- añadir dos nuevos libros
INSERT INTO libros (isbn, ean, titulo, autor_id, editorial_id, precio_coste, precio_venta, stock, stock_min, stock_max, fecha_edicion)
VALUES 
('9780000000001', '9780000000001', 'Nuevo Libro 1', 1, 1, 15.00, 25.00, 10, 1, 20, '2024-01-01'),
('9780000000002', '9780000000002', 'Nuevo Libro 2', 2, 2, 18.00, 28.00, 8, 1, 15, '2024-02-01');

-- Añadir una venta y 3 líneas de detalle sobre esa venta
INSERT INTO ventas (cliente_id, fecha, importe_bruto, importe_iva, importe_total)
VALUES (1, CURDATE(), 100.00, 21.00, 121.00);

SET @venta_id = LAST_INSERT_ID();

INSERT INTO lineasventas (venta_id, numero_linea, libro_id, iva, cantidad, precio, importe)
VALUES
(@venta_id, 1, 1, 0.21, 2, 25.00, 50.00),
(@venta_id, 2, 2, 0.21, 1, 28.00, 28.00),
(@venta_id, 3, 3, 0.21, 1, 22.00, 22.00);

-- 4. finalizar confirmando los cambios
COMMIT;

-- 5. 