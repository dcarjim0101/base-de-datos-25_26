-- actividad 6.11
-- GROUP BY - HAVING

-- base de datos empresa
USE empresa;

-- 1. Obtener el número de empleados que hay en cada departamento.
-- columnas: id, departamento, num_empleados
SELECT 
    departamento_id,
    departamentos.nombre departamento,
    COUNT(*) num_empleados
FROM
    empleados
        INNER JOIN
    departamentos ON empleados.departamento_id = departamentos.id
GROUP BY departamento_id;

-- 2. Obtener el número de empleados que hay en cada departamento cuyo sueldo esté por encima de los 30000 anuales.
-- columnas: id, departamento, num_empleados
SELECT 
    departamento_id,
    departamentos.nombre departamento,
    COUNT(*) num_empleados
FROM
    empleados
        LEFT JOIN
    departamentos ON empleados.departamento_id = departamentos.id
WHERE
    salario > 30000
GROUP BY empleados.departamento_id;

-- 3. Obtener el número total de empleados que hay en cada departamento cuyo salario esté comprendido entre 20000 y 50000.
-- Mismas columnas que el ejercicio anterior. 
SELECT 
    departamento_id,
    departamentos.nombre departamento,
    COUNT(*) num_empleados
FROM
    empleados
        LEFT JOIN
    departamentos ON empleados.departamento_id = departamentos.id
WHERE
    salario BETWEEN 20000 AND 50000
GROUP BY empleados.departamento_id;

-- 4. Obtener el número de empleados que nacieron en cada año.
-- Mostrar las columnas con el alias Año y Nempleados.
SELECT 
    YEAR(fecha_nac) AS Año, COUNT(id) AS Nempleados
FROM
    empleados
GROUP BY YEAR(fecha_nac);

-- 5. Sobre la tabla Empleados_proyectos, obtener la suma total de horas trabajadas en cada proyecto.
-- Mostrar id, Proyecto y HorasAcumuladas. 
SELECT 
    proyectos.id,
    proyectos.descripcion AS Proyecto,
    SUM(empleados_proyectos.horas) AS HorasAcumuladas
FROM
    proyectos
        JOIN
    empleados_proyectos ON proyectos.id = empleados_proyectos.proyecto_id
GROUP BY proyectos.id , proyectos.descripcion;

-- 6. Obtener el número de empleados que tiene a su cargo cada supervisor.
-- Mostrar id, Apellidos, Nombre, y el alias numDependientes
SELECT 
    empleados.id,
    empleados.apellidos,
    empleados.nombre,
    COUNT(e2.id) AS numDependientes
FROM
    empleados
        JOIN
    empleados AS e2 ON empleados.id = e2.supervisor_id
GROUP BY empleados.id , empleados.apellidos , empleados.nombre;

-- 7. Obtener para cada departamento la siguiente información estadística:
SELECT 
    departamentos.id AS NumeroDepartamento,
    departamentos.nombre AS NombreDepartamento,
    jefe.nombre AS JefeDepartamento,
    COUNT(empleados.id) AS NumeroEmpleados,
    AVG(empleados.salario) AS SalarioMedio,
    MAX(empleados.salario) AS SalarioMaximo,
    MIN(empleados.salario) AS SalarioMinimo,
    SUM(empleados.salario) AS SumaSalarios
FROM
    departamentos
        LEFT JOIN
    empleados ON departamentos.id = empleados.departamento_id
        LEFT JOIN
    empleados AS jefe ON departamentos.jefe_departamento_id = jefe.id
GROUP BY departamentos.id , departamentos.nombre , jefe.nombre;

-- 8. Obtener la siguiente información:
SELECT 
    empleados.id,
    empleados.nss,
    empleados.nombre,
    COUNT(beneficiarios.id) AS TotalBeneficiarios
FROM
    empleados
        LEFT JOIN
    beneficiarios ON empleados.id = beneficiarios.empleado_id
GROUP BY empleados.id , empleados.nss , empleados.nombre;

-- 9. Mostrar el número de beneficiarios de cada departamento (intervienen las tablas Empleados, Departamento y Dependientes). Mostrará la siguiente información.
SELECT 
    departamentos.id AS idDepartamento,
    departamentos.nombre AS NombreDepartamento,
    COUNT(beneficiarios.id) AS NumBeneficiarios
FROM
    departamentos
        LEFT JOIN
    empleados ON departamentos.id = empleados.departamento_id
        LEFT JOIN
    beneficiarios ON empleados.id = beneficiarios.empleado_id
GROUP BY departamentos.id , departamentos.nombre;

-- 10. Obtener el número de horas acumuladas en cada proyecto, mostrando la siguiente información:
SELECT 
    proyectos.id AS IdProyecto,
    proyectos.descripcion AS NombreProyecto,
    departamentos.nombre AS NombreDepartamento,
    SUM(empleados_proyectos.horas) AS HorasAcumuladas
FROM
    proyectos
        JOIN
    departamentos ON proyectos.departamento_id = departamentos.id
        JOIN
    empleados_proyectos ON proyectos.id = empleados_proyectos.proyecto_id
GROUP BY proyectos.id , proyectos.descripcion , departamentos.nombre;

-- 11. Mostrar el número de horas acumuladas por cada trabajador:
SELECT 
    empleados_proyectos.empleado_id,
    SUM(empleados_proyectos.horas) AS HorasAcumuladas
FROM
    empleados_proyectos
GROUP BY empleados_proyectos.empleado_id;

-- 12. Mostrar el número de horas acumuladas por cada trabajador en cada proyecto.
SELECT 
    empleados_proyectos.empleado_id AS idEmpleado,
    empleados_proyectos.proyecto_id AS IdProyecto,
    SUM(empleados_proyectos.horas) AS HorasAcumuladas
FROM
    empleados_proyectos
GROUP BY empleados_proyectos.empleado_id , empleados_proyectos.proyecto_id;