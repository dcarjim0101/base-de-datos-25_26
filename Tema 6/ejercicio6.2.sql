-- Actividad 6.2
-- tema 6 Lenguaje SQL - DML
-- base de datos 25/26
-- alumno: David Carrero Jiménez

USE futbol;
-- 1.
UPDATE equipos 
SET 
    nombre = 'Girona Futbol Club'
WHERE
    id = 2 LIMIT 1;

-- 2.
UPDATE equipos 
SET 
    ciudad = 'Vila-real'
WHERE
    id = 7 LIMIT 1;

-- 3.
UPDATE equipos 
SET 
    aforo = aforo + 1000
WHERE
    aforo > 50000;

-- 4.
UPDATE jugadores 
SET 
    equipo_id = 7
WHERE
    nombre = 'Hugo Duro';

-- 5.
UPDATE jugadores 
SET 
    fecha_nac = '2001-06-05'
WHERE
    id = 23 LIMIT 1;

-- 6.
UPDATE partidos 
SET 
    goles_casa = 2,
    goles_fuera = 1
WHERE
    id = 7 LIMIT 1;

-- 7.
UPDATE partidos 
SET 
    observaciones = CONCAT_WS(' ', observaciones, ' (actualizado)')
ORDER BY fecha DESC LIMIT 3;

-- 8.
UPDATE goles 
SET 
    minuto = minuto + 1
WHERE
    descripcion LIKE '%penalti%';

-- 9.
UPDATE goles g
        JOIN
    partidos p ON g.partido_id = p.id
        JOIN
    jugadores j ON g.jugador_id = j.id 
SET 
    g.jugador_id = 18
WHERE
    g.partido_id = 13
        AND j.equipo_id = p.equipo_casa_id;

-- 10.
UPDATE goles 
SET 
    minuto = minuto + 1
WHERE
    jugador_id = 20 ORDER BY minuto LIMIT 2;

-- 11.
UPDATE equipos 
SET 
    estadio = 'Reale Arena Nuevo'
WHERE
    nombre = 'Real Sociedad';

-- 12.
UPDATE jugadores 
SET 
    equipo_id = 8
WHERE
    equipo_id = (SELECT 
            id
        FROM
            equipos
        WHERE
            nombre = 'Girona Futbol Club');

-- 13.
UPDATE partidos 
SET 
    goles_casa = goles_casa + 1
WHERE
    equipo_casa_id = 6;

-- 14.
UPDATE goles 
SET 
    minuto = minuto - 2
WHERE
    minuto > 80;

-- 15.
UPDATE jugadores 
SET 
    nombre = 'José Gayà'
WHERE
    id = 16;