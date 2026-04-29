-- actividad 6.9 Consultas Multitablas Avanzadas

-- 1. Empleados.
SELECT 
    e.id,
    e.nombre,
    e.apellidos,
    e.salario,
    e.departamento_id,
    d.nombre AS nombre_departamento
FROM empleados e JOIN departamentos d ON e.departamento_id = d.id ORDER BY e.id;

-- 2. Departamentos.
SELECT 
    d.id,
    d.nombre,
    d.localizacion,
    d.componentes,
    d.jefe_departamento_id,
    e.apellidos,
    e.nombre
FROM departamentos d JOIN empleados e ON d.jefe_departamento_id = e.id ORDER BY d.nombre;

-- 3. Empleados con supervisor
SELECT 
    e.id,
    e.nombre,
    e.apellidos,
    e.nss,
    e.salario,
    s.nombre AS nombre_supervisor,
    s.apellidos AS apellidos_supervisor
FROM empleados e LEFT JOIN empleados s ON e.supervisor_id = s.id ORDER BY e.id;

-- 4. Beneficiarios con Empleados
SELECT 
    b.id,
    b.nombre,
    b.genero,
    b.parentesco,
    b.fecha_nac,
    b.empleado_id,
    e.nombre AS nombre_empleado,
    e.apellidos AS apellidos_empleado
FROM beneficiarios b JOIN empleados e ON b.empleado_id = e.id;

-- 5. Proyectos
SELECT 
    p.id,
    p.descripcion,
    p.num_proyecto,
    p.localizacion,
    p.fecha_inicio,
    p.fecha_fin,
    p.departamento_id,
    d.nombre AS nombre_departamento
FROM proyectos p JOIN departamentos d ON p.departamento_id = d.id;

-- 6. Proyectos con Jefe de Departamento
SELECT 
    p.id,
    p.descripcion,
    p.num_proyecto,
    p.localizacion,
    p.fecha_inicio,
    p.fecha_fin,
    p.departamento_id,
    d.nombre AS nombre_departamento,
    e.nombre AS nombre_jefe,
    e.apellidos AS apellidos_jefe
FROM proyectos p JOIN departamentos d ON p.departamento_id = d.id JOIN empleados e ON d.jefe_departamento_id = e.id;

-- 7. Informe empleados_proyectos
SELECT 
    ep.empleado_id,
    ep.proyecto_id,
    ep.horas,
    e.nombre,
    e.apellidos,
    p.descripcion
FROM empleados_proyectos ep JOIN empleados e ON ep.empleado_id = e.id JOIN proyectos p  ON ep.proyecto_id = p.id ORDER BY e.apellidos, e.nombre;