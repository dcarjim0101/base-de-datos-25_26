-- examen recuperacion tema 08
-- David Carrero Jimenez


-- Ejercicio 1: clasificar_cuenta() - funcion - base de datos: bancos
USE bancos;
DELIMITER $$
DROP FUNCTION IF EXISTS clasificar_cuenta $$
CREATE FUNCTION clasificar_cuenta(p_iban CHAR(34))
RETURNS VARCHAR(20)
BEGIN
	DECLARE v_saldo DECIMAL(10,2);
	DECLARE v_clasificacion VARCHAR(20);

	SET v_saldo = (
		SELECT saldo
		FROM cuentas
		WHERE iban = p_iban
	);
	CASE
		WHEN v_saldo < 0 THEN
			SET v_clasificacion = 'Descubierto';

		WHEN v_saldo < 1000 THEN
			SET v_clasificacion = 'Basica';

		WHEN v_saldo < 10000 THEN
			SET v_clasificacion = 'Premium';

		ELSE
			SET v_clasificacion = 'Elite';
	END CASE;
	RETURN v_clasificacion;
END $$
DELIMITER ;

-- Ejercicio 2: saldo_total_cliente() - funcion  - base de datos: bancos
DELIMITER $$
DROP FUNCTION IF EXISTS saldo_total_cliente $$
CREATE FUNCTION saldo_total_cliente(id INT UNSIGNED)
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE v_id INT UNSIGNED;
    DECLARE v_saldo DECIMAL(10,2);
    DECLARE v_cuentas CHAR(24)

    SET v_id = (
        SELECT id, cuentas
        FROM clientes
        WHERE cuenta > 1
    );
    IF (v_saldo)(
        v_saldo = saldo + saldo
    )
    RETURNS IFNULL(0.00)
    END IF
END $$
DELIMITER ;


-- Ejercicio 3: movimientos_periodo() - procedimiento - base de datos: bancos
DELIMITER $$
DROP PROCEDURE IF EXISTS movimientos_periodo $$
CREATE PROCEDURE movimientos_periodo(fecha_inicio DATE, fecha_fin DATE)
RETURNS CHAR(256)
BEGIN
    DECLARE v_lista CHAR(256);

	SET v_lista = (
		SELECT id, cuenta_id, fechahora, concepto, tipo, cantidad
		FROM movimientos
		WHERE fechahora > fecha_inicio AND fechahora < fecha_fin
	)
	RETURNS movimientos
END $$
DELIMITER ;


-- Ejercicio 4: comision_descubierto() - procedimiento con cursor - base de datos: bancos
DELIMITER $$
DROP PROCEDURE IF EXISTS comision_descubierto $$
CREATE PROCEDURE comision_descubierto()
RETURNS CHAR(256)
BEGIN
	DECLARE v_cuenta CHAR(24);

DECLARE cursor_4 CURSOR FOR movimientos
END $$
DELIMITER ;


-- Ejercicio 5: validar_importe_reintegro - trigger - base de datos: bancos
DELIMITER $$
DROP TRIGGER IF EXISTS validar_importe_reintegro $$
CREATE TRIGGER validar_importe_reintegro BEFORE INSERT
ON movimientos FOR EACH ROW INSERT
BEGIN
	IF (tipo = 'R')(
		cantidad < 0
	) ELSEIF (tipo > 0)(
		cantidad * -1
	)
	END IF

END $$
DELIMITER ;


-- Ejercicio 6: historial_saldo - trigger - base de datos: bancos
USE bancos;
CREATE TABLE IF NOT EXISTS historial_saldo( id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, cuenta_id INT UNSIGNED, saldo_anterior DECIMAL(10,2), saldo_nuevo DECIMAL(10,2), fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (cuenta_id) REFERENCES cuentas(id) ON DELETE RESTRICT ON UPDATE RESTRICT );
DELIMITER $$
DROP TRIGGER IF EXISTS historial_saldo $$
CREATE TRIGGER historial_saldo AFTER UPDATE
ON cuentas FOR EACH ROW UPDATE
BEGIN
	FOR UPDATE cuenta.saldo (
		INSERT JOIN (
			id AUTO_INCREMENT PRIMARY KEY,
			cuenta_id INT UNSIGNED,
			saldo_anterior DECIMAL(10,2),
			saldo_nuevo DECIMAL(10,2),
			fecha_cambio TIMESTAMP
		)
	)
END $$
DELIMITER ;


-- Ejercicio 7: resumen_movimientos_cliente() - procedimiento con cursor - base de datos: bancos
USE bancos;
DELIMITER $$
DROP PROCEDURE IF EXISTS resumen_movimientos_cliente
CREATE PROCEDURE resumen_movimientos_cliente(p_cliente_id INT UNSIGNED)
RETURNS INT UNSIGNED
BEGIN
	DECLARE v_iban CHAR(24);

	SET v_iban = (

	)



-- Ejercicio 8: recalcular_saldos - evento - base de datos: bancos
