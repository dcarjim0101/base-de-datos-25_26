DROP DATABASE IF EXISTS Futbol;
CREATE DATABASE IF NOT EXISTS Futbol;

USE FUTBOL;

DROP TABLE IF EXISTS equipos;
CREATE TABLE equipos (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL,
    estadio VARCHAR(50) NOT NULL,
    aforo INT UNSIGNED,
    fundacion SMALLINT(4) UNSIGNED,
    ciudad VARCHAR(50)
);

DROP TABLE IF EXISTS jugadores;
CREATE TABLE jugadores (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    fecha_nac DATE,
    equipo_id INT UNSIGNED,
    FOREIGN KEY (equipo_id) REFERENCES equipos (id) 
    ON DELETE SET NULL ON UPDATE CASCADE
);

DROP TABLE IF EXISTS partidos;
CREATE TABLE partidos (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    equipo_casa_id INT UNSIGNED,
    equipo_fuera_id INT UNSIGNED,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    goles_casa TINYINT UNSIGNED,
    goles_fuera TINYINT UNSIGNED,
    observaciones TEXT,
    FOREIGN KEY (equipo_casa_id) REFERENCES equipos (id) 
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (equipo_fuera_id) REFERENCES equipos (id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT partidos_ck CHECK (equipo_casa_id != equipo_fuera_id)
);

DROP TABLE IF EXISTS goles;
CREATE TABLE goles (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    partido_id INT UNSIGNED NOT NULL,
    minuto TINYINT UNSIGNED,
    descripcion TEXT,
    jugador_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (partido_id) REFERENCES partidos (id) 
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (jugador_id) REFERENCES jugadores (id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

USE FUTBOL;

-- Insertar equipos de LaLiga
INSERT INTO equipos VALUES
(1, 'Real Madrid', 'Santiago Bernabéu', 81044, 1902, 'Madrid'),
(2, 'FC Barcelona', 'Spotify Camp Nou', 99354, 1899, 'Barcelona'),
(3, 'Atlético de Madrid', 'Cívitas Metropolitano', 68456, 1903, 'Madrid'),
(4, 'Sevilla FC', 'Ramón Sánchez-Pizjuán', 43883, 1890, 'Sevilla'),
(5, 'Real Betis Balompié', 'Benito Villamarín', 60721, 1907, 'Sevilla');

-- Insertar jugadores actuales de LaLiga
INSERT INTO jugadores VALUES
(1, 'Vinícius Jr.', '2000-07-12', 1),
(2, 'Jude Bellingham', '2003-06-29', 1),
(3, 'Rodrygo Goes', '2001-01-09', 1),
(4, 'Robert Lewandowski', '1988-08-21', 2),
(5, 'Pedri', '2002-11-25', 2),
(6, 'Lamine Yamal', '2007-07-13', 2),
(7, 'Antoine Griezmann', '1991-03-21', 3),
(8, 'Álvaro Morata', '1992-10-23', 3),
(9, 'Rodrigo De Paul', '1994-05-24', 3),
(10, 'Jesús Navas', '1985-11-21', 4),
(11, 'Youssef En-Nesyri', '1997-06-01', 4),
(12, 'Ivan Rakitić', '1988-03-10', 4),
(13, 'Isco Alarcón', '1992-04-21', 5),
(14, 'Borja Iglesias', '1993-01-17', 5),
(15, 'Guido Rodríguez', '1994-04-12', 5);

-- Insertar partidos de LaLiga
INSERT INTO partidos VALUES
(1, 1, 2, '2024-02-18 21:00:00', 2, 1, 'Clásico con gol decisivo de Bellingham'),
(2, 3, 4, '2024-03-02 18:30:00', 1, 0, 'Victoria ajustada del Atlético'),
(3, 2, 4, '2024-03-10 20:00:00', 2, 2, 'Empate en un partido con muchas ocasiones'),
(4, 1, 3, '2024-03-15 21:00:00', 3, 1, 'El Madrid se impone con doblete de Vinícius'),
(5, 5, 1, '2024-04-05 21:00:00', 1, 3, 'El Madrid se impone con autoridad en el Villamarín'),
(6, 5, 3, '2024-04-12 18:30:00', 2, 2, 'Partido vibrante con empate final');

-- Insertar goles de LaLiga
INSERT INTO goles VALUES 
(NULL, 1, 10, 'Golazo de Vinícius tras regatear al portero', 1),
(NULL, 1, 80, 'Bellingham marca de cabeza', 2),
(NULL, 1, 85, 'Lewandowski recorta distancias con un disparo lejano', 4),
(NULL, 2, 30, 'Griezmann adelanta al Atlético tras una gran jugada', 7),
(NULL, 3, 20, 'Pedri abre el marcador con un tiro ajustado', 5),
(NULL, 3, 50, 'En-Nesyri empata tras un error defensivo', 11),
(NULL, 3, 65, 'Lewandowski pone el 2-1 con un penalti', 4),
(NULL, 3, 89, 'Navas sorprende con un gol en el último minuto', 10),
(NULL, 4, 25, 'Bellingham abre el marcador con un disparo lejano', 2),
(NULL, 4, 55, 'Rodrygo amplía la ventaja con una jugada individual', 3),
(NULL, 4, 85, 'Vinícius sentencia tras asistencia de Modric', 1),
(NULL, 4, 91, 'Morata marca el gol del honor para el Atlético', 8),
(NULL, 5, 15, 'Isco marca con un disparo desde la frontal', 13),
(NULL, 5, 50, 'Vinícius empata con un regate espectacular', 1),
(NULL, 5, 70, 'Rodrygo adelanta al Madrid con un disparo raso', 3),
(NULL, 5, 85, 'Bellingham sentencia con un cabezazo', 2),
(NULL, 6, 10, 'Guido Rodríguez abre el marcador con un remate de córner', 15),
(NULL, 6, 30, 'Morata empata tras una contra rápida', 8),
(NULL, 6, 60, 'Borja Iglesias adelanta al Betis con un penalti', 14),
(NULL, 6, 80, 'Griezmann iguala con un gol en el descuento', 7);