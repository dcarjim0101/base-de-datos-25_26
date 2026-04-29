-- practica_75_04
-- descripcion: bloqueo de tablas y filas
-- autor: david carrero jimenez

USE geslibros;

-- 1. creacion de usuarios
CREATE USER ubrique_01@localhost identified by 'ubrique01';
CREATE USER arcos_01@localhost identified by 'arcos01';

-- asignacion de privilegios
GRANT ALL PRIVILEGES ON *.* TO ubrique_01@localhost, arcos_01@localhost;