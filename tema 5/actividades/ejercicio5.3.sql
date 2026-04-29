-- Actividad 5.3

-- borro la base de datos si existe
DROP DATABASE IF EXISTS tipo_datos;

-- creo la base de datos con el juego de caracteres y la coleccion
CREATE DATABASE IF NOT EXISTS tipo_datos
CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- usar la base de datos
USE tipo_datos;

-- borro la tabla tipos_datos_num
DROP TABLE IF EXISTS tipo_datos_num;

-- creo la tabla con las siguientes columnas si no existe
CREATE TABLE tipo_datos_num (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    num_camiseta TINYINT UNSIGNED,
    diferencias_goles SMALLINT,
    goles_a_favor SMALLINT UNSIGNED,
    goles_en_contra SMALLINT UNSIGNED,
    num_habitantes INT UNSIGNED,
    humedad FLOAT(3,2) UNSIGNED,
    precipitaciones SMALLINT UNSIGNED,
    temperatura_maxima FLOAT(6,2),
    temperatura_minima FLOAT(6,2),
    velocidad_viento SMALLINT UNSIGNED,
    altura SMALLINT UNSIGNED,
    precio DECIMAL(10,2),
    sueldo DECIMAL(10,2),
    seno DOUBLE(30,29),
    coseno DOUBLE(30,29),
    tangente SMALLINT UNSIGNED
);

-- añadir los registros
INSERT INTO tipo_datos_num VALUES
(
	NULL,
	34,
    -5,
    56,
    45,
    345000,
    0.90,
    300,
    45.56,
    -1243.78,
    500,
    10000,
    45.67,
    45000,
    0.5678,
    0.785,
    34
);