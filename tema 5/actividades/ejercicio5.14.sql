-- Usar la base de datos
USE empleados_taller;

ALTER TABLE clientes
	ADD COLUMN apellidos VARCHAR(50) UNIQUE NOT NULL,
    ADD COLUMN poblacion TINYINT(255) UNIQUE NOT NULL,
    ADD COLUMN nacionalidad VARCHAR(20) UNIQUE NOT NULL,
    ADD COLUMN email VARCHAR(50) UNIQUE NOT NULL,
    ADD COLUMN direccion VARCHAR(50) UNIQUE NOT NULL,
    ADD COLUMN cod_clientes VARCHAR(10) UNIQUE NOT NULL,
    ADD COLUMN tipo_cliente TINYINT(2) UNIQUE NOT NULL;
    
ALTER TABLE clientes
MODIFY nombre VARCHAR(25) NOT NULL,
MODIFY apellidos VARCHAR(45) NOT NULL,
MODIFY nacionalidad VARCHAR(30) DEFAULT 'España',
MODIFY direccion VARCHAR(100);

ALTER TABLE clientes
CHANGE email correo_electronico VARCHAR(60);

ALTER TABLE clientes
ADD CONSTRAINT CK_clientes_correo
CHECK (correo_electronico LIKE '%@%');

ALTER TABLE clientes
ADD CONSTRAINT CK_clientes_tipo
CHECK (tipo_cliente BETWEEN 0 AND 10);

CREATE INDEX IDX_clientes_apellidos_nombre
ON clientes (apellidos, nombre);

SHOW INDEX FROM clientes;