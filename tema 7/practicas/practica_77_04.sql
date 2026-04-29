-- actividad 7.7
-- david carrero jimenez

USE empresa;
-- 1. Añadir apellidos
UPDATE empleados 
SET 
    apellidos = CONCAT(apellidos, ' López');

-- 2. Consulta
SELECT 
    id, nss, CONCAT(apellidos, ', ', nombre) AS nombre
FROM
    empleados;

-- 3. Consulta
SELECT 
    id,
    nss,
    nombre,
    SUBSTRING_INDEX(apellidos, ' ', 1) AS apellido1,
    SUBSTRING_INDEX(apellidos, ' ', - 1) AS apellido2
FROM
    empleados;
    
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
from empleados;