-- Actividad 6.6 Funciones de agregado
USE empresa;

-- 6.1 ORDER BY, LIMIT, ALL, DISTINCT
-- 6.1.1
SELECT * FROM empleados ORDER BY salario DESC LIMIT 3;

-- 6.1.2
SELECT * FROM empleados ORDER BY salario ASC LIMIT 5;

-- 6.1.3
SELECT * FROM empleados ORDER BY nombre ASC;

-- 6.1.4
SELECT * FROM departamentos LIMIT 3;

-- 6.1.5
SELECT * FROM empleados WHERE departamento_id = 3 ORDER BY salario DESC LIMIT 3;

-- 6.2 Función COUNT()
-- 6.2.1
SELECT COUNT(*) AS total_departamentos FROM departamentos;

-- 6.2.2
SELECT COUNT(*) AS total_mujeres FROM Beneficiarios WHERE genero = 'M';

-- 6.2.3
SELECT COUNT(*) AS empleados_salario FROM Empleados WHERE salario BETWEEN 20000 AND 50000;

-- 6.2.4
SELECT COUNT(*) AS empleados_nacidos_despues_1970 FROM Empleados WHERE fecha_nac > '1970-01-01';

-- 6.2.5
SELECT COUNT(*) AS proyectos FROM departamentos WHERE id >= 3;

-- 6.2.6
SELECT COUNT(DISTINCT departamento_id) AS num_departamentos FROM proyectos;

-- 6.2.7
SELECT COUNT(DISTINCT empleado_id) AS num_empleados FROM empleados_proyectos;

-- 6.3 Función SUM()
-- 6.3.1
SELECT SUM(horas) AS total_horas FROM empleados_proyectos;

-- 6.3.2
SELECT SUM(horas) AS total_horas_proyecto2 FROM empleados_proyectos WHERE proyecto_id = 2;

-- 6.3.3
SELECT SUM(salario) AS total_salarios FROM empleados;

-- 6.3.4
SELECT SUM(salario) AS total_salarios FROM empleados WHERE departamento_id = 5;

-- 6.3.5
SELECT SUM(salario) AS total_salarios FROM empleados WHERE supervisor_id = 3;

-- 6.3.6
SELECT COUNT(*) AS numero_empleados,
       SUM(salario) AS total_salarios FROM empleados WHERE departamento_id = 4;
       
-- 6.4 Función AVG()
-- 6.4.1
SELECT AVG(horas) AS media_horas FROM empleados_proyectos;

-- 6.4.2
SELECT COUNT(*) AS total_jornadas,
       SUM(horas) AS suma_horas,
       AVG(horas) AS media_horas
FROM empleados_proyectos;

-- 6.4.3
SELECT COUNT(*) AS numero_empleados,
       SUM(salario) AS suma_salarios,
       AVG(salario) AS media_salarios
FROM empleados WHERE departamento_id = 3;

-- 6.4.4
SELECT AVG(salario) AS salario_medio FROM empleados;

-- 6.4.5
SELECT COUNT(*) AS numero_empleados,
       AVG(salario) AS salario_medio,
       SUM(salario) AS suma_salarios
FROM empleados;

-- 6.4.6
SELECT COUNT(*) AS numero_empleados,
       AVG(salario) AS salario_medio
FROM empleados WHERE fecha_nac BETWEEN '1960-01-01' AND '1980-12-31';

-- 6.4.7
SELECT * FROM empleados WHERE salario > (SELECT AVG(salario) FROM empleados);

-- 6.4.8
SELECT *
FROM empleados
WHERE salario < (
    SELECT AVG(salario)
    FROM empleados
    WHERE departamento_id = 3
);

-- 6.4.9
SELECT e.nss, e.nombre, e.apellidos FROM empleados e JOIN empleados_proyectos ep ON e.id = ep.empleado_id WHERE ep.horas > (SELECT AVG(horas) FROM empleados_proyectos);

-- 6.5 Función MIN() y MAX()
-- 6.5.1
SELECT MAX(salario) AS salario_maximo FROM empleados;

-- 6.5.2
SELECT MIN(salario) AS salario_minimo FROM empleados;

-- 6.5.3
SELECT MAX(horas) AS max_horas FROM empleados_proyectos;

-- 6.5.4
SELECT *
FROM empleados WHERE salario = (SELECT MAX(salario) FROM empleados);

-- 6.5.5
SELECT *
FROM empleados WHERE salario = (SELECT MIN(salario) FROM empleados);

-- 6.5.6
SELECT empleado_id AS nss_empleado_max_horas FROM empleados_proyectos WHERE horas = (SELECT MAX(horas) FROM empleados_proyectos);

-- 6.5.7
SELECT e.nss, e.nombre, e.apellidos FROM empleados e JOIN empleados_proyectos ep ON e.id = ep.empleado_id WHERE ep.horas = (SELECT MAX(horas) FROM empleados_proyectos);

-- 6.5.8
SELECT e.nss FROM empleados e JOIN empleados_proyectos ep ON e.id = ep.empleado_id WHERE ep.horas = (SELECT MIN(horas) FROM empleados_proyectos);

-- 6.5.9
SELECT e.nss, e.nombre, e.apellidos FROM empleados e JOIN empleados_proyectos ep ON e.id = ep.empleado_id WHERE ep.horas = (SELECT MIN(horas) FROM empleados_proyectos);