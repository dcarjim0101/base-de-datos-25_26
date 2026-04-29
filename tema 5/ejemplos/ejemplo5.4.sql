-- ejemplo 54
-- restriccion DEFAULT

USE test;

CREATE TABLE IF NOT EXISTS pedidos(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    fecha_pedido DATE DEFAULT CURRENT_TIMESTAMP,
    importe DECIMAL(10,2) DEFAULT 0.00,
    forma_pago VARCHAR(20) DEFAULT 'Contado'
);

INSERT INTO pedidos VALUES
(null, '2025-12-12', 234.56, 'Transferencia'),
(null, default, default, default);

-- auditar las tablas
-- almacenar la fecha hora de creacion de un registro
-- almacenar la fecha hora de actualizacion de un registro
DROP TABLE IF EXISTS cuentas;
CREATE TABLE IF NOT EXISTS cuentas(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    IBAN CHAR(22) UNIQUE,
    titular VARCHAR(50),
    saldo DECIMAL(10,2) DEFAULT '0.00',
    
    -- columnas de auditoria
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO cuentas VALUES
(null, '12345678932154697777', 'Pedro Reina Moscoso', default, default, default);

UPDATE cuentas SET
	saldo = '12000',
    update_at = now();