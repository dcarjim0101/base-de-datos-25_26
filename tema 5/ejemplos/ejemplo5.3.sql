-- ejemplo 03
-- restricciones

-- 1 usamos la base de datos de testeo
USE test;

-- 2 crear la tabla libros
-- 2.1 restriccion a nivel de columna
DROP TABLE IF EXISTS libros;
CREATE TABLE IF NOT EXISTS libros(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(70) NOT NULL,
    autor VARCHAR(50) NOT NULL,
    ean CHAR(13) UNIQUE NOT NULL
);

DROP TABLE IF EXISTS clientes;
CREATE TABLE IF NOT EXISTS clientes(
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    cif CHAR(9) UNIQUE NOT NULL,
    nacionalidad VARCHAR(20)
);

DROP TABLE IF EXISTS pedidos;
CREATE TABLE IF NOT EXISTS pedidos(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    fecha DATE,
    importe DECIMAL(10,2),
    cliente_id INT UNSIGNED,
    CONSTRAINT FK_cliente_id_pedidos FOREIGN KEY(cliente_id) REFERENCES clientes(id)
    ON DELETE RESTRICT ON UPDATE RESTRICT
);

ALTER TABLE pedidos
DROP CONSTRAINT FK_cliente_id_pedidos