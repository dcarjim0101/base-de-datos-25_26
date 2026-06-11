-- practica recuperacion 8_2
-- David Carrero Jiménez

-- Actividad 1. saldo_total
-- Crear una función que devuelva la suma total del saldo de todas las cuentas. 
DELIMITER $$
DROP FUNCTION IF EXISTS saldo_total $$
CREATE FUNCTION saldo_total()
RETURNS DECIMAL(10,2)
BEGIN

	DECLARE v_total DECIMAL(10,2);

	SET v_total = (
		SELECT SUM(saldo)
		FROM cuentas
	);

	RETURN v_total;

END $$
DELIMITER ;

SELECT saldo_total();


-- Actividad 2. mejor_cliente
-- Crear una función que devuelva el id del mejor cliente. Siendo el mejor cliente aquél al que pertenece la cuenta de mayor saldo.
DELIMITER $$
DROP FUNCTION IF EXISTS mejor_cliente $$
CREATE FUNCTION mejor_cliente()
RETURNS INT UNSIGNED
BEGIN

	DECLARE v_cliente INT UNSIGNED;

	SET v_cliente = (
		SELECT cliente_id
		FROM cuentas
		ORDER BY saldo DESC
		LIMIT 1
	);

	RETURN v_cliente;
END $$
DELIMITER ;

SELECT mejor_cliente();


-- Actividad 3. Función saldo_cuentas
DELIMITER $$
DROP FUNCTION IF EXISTS saldo_cuentas $$
CREATE FUNCTION saldo_cuentas(p_id_cuenta INT UNSIGNED)
RETURNS DECIMAL(10,2)
BEGIN

	DECLARE v_saldo DECIMAL(10,2);

	SET v_saldo = (
		SELECT SUM(cantidad)
		FROM movimientos
		WHERE cuenta_id = p_id_cuenta
	);

	RETURN v_saldo;
END $$
DELIMITER ;

SELECT saldo_cuentas(1);


-- Actividad 4. Procedimiento verificar_saldo
DELIMITER $$
DROP PROCEDURE IF EXISTS verificar_saldo $$
CREATE PROCEDURE verificar_saldo(p_id_cuenta INT UNSIGNED)
BEGIN

	DECLARE v_saldo_tabla DECIMAL(10,2);
	DECLARE v_saldo_real DECIMAL(10,2);

	SET v_saldo_tabla = (
		SELECT saldo
		FROM cuentas
		WHERE id = p_id_cuenta
	);

	SET v_saldo_real = saldo_cuentas(p_id_cuenta);

	IF v_saldo_tabla != v_saldo_real THEN

		SELECT *
		FROM cuentas
		WHERE id = p_id_cuenta;

	END IF;
END $$
DELIMITER ;

CALL verificar_saldo(2);


-- Actividad 5. Procedimiento auditar_saldo
-- Idem que el anterior, pero en caso de no coincidencia de los saldos, actualizar a partir del saldo total obtenido a partir de los movimientos.
DELIMITER $$
DROP PROCEDURE IF EXISTS auditar_saldo $$
CREATE PROCEDURE auditar_saldo(p_id_cuenta INT UNSIGNED)
BEGIN

	DECLARE v_saldo_tabla DECIMAL(10,2);
	DECLARE v_saldo_real DECIMAL(10,2);

	SET v_saldo_tabla = (
		SELECT saldo
		FROM cuentas
		WHERE id = p_id_cuenta
	);

	SET v_saldo_real = saldo_cuentas(p_id_cuenta);

	IF v_saldo_tabla != v_saldo_real THEN

		UPDATE cuentas
		SET saldo = v_saldo_real
		WHERE id = p_id_cuenta;

		SELECT 'descuadre actualizado';
	END IF;
END $$
DELIMITER ;

CALL auditar_saldo(2);