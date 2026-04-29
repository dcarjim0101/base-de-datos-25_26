-- actividad 6.10 
-- 1. Mostrar los detalles sobre empleados y departamentos.
SELECT 
    e.id,
    e.nombre,
    e.apellidos,
    e.nss,
    TIMESTAMPDIFF(YEAR,
        e.fecha_nac,
        CURDATE()) AS edad,
    e.salario,
    d.nombre AS departamento
FROM
    empleados e
        LEFT JOIN
    departamentos d ON e.departamento_id = d.id
ORDER BY e.id;

-- 2. Mostrar detalles a cerca de los departamentos.
SELECT 
    d.id,
    d.nombre,
    d.jefe_departamento_id,
    e.id AS empleado_id,
    e.nombre,
    e.apellidos
FROM
    departamentos d
        LEFT JOIN
    empleados e ON d.id = e.departamento_id
ORDER BY d.id;

-- 3. Mostrar los detalles sobre los empleados que hayan trabajado en algún proyecto.
SELECT 
    e.id,
    e.nombre,
    e.apellidos,
    d.nombre AS departamento,
    p.descripcion AS proyecto,
    ep.horas
FROM
    empleados e
        LEFT JOIN
    departamentos d ON e.departamento_id = d.id
        LEFT JOIN
    empleados_proyectos ep ON e.id = ep.empleado_id
        LEFT JOIN
    proyectos p ON ep.proyecto_id = p.id
ORDER BY ep.horas DESC;

-- 4. Mostrar los siguientes detalles sobre proyectos
SELECT 
    p.id,
    p.descripcion AS nombre_proyecto,
    p.num_proyecto,
    p.fecha_inicio,
    d.nombre AS departamento,
    e.nombre,
    e.apellidos,
    ep.horas
FROM
    proyectos p
        LEFT JOIN
    departamentos d ON p.departamento_id = d.id
        LEFT JOIN
    empleados_proyectos ep ON p.id = ep.proyecto_id
        LEFT JOIN
    empleados e ON ep.empleado_id = e.id
ORDER BY ep.horas DESC;