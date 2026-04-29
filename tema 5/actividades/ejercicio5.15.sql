-- Actividad: 5.15
-- Tema Lenguaje SQL - DDL
-- Módulo de Base de Datos
-- Curso 25/26
-- Nombre: David Carrero Jimenez

-- Creación de la base de datos
DROP DATABASE IF EXISTS libros_almacen;
CREATE DATABASE libros_almacen;

-- Usar la base de datos
USE libros_almacen;

-- crear la tabla libros
CREATE TABLE libros (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    precio DECIMAL(8,2) NOT NULL
);

-- crear la tabla provincias
CREATE TABLE Provincias (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_almacen INT
);
-- crear la tabla provincias
CREATE TABLE Provincias (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_almacen INT
);


-- crear la tabla almacenes
CREATE TABLE Almacenes (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    fecha DATE,
    id_provincia INT,
    FOREIGN KEY (id_provincia) REFERENCES Provincias(id)
);

-- crear la tabla poblaciones
CREATE TABLE Poblaciones (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    habitantes INT,
    id_provincia INT,
    FOREIGN KEY (id_provincia) REFERENCES Provincias(id)
);

-- crear la tabla socios
CREATE TABLE Socios (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    codsocio VARCHAR(20) UNIQUE,
    telefono VARCHAR(20),
    dni VARCHAR(15) UNIQUE,
    id_poblacion INT,
    id_socio_avalista INT,
    FOREIGN KEY (id_poblacion) REFERENCES Poblaciones(id),
    FOREIGN KEY (id_socio_avalista) REFERENCES Socios(id)
);

-- crear la tabla pedidos
CREATE TABLE Pedidos (
    id INT PRIMARY KEY,
    fecha DATE NOT NULL,
    envio VARCHAR(50),
    id_socio INT,
    FOREIGN KEY (id_socio) REFERENCES Socios(id)
);

-- crear la tabla educacion
CREATE TABLE Educacion (
    id_libro INT,
    curso VARCHAR(50),
    asignatura VARCHAR(50),
    PRIMARY KEY (id_libro),
    FOREIGN KEY (id_libro) REFERENCES Libros(id)
);

-- crear la tabla lectura
CREATE TABLE Lectura (
    id_libro INT,
    tipo VARCHAR(50),
    genero VARCHAR(50),
    PRIMARY KEY (id_libro),
    FOREIGN KEY (id_libro) REFERENCES Libros(id)
);

-- crear la tabla LibrosPedidos 
CREATE TABLE LibrosPedidos (
    id_pedido INT,
    id_libro INT,
    unidades INT NOT NULL,
    precio DECIMAL(8,2) NOT NULL,
    PRIMARY KEY (id_pedido, id_libro),
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id),
    FOREIGN KEY (id_libro) REFERENCES Libros(id)
);

-- crear la tabla AlmacenesLibros 
CREATE TABLE AlmacenesLibros (
    id_almacen INT,
    id_libro INT,
    stock INT NOT NULL,
    PRIMARY KEY (id_almacen, id_libro),
    FOREIGN KEY (id_almacen) REFERENCES Almacenes(id),
    FOREIGN KEY (id_libro) REFERENCES Libros(id)
);
