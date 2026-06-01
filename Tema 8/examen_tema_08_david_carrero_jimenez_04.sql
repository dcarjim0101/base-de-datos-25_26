-- examen tema 08
-- David Carrero Jimenez

-- ejercicio 1: resumen_cliente() -- funcion - base de datos bancos
-- Tipo: Función
-- Nombre: resumen_cliente()
-- Parámetro de entrada: id de un cliente (INT UNSIGNED)
-- Devuelve: El número total de cuentas que tiene ese cliente (INT)
-- Descripción: Dada la id de un cliente, la función deberá devolver cuántas cuentas tiene registradas en la base de datos.
USE bancos;
DELIMITER $$
CREATE FUNCTION resumen_clientes(cliente_id INT UNSIGNED)
RETURNS TABLE (nombre VARCHAR (255), num_cuentas INT)
BEGIN
RETURN(
    SELECT CONCAT(c.nombre, ' ', c.apellidos) AS nombre, COUNT(*) AS num_cuentas
    FROM clientes c
    JOIN cuentas cu ON c.id = cu.cliente_id
    WHERE c.id = cliente_id
    GROUP BY c.id, c.nombre, c.apellidos
)
END $$
DELIMITER ;

-- ejercicio 2: saldo_medio_ciudad() -- funcion - base de datos bancos
-- Tipo: Función
-- Nombre: saldo_medio_ciudad()
-- Parámetro de entrada: nombre de una ciudad (VARCHAR(50))
-- Devuelve: El saldo medio de todas las cuentas pertenecientes a clientes de esa ciudad (DECIMAL(10,2))
-- Descripción: Calcular el saldo medio de las cuentas cuyos titulares residen en la ciudad indicada. Si no hay clientes en esa ciudad, devolver 0.00.
USE bancos;
DELIMITER $$
CREATE FUNCTION saldo_medio_ciudad(ciudad VARCHAR(50))
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE saldo_medio DECIMAL(10,2);
    SELECT AVG(cu.saldo) INTO saldo_medio
    FROM clientes ciudad
    JOIN cuentas cu ON ciudad.id = cu.cliente_id
    WHERE ciudad.ciudad = ciudad;
    IF saldo_medio IS NULL THEN
        RETURN 0.00;
    ELSE
        RETURN saldo_medio;
    END IF;
END $$
DELIMITER ;

-- ejercicio 3: clientes_saldo_negativo() -- procedimiento - base de datos bancos
-- Tipo: Procedimiento
-- Nombre: clientes_saldo_negativo()
-- Parámetros de entrada: ninguno
-- Descripción: El procedimiento deberá devolver un listado con todos los clientes que tienen al menos una cuenta con saldo negativo (menor que 0).
-- el listado mostrará: id del cliente, nombre, apellidos, email, iban de la cuenta en rojo, saldo de esa cuenta.
USE bancos;
DELIMITER $$
CREATE PROCEDURE clientes_saldo_negativo()
BEGIN
    SELECT c.id, c.nombre, c.apellidos, c.email, cu.iban, cu.saldo
    FROM clientes c
    JOIN cuentas cu ON c.id = cu.cliente_id
    WHERE cu.saldo < 0;
END $$
DELIMITER ;

-- ejercicio 4: aplicar_interes() -- procedimiento con cursor - base de datos bancos
-- Tipo: Procedimiento
-- Nombre: aplicar_interes()
-- Parámetro de entrada: porcentaje de interés (DECIMAL(5,2))
-- Cursor: deberá recorrer todas las cuentas con saldo mayor que 0.
-- Descripción: Para cada cuenta con saldo positivo, insertar un nuevo movimiento en la tabla movimientos con:
USE bancos;
DELIMITER $$
CREATE PROCEDURE aplicar_interes(porcentaje_interes DECIMAL (5,2))
RETURNS DECIMAL(5,2)
BEGIN
    DECLARE porcentaje_interes CURSOR FOR SELECT
    WHERE cuentas.saldo < 0;
    INSERT INTO movimientos VALUES
    (13, aplicar_interes, DEFAULT, 'Abono de interes', 'I', saldo * procentaje_interes / 100);
    UPDATE cuentas.saldo + aplicar_interes()
