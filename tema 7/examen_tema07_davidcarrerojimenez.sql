-- Examen tema 7
-- David Carrero Jiménez

-- 1. Crear usuarios
-- 1.1 Usuario estadio
SELECT PASSWORD('Est@dio25');
CREATE USER estadio IDENTIFIED BY PASSWORD 'contraseña encriptada';
GRANT USAGE ON *. test;
-- 1.2 Usuario marcador
SELECT PASSWORD('Golf#2025');
CREATE USER marcador IDENTIFIED BY PASSWORD 'contraseña encriptada';
GRANT USAGE ON *. test;
-- 1.3 Usuario nombre y apellido
SELECT PASSWORD('Examen#07');
CREATE USER davidcarrero IDENTIFIED BY PASSWORD 'contraseña encriptada'


-- 2. Asignacion de privilegios
-- 2.1
GRANT ALL PRIVILEGES ON * TO 'estadio' WITH GRANT OPTION;
-- 2.2
GRANT ALL PRIVILEGES ON futbol TO 'estadios';
-- 2.3
GRANT ALL PRIVILEGES ON futbol.equipos TO 'estadios';
GRANT ALL PRIVILEGES ON futbol.jugadores TO 'estadios';
-- 2.4
GRANT SELECT ON futbol.equipos TO 'marcador';
GRANT SELECT ON futbol.jugadores TO 'marcador';
GRANT SELECT ON futbol.partidos TO 'marcador';
GRANT SELECT ON futbol.goles TO 'marcador';
-- 2.5
GRANT SELECT(nombre, estadio, aforo, ciudad)
      UPDATE(nombre, estadio, aforo, ciudad) ON futbol.equipos TO 'marcador';
-- 2.6
GRANT SELECT(id, nombre, fecha_nac) 
      UPDATE(equipo_id) ON futbol.jugadores TO 'marcador';
-- 2.7
GRANT SELECT ON futbol.* EXCEPT goles TO 'davidcarrero';


-- 3. Eliminar privilegios
-- 3.1
DELETE PRIVILEGES GRANT OPTION TO 'estadio';
-- 3.2
DELETE ALL PRIVILEGES ON * TO 'estadio';
-- 3.3
DELETE ALL PRIVILEGES ON futbol TO 'estadio';
-- 3.4
DELETE PRIVILEGES INSERT ON futbol.partidos TO 'marcador';
-- 3.5
DELETE PRIVILEGES SELECT(id, nombre, fecha_nac) ON futbol.jugadores TO 'marcador';
-- 3.6
DELETE ALL PRIVILEGES ON futbol.* EXCEPT equipos TO 'marcador';
DELETE ALL PRIVILEGES ON futbol.* EXCEPT jugadores TO 'marcador';
-- 3.7
DELETE PRIVILEGES SELECT, UPDATE, DELETE ON futbol.equipos TO 'davidcarrero';
DELETE PRIVILEGES SELECT, UPDATE, DELETE ON futbol.jugadores TO 'davidcarrero';
DELETE PRIVILEGES SELECT, UPDATE, DELETE ON futbol.partidos TO 'davidcarrero';


-- 4. Renombrar usuarios y cambiar passwords
-- 4.1
RENAME USER 'estadio' TO 'estadio_admin';
-- 4.2
RENAME USER 'marcador' TO 'marcador_ro';
-- 4.3
SELECT PASSWORD('Admin#2026');
SET PASSWORD FOR 'estadio_admin' = 'contraseña cifrada'; -- aqui se obtiene el password cifrado
-- 4.4
SELECT PASSWORD('ReadOnly#99');
SET PASSWORD FOR 'marcador_ro' = 'contraseña cifrada'; -- aqui se obtiene el password cifrado
-- 4.5
DELETE USER 'davidcarrero';


-- 5. Transaccion con SAVEPOINT
USE empresa;
-- 5.1
START TRANSACTION;
-- 5.2
CREATE SAVEPOINT 'antes_subida';
-- 5.3
INSERT INTO empleados VALUES
(12, 'Antonio','A','González','183925845','1968-12-27','17, calle Pedernal, Algodonales, Cádiz', 28000,2,5),
(13, 'Josefina','J','Pérez','482936475','1975-03-28','22, calle Alpaca, Antequera, Málaga', 35000,NULL,5);
-- 5.4
CREATE SAVEPOINT 'despues_insercion';
-- 5.5
-- 5.6
-- 5.7
GO TO 'despues_insercion';
-- 5.8
COMMIT;


-- 6. Funciones MySQL
USE empresa;
-- 6.1
-- ANTONIO GONZALEZ BENITEZ, 22, gobe
-- JOSEFINA PEREZ CARRASCO, 21, peca
-- 6.2
-- 6.3
-- 6.4
-- 6.5
-- 6.6
-- 6.7


-- 7. Bloqueos de tablas
USE futbol;
-- 7.1.1
LOCK TABLE equipos READ;
-- 7.1.2
SELECT * from equipos;
-- 7.1.3
INSERT INTO equipos VALUES
(6, 'Puerto Serrano Atletico', 'Estadio de Polixe', 2000, 1996, 'Puerto Serrano');
-- 7.1.4
UNLOCK TABLES;
-- 7.2
START TRANSACTION;
-- 7.2.1
LOCK FOR UPDATE 'Real Madrid' FROM equipos;
-- 7.2.2
UPDATE aforo = +5000 ON 'Santiago Bernabéu' FROM equipos;
-- 7.2.3
INSERT INTO partidos VALUES
(7, 8, '2026-07-23 22:30:00', 5, 7, 'Prado del Rey');
-- 7.2.4
COMMIT;


-- 8. Exportar e importar datos
USE empresa;
-- 8.1
EXPORT TO 'empleados_houston.csv' WHERE 'Houston';
-- 8.2
mysqldump TO 'empresa_backup.sql' empresa;
-- 8.3
mysqldump TO 'empresa_empleados_proyectos.sql' empresa [empleados, proyectos];
-- 8.4
mysqldump
-- 8.5
-- 8.6
