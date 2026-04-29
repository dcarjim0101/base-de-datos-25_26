-- practica_75_ubrique_01_04
-- conexion ubrique_01

-- 2
USE geslibros;

-- 3
LOCK TABLE clientes READ;
SELECT * FROM libros;

-- 5
UNLOCK TABLE;

-- 7
SELECT * FROM libros;
LOCK TABLE libros READ;

-- 9
START TRANSACTION;

-- bloqueo exclusivo
SELECT precio_venta FROM libros FOR UPDATE;

-- decrementar el precio
UPDATE libros SET precio_venta = precio_venta * 0.70;

-- terminar la transaccion
COMMIT;