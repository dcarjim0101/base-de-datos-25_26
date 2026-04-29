-- actividad 5.7

-- uso la base de datos de testeo
USE test;

-- borro la tabla pacientes si existe y la creo si no existe
DROP TABLE IF EXISTS pacientes;
CREATE TABLE IF NOT EXISTS pacientes(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    apellidos VARCHAR(45) NOT NULL,
	nss TINYINT (12) UNIQUE NOT NULL,
    email TINYINT(40),
    telefono TINYINT(9),
    poblacion TINYINT(20) NOT NULL,
    expediente VARCHAR(200) NOT NULL,
    dni TINYINT (9) UNIQUE NOT NULL,
    historial_clinico VARCHAR(200),
    fecha_nac DATE,
    edad TINYINT(3) NOT NULL
);