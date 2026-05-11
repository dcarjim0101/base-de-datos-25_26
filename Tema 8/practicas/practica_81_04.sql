-- Practica 8.1
-- ejercicio 1
DELIMITER $$
DROP PROCEDURE IF EXISTS clientes_por_ciudad $$
CREATE PROCEDURE clientes_por_ciudad(IN p_ciudad VARCHAR(20))
BEGIN
    SELECT * FROM clientes WHERE ciudad = p_ciudad;
END $$

-- uso del procedimiento
DELIMITER ;
CALL clientes_por_ciudad('Ubrique');

-- ejercicio 2
DELIMITER $$
DROP PROCEDURE IF EXISTS movimientos_cuenta $$
CREATE PROCEDURE movimientos_cuenta(IN p_cuenta VARCHAR(10))
DROP DATABASE IF EXISTS movimientos_cuenta $$
CREATE PROCEDURE movimientos WHERE cuenta_10 = p_cuenta ORDER BY FechaHora DESC;
END $$

-- uso del procedimiento
DELIMITER ;
CALL movimientos_cuenta(1);

-- ejercicio 3
DELIMITER $$
DROP PROCEDURE IF EXISTS clientes_cuentas $$
CREATE PROCEDURE clientes_cuentas(IN p_id_cliente INT UNSIGNED)
BEGIN
    SELECT * FROM cuentas WHERE id_cliente = p_id_cliente;
END $$

-- uso del procedimiento
DELIMITER ;
CALL clientes_cuentas(1);

-- ejercicio 4
DELIMITER $$
DROP PROCEDURE IF EXISTS SaldosBajos $$
CREATE PROCEDURE SaldosBajos()
BEGIN
    SELECT c.id_cuenta, c.iban, cl.nombre, cl.apellidos, cl.dni, c.saldo
    FROM cuentas c
    JOIN clientes cl ON c.id_cliente = cl.id_cliente
    WHERE c.saldo <= 200;
END $$
DELIMITER ;

-- uso del procedimiento
CALL SaldosBajos();

-- ejercicio 5
DELIMITER $$
DROP PROCEDURE IF EXISTS SaldoTotalPorCliente $$
CREATE PROCEDURE bancos.SaldoTotalPorCliente()
BEGIN
    SELECT cl.id_cliente, cl.nombre, cl.apellidos, cl.dni, cl.ciudad, SUM(c.saldo) AS saldo_total
    FROM clientes cl
    JOIN cuentas c ON cl.id_cliente = c.id_cliente
    GROUP BY cl.id_cliente
    ORDER BY cl.nombre, cl.apellidos;
END $$
DELIMITER ;

-- uso del procedimiento
CALL SaldoTotalPorCliente();