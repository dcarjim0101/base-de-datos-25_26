-- examen recuperacion ordinal tema 08
-- David Carrero Jiménez

USE tienda_pinturas;

-- Ejercicio 1: calcular_importe_venta() - Función - base de datos: tienda_pinturas
-- Tipo: Función
-- Nombre: calcular_importe_venta()
-- Parámetro de entrada: venta_id (INT UNSIGNED)
-- Devuelve: El importe total real de la venta calculado como suma de cantidad * precio_unitario de todos sus registros en Detalle_venta (DECIMAL(10,2))
-- Descripción: Dado el id de una venta, calcular y devolver el importe bruto real a partir de las líneas de detalle. Si la venta no existe o no tiene líneas, devolver 0.00 mediante IFNULL().
-- Actividad 1
-- Función: calcular_importe_venta
-- Parámetros: id venta
-- Descripción: devuelve el importe total real de una venta
-- calculado a partir de sus líneas de detalle.
-- Return: importe total de la venta

DELIMITER $$

DROP FUNCTION IF EXISTS calcular_importe_venta $$

CREATE FUNCTION calcular_importe_venta(p_venta_id INT UNSIGNED)
RETURNS DECIMAL(10,2)

BEGIN

	DECLARE v_total DECIMAL(10,2);

	SET v_total = (
		SELECT IFNULL(SUM(cantidad * precio_unitario), 0.00)
		FROM Detalle_venta
		WHERE venta_id = p_venta_id
	);

	RETURN v_total;

END $$

DELIMITER ;

-- Uso
SELECT calcular_importe_venta(1);


-- Ejercicio 2: clasificar_cliente() - Función - base de datos: tienda_pinturas
-- Tipo: Función
-- Nombre: clasificar_cliente()
-- Parámetro de entrada: cliente_id (INT UNSIGNED)
-- Devuelve: Una cadena VARCHAR(20) con la clasificación del cliente según el total gastado en todas sus ventas:
-- 'VIP' si el total es mayor o igual a 500.00
-- 'Regular' si el total está entre 100.00 y 499.99
-- 'Ocasional' si el total es menor que 100.00
-- 'Inactivo' si no tiene ninguna venta
-- Observaciones: Usar la instrucción CASE con evaluación de condiciones.-- Actividad 2
-- Función: clasificar_cliente
-- Parámetros: id cliente
-- Descripción: clasifica a un cliente según el total gastado
-- en todas sus ventas.
-- Return: VIP, Regular, Ocasional o Inactivo

DELIMITER $$

DROP FUNCTION IF EXISTS clasificar_cliente $$

CREATE FUNCTION clasificar_cliente(p_cliente_id INT UNSIGNED)
RETURNS VARCHAR(20)

BEGIN

	DECLARE v_total DECIMAL(10,2);
	DECLARE v_clasificacion VARCHAR(20);

	SET v_total = (
		SELECT IFNULL(SUM(importe_total), 0.00)
		FROM ventas
		WHERE cliente_id = p_cliente_id
	);

	CASE
		WHEN v_total >= 500 THEN
			SET v_clasificacion = 'VIP';

		WHEN v_total >= 100 THEN
			SET v_clasificacion = 'Regular';

		WHEN v_total > 0 THEN
			SET v_clasificacion = 'Ocasional';

		ELSE
			SET v_clasificacion = 'Inactivo';
	END CASE;

	RETURN v_clasificacion;

END $$

DELIMITER ;

-- Uso
SELECT clasificar_cliente(1);


-- Ejercicio 3: ventas_por_periodo() - Procedimiento - base de datos: tienda_pinturas
-- Tipo: Procedimiento
-- Nombre: ventas_por_periodo()
-- Parámetros de entrada:
-- fecha_inicio (DATE)
-- fecha_fin (DATE)
-- Descripción: Devolver un listado de todas las ventas realizadas entre las dos fechas indicadas (ambas incluidas).
-- El listado mostrará: id_venta, fecha, nombre y apellidos del cliente, nombre del empleado que atendió la venta, total, metodo_pago
-- Actividad 3
-- Procedimiento: ventas_por_periodo
-- Parámetros: fecha inicio, fecha fin
-- Descripción: muestra las ventas realizadas entre dos fechas
-- incluyendo cliente, empleado, total y método de pago

