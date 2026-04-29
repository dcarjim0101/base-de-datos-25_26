-- borro la base de datos RestriccionesDefault si existe y la creo si no existe
DROP DATABASE IF EXISTS restricciones_check;
CREATE DATABASE IF NOT EXISTS restricciones_check
CHARACTER SET utf8 COLLATE utf8_general_ci;

-- uso esta base de datos
USE restricciones_check;

DROP TABLE IF EXISTS resdefault;
CREATE TABLE IF NOT EXISTS resdefault(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    importe DECIMAL(5,2),
    sueldo DECIMAL(6,2),
    nombre VARCHAR(20) NOT NULL,
    apellidos VARCHAR(45) NOT NULL,
    NBeneficiarios TINYINT(2) NOT NULL,
    NAsignatura TINYINT(2) NOT NULL,
    Beca BOOLEAN,
    ImporteBeca DECIMAL(6,2),
    Ngoles TINYINT(3) NOT NULL,
    AnnoNacimiento TINYINT(4),
    FechaNacimiento DATE,
    HoraLlegada TIME
);

DROP TABLE IF EXISTS comparacionBetween;
CREATE TABLE IF NOT EXISTS comparacionBetween(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    NNgoles TINYINT (BETWEEN 20 AND 30),
    Sueldo DECIMAL (BETWEEN 2000 AND 3000),
    importe DECIMAL (BETWEEN 400 AND 600),
    cantidad TINYINT (BETWEEN 5 AND 20),
    valor TINYINT (BETWEEN 5 AND 20),
    tipodescuento TINYINT (BETWEEN 5,25 AND 20,50),
    precio TINYINT (BETWEEN 20 AND 30)
);

DROP TABLE IF EXISTS chekin;
CREATE TABLE IF NOT EXISTS chekin(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    provincia VARCHAR(30) NOT NULL,
    poblacion VARCHAR(30) NOT NULL,
    cicloEstudio VARCHAR(30),
    valores TINYINT(5),
    nacionalidad VARCHAR(30),
    CodEmpleado VARCHAR(_AB%),
    NRP TINYINT(%Z),
    DNI TINYINT(25%)
);