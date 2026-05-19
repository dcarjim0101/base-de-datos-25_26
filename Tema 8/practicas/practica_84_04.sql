-- Practica 8.4
-- David Carrero Jiménez

-- Actividad 1. actualizar_saldo()
USE bancos;
DROP PROCEDURE IF EXISTS actualizar_saldo;
DELIMITER $$
CREATE PROCEDURE actualizar_saldo()
BEGIN
    UPDATE cuentas
    SET saldo = saldo_cuenta(id_cuenta);
    SELECT 
        id_cuenta,
        IBAN,
        saldo
    FROM cuentas;
END$$
DELIMITER ;
CALL actualizar_saldo();

-- Actividad 2. mantenimiento(cuota)
USE bancos;
DROP PROCEDURE IF EXISTS mantenimiento;
DELIMITER $$

CREATE PROCEDURE mantenimiento(IN cuota DECIMAL(15,2))
BEGIN
    INSERT INTO movimientos(id_cuenta, fecha_hora, concepto, tipo, importe)
    SELECT 
        id_cuenta,
        NOW(),
        'Cuota mantenimiento 2026',
        'R',
        -cuota
    FROM cuentas;
    UPDATE cuentas
    SET saldo = saldo - cuota;
    SELECT 
        id_cuenta,
        IBAN,
        saldo
    FROM cuentas;
END$$
DELIMITER ;
CALL mantenimiento(15);

-- Actividad 3. cuota_mantenimiento_2()
USE bancos;
DROP PROCEDURE IF EXISTS cuota_mantenimiento_2;
DELIMITER $$
CREATE PROCEDURE cuota_mantenimiento_2()
BEGIN
    INSERT INTO movimientos(id_cuenta, fecha_hora, concepto, tipo, importe)
    SELECT
        id_cuenta,
        NOW(),
        'Cuota mantenimiento 2026',
        'R',
        CASE
            WHEN saldo < 2000 THEN -20
            WHEN saldo <= 10000 THEN -10
            ELSE -5
        END
    FROM cuentas;
    UPDATE cuentas
    SET saldo = saldo +
    CASE
        WHEN saldo < 2000 THEN -20
        WHEN saldo <= 10000 THEN -10
        ELSE -5
    END;
    SELECT 
        id_cuenta,
        IBAN,
        saldo
    FROM cuentas;
END$$
DELIMITER ;
CALL cuota_mantenimiento_2();