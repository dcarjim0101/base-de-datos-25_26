-- crear la base de datos ajedrez e indicar el juego de caracteres
-- utf8mb4
-- utf8mb4_general_ci
CREATE DATABASE IF NOT EXISTS ajedrez
CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- Modificar la base de datos ajedrez para establecer el juego de caracteres 
-- inglés internacional así como la colección correspondiente.
ALTER DATABASE ajedrez
CHARACTER SET hp8 COLLATE hp8_english_ci;

-- Eliminar la base de datos ajedrez.
DROP DATABASE IF EXISTS ajedrez;

-- Crear la base de datos futbol, usar el juego de caracteres utf16 
-- y la colección utf16_general_ci'
CREATE DATABASE IF NOT EXISTS futbol
CHARACTER SET utf16 COLLATE utf16_general_ci;

-- Modificar la base de datos futbol para cambiar al juego de caracteres 
-- UTF8MB4 y la colección 'utf8mb4_general_ci'
ALTER DATABASE futbol
CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- Eliminar definitivamente la base de datos futbol
DROP DATABASE IF EXISTS futbol;