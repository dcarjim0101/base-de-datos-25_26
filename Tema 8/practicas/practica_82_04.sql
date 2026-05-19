-- Practica 8.2
-- David Carrero Jiménez

USE bancos;

-- Actividad 1. saldo_total
DELIMITER $$

CREATE FUNCTION saldo_total() RETURNS DECIMAL(10,2)
BEGIN
    RETURN (SELECT SUM(saldo) FROM cuentas);
END$$

DELIMITER ;

SELECT saldo_total() AS 'Saldo Total';


-- Actividad 2. mejor_cliente
DELIMITER $$

CREATE FUNCTION mejor_cliente() RETURNS INT UNSIGNED
BEGIN
    RETURN (SELECT cliente_id FROM cuentas WHERE saldo = (SELECT MAX(saldo) FROM cuentas) LIMIT 1);
END$$

DELIMITER ;

SELECT mejor_cliente() AS 'ID del Mejor Cliente';


-- Actividad 3. Función saldo_cuentas
DELIMITER $$

CREATE FUNCTION saldo_cuentas(p_cuenta_id INT UNSIGNED) RETURNS DECIMAL(10,2)
BEGIN
    RETURN (SELECT COALESCE(SUM(cantidad), 0) FROM movimientos WHERE cuenta_id = p_cuenta_id);
END$$

DELIMITER ;

SELECT saldo_cuentas(1) AS 'Saldo Verificado Cuenta 1';


-- Actividad 4. Procedimiento verificar_saldo
DELIMITER $$

CREATE PROCEDURE verificar_saldo(p_cuenta_id INT UNSIGNED)
BEGIN
    SELECT 
        c.id,
        c.iban,
        c.saldo AS 'Saldo Registrado',
        saldo_cuentas(c.id) AS 'Saldo Verificado',
        c.saldo - saldo_cuentas(c.id) AS 'Diferencia'
    FROM cuentas c
    WHERE c.id = p_cuenta_id;
END$$

DELIMITER ;

CALL verificar_saldo(1);


-- Actividad 5. Procedimiento verificar_saldo
DELIMITER $$

CREATE PROCEDURE verificar_saldo_actualizar(p_cuenta_id INT UNSIGNED)
BEGIN
    UPDATE cuentas 
    SET saldo = saldo_cuentas(p_cuenta_id) 
    WHERE id = p_cuenta_id;
    
    SELECT * FROM cuentas WHERE id = p_cuenta_id;
END$$

DELIMITER ;

CALL verificar_saldo_actualizar(1);
