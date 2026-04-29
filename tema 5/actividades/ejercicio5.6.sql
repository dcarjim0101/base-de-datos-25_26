-- actividad 5.6

-- uso la base de datos de testeo
USE test;

-- borrar la tabla alumnos si existe y crear la tabla alumnos si no existe
DROP TABLE IF EXISTS alumnos;
CREATE TABLE IF NOT EXISTS alumnos(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    apellidos VARCHAR(45) NOT NULL,
	dni TINYINT (9) UNIQUE NOT NULL,
    fecha_nac DATE,
    edad TINYINT NOT NULL,
    poblacion TINYINT(20) NOT NULL,
    direccion TINYINT NOT NULL,
    cpostal TINYINT(4) NOT NULL,
    provincia TINYINT(20),
    nacionalidad TINYINT(20),
    telefono TINYINT(13),
    email TINYINT(60)
);

-- borrar la tabla articulos si existe y crear la tabla articulos si no existe
DROP TABLE IF EXISTS articulos;
CREATE TABLE IF NOT EXISTS articulos(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(200) NOT NULL,
    referencia TINYINT(10) UNIQUE NOT NULL,
    precio_coste DECIMAL(4,2) UNSIGNED NOT NULL,
    precio_venta DECIMAL(4,2) UNSIGNED NOT NULL,
    descuento DECIMAL(3,1) UNSIGNED NOT NULL,
    imagen VARCHAR(20) NOT NULL,
    categoria VARCHAR(20) NOT NULL,
    stock TINYINT UNSIGNED NOT NULL,
    stock_min TINYINT(0) UNSIGNED NOT NULL,
    stock_max TINYINT(200) UNSIGNED NOT NULL
);

-- borrar la tabla registro_llegadas si existe y crear la tabla registro_llegadas si no existe
DROP TABLE IF EXISTS registro_llegadas;
CREATE TABLE IF NOT EXISTS registro_llegadas(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    fecha_hora DATETIME,
    fecha_hora_llegada DATETIME,
    tiempo_realizado TIME,
	FOREIGN KEY(corredor_id) REFERENCES corredores(id)
);