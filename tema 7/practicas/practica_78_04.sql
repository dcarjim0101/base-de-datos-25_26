-- practica_78_04
-- funciones fecha hora

-- 1. añadir tres corredores
USE maratoon;

INSERT INTO corredores(nombre, apellidos, ciudad, fechaNacimiento, sexo, club_id)
('Javier', 'Moscoso Granados', 'Villaluenga', '1994-07-14', 'H', 5),
('María', 'Rodríguez Pérez', 'Villaluenga', '1954-07-14', 'M', 5),
('Juan', 'Clavijo Moreno', 'Grazalema', '1993-07-14', 'H', 5);

-- 2. actualizar edad
UPDATE corredores 
SET 
    edad = TIMESTAMPDIFF(YEAR,
        fechaNacimiento,
        NOW());

-- 3. Actualizar Categoría
UPDATE corredores SET categoria_id = 
CASE
	WHEN edad < 12 THEN 1 -- infantil
    WHEN edad < 15 THEN 2 -- junior
    WHEN edad < 18 THEN 3 -- juvenil
    WHEN edad < 30 THEN 4 -- senior a
    WHEN edad < 40 THEN 5 -- senior b
    WHEN edad < 50 THEN 6 -- VT A
    WHEN edad < 60 THEN 7 -- VT B
    ELSE 8
END;

-- 4. Maratón de Sevilla
INSERT INTO registros VALUES 
(NULL, 2, 2, '2019-12-02 09:00:00', '2019-12-02 11:15:00', NULL),
(NULL, 2, 3, '2019-12-02 09:00:00', '2019-12-02 11:20:00', NULL),
(NULL, 2, 4, '2019-12-02 09:00:00', '2019-12-02 11:25:00', NULL),
(NULL, 2, 5, '2019-12-02 09:00:00', '2019-12-02 11:30:00', NULL),
(NULL, 2, 6, '2019-12-02 09:00:00', '2019-12-02 11:35:00', NULL);

-- 5. Actualizar tiempo de llegada
UPDATE registros
SET TiempoInvertido = TIMEDIFF(Llegada, Salida)
WHERE carrera_id = 2;

-- 6. Mostrar clasificación
-- clasificación general
SELECT 
    r.corredor_id AS id,
    c.Nombre,
    c.Apellidos,
    cl.Nombre AS club,
    cat.Nombre AS categoria,
    r.TiempoInvertido
FROM registros r
JOIN corredores c ON r.corredor_id = c.id
LEFT JOIN clubs cl ON c.club_id = cl.id
LEFT JOIN categorias cat ON c.categoria_id = cat.id
WHERE r.carrera_id = 2
ORDER BY r.TiempoInvertido ASC;

-- añadir total de segundos
SELECT 
    r.corredor_id AS id,
    c.Nombre,
    c.Apellidos,
    cl.Nombre AS club,
    cat.Nombre AS categoria,
    r.TiempoInvertido,
    TIME_TO_SEC(r.TiempoInvertido) AS total_segundos
FROM registros r
JOIN corredores c ON r.corredor_id = c.id
LEFT JOIN clubs cl ON c.club_id = cl.id
LEFT JOIN categorias cat ON c.categoria_id = cat.id
WHERE r.carrera_id = 2
ORDER BY r.TiempoInvertido ASC;

-- diferencia con el record mundial
SELECT 
    r.corredor_id AS id,
    c.Nombre,
    c.Apellidos,
    cl.Nombre AS club,
    cat.Nombre AS categoria,
    r.TiempoInvertido,
    TIME_TO_SEC(r.TiempoInvertido) AS total_segundos,
    TIME_TO_SEC(r.TiempoInvertido) - 7299 AS diferencia_record_segundos
FROM registros r
JOIN corredores c ON r.corredor_id = c.id
LEFT JOIN clubs cl ON c.club_id = cl.id
LEFT JOIN categorias cat ON c.categoria_id = cat.id
WHERE r.carrera_id = 2
ORDER BY r.TiempoInvertido ASC;

-- clasificacion solo categoria senior a
SELECT 
    r.corredor_id AS id,
    c.Nombre,
    c.Apellidos,
    cl.Nombre AS club,
    cat.Nombre AS categoria,
    r.TiempoInvertido,
    TIME_TO_SEC(r.TiempoInvertido) AS total_segundos,
    TIME_TO_SEC(r.TiempoInvertido) - 7299 AS diferencia_record_segundos
FROM registros r
JOIN corredores c ON r.corredor_id = c.id
LEFT JOIN clubs cl ON c.club_id = cl.id
LEFT JOIN categorias cat ON c.categoria_id = cat.id
WHERE r.carrera_id = 2
AND cat.Nombrecorto = 'SNA'
ORDER BY r.TiempoInvertido ASC;