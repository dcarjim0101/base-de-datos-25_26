-- 1. crear la tabla fmatematicas
DROP DATABASE IF EXISTS fmatematicas;
CREATE DATABASE IF NOT EXISTS fmatematicas;

USE fmatematicas;

-- 2. crear la tabla angulos los valores con minima precision
-- id, grados, radianes, seno, coseno, tangente
DROP TABLE IF EXISTS angulos;
CREATE TABLE IF NOT EXISTS angulos(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    grados SMALLINT UNSIGNED, -- [0,360]
    radianes DOUBLE(31,30), --
    seno DOUBLE(31,30), -- [-1,1]
    coseno DOUBLE(31,30), -- [-1,1]
    tangente DOUBLE(31,30) -- cualquier valor real
);

-- 3. insertar en la tabla angulos los valores de 5 angulos (0 a 360)
INSERT INTO angulos (grados) VALUES
(0),  (30), (60), (180), (270);

INSERT INTO angulos (grados) VALUES
(10),  (34), (67), (149), (258);

-- 4. actualizar la columna radianes a partir de la columna grados añadida en el apartado anterior
UPDATE angulos SET radianes = radians(grados);

-- 5. actualizar las columnas seno, coseno y tangente a partir de la columna radianes actualizada en el apartado anterior
UPDATE angulos SET 
	seno = sin(radianes),
	coseno = cos(radianes),
	tangente = tan(radianes);

-- 6. obtener un valor entre [1, 10]
SELECT CEILING(RAND() * 10);

-- 7. obtener un valor entre [0, 9]
SELECT FLOOR(RAND()*9);

-- 8. obtener un valor entre [0, 4]
SELECT FLOOR(RAND()*4);

-- 9. obtener un valor entre [0, 100000]
SELECT FLOOR(RAND()*100000);