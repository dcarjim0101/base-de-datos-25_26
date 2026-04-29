-- practica_710_04
-- los comandos estan comentados puesto que se ejecutan desde una consola

-- 1. accede usuario root a modo consola
mysql -h localhost -u root

-- 2. comandos sql
show databases;
use geslibros;
show tables;
select host, user, password from mysql.user;
show grants for root@localhost;
show grants for current_user();

-- 3. crear usuario
CREATE USER lopez@localhost identified by '1234567';
GRANT CREATE, ALTER, UPDATE ON maratoon.corredores TO lopez@localhost;

-- 4. cambiar password usuario anterior
SET PASSWORD FOR lopez@localhost = PASSWORD('654321');

-- 5. realizar la transaccion
START TRANSACTION;
UPDATE libros SET precio_venta = precio_venta * 1.10;
SELECT precio_venta FROM libros;
ROLLBACK;

-- 6. bloqueo de tablas
LOCK TABLES libros READ;
SELECT nombre FROM autores;
UNLOCK TABLES;
SELECT nombre FROM autores;

-- 7. realizar operaciones en la transaccion
START TRANSACTION;
LOCK TABLES clientes WHERE provincia = 'Cádiz' SHARE;
SELECT * FROM clientes WHERE provincia = 'Cádiz';
COMMIT;

-- 8. realizar operaciones en la base de datos maratoon
USE MARATOON;
UPDATE corredores
SET edad = TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE());

-- 9. corredores de villamartin
SELECT id, Nombre, Apellidos, Ciudad, FechaNacimiento, Sexo, Edad, Categoria_id, Club_id
	FROM Corredores WHERE Ciudad = 'Villamartín'
	INTO OUTFILE "C:/Users/02_1DAW_alum/Desktop/base de datos 25_26/csvs/corredores_villamartin.csv"
	FIELDS TERMINATED BY ','
	ENCLOSED BY '"'
	LINES TERMINATED BY '\n';
    
-- 10. salir
EXIT;

-- 11. realizar copia de seguridad de la base de datos maratoon
mysqldump -u root -p maratoon > maratoon.sql

-- 12. realizar copia de seguridad de todas las bases de datos
mysqldump -u root -p --all-databases > alldatabases.sql

-- 13. exportar la base de datos
mysqldump -u root -p --xml empresa > empresa.xml