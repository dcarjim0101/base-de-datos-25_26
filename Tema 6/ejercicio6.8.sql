-- Actividad 6.8 Consultas multitablas

USE futbol;

-- 6.8.1 Realiza un producto cartesiano entre las tablas jugadores y equipos
SELECT * FROM jugadores, equipos;

-- 6.8.2 Realiza un producto cartesiano entre las tablas jugadores y goles.
SELECT * FROM jugadores, goles;

-- 6.8.3 Realiza un producto cartesiano entre las tablas jugadores y equipos eliminando los registros espurios (where).
SELECT * FROM jugadores, equipos WHERE jugadores.equipo_id = equipos.id;

-- 6.8.4 Realiza un producto cartesiano entre las tablas jugadores y goles eliminando los registros espurios (where).
SELECT * FROM goles, jugadores WHERE goles.jugadores_id = jugadores.id;

-- 6.8.5 Realiza INNER JOIN correcto entre las tablas jugadores y equipos, devolver todas las columnas de jugadores y de equipos.
SELECT * FROM jugadores INNER JOIN equipos ON jugadores.equipo_id = equipos.id;

-- 6.8.6 Realiza INNER JOIN correcto entre las tablas jugadores y equipos, devolver las columnas id, nombre, edad y equipo
SELECT * FROM jugadores INNER JOIN equipos ON (SELECT id, nombre, TIMESTAMPDIFF(YEAR, jugadores.fecha_nac, CURDATE()) edad FROM futbol.jugadores);

-- 6.8.7 Realizar INNER JOIN correcto entre las tablas jugadores y goles.
SELECT * FROM jugadores INNER JOIN goles ON jugadores.id = goles.jugador_id;

-- 6.8.8 Realiza INNER JOIN correcto entre las tablas jugadores y goles, devolver las columnas id, nombre, minuto, descripción.
SELECT * FROM jugadores INNER JOIN goles ON (SELECT id, nombre, minuto, descripcion FROM futbol.jugadores);

-- 6.8.9 Realizar INNER JOIN correcto entre las tablas jugadores, equipos y goles.
SELECT * FROM jugadores INNER JOIN equipos ON jugadores.equipo_id = equipos.id INNER JOIN goles ON jugadores.id = goles.jugador_id;

-- 6.8.10 Realiza INNER JOIN correcto entre las tablas jugadores y goles, devolver las columnas id, nombre, equipo, minuto, descripción.
SELECT * FROM jugadores INNER JOIN goles ON (SELECT id, nombre, equipo, minuto, descripcion FROM futbol.jugadores);

-- 6.8.11 Realizar INNER JOIN correcto entre las tablas jugadores, equipos, goles y partidos. Todas las columnas.
SELECT * FROM jugadores INNER JOIN equipos ON jugadores.equipo_id = equipos.id INNER JOIN goles ON jugadores.id = goles.jugador_id INNER JOIN partidos ON jugadores.id = partidos.jugador_id;

-- 6.8.12 Realiza INNER JOIN correcto entre las tablas jugadores y goles, devolver las columnas id, nombre, equipo, minuto, descripción, observaciones.
SELECT * FROM jugadores INNER JOIN goles ON (SELECT id, nombre, equipo, minuto, descripcion FROM futbol.jugadores);