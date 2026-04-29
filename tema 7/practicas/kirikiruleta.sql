-- funciones MYSQL

-- funciones de lista
-- 1. devuelve el valor mayor de la lista
SELECT greatest(45, 67, 12, 5);

-- 2. si quisierammos un select mas descriptivo mostrando un texto
SELECT
'angulo de:',
45,
RADIANS(45) radianes,
SIN(RADIANS(45)) seno;

-- 3. valor aleatorio entre 0 y 1 (0,1)
SELECT RAND() val_1, RAND() val_2, RAND() val_3, RAND() val_4;

-- 4. numero aleatorio entre 1 y 10
SELECT ceiling(RAND() * 10);

-- 5. numero aleatorio entre 0 y 9
SELECT floor(rand()*10);

-- 6. numero aleatorio entre 1 y 6
SELECT CEILING(RAND()*6) dado_1,
		CEILING(RAND()*6) dado_2,
		CEILING(RAND()*6) dado_3,
		CEILING(RAND()*6) dado_4;
    
-- 4. Consulta
SELECT 
    id,
    nombre,
    apellidos,
    nss,
    
-- orden normal
SUBSTRING_INDEX(direccion, ', ', 1) AS codigo_postal,
    SUBSTRING_INDEX(SUBSTRING_INDEX(direccion, ', ', 2), ', ', -1) AS ciudad,
    '' AS provincia,
    SUBSTRING_INDEX(direccion, ', ', -1) AS estado,

-- orden invertido
SUBSTRING_INDEX(direccion, ', ', -1) AS estado_inv,
    '' AS provincia_inv,
    SUBSTRING_INDEX(SUBSTRING_INDEX(direccion, ', ', 2), ', ', -1) AS ciudad_inv,
    SUBSTRING_INDEX(direccion, ', ', 1) AS codigo_postal_inv

from empleados;

-- 5. Crear código
SELECT 
    id,
    apellidos,
    nombre,
    nss,
    CONCAT(
        RIGHT(nss, 3), '/',
        UPPER(LEFT(nombre, 2)),
        UPPER(LEFT(SUBSTRING_INDEX(apellidos, ' ', 1), 2)),
        UPPER(LEFT(SUBSTRING_INDEX(apellidos, ' ', -1), 2))
    ) AS codigo_generado
