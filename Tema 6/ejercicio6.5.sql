-- actividad 6.5
-- Consultas básicas de selección

USE futbol;

-- 5.1 Consultas básicas
-- 5.1.1 Listado de todos los jugadores
SELECT * FROM jugadores;

-- 5.1.2 Listado de todos los equipos
SELECT * FROM equipos;

-- 5.1.3 Listado de todos los partidos
SELECT * FROM partidos;

-- 5.1.4 Listado de los tres últimos partidos disputados
SELECT * FROM partidos ORDER BY fecha DESC LIMIT 3;


-- 5.2 consultas con LIMIT
-- 5.2.1 Listado de los 5 goles más tempranos
SELECT * FROM goles ORDER BY minuto LIMIT 5;

-- 5.2.2 Listado de goles del 5 al 10
SELECT * FROM goles ORDER BY id LIMIT 5 OFFSET 4;

-- 5.2.3 Listado de los tres últimos partidos disputados
SELECT * FROM partidos ORDER BY fecha DESC LIMIT 3;

-- 5.2.4 Listado de sólo 1 partido donde intervino el Betis como equipo de fuera
SELECT id FROM equipos WHERE nombre LIKE '%Betis%';
SELECT * FROM partidos WHERE equipo_fuera_id = 5;

-- 5.2.5 Listado de 1 partido donde el equipo de fuera no marcó
SELECT * FROM partidos WHERE goles_fuera = 0;

-- 5.2.6 Listar 5 goles a partir del gol 4
SELECT * FROM goles ORDER BY goles ASC LIMIT 4;


-- 5.3 consultas (lista columnas)
-- 5.3.1
SELECT id, nombre, equipo_id FROM jugadores;

-- 5.3.2
SELECT id AS Numero, nombre AS "Nombre Jugador", equipo_id AS "Codigo Equipo" FROM jugadores;

-- 5.3.3
SELECT id Numero, nombre "Nombre Jugador", equipo_id "Codigo Equipo" FROM jugadores;

-- 5.3.4
SELECT jugadores.id AS Numero,
       jugadores.nombre AS "Nombre Jugador",
       jugadores.equipo_id AS "Codigo Equipo"
FROM jugadores;

-- 5.3.5
SELECT futbol.jugadores.id AS Numero,
       futbol.jugadores.nombre AS "Nombre Jugador",
       futbol.jugadores.equipo_id AS "Codigo Equipo"
FROM futbol.jugadores;

-- 5.3.6
SELECT (32 + (0.33 * 10)) / 4 AS resultado;


-- 5.4 Con predicciones (WHERE)
-- 5.4.1
SELECT * FROM jugadores WHERE equipo_id = 2;

-- 5.4.2
SELECT * FROM jugadores WHERE id = 4;

-- 5.4.3
SELECT * FROM jugadores WHERE equipo_id = 2 ORDER BY fecha_nac DESC LIMIT 3;

-- 5.4.4
SELECT * FROM equipos WHERE aforo > 10000;

-- 5.4.5
SELECT * FROM equipos WHERE aforo > 12000 AND fundacion > 1970;

-- 5.4.6
SELECT * FROM goles WHERE jugador_id = 1;

-- 5.4.7
SELECT * FROM goles WHERE jugador_id = 1
AND partido_id IN (
    SELECT id
    FROM partidos
    WHERE equipo_casa_id = 1
);

-- 5.4.8
SELECT *
FROM jugadores WHERE nombre LIKE 'Lamine%';

-- 5.4.9
SELECT * FROM jugadores WHERE equipo_id = 1 AND nombre LIKE 'Jude%';

-- 5.4.10
SELECT * FROM partidos WHERE equipo_casa_id = 3 AND goles_casa > goles_fuera;

-- 5.4.11
SELECT * FROM partidos WHERE goles_casa > goles_fuera;

-- 5.4.12
SELECT * FROM partidos WHERE goles_casa = goles_fuera;

-- 5.4.13
SELECT * FROM partidos WHERE goles_fuera > goles_casa;

-- 5.4.14
SELECT * FROM partidos WHERE ABS(goles_casa - goles_fuera) > 1;

-- 5.5 Operadores IN, BETWEEN, LIKE
-- 5.5.1
SELECT * FROM jugadores WHERE equipo_id IN (
    SELECT id
    FROM equipos
    WHERE nombre IN ('Real Madrid', 'FC Barcelona', 'Real Betis Balompié')
);

-- 5.5.2
SELECT * FROM equipos WHERE aforo BETWEEN 40000 AND 80000;

-- 5.5.3
SELECT * FROM equipos WHERE aforo >= 30000;

-- 5.5.4
SELECT * FROM jugadores WHERE fecha_nac BETWEEN '1995-01-01' AND '2000-12-31';

-- 5.5.5
SELECT * FROM jugadores WHERE nombre LIKE 'D%';

-- 5.5.6
SELECT * FROM jugadores WHERE nombre LIKE '%Alarcón%';

-- 5.6 Con criterios de ordenación (ORDER BY)
-- 5.6.1
SELECT * FROM jugadores ORDER BY nombre DESC;

-- 5.6.2
SELECT * FROM equipos ORDER BY aforo DESC;

-- 5.6.3
SELECT * FROM jugadores ORDER BY equipo_id, nombre;

-- 5.6.4
SELECT * FROM jugadores WHERE equipo_id = 1 ORDER BY fecha_nac ASC;

-- 5.6.5
SELECT * FROM jugadores WHERE equipo_id = 2 ORDER BY fecha_nac DESC;