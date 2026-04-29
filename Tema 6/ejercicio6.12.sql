-- actividad 6.12 views
-- 1. Crear consulta
SELECT 
    movimientos.id,
    movimientos.id_cuenta,
    cuentas.num_cuenta,
    CONCAT(clientes.apellidos, ', ', clientes.nombre) AS cliente,
    DATE(movimientos.fecha_hora) AS fecha,
    movimientos.concepto,
    movimientos.tipo,
    movimientos.cantidad,
    movimientos.saldo
FROM movimientos
JOIN cuentas ON movimientos.id_cuenta = cuentas.id
JOIN clientes ON cuentas.id_cliente = clientes.id
ORDER BY movimientos.id;

-- 2. Crear la vista mov_clientes a partir de la consulta anterior
CREATE VIEW mov_clientes AS
SELECT 
    movimientos.id,
    movimientos.id_cuenta,
    cuentas.num_cuenta,
    CONCAT(clientes.apellidos, ', ', clientes.nombre) AS cliente,
    DATE(movimientos.fecha_hora) AS fecha,
    movimientos.concepto,
    movimientos.tipo,
    movimientos.cantidad,
    movimientos.saldo
FROM movimientos
JOIN cuentas ON movimientos.id_cuenta = cuentas.id
JOIN clientes ON cuentas.id_cliente = clientes.id;

-- 3. A partir de la vista anterior realizar las siguientes consultas:
-- 3.1
SELECT *
FROM mov_clientes
WHERE YEAR(fecha) = 2021;

-- 3.2
SELECT *
FROM mov_clientes
WHERE tipo = 'I';

-- 3.3
SELECT *
FROM mov_clientes
WHERE tipo = 'R'
AND cantidad < 10;

-- 3.4
SELECT 
    num_cuenta,
    SUM(cantidad) AS saldo_total
FROM mov_clientes
GROUP BY num_cuenta;