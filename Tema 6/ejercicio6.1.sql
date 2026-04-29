-- Actividad 6.1
-- tema 6 Lenguaje SQL - DML
-- base de datos 25/26
-- alumno: David Carrero Jiménez

-- descripcion: mina de datos de la bbdd futbol
USE futbol;

-- tabla equipos
INSERT INTO equipos (nombre, estadio, aforo, fundacion, ciudad) VALUES
('Valencia CF', 'Mestalla', 49430, 1919, 'Valencia'),
('Villarreal CF', 'Estadio de la Cerámica', 23500, 1923, 'Villarreal'),
('Athletic Club', 'San Mamés', 53289, 1898, 'Bilbao'),
('Real Sociedad', 'Reale Arena', 39500, 1909, 'San Sebastián'),
('RC Celta de Vigo', 'Abanca-Balaídos', 29000, 1923, 'Vigo');

-- tabla jugadores
INSERT INTO jugadores (nombre, fecha_nac, equipo_id) VALUES
-- Valencia CF
('José Gayà', '1995-05-25', 1),
('Hugo Duro', '1999-11-10', 1),
('Giorgi Mamardashvili', '2000-09-29', 1),

-- Villarreal CF
('Gerard Moreno', '1992-04-07', 2),
('Dani Parejo', '1989-04-16', 2),
('Álex Baena', '2001-07-20', 2),

-- Athletic Club
('Iñaki Williams', '1994-06-15', 3),
('Nico Williams', '2002-07-12', 3),
('Oihan Sancet', '2000-04-25', 3),

-- Real Sociedad
('Mikel Oyarzabal', '1997-04-21', 4),
('Takefusa Kubo', '2001-06-04', 4),
('Martín Zubimendi', '1999-02-02', 4),

-- RC Celta de Vigo
('Iago Aspas', '1987-08-01', 5),
('Jonathan Bamba', '1996-03-26', 5),
('Fran Beltrán', '1999-02-03', 5);

-- tabla partidos
INSERT INTO partidos (equipo_casa_id, equipo_fuera_id, fecha, goles_casa, goles_fuera, observaciones) VALUES
(6, 7, '2024-09-01 18:30:00', 1, 1, 'Empate igualado en Mestalla'),
(8, 9, '2024-09-07 21:00:00', 2, 0, 'Athletic sólido en San Mamés'),
(10, 6, '2024-09-14 18:30:00', 0, 2, 'Valencia gana con autoridad fuera de casa'),
(7, 8, '2024-09-21 21:00:00', 3, 2, 'Partido muy ofensivo en La Cerámica'),
(9, 10, '2024-09-28 18:30:00', 1, 0, 'Victoria ajustada de la Real Sociedad'),
(7, 9, '2024-10-05 18:30:00', 2, 2, 'Empate con alternativas en La Cerámica'),
(6, 8, '2024-10-12 21:00:00', 1, 0, 'Valencia se impone en Mestalla'),
(10, 7, '2024-10-19 18:30:00', 1, 3, 'Villarreal domina el encuentro'),
(9, 6, '2024-10-26 21:00:00', 2, 1, 'Remontada de la Real en casa'),
(8, 10, '2024-11-02 18:30:00', 2, 1, 'Athletic gana con gol decisivo en San Mamés');

-- tabla goles
INSERT INTO goles (partido_id, minuto, descripcion, jugador_id) VALUES
-- Partido 7: Valencia 1 - 1 Villarreal
(7, 35, 'Hugo Duro remata dentro del área', 17),
(7, 70, 'Gerard Moreno empata con disparo cruzado', 19),

-- Partido 8: Athletic 2 - 0 Real Sociedad
(8, 25, 'Iñaki Williams marca tras una contra', 22),
(8, 60, 'Oihan Sancet anota desde la frontal', 24),

-- Partido 9: Celta 0 - 2 Valencia
(9, 40, 'José Gayà marca llegando desde atrás', 16),
(9, 75, 'Hugo Duro sentencia el partido', 17),

-- Partido 10: Villarreal 3 - 2 Athletic
(10, 15, 'Álex Baena abre el marcador', 21),
(10, 30, 'Iñaki Williams empata el encuentro', 22),
(10, 50, 'Gerard Moreno marca de penalti', 19),
(10, 65, 'Nico Williams empata con un gran disparo', 23),
(10, 85, 'Dani Parejo marca el gol de la victoria', 20),

-- Partido 11: Real Sociedad 1 - 0 Celta
(11, 55, 'Oyarzabal marca tras un centro lateral', 25),

-- Partido 12: Villarreal 2 - 2 Real Sociedad
(12, 20, 'Gerard Moreno define con clase', 19),
(12, 45, 'Takefusa Kubo empata antes del descanso', 26),
(12, 70, 'Álex Baena marca desde fuera del área', 21),
(12, 88, 'Oyarzabal empata de cabeza', 25),

-- Partido 13: Valencia 1 - 0 Athletic
(13, 60, 'Hugo Duro marca el único gol del partido', 17),

-- Partido 14: Celta 1 - 3 Villarreal
(14, 10, 'Iago Aspas marca de falta directa', 28),
(14, 30, 'Gerard Moreno empata el partido', 19),
(14, 55, 'Álex Baena culmina una buena jugada', 21),
(14, 80, 'Dani Parejo cierra el partido desde el punto de penalti', 20),

-- Partido 15: Real Sociedad 2 - 1 Valencia
(15, 25, 'Takefusa Kubo abre el marcador', 26),
(15, 50, 'Hugo Duro empata el encuentro', 17),
(15, 78, 'Oyarzabal marca el gol de la victoria', 25),

-- Partido 16: Athletic 2 - 1 Celta
(16, 35, 'Nico Williams marca tras una jugada individual', 23),
(16, 60, 'Iago Aspas empata el partido', 28),
(16, 85, 'Iñaki Williams da la victoria al Athletic', 22);