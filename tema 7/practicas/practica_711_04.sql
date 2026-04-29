-- practica_711_04

-- 1. crear usuarios
SELECT PASSWORD('1234567');
CREATE USER 'davidcarrero@localhost' IDENTIFIED BY '*6A7A490FB9DC8C33C2B025A91737077A7E9CC5E5';
GRANT USAGE ON test.* TO 'davidcarrero@localhost';
SHOW GRANTS FOR 'davidcarrero@localhost';

-- 2. asignar privilegios
GRANT ALL PRIVILEGES ON * TO 'davidcarrero@localhost' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON geslibros TO 'davidcarrero@localhost';

GRANT ALL PRIVILEGES ON geslibros.libros TO 'davidcarrero@localhost';
GRANT ALL PRIVILEGES ON geslibros.editoriales TO 'davidcarrero@localhost';
GRANT ALL PRIVILEGES ON geslibros.clientes TO 'davidcarrero@localhost';

GRANT SELECT ON geslibros.libros TO 'davidcarrero@localhost';
GRANT SELECT ON geslibros.editoriales TO 'davidcarrero@localhost';
GRANT SELECT ON geslibros.clientes TO 'davidcarrero@localhost';

GRANT SELECT (nombre, direccion, poblacion, c_postal, telefono, email),
      UPDATE (nombre, direccion, poblacion, c_postal, telefono, email)
ON geslibros.clientes TO 'davidcarrero@localhost';

GRANT SELECT (id, titulo, precio_venta, fechaedicion),
      UPDATE (precio_venta, titulo)
ON geslibros.libros TO 'davidcarrero@localhost';

GRANT SELECT ON geslibros.* TO 'davidcarrero@localhost';
REVOKE SELECT ON geslibros.ventas FROM 'davidcarrero@localhost';
REVOKE SELECT ON geslibros.lineasventas FROM 'davidcarrero@localhost';

-- 3. eliminar privilegios
REVOKE GRANT OPTION ON * FROM 'davidcarrero@localhost';

REVOKE ALL PRIVILEGES ON * FROM 'davidcarrero@localhost';

REVOKE ALL PRIVILEGES ON geslibros FROM 'davidcarrero@localhost';

REVOKE UPDATE ON geslibros.libros FROM 'davidcarrero@localhost';

REVOKE SELECT (id, titulo, precio_venta) ON geslibros.libros FROM 'davidcarrero@localhost';

REVOKE ALL PRIVILEGES ON geslibros FROM 'davidcarrero@localhost';

GRANT ALL PRIVILEGES ON geslibros.libros TO 'davidcarrero@localhost';
GRANT ALL PRIVILEGES ON geslibros.clientes TO 'davidcarrero@localhost';

REVOKE SELECT, UPDATE, DELETE ON geslibros.libros FROM 'davidcarrero@localhost';
REVOKE SELECT, UPDATE, DELETE ON geslibros.clientes FROM 'davidcarrero@localhost';
REVOKE SELECT, UPDATE, DELETE ON geslibros.editoriales FROM 'davidcarrero@localhost';
REVOKE SELECT, UPDATE, DELETE ON geslibros.autores FROM 'davidcarrero@localhost';

-- 4. cambiar password
SELECT PASSWORD('21436587');
SET PASSWORD FOR 'davidcarrero@localhost' = '*1DEB27DD74919473A2C69FDFA8E46B08E9F16547';

-- 5. sorteo
USE LoteriaPrimitiva;

START TRANSACTION;

INSERT INTO Sorteos (
    fecha, num1, num2, num3, num4, num5, num6, complementario, reintegro
) VALUES (
    NOW(),
    FLOOR(RAND()*49)+1,
    FLOOR(RAND()*49)+1,
    FLOOR(RAND()*49)+1,
    FLOOR(RAND()*49)+1,
    FLOOR(RAND()*49)+1,
    FLOOR(RAND()*49)+1,
    FLOOR(RAND()*49)+1,
    FLOOR(RAND()*10)
);

INSERT INTO Sorteos (
    fecha, num1, num2, num3, num4, num5, num6, complementario, reintegro
) VALUES (
    NOW(),
    FLOOR(RAND()*49)+1,
    FLOOR(RAND()*49)+1,
    FLOOR(RAND()*49)+1,
    FLOOR(RAND()*49)+1,
    FLOOR(RAND()*49)+1,
    FLOOR(RAND()*49)+1,
    FLOOR(RAND()*49)+1,
    FLOOR(RAND()*10)
);

COMMIT;

-- 6. base de datos maratoon
USE maratoon;

ALTER TABLE Corredores
ADD apellido1 VARCHAR(40),
ADD apellido2 VARCHAR(40),
ADD codigo CHAR(11);

UPDATE Corredores
SET 
    apellido1 = SUBSTRING_INDEX(Apellidos, ' ', 1),
    apellido2 = SUBSTRING_INDEX(Apellidos, ' ', -1);
    
UPDATE Corredores
SET codigo = UPPER(
    CONCAT(
        DATE_FORMAT(FechaNacimiento, '%Y'),
        '/',
        LEFT(Nombre, 2),
        LEFT(apellido1, 2),
        LEFT(apellido2, 2)
    )
);

UPDATE Corredores
SET Edad = TIMESTAMPDIFF(YEAR, FechaNacimiento, NOW());

START TRANSACTION;
LOCK TABLES Categorias WRITE, Corredores WRITE;

UPDATE Corredores SET categoria_id = 1 WHERE Edad < 12;
UPDATE Corredores SET categoria_id = 2 WHERE Edad BETWEEN 12 AND 14;
UPDATE Corredores SET categoria_id = 3 WHERE Edad BETWEEN 15 AND 17;
UPDATE Corredores SET categoria_id = 4 WHERE Edad BETWEEN 18 AND 29;
UPDATE Corredores SET categoria_id = 5 WHERE Edad BETWEEN 30 AND 39;
UPDATE Corredores SET categoria_id = 6 WHERE Edad BETWEEN 40 AND 49;
UPDATE Corredores SET categoria_id = 7 WHERE Edad BETWEEN 50 AND 59;
UPDATE Corredores SET categoria_id = 8 WHERE Edad >= 60;

UNLOCK TABLES;

COMMIT;

-- 7. exportar/importar datos
SELECT nombre, direccion, poblacion, c_postal, nif, telefono, email INTO OUTFILE 'clientesUbrique.csv'
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n' FROM clientes WHERE poblacion = 'Ubrique';

SELECT 
    id, nombre, nacionalidad, email, fecha_nac, fecha_def, premios
FROM autores
INTO OUTFILE 'autores.xml'
FIELDS TERMINATED BY ''
LINES TERMINATED BY '\n';

-- mysqldump -u root -p Geslibros > geslibros_backup.sql

LOAD DATA INFILE 'libros.csv' INTO TABLE libros
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    id,
    isbn,
    ean,
    titulo,
    autor_id,
    editorial_id,
    precio_coste,
    precio_venta,
    stock,
    stock_min,
    stock_max,
    fecha_edicion
);