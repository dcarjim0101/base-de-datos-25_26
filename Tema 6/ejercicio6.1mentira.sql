-- Actividad 6.1
-- tema 6 Lenguaje SQL - DML
-- base de datos 25/26
-- alumno: David Carrero Jiménez

USE proyectos;

-- 1. Añadir los detalles de 5 clientes INSERT VALUES
INSERT INTO clientes VALUES
(null, 'ayuntamiento de Ubrique', '12345678T'),
(null, 'Almacen maderero García', '14445678T'),
(null, 'Curtisierra', '1234565T'),
(null, 'Fundas gafas piel jimenez', '88845678T'),
(null, 'jumove sierra', '123451234T');

-- 2. añadir los detalles de 1 cliente INSERT SET
INSERT INTO clientes SET
	nombre = 'infosama ubrique',
    nif = '45678123R';
    
-- 3. añadir 5 proyectos con INSERT VALUES
INSERT INTO proyectos VALUES
(null, 'puente romano puerto serrano', 'salida de puerto serrano a sevilla', 34000.00, 1, null, 'Presupuestado'),
(null, 'puente romano montellano', 'salida de montellano a sevilla', 34001.00, 2, null, 'Presupuestado'),
(null, 'puente romano el coronil', 'salida de el coronil a sevilla', 34002.00, 3, null, 'Iniciado'),
(null, 'puente romano los molares', 'salida de los molares a sevilla', 34003.00, 4, null, 'Presupuesto'),
(null, 'puente romano bornos', 'salida de bornos a jerez', 34004.00, 5, null, 'Iniciado');

-- 4. añadir 1 proyecto con INSERT SET

-- 5. añadir 5 empleados con INSERT VALUES

-- 6. añadir 1 empleado con INSERT SET
