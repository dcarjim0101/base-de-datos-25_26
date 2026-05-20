-- ejemplo triggers en PL/SQL
USE bancos;

-- ejemplo 1: trigger para actualizar el saldo de una cuenta cada vez que se inserta un nuevo movimiento
-- nombre: Actualizar_Saldo
-- momento: after
-- evento: insert

DELIMITER $$
DROP TRIGGER IF EXISTS Actualizar_Saldo$$
CREATE TRIGGER Actualizar_Saldo AFTER INSERT ON movimientos
FOR EACH ROW
BEGIN
    UPDATE cuentas SET saldo = saldo + NEW.cantidad WHERE id = NEW.cuenta_id;
END$$