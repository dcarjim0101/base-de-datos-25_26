-- Actividad: 5.13
-- Tema Lenguaje SQL - DDL
-- Módulo de Base de Datos
-- Curso 25/26
-- Nombre: David Carrero Jimenez

-- Creación de la base de datos
DROP DATABASE IF EXISTS empleados_taller;
CREATE DATABASE IF NOT EXISTS empleados_taller;

-- Usar la base de datos
USE empleados_taller;

-- =========================
-- Tabla clientes
-- =========================
DROP TABLE IF EXISTS clientes;
CREATE TABLE clientes (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    nif CHAR(9) UNIQUE NOT NULL
);

-- =========================
-- Teléfonos de clientes
-- =========================
DROP TABLE IF EXISTS telefonos_clientes;
CREATE TABLE telefonos_clientes (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT UNSIGNED NOT NULL,
    telefono CHAR(9) NOT NULL,
    UNIQUE (cliente_id, telefono),
    FOREIGN KEY (cliente_id)
        REFERENCES clientes(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- =========================
-- Tabla proyectos
-- =========================
DROP TABLE IF EXISTS proyectos;
CREATE TABLE proyectos (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    proyecto VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    presupuesto DECIMAL(10,2),
    cliente_id INT UNSIGNED,
    jefe_id INT UNSIGNED
);

-- =========================
-- Tabla empleados
-- =========================
DROP TABLE IF EXISTS empleados;
CREATE TABLE empleados (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    dni CHAR(9) UNIQUE NOT NULL,
    proyecto_id INT UNSIGNED,
    supervisor_id INT UNSIGNED
);

-- =========================
-- Teléfonos de empleados
-- =========================
DROP TABLE IF EXISTS telefonos_empleados;
CREATE TABLE telefonos_empleados (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    empleado_id INT UNSIGNED NOT NULL,
    telefono CHAR(9) NOT NULL,
    UNIQUE (empleado_id, telefono),
    FOREIGN KEY (empleado_id)
        REFERENCES empleados(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- =========================
-- Beneficiarios
-- =========================
DROP TABLE IF EXISTS beneficiarios;
CREATE TABLE beneficiarios (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    fecha_nac DATE NOT NULL,
    empleado_id INT UNSIGNED,
    FOREIGN KEY (empleado_id)
        REFERENCES empleados(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- =========================
-- Proyectos - Empleados
-- =========================
DROP TABLE IF EXISTS proyectos_empleados;
CREATE TABLE proyectos_empleados (
    empleado_id INT UNSIGNED NOT NULL,
    proyecto_id INT UNSIGNED NOT NULL,
    horas SMALLINT UNSIGNED,
    valoracion VARCHAR(255),
    f_inicio DATE,
    f_fin DATE,
    PRIMARY KEY (empleado_id, proyecto_id),
    FOREIGN KEY (empleado_id)
        REFERENCES empleados(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (proyecto_id)
        REFERENCES proyectos(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- =========================
-- Restricciones FOREIGN KEY en empleados
-- =========================
ALTER TABLE empleados
ADD CONSTRAINT FK_empleados_proyecto
    FOREIGN KEY (proyecto_id)
    REFERENCES proyectos(id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,

ADD CONSTRAINT FK_empleados_supervisor
    FOREIGN KEY (supervisor_id)
    REFERENCES empleados(id)
    ON DELETE SET NULL
    ON UPDATE CASCADE;

-- =========================
-- Índices
-- =========================
CREATE INDEX IDX_nombre_empleados ON empleados(nombre);
CREATE INDEX IDX_proyecto_proyectos ON proyectos(proyecto);

SHOW INDEX FROM empleados;
SHOW INDEX FROM proyectos;

-- =========================
-- Parte 2: Modificaciones
-- =========================

-- Añadir columna email a empleados
ALTER TABLE empleados
ADD COLUMN email VARCHAR(60) UNIQUE NOT NULL;