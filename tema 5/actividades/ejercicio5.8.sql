-- actividad 5.8

-- borro la base de datos horarios si existe y la creo si no existe
DROP DATABASE IF EXISTS horarios;
CREATE DATABASE IF NOT EXISTS horarios;

-- uso esta base de datos
USE horarios;

-- creo la tabla departamentos
DROP TABLE IF EXISTS departamentos;
CREATE TABLE IF NOT EXISTS departamentos(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre_campo VARCHAR(20) NOT NULL,
    codigo_dpt VARCHAR(3) UNIQUE NOT NULL
);

-- creo la tabla profesor
DROP TABLE IF EXISTS profesor;
CREATE TABLE IF NOT EXISTS profesor(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    apellidos VARCHAR(45) NOT NULL,
    email VARCHAR(40) UNIQUE,
    fecha_ingreso DATE NOT NULL,
    especialidad VARCHAR(20) NOT NULL,
    nrp TINYINT(9) UNIQUE NOT NULL,
    CONSTRAINT FK_departamento_id_profesor FOREIGN KEY(departamento_id) REFERENCES departamento(id)
    ON DELETE RESTRICT ON UPDATE RESTRICT
);

-- creo la tabla asignatura
DROP TABLE IF EXISTS asignatura;
CREATE TABLE IF NOT EXISTS asignatura(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20),
    nivel VARCHAR(4),
    codigo_asig VARCHAR(7) UNIQUE,
    horas TINYINT(3),
    CONSTRAINT FK_departamento_id_asignatura FOREIGN KEY(departamento_id) REFERENCES departamento(id)
    ON DELETE RESTRICT ON UPDATE RESTRICT
);

-- creo la tabla horario
DROP TABLE IF EXISTS horario;
CREATE TABLE IF NOT EXISTS horario(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    CONSTRAINT FK_profesor_id_horario FOREIGN KEY(profesor_id) REFERENCES profesor(id)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
    dia TINYINT(1),
    tramo TINYINT(1),
    turno TINYINT(1),
    CONSTRAINT FK_asignatura_id_horario FOREIGN KEY(asignatura_id) REFERENCES asignatura(id)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
    horas TIME
);

