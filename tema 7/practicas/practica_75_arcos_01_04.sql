-- practica_75_ubrique_01_04
-- conexion ubrique_01

-- 2
USE geslibros;

-- 4
SELECT * FROM clientes WHERE provincia = 'Guadalajara';
INSERT INTO cliente VALUES 
(120, 'federico', 'calle bornos', 'Guadalajara', '12345', 18, '123456789', '123456789', '123456789', 'federico@gmail.com', '2011/03/24');

-- 6
SELECT * FROM clientes WHERE email = '@gmail.com';
LOCK TABLE libros WRITE;
INSERT INTO libros VALUES 
(121, '1234567890123', '1234567890123', 'el libro', 3, 4, 156.76, 170.00, 2, 0, 4, '2011/03/24', '2026/04/13');

-- 8
UNLOCK TABLE;

-- 9
START TRANSACTION;

-- realizar un bloqueo
SELECT * FROM editoriales FOR SHARE;
SELECT * FROM autores FOR SHARE;

-- añadir dos libros
INSERT INTO libros (id_libro, titulo, id_autor, id_editorial, anio_publicacion)
VALUES 
(1, 'El legado del viento', 1, 1, 2020),
(2, 'Sombras del pasado', 2, 2, 2022);

-- terminar la transaccion
COMMIT;