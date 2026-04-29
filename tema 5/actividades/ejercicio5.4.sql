-- Actividad 5.4

-- usar la base de datos
USE tipo_datos;

-- borro la tabla si existe
DROP TABLE IF EXISTS tipos_datos_string;

-- creo la tabla con las siguientes columnas si no existe
CREATE TABLE tipos_datos_string (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    codigo_postal SMALLINT UNSIGNED,
    telefono INT UNSIGNED,
    apellidos CHAR(20),
    nombre CHAR(20),
    nombre_acronimo CHAR(20),
    historial CHAR(20),
    direccion SMALLINT UNSIGNED,
    provincia CHAR(15),
    observaciones TEXT,
    contenido_libro MEDIUMTEXT,
    categoria CHAR(20),
    create_at DATETIME,
    update_at DATETIME
);

-- añadir los registros
INSERT INTO tipos_datos_string VALUES(
	NULL,
    11659,
    956324654,
    carrero_jimenez,
    david,
    david_acronimo,
    todo_bien,
    11659,
    cadiz,
    todo_bien_jajaja_aqui_viviendo_la_vida,
    hay_muchas_palabras,
    primero_segundo,
    2020-11-6/21-34-56,
    2025-9-24/15-46-21
);