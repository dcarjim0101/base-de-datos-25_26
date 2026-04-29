-- actividad 6.4
-- 4.1 insertar una compra en la base de datos gesibros
-- insertamos la venta
insert into ventas (id, cliente_id, fecha, importe_bruto, importe_iva, importe_total) VALUES
(11, 6, now(), 289.50, 60.80, 350.30);

-- insertamos las lineas_ventas de esa factura
insert into lineasventas (venta_id, numero_linea, libro_id, iva, cantidad, precio, importe) values
(11, 1, 11, 0.21, 5, 30, 150),
(11, 2, 12, 0.21, 10, 13, 130),
(11, 3, 15, 0.21, 1, 9.50, 9.50);

-- 4.2.1 actualizar la direccion del cliente
-- id = 5
UPDATE clientes 
SET 
    direccion = 'Pollígono Ansu fati, Calle Messi, Nave 20'
WHERE
    nif = '23124234G';
    
-- 4.2.2 añadir el premio planeta
SELECT id from autores where nombre = 'Oscar Wilde';

UPDATE autores 
SET 
    premios = CONCAT_WS(', ', premios, 'Planeta')
WHERE
    id = 2;

-- 4.2.3 se decrementa el precio de venta de todos los libros en un 10%
UPDATE libros 
SET 
    precio_venta = precio_venta * 0.9;
    
-- 4.2.4 incrementar el precio de costo de los libros de las editoriales
select id from editoriales where nombre = 'Alfaguara';
select id from editoriales where nombre = 'Anaya';

UPDATE libros 
SET 
    precio_coste = precio_coste * 1.10
WHERE
    editorial_id IN (5 , 6);
    
-- 4.2.5 todos los libros editados del año 2000 se les descuenta 2€ del precio de venta
UPDATE libros 
SET 
    precio_venta = precio_venta - 2
WHERE
    YEAR(fecha_edicion) < 2000;

-- 4.3 eliminar la editorial alfaguara, pero antes todos los libros de dicha editorial
SELECT id FROM editoriales WHERE nombre = 'Alfaguara';

-- elimino todos los libros de la editorial Alfaguara
DELETE FROM libros WHERE editorial_id = 5;

-- elimino la editorial alfaguara
DELETE FROM editoriales WHERE id = 5;