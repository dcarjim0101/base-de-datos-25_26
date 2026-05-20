-- practica 85
-- alumno: David Carrero Jiménez
-- base de datos: triggers
-- curso: 25/26

USE bancos;

-- ejercicio 1
-- nombre: bonificacion_apertura
-- descripcion: Trigger para otorgar una bonificación de 20 euros a la apertura de una nueva cuenta
-- momento: AFTER
-- evento: INSERT
-- tabla: cuentas

DELIMITER $$
DROP TRIGGER IF EXISTS bonificacion_apertura$$
CREATE TRIGGER bonificacion_apertura AFTER INSERT ON cuentas
FOR EACH ROW
BEGIN
    -- insertar un movimiento de bonificación por apertura
    INSERT INTO movimientos (cuenta_id, fecha_hora, concepto, tipo, cantidad)
    VALUES (NEW.id, NOW(), 'Bonificación apertura', 'I', 20.00);

END$$

-- uso del trigger bonificacion_apertura

-- insertar nueva cuenta para el cliente 1

-- USO
DELIMITER ;
INSERT INTO cuentas (id, iban, cliente_id, fecha, saldo)
VALUES (6, 'ES00000870000000010000', 1, NOW(), 0.00);

INSERT INTO cuentas (id, iban, cliente_id, fecha, saldo)
VALUES (null, 'ES00000870000000020000', 2, NOW(), 0.00);

DELIMITER $$


-- Actividad 2. validar_movimiento()
-- Crear un TRIGGERS de forma que si un usuario realiza un movimiento en su cuenta de tipo R reintegro y resulta que la cantidad a retirar es superior al saldo disponible, registre finalmente ese movimiento pero como no tiene saldo, la cantidad a retirar sería cero. En caso de que el cliente tenga saldo se deberá actualizar la columna saldo de la tabla cuentas. 
 
-- Por otro lado si el cliente va a realizar un ingreso, sólo se debe proceder actualizando la columna saldo de la tabla cuentas.

DROP TRIGGER IF EXISTS validar_movimiento$$
CREATE TRIGGER validar_movimiento BEFORE INSERT ON movimientos
FOR EACH ROW
BEGIN
    SET NEW.cantidad = CASE
        WHEN NEW.tipo = 'R' AND NEW.cantidad > (SELECT saldo FROM cuentas WHERE id = NEW.cuenta_id) THEN 0ELSE NEW.cantidad
    END;
END$$
DELIMITER ;
