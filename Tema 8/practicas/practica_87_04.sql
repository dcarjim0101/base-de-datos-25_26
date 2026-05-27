-- practica 8.7
-- base de datos geslibros
USE geslibros;

-- Actividad 1. Función importe_bruto_venta()
DELIMITER $$
CREATE FUNCTION importe_bruto_venta(id_venta INT) RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(importe) INTO total
    FROM lineasventas
    WHERE id_venta = id_venta;
    RETURN IFNULL(total, 0);
END$$
DELIMITER ;

-- Actividad 2. Función importe_iva_ventas()
DELIMITER $$
CREATE FUNCTION importe_iva_venta(id_venta INT) RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    DECLARE total_iva DECIMAL(10,2);
    SELECT SUM(importe * (iva / 100)) INTO total_iva
    FROM lineasventas
    WHERE id_venta = id_venta;
    RETURN IFNULL(total_iva, 0);
END$$
DELIMITER ;

-- Actividad 3. Estudio_stock
DELIMITER $$
CREATE PROCEDURE estudio_stock()
BEGIN
    SELECT CONCAT('Rotura de STOCK: ', id_libro) AS mensaje, id_libro, titulo, precio_coste, stock, stock_minimo, stock_maximo, (stock_maximo - stock) AS stock_necesario
    FROM libros
    WHERE stock <= stock_minimo;
END$$
DELIMITER ;

-- Actividad 4. Verificar_importe_total_venta
DELIMITER $$
CREATE PROCEDURE verificar_importe_total_venta()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_id_venta INT;
    DECLARE v_importe_bruto DECIMAL(10,2);
    DECLARE v_importe_iva DECIMAL(10,2);
    DECLARE v_importe_total DECIMAL(10,2);
    
    DECLARE cur CURSOR FOR SELECT id_venta FROM ventas;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO v_id_venta;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SET v_importe_bruto = importe_bruto_venta(v_id_venta);
        SET v_importe_iva = importe_iva_venta(v_id_venta);
        SET v_importe_total = v_importe_bruto + v_importe_iva;

        UPDATE ventas
        SET Importe_bruto = IF(Importe_bruto <> v_importe_bruto, v_importe_bruto, Importe_bruto),
            Importe_iva = IF(Importe_iva <> v_importe_iva, v_importe_iva, Importe_iva),
            Importe_total = IF(Importe_total <> v_importe_total, v_importe_total, Importe_total)
        WHERE id_venta = v_id_venta;
    END LOOP;

    CLOSE cur;
END$$
DELIMITER ;

-- Actividad 5. TRIGGER actualizar_stock
DELIMITER $$
CREATE TRIGGER actualizar_stock AFTER INSERT ON lineasventas FOR EACH ROW
BEGIN
    UPDATE libros
    SET stock = stock - NEW.cantidad
    WHERE id_libro = NEW.id_libro;
END$$
DELIMITER ;

-- Actividad 6. TRIGGER fuera_de_stock
DELIMITER $$
CREATE TRIGGER fuera_de_stock BEFORE INSERT ON lineasventas FOR EACH ROW
BEGIN
    DECLARE stock_disponible INT;
    SELECT stock INTO stock_disponible FROM libros WHERE id_libro = NEW.id_libro;

    IF stock_disponible <= 0 THEN
        SET NEW.cantidad = 0;
    ELSEIF NEW.cantidad > stock_disponible THEN
        SET NEW.cantidad = stock_disponible;
    END IF;
END$$
DELIMITER ;

-- Actividad 7. EVENT. lineas_ventas
DELIMITER $$
CREATE EVENT lineas_ventas ON SCHEDULE EVERY 1 DAY STARTS CURRENT_TIMESTAMP
DO
BEGIN
    SELECT * FROM lineasventas
    WHERE DATE(fecha) = CURDATE()
    INTO OUTFILE '/var/lib/mysql-files/lineasventasdia.csv'
    FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';
END$$
DELIMITER ;

-- Actividad 8. EVENT. rebajas
DELIMITER $$
CREATE EVENT rebajas ON SCHEDULE AT '2020-06-01 00:00:00'
DO
BEGIN
    UPDATE libros
    SET precio_venta = precio_venta * 0.9;
END$$
DELIMITER ;