DELIMITER $$

DROP PROCEDURE IF EXISTS ventas_por_periodo $$

CREATE PROCEDURE ventas_por_periodo(
	p_fecha_inicio DATE,
	p_fecha_fin DATE
)

BEGIN

	SELECT
		v.id AS id_venta,
		v.fecha,
		CONCAT(c.nombre, ' ', c.apellidos) AS cliente,
		e.nombre AS empleado,
		v.total,
		v.metodo_pago
	FROM ventas v
	JOIN clientes c
		ON v.cliente_id = c.id
	JOIN empleados e
		ON v.empleado_id = e.id
	WHERE v.fecha BETWEEN p_fecha_inicio AND p_fecha_fin
	ORDER BY v.fecha;

END $$

DELIMITER ;

-- Uso
CALL ventas_por_periodo('2024-01-01', '2024-12-31');


-- Ejercicio 4: actualizar_precios_por_marca() - Procedimiento con cursor - base de datos: tienda_pinturas
-- Tipo: Procedimiento
-- Nombre: actualizar_precios_por_marca()
-- Parámetros de entrada: marca_buscar (VARCHAR(50)), porcentaje (DECIMAL(5,2))
-- Cursor: deberá recorrer todos los productos cuya marca coincida con marca_buscar.
-- Descripción: Para cada producto de la marca indicada, actualizar su precio aplicando el porcentaje indicado. Si el porcentaje es positivo se incrementa el precio; si es negativo se reduce.
-- Nuevo precio = precio actual + precio actual × (porcentaje / 100)
-- Salida: Durante el recorrido, mostrar por pantalla: id_producto, nombre del producto, precio anterior, precio nuevo
-- Observaciones: Usar la estructura LOOP para recorrer el cursor.
-- Actividad 4
-- Procedimiento: actualizar_precios_por_marca
-- Parámetros: marca, porcentaje
-- Descripción: actualiza el precio de los productos de una marca
-- mostrando el precio anterior y el nuevo precio

DELIMITER $$

DROP PROCEDURE IF EXISTS actualizar_precios_por_marca $$

CREATE PROCEDURE actualizar_precios_por_marca(
	p_marca_buscar VARCHAR(50),
	p_porcentaje DECIMAL(5,2)
)

BEGIN

	-- declaro variable boolean fin de cursor
	DECLARE v_lrf BOOLEAN DEFAULT 0;

	-- declaro variables
	DECLARE v_id INT UNSIGNED;
	DECLARE v_nombre VARCHAR(100);
	DECLARE v_precio DECIMAL(10,2);
	DECLARE v_nuevo_precio DECIMAL(10,2);

	-- declaro cursor
	DECLARE c_productos CURSOR FOR
	SELECT id, nombre, precio
	FROM productos
	WHERE marca = p_marca_buscar;

	-- declaro manejador error
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_lrf = 1;

	-- abro cursor
	OPEN c_productos;

	bucle: LOOP

		FETCH c_productos INTO v_id, v_nombre, v_precio;

		IF v_lrf THEN
			LEAVE bucle;
		END IF;

		SET v_nuevo_precio = v_precio + (v_precio * p_porcentaje / 100);

		SELECT
			v_id AS id_producto,
			v_nombre AS producto,
			v_precio AS precio_anterior,
			v_nuevo_precio AS precio_nuevo;

		UPDATE productos
		SET precio = v_nuevo_precio
		WHERE id = v_id;

	END LOOP;

	CLOSE c_productos;

END $$

DELIMITER ;

-- Uso
CALL actualizar_precios_por_marca('Titanlux', 10);


-- Ejercicio 5: verificar_stock_antes_venta - Trigger - base de datos: tienda_pinturas-- Actividad 5
-- Trigger: verificar_stock_antes_venta
-- Momento: BEFORE
-- Evento: INSERT
-- Tabla: Detalle_venta
-- Descripción: comprueba que existe stock suficiente antes de vender.
-- Si la cantidad supera el stock, vende todo el stock disponible.
-- Si no hay stock, cancela la inserción.

DELIMITER $$

