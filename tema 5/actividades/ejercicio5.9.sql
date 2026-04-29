CREATE DATABASE RestriccionesDefault
CHARACTER SET utf8 COLLATE utf8_general_ci;

-- borro la base de datos RestriccionesDefault si existe y la creo si no existe
DROP DATABASE IF EXISTS RestriccionesDefault;
CREATE DATABASE IF NOT EXISTS RestriccionesDefault;

-- uso esta base de datos
USE RestriccionesDefault;

DROP TABLE IF EXISTS resdefault;
CREATE TABLE IF NOT EXISTS resdefault(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    poblacion TINYINT(20) NOT NULL,
    provincia VARCHAR(20) NOT NULL,
    nacionalidad VARCHAR(20) NOT NULL,
    precio DECIMAL(4,2) NOT NULL,
    sueldo DECIMAL(4,1) NOT NULL,
    fecha_hora DATETIME,
    fecha_llegada DATETIME,
    hora_llegada DATETIME,
    casado BOOLEAN,
    carnet_conducir BOOLEAN
);

INSERT INTO resdefault VALUES
(null, '17000', 'Cadiz', 'española', default, default);