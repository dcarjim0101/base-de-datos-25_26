-- Actividad 6.7 Subconsultas
USE empresa;

-- 7.1 Mostrar nombre y apellidos de los empleados que trabajan en el mismo departamento que John Smith.
SELECT 
    nombre, apellidos
FROM
    Empleados
WHERE
    departamento_id = (SELECT 
            departamento_id
        FROM
            Empleados
        WHERE
            nombre = 'John' AND apellidos = 'Smith');

-- 7.2 Mostrar nombre y apellidos de los empleados mayores que Franklin Wong
SELECT 
    nombre, apellidos
FROM
    Empleados
WHERE
    fecha_nac < (SELECT 
            fecha_nac
        FROM
            Empleados
        WHERE
            nombre = 'Franklin'
                AND apellidos = 'Wong');

-- 7.3 Mostrar nombre, apellidos y salario de los empleados cuyo salario es mayor que el salario medio de la empresa.
SELECT 
    nombre, apellidos, salario
FROM
    Empleados
WHERE
    salario > (SELECT 
            AVG(salario)
        FROM
            Empleados);

-- 7.4 Mostrar los empleados que trabajan en el departamento Investigación.
SELECT 
    nombre, apellidos
FROM
    Empleados
WHERE
    departamento_id = (SELECT 
            id
        FROM
            Departamentos
        WHERE
            nmbre = 'Investigación');

-- 7.5 Mostrar descripción y localización de los proyectos del departamento Administración.
SELECT 
    descripcion, localizacion
FROM
    Proyectos
WHERE
    departamento_id = (SELECT 
            id
        FROM
            Departamentos
        WHERE
            nmbre = 'Administración');

-- 7.6 Mostrar los empleados que participan en proyectos.
SELECT 
    nombre, apellidos
FROM
    Empleados
WHERE
    id IN (SELECT 
            empleado_id
        FROM
            empleados_proyectos);

-- 7.7 Mostrar empleados que no están asignados a proyectos.
SELECT 
    nombre, apellidos
FROM
    Empleados
WHERE
    id NOT IN (SELECT 
            empleado_id
        FROM
            empleados_proyectos);

-- 7.8 Mostrar empleados que tienen beneficiarios registrados.
SELECT 
    nombre, apellidos
FROM
    Empleados
WHERE
    id IN (SELECT 
            empleado_id
        FROM
            Beneficiarios);

-- 7.9 Mostrar empleados cuyo salario es el máximo de la empresa.
SELECT 
    nombre, apellidos, salario
FROM
    Empleados
WHERE
    salario = (SELECT 
            MAX(salario)
        FROM
            Empleados);

-- 7.10 Mostrar nombre, apellidos y salario de los empleados cuyo salario sea mayor que el salario de al menos un empleado del departamento 1.
SELECT 
    nombre, apellidos, salario
FROM
    Empleados
WHERE
    salario > (SELECT 
            MIN(salario)
        FROM
            Empleados
        WHERE
            departamento_id = 1);

-- 7.11 Mostrar nombre, apellidos y salario de los empleados que ganan más que todos los empleados del departamento 2.  (obtener las dos versiones con y sin ALL)
SELECT 
    nombre, apellidos, salario
FROM
    Empleados
WHERE
    salario > ALL (SELECT 
            salario
        FROM
            Empleados
        WHERE
            departamento_id = 2);

-- 7.12 Mostrar los empleados cuyo número de horas en un proyecto sea mayor que alguna asignación registrada en la tabla empleados_proyectos.
SELECT 
    nombre, apellidos, horas
FROM
    Empleados e
        JOIN
    empleados_proyectos ep ON e.id = ep.empleado_id
WHERE
    horas > (SELECT 
            MIN(horas)
        FROM
            empleados_proyectos);