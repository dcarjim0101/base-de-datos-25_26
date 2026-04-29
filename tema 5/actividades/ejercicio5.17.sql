-- Actividad: 5.17
-- Tema Lenguaje SQL - DDL
-- Módulo de Base de Datos
-- Curso 25/26
-- Nombre: David Carrero Jimenez

-- Creación de la base de datos
DROP DATABASE IF EXISTS gescomercial;
CREATE DATABASE gescomercial;

-- Usar la base de datos
USE gescomercial;

-- crear la tabla departamentos
CREATE TABLE Departamentos (
	id INT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    funcion VARCHAR(100) NOT NULL
);

-- crear la tabla categorias
CREATE TABLE Categorias (
	id INT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    salarioBase DECIMAL(8,2) NOT NULL
);

-- crear la tabla empleados
CREATE TABLE Empleados (
	id INT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    apellidos VARCHAR(30) NOT NULL,
    dir VARCHAR(100) NOT NULL,
    poblacion VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    telefono VARCHAR(9) NOT NULL,
    dni VARCHAR(15) UNIQUE,
    nss VARCHAR(11) UNIQUE,
    idDepartamento VARCHAR(5),
    idCategoria VARCHAR(5)
);

-- crear la tabla almacen
CREATE TABLE Almacen (
	id INT PRIMARY KEY,
    ubicacion VARCHAR(30) NOT NULL,
    idEmpleado VARCHAR(5) NOT NULL
);

-- crear la tabla estante
CREATE TABLE Estante (
	id INT PRIMARY KEY,
    idAlmacen VARCHAR(5) NOT NULL,
    descripcion VARCHAR(255)
);

-- crear la tabla familias
CREATE TABLE Familias (
	id INT PRIMARY KEY,
    descripcion VARCHAR(255)
);

-- crear la tabla articulos
CREATE TABLE Articulos (
	id INT PRIMARY KEY,
    codigoInterno VARCHAR(20) UNIQUE NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    precioCoste DECIMAL(8,2) NOT NULL,
    precioVenta DECIMAL(8,2) NOT NULL,
    unidades INT NOT NULL,
    idAlmacen VARCHAR(5),
    idEstante VARCHAR(5),
    idFamilia VARCHAR(5)
);

-- crear la tabla regiones
CREATE TABLE Regiones (
	id INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- crear la tabla provincias
CREATE TABLE Provincias (
	id INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    idRegion VARCHAR(5)
);

-- crear la tabla poblaciones
CREATE TABLE Poblaciones (
	id INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    idProvincia VARCHAR(5)
);

-- crear la tabla clientes
CREATE TABLE Clientes (
	id INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    contacto VARCHAR(50),
    cif VARCHAR(15) UNIQUE,
    email VARCHAR(50),
    web VARCHAR(50),
    direccion VARCHAR(100),
    telefono VARCHAR(9),
    movil VARCHAR(9),
    cpostal VARCHAR(5),
    idPoblacion VARCHAR(5),
    idProvincia VARCHAR(5),
    idRegion VARCHAR(5)
);

-- crear la tabla ventas
CREATE TABLE Ventas (
	id INT PRIMARY KEY,
    numVenta VARCHAR(20) UNIQUE NOT NULL,
    fecha DATE NOT NULL,
    importeTotal DECIMAL(10,2) NOT NULL,
    idCliente VARCHAR(5),
    formaPago VARCHAR(20),
    observaciones VARCHAR(255)
);

-- crear la tabla detallesventas
CREATE TABLE DetallesVentas (
	numDetalle INT PRIMARY KEY,
    idVenta VARCHAR(5),
    idArticulo VARCHAR(5),
    precio DECIMAL(8,2) NOT NULL,
    unidades INT NOT NULL,
    descuento DECIMAL(5,2),
    iva DECIMAL(5,2),
    importeSinIva DECIMAL(10,2),
    importeConIva DECIMAL(10,2)
);

-- añadir a la tabla clientes la columna imagen
ALTER TABLE Clientes
ADD imagen VARCHAR(100);

-- añadir a la tabla articulos las columnas stockminimo y stockmaximo
ALTER TABLE Articulos
ADD stockMinimo INT CHECK (stockMinimo <= 10),
ADD stockMaximo INT CHECK (stockMaximo <= 1000);

-- añadir a la tabla clientes el campo observaciones
ALTER TABLE Clientes
ADD observaciones TEXT;

-- indice en la tabla clientes
CREATE INDEX idx_clientes_nombre
ON Clientes (nombre);

-- indice en la tabla articulos
CREATE INDEX idx_articulos_descripcion
ON Articulos (descripcion);

-- indice en la tabla empleados
CREATE INDEX idx_empleados_apellidos_nombre
ON Empleados (apellidos, nombre);