DROP TRIGGER IF EXISTS verificar_stock_antes_venta $$

CREATE TRIGGER verificar_stock_antes_venta
BEFORE INSERT ON Detalle_venta
FOR EACH ROW

BEGIN

	DECLARE v_stock INT;

	SELECT stock
	INTO v_stock
	FROM productos
	WHERE id = NEW.producto_id;

	IF v_stock = 0 THEN

		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'No hay stock disponible para este producto';

	ELSEIF NEW.cantidad > v_stock THEN

		SET NEW.cantidad = v_stock;

	END IF;

END $$

DELIMITER ;
        

-- Ejercicio 6: auditar_cambio_precio - Tigger - base de datos: tienda_pinturas
-- Actividad 6
-- Tabla: auditoria_precios

-- Actividad 6
-- Trigger: auditar_cambio_precio
-- Momento: AFTER
-- Evento: UPDATE
-- Tabla: Productos
-- Descripción: registra en una tabla de auditoría
-- los cambios de precio realizados sobre los productos.

DELIMITER $$

DROP TRIGGER IF EXISTS auditar_cambio_precio $$

CREATE TRIGGER auditar_cambio_precio
AFTER UPDATE ON Productos
FOR EACH ROW

BEGIN

	IF OLD.precio <> NEW.precio THEN

		INSERT INTO auditoria_precios
		(producto_id, precio_anterior, precio_nuevo)
		VALUES
		(
			NEW.id,
			OLD.precio,
			NEW.precio
		);

	END IF;

END $$

DELIMITER ;


-- Ejercicio 7: sincronizar_totales_ventas() - Procedimiento con cursor - base de datos: tienda_pinturas
-- Actividad 7
-- Procedimiento: sincronizar_totales_ventas
-- Parámetros: null
-- Descripción: comprueba que el total almacenado en cada venta
-- coincide con el total calculado a partir de sus líneas de detalle.
-- Si existe descuadre, actualiza el total.

DELIMITER $$

DROP PROCEDURE IF EXISTS sincronizar_totales_ventas $$

CREATE PROCEDURE sincronizar_totales_ventas()

BEGIN

	-- declaro variable boolean fin de cursor
	DECLARE v_lrf BOOLEAN DEFAULT 0;

	-- declaro variables
	DECLARE v_id INT UNSIGNED;
	DECLARE v_total DECIMAL(10,2);
	DECLARE v_total_calculado DECIMAL(10,2);

	-- declaro cursor
	DECLARE c_ventas CURSOR FOR
	SELECT id, total
	FROM ventas
	ORDER BY id;

	-- declaro manejador error
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_lrf = 1;

	-- abro cursor
	OPEN c_ventas;

	-- primera lectura
	FETCH c_ventas INTO v_id, v_total;

	WHILE (NOT v_lrf) DO

		SET v_total_calculado = calcular_importe_venta(v_id);

		IF v_total <> v_total_calculado THEN

			SELECT
				v_id AS id_venta,
				v_total AS total_almacenado,
				v_total_calculado AS total_calculado,
				v_total_calculado - v_total AS diferencia;

			UPDATE ventas
			SET total = v_total_calculado
			WHERE id = v_id;

		END IF;

		FETCH c_ventas INTO v_id, v_total;

	END WHILE;

	CLOSE c_ventas;

END $$

DELIMITER ;

-- Uso
CALL sincronizar_totales_ventas();



-- Ejercicio 8: exportar_pedidos_pendientes - Evento - base de datos: tienda_pinturas
DELIMITER $$

DROP EVENT IF EXISTS exportar_pedidos_pendientes $$

CREATE EVENT exportar_pedidos_pendientes

ON SCHEDULE
EVERY 1 WEEK
STARTS '2026-06-15 06:00:00'
ENDS '2027-06-15 06:00:00'

DO

SELECT
	p.id AS id_pedido,
	p.fecha,
	p.total,
	pr.nombre AS proveedor,
	pr.telefono
FROM pedidos p
JOIN proveedores pr
	ON p.proveedor_id = pr.id
WHERE p.estado = 'pendiente'
INTO OUTFILE '/tmp/pedidos_pendientes.csv'
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n';

$$

DELIMITER ;