END $$
DELIMITER ;

-- ejercicio 5: actualizar_stock_venta -- trigger - base de datos geslibros
-- Tipo: Trigger
-- Nombre: actualizar_stock_venta
-- Momento: AFTER
-- Evento: INSERT
-- Tabla: lineasventas
-- Descripción: Cada vez que se inserte una línea de venta, se deberá decrementar el stock del libro correspondiente en la tabla libros según la cantidad indicada en la línea de venta.
-- Ejemplo: Si se venden 4 unidades del libro con id = 7, el campo stock del libro 7 debe reducirse en 4 unidades.
USE geslibros;
DELIMITER $$
CREATE TRIGGER actualizar_stock_venta AFTER INSERT
ON lineasventas FOR EACH ROW WHILE
BEGIN
    WHILE INSERT lineasventas = stock WHERE libros - lineasventas.cantidad
END $$
DELIMITER ;

-- ejercicio 6: control_precio_libro -- trigger - base de datos geslibros
-- Tipo: Trigger
-- Nombre: control_precio_libro
-- Momento: BEFORE
-- Evento: UPDATE
-- Tabla: libros
-- Descripción: Antes de actualizar un libro, comprobar que el nuevo precio de venta (precio_venta) no sea inferior al precio de coste (precio_coste). Si el nuevo precio_venta fuera menor o igual al precio_coste, se deberá asignar automáticamente como precio_venta el valor de precio_coste multiplicado por 1.10 (es decir, con un margen mínimo del 10%).
-- Observaciones: El alumno debe identificar correctamente las referencias NEW y OLD.
USE geslibros;
DELIMITER $$
CREATE TRIGGER control_precio_libre BEFORE UPDATE
ON libros FOR EACH ROW SELECT
BEGIN
    SELECT libros WHERE OLD libros.precio_venta > libros.precio_coste
    IF OLD libros.precio_venta <= libros.precio_coste (
        NEW libros.precio_venta = libros.precio_coste * 0.90
    )
END $$
DELIMITER ;

-- ejercicio 7: verificar_importes_ventas() -- procedimiento con cursos - base de datos geslibros
-- Tipo: Procedimiento
-- Nombre: verificar_importes_ventas()
-- Parámetros de entrada: ninguno
-- Cursor: deberá recorrer todas las ventas de la tabla ventas.
-- Descripción: Para cada venta, comparar el valor almacenado en la columna importe_bruto con la suma real de la columna importe de sus registros en lineasventas. Si los importes no coinciden, actualizar importe_bruto con el valor correcto y mostrar por pantalla: id de la venta, importe almacenado, importe calculado, diferencia
USE geslibros;
DELIMITER $$
CREATE PROCEDURE verificar_importes_ventas()
BEGIN
    JOIN ventas v ON v.id
    JOIN lineasventas lv ON lv.id
    LOOP
        v.importe_bruto + lv.importe
        IF v.importe_bruto != lv.importe (
            UPDATE v..importe_bruto
            SELECT v.id, v.importe_almacenado, v.importe_calculado, v.diferencia
        )
    END LOOP
END $$
DELIMITER ;

-- ejercicio 8: exportar_movimientos_diarios -- evento - base de datos bancos
-- Tipo: Evento
-- Nombre: exportar_movimientos_diarios
-- Tipo de planificación: periódico, con frecuencia diaria
-- Inicio: mañana a las 00:00:00
-- Duración máxima: 1 año desde la fecha de inicio
-- Descripción: Al final de cada día, generar un fichero CSV llamado movimientos_dia.csv con todos los movimientos registrados durante ese día (fecha igual a CURDATE()).
-- El fichero incluirá las columnas: id del movimiento, fecha, concepto, tipo, importe, iban de la cuenta asociada
-- Separador de columnas: ;
USE bancos;
DELIMITER $$
CREATE EVENT IF NOT EXISTS exportar_movimientos_diarios
ON SCHEDULE (
    ENABLE
    DO exportar_movimientos_diarios
    AT DATETIME 2026/06/02 00:00:00
)

INTERVAL(
    EVERY days AT 00:00:00
    START 2026/06/02
    ENDS 2026/06/02 + 1 YEAR
)