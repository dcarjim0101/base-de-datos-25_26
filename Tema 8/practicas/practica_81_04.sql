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
