-- Juego de caracteres mysql
SHOW CHARACTER SET;

-- Muestra las colecciones disponibles
SHOW COLLATION;

-- Crear una base de datos de ejemplo
CREATE DATABASE ejemplo;

-- Crear la base de datos EJEMPLO solo si no existe
CREATE DATABASE IF NOT EXISTS ejemplo;

-- Crear la base de datos BANCO Multiligüe con UTF8
CREATE DATABASE IF NOT EXISTS banco
CHARACTER SET utf8 COLLATE utf8_general_ci;

-- Crear la base de datos BANCO para español con UTF8
CREATE DATABASE IF NOT EXISTS banco
CHARACTER SET utf8 COLLATE utf8_spanish_ci;

-- Crear la base de datos BANCO para español con UTF8MB4
CREATE DATABASE IF NOT EXISTS banco
CHARACTER SET UTF8MB4 COLLATE utf8mb4_spanish_ci;

-- Crear la base de datos BANCO para español con LATIN1
CREATE DATABASE IF NOT EXISTS banco
CHARACTER SET latin1 COLLATE latin1_spanish_ci;

-- Crear la base de datos BANCO Multiligüe con LATIN1
CREATE DATABASE IF NOT EXISTS banco
CHARACTER SET latin1 COLLATE latin1_general_ci;

-- crear la base de datos geslibros español multilingüe con juego de caracteres utf8mb4
-- opciones por defecto
CREATE DATABASE IF NOT EXISTS geslibros
CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;