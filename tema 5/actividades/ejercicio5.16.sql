-- Actividad: 5.16
-- Tema Lenguaje SQL - DDL
-- Módulo de Base de Datos
-- Curso 25/26
-- Nombre: David Carrero Jimenez

-- Usar la base de datos
USE libros_almacen;

-- 1. tabla autores
CREATE TABLE Autores (
    id INT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    nacionalidad VARCHAR(100),
    fechaNac DATE,
    estilo VARCHAR(100)
);

-- 2. tabla libros
ALTER TABLE Libros
DROP COLUMN autor,
ADD autor_id INT,
ADD CONSTRAINT fk_libros_autores
FOREIGN KEY (autor_id) REFERENCES Autores(id),
ADD ISBN CHAR(13) UNIQUE,
ADD EAN CHAR(13) UNIQUE,
ADD categorias VARCHAR(255),
ADD tipo_lector VARCHAR(20),
ADD fecha_edicion DATE;

-- 3. tabla socios
ALTER TABLE Socios
ADD CONSTRAINT uq_socios_telefono UNIQUE (telefono),
ADD direccion VARCHAR(255),
ADD poblacion VARCHAR(100),
ADD c_postal VARCHAR(10),
ADD provincia VARCHAR(100),
ADD nacionalidad VARCHAR(100),
ADD valoracion DECIMAL(3,1),
ADD CONSTRAINT chk_valoracion
CHECK (valoracion BETWEEN 0 AND 10),
CHANGE nombre socio VARCHAR(255);

-- 4. tabla LibrosPedidos
ALTER TABLE LibrosPedidos
ADD descuento DECIMAL(4,3),
ADD CONSTRAINT chk_descuento
CHECK (descuento BETWEEN 0 AND 1),
ADD importe DECIMAL(10,2);

-- 5. ficheros indices
CREATE INDEX idx_libros_titulo
ON Libros(titulo);

CREATE INDEX idx_pedidos_fecha
ON Pedidos(fecha);

CREATE INDEX idx_almacenes_nombre
ON Almacenes(nombre);

CREATE INDEX idx_socios_nombre
ON Socios(socio);