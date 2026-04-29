-- creacion de tabla

-- 1
-- seleccionar base de datos activa
USE geslibros;

-- 2
-- crear la tabla libros
-- id, titulo, precio, autor, editorial, paginas
DROP TABLE IF EXISTS libros;
CREATE TABLE IF NOT EXISTS libros(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	titulo VARCHAR(40),
    autor VARCHAR(50),
    editorial VARCHAR(20),
    paginas SMALLINT UNSIGNED,
    fecha_edicion DATE,
    precio DECIMAL(10,2)
);

-- 3
-- insertar un libro
INSERT INTO libros VALUES(
	null,
    'La historia interminable',
    'mikel ende',
    'somosagua',
    340,
    '2025/12/12',
    37.80
);