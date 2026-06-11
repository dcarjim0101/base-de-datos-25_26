-- practica recuperacion 8_4
-- David Carrero Jiménez

-- Actividad 1. actualizar_saldo()
-- Implementa el procedimiento actualizar_saldo() para la base de datos bancos
DELIMITER $$
DROP PROCEDURE IF EXISTS actualizar_saldo $$
CREATE PROCEDURE actualizar_saldo()
BEGIN

	DECLARE v_lrf BOOLEAN DEFAULT 0;

	DECLARE v_id INT UNSIGNED;
	DECLARE v_iban CHAR(24);
	DECLARE v_saldo DECIMAL(10,2);
	DECLARE v_saldo_funcion DECIMAL(10,2);

	DECLARE c_cuentas CURSOR FOR
	SELECT id, iban, saldo
	FROM cuentas
	ORDER BY id;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_lrf = 1;
	OPEN c_cuentas;
	FETCH c_cuentas INTO v_id, v_iban, v_saldo;

	WHILE (NOT v_lrf) DO

		SET v_saldo_funcion = saldo_cuentas(v_id);

		IF v_saldo <> v_saldo_funcion THEN

			SELECT
			CONCAT(
				'Cuenta ', v_id,
				' | ', v_iban,
				' | saldo tabla: ', v_saldo,
				' | saldo función: ', v_saldo_funcion,
				' | descuadre: ', v_saldo_funcion - v_saldo
			);

			UPDATE cuentas
			SET saldo = v_saldo_funcion
			WHERE id = v_id;

		END IF;
		FETCH c_cuentas INTO v_id, v_iban, v_saldo;
	END WHILE;
	CLOSE c_cuentas;
END $$
DELIMITER ;

CALL actualizar_saldo();


-- Actividad 2. mantenimiento(cuota)
-- Crea el procedimiento mantenimiento(cuota NUMBER) para aplicar una cuota anual a todas las cuentas.
DELIMITER $$

DROP PROCEDURE IF EXISTS mantenimiento $$

CREATE PROCEDURE mantenimiento(p_cuota DECIMAL(10,2))

BEGIN
	DECLARE v_lrf BOOLEAN DEFAULT 0;

	DECLARE v_id INT UNSIGNED;

	DECLARE c_cuentas CURSOR FOR
	SELECT id
	FROM cuentas
	ORDER BY id;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_lrf = 1;

	OPEN c_cuentas;

	FETCH c_cuentas INTO v_id;

	WHILE (NOT v_lrf) DO

		INSERT INTO movimientos
		(cuenta_id, fechahora, concepto, tipo, cantidad)
		VALUES
		(
			v_id,
			NOW(),
			'Cuota mantenimiento 2026',
			'R',
			-p_cuota
		);

		UPDATE cuentas
		SET saldo = saldo - p_cuota
		WHERE id = v_id;

		FETCH c_cuentas INTO v_id;
	END WHILE;
	CLOSE c_cuentas;
END $$
DELIMITER ;

CALL mantenimiento(15);


-- Actividad 3. cuota_mantenimiento_2()
-- Implementa una segunda versión del mantenimiento anual, sin parámetro de entrada, donde la cuota depende del saldo de cada cuenta.
DELIMITER $$
DROP PROCEDURE IF EXISTS cuota_mantenimiento_2 $$
CREATE PROCEDURE cuota_mantenimiento_2()
BEGIN
	DECLARE v_lrf BOOLEAN DEFAULT 0;

	DECLARE v_id INT UNSIGNED;
	DECLARE v_saldo DECIMAL(10,2);
	DECLARE v_cuota DECIMAL(10,2);

	DECLARE c_cuentas CURSOR FOR
	SELECT id, saldo
	FROM cuentas
	ORDER BY id;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_lrf = 1;

	OPEN c_cuentas;

	FETCH c_cuentas INTO v_id, v_saldo;

	WHILE (NOT v_lrf) DO

		CASE
			WHEN v_saldo < 2000 THEN
				SET v_cuota = 20;

			WHEN v_saldo <= 10000 THEN
				SET v_cuota = 10;

			ELSE
				SET v_cuota = 5;
		END CASE;

		INSERT INTO movimientos
		(cuenta_id, fechahora, concepto, tipo, cantidad)
		VALUES
		(
			v_id,
			NOW(),
			'Cuota mantenimiento 2026',
			'R',
			-v_cuota
		);

		UPDATE cuentas
		SET saldo = saldo - v_cuota
		WHERE id = v_id;
		FETCH c_cuentas INTO v_id, v_saldo;
	END WHILE;
	CLOSE c_cuentas;
END $$
DELIMITER ;

CALL cuota_mantenimiento_2();