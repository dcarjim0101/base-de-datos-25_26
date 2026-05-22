-- base de datos bancos
USE bancos;

-- Actividad 1
DELIMITER $$
CREATE EVENT bancos.movimientos_semanales ON SCHEDULE EVERY 1 WEEK STARTS '2026-05-25 00:00:00'
DO
BEGIN
    SELECT * FROM bancos.movimientos
    WHERE fecha >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
    INTO OUTFILE '/var/lib/mysql-files/moviweek.csv'
    FIELDS TERMINATED BY ',' 
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';
END$$
DELIMITER ;
SELECT * FROM information_schema.events;


-- Actividad 2
DELIMITER $$
CREATE EVENT bancos.verificacion_saldo_diario ON SCHEDULE EVERY 1 DAY STARTS '2026-05-25 00:00:00'
DO
BEGIN
    CALL bancos.actualizar_saldo();
END$$
DELIMITER ;
SELECT * FROM information_schema.events;


-- Actividad 3
DELIMITER $$
CREATE EVENT bancos.verificacion_cliente_mensual ON SCHEDULE EVERY 1 MONTH STARTS '2026-05-25 00:00:00'
DO
BEGIN
    SELECT c.id_cliente, c.nombre, c.apellidos, c.email, a.iban, a.saldo
    FROM bancos.clientes c
    JOIN bancos.cuentas a ON c.id_cliente = a.id_cliente
    WHERE a.saldo < 0
    INTO OUTFILE '/var/lib/mysql-files/clientesenrojo.csv'
    FIELDS TERMINATED BY ',' 
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';
END$$
DELIMITER ;
SELECT * FROM information_schema.events;