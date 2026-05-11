DROP DATABASE IF EXISTS gescomercial;
CREATE DATABASE  IF NOT EXISTS gescomercial;
USE gescomercial;

-- Tabla categorias
-- Almacena las categorias de productos

DROP TABLE IF EXISTS categorias;
CREATE TABLE IF NOT EXISTS categorias (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    categoria VARCHAR(30),
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO categorias (id, categoria) VALUES
(1,'Hardware'),
(2,'Software'),
(3,'Redes y Comunicaciones'),
(4,'Accesorios y Periféricos'),
(5,'Electrónica de Consumo'),
(6,'Servicios');


-- Tabla proveedores
-- Almacena los datos de proveedores
DROP TABLE IF EXISTS proveedores;
CREATE TABLE proveedores(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40),
    direccion VARCHAR(50),
    poblacion VARCHAR(50),
    c_postal CHAR(5),
    provincia VARCHAR(50),
    nif CHAR(9) UNIQUE,
    telefono CHAR(9),
    movil CHAR(9) UNIQUE,
    email VARCHAR(45) UNIQUE,
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Datos de gemini IA

INSERT INTO proveedores (nombre, direccion, poblacion, c_postal, provincia, nif, telefono, movil, email)
VALUES
  ('Empresa Suministros S.A.', 'Calle Mayor, 10', 'Sevilla', '41001', 'Sevilla', 'A12345678', '954321000', '654321000', 'empresa.suministros@email.com'),
  ('Comercial Pérez S.L.', 'Calle Real, 55', 'Córdoba', '14001', 'Córdoba', 'B23456789', '912345678', '612345678', 'comercial.perez@email.com'),
  ('Distribuciones González S.L.', 'Gran Vía, 2', 'Málaga', '29001', 'Málaga', 'C34567890', '934567890', '634567890', 'distribuciones.gonzalez@email.com'),
  ('Proveedor López S.C.P.', 'Plaza Mayor, 8', 'Granada', '18001', 'Granada', 'D45678901', '998765432', '698765432', 'proveedor.lopez@email.com'),
  ('Materiales Ruiz S.A.', 'Calle del Sol, 12', 'Jaén', '23001', 'Jaén', 'E56789012', '987654321', '687654321', 'materiales.ruiz@email.com'),
  ('Ferretería Gómez S.L.', 'Paseo de la Castellana, 90', 'Madrid', '28001', 'Madrid', 'F67890123', '976543210', '676543210', 'ferreteria.gomez@email.com'),
  ('Electricidad Martín S.C.P.', 'Calle de Atocha, 15', 'Barcelona', '08001', 'Barcelona', 'G78901234', '965432109', '665432109', 'electricidad.martin@email.com'),
  ('Construcción González S.L.', 'Avenida del Rey Juan Carlos I, 3', 'Valencia', '46001', 'Valencia', 'H89012345', '954321001', '654321001', 'construccion.gonzalez@email.com'),
  ('Suministros Ruiz S.A.', 'Calle de Gran Vía, 50', 'Bilbao', '48001', 'Bilbao', 'I90123456', '943210009', '643210009', 'suministros.ruiz@email.com'),
  ('Materiales Gutiérrez S.L.', 'Paseo de la Constitución, 20', 'Valladolid', '47001', 'Valladolid', 'J01234567', '932100098', '632100098', 'materiales.gutierrez@email.com');


-- Tabla clientes
-- Almacena los datos de clientes

DROP TABLE IF EXISTS Clientes;
CREATE TABLE Clientes (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40),
    direccion VARCHAR(50),
    poblacion VARCHAR(50),
    c_postal CHAR(5),
    provincia VARCHAR(50),
    nif CHAR(9) UNIQUE,
    telefono CHAR(9),
    movil CHAR(9) UNIQUE,
    email VARCHAR(45) UNIQUE,
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- con inteligencia artifical gemini

INSERT INTO Clientes (nombre, direccion, poblacion, c_postal, provincia, nif, telefono, movil, email)
VALUES
  ('Juan Pérez López', 'Calle Mayor, 12', 'Sevilla', '41001', 'Sevilla', '123456789A', '954321000', '654321000', 'juan.perez@email.com'),
  ('María García Jiménez', 'Calle Real, 50', 'Córdoba', '14001', 'Córdoba', '234567890B', '912345678', '612345678', 'maria.garcia@email.com'),
  ('Pedro Sánchez González', 'Gran Vía, 3', 'Málaga', '29001', 'Málaga', '345678901C', '934567890', '634567890', 'pedro.sanchez@email.com'),
  ('Ana López Martínez', 'Plaza Mayor, 7', 'Granada', '18001', 'Granada', '456789012D', '998765432', '698765432', 'ana.lopez@email.com'),
  ('Isabel Ruiz Fernández', 'Calle del Sol, 15', 'Jaén', '23001', 'Jaén', '567890123E', '987654321', '687654321', 'isabel.ruiz@email.com'),
  ('David Gómez Moreno', 'Paseo de la Castellana, 100', 'Madrid', '28001', 'Madrid', '678901234F', '976543210', '676543210', 'david.gomez@email.com'),
  ('Laura Martín Blanco', 'Calle de Atocha, 12', 'Barcelona', '08001', 'Barcelona', '789012345G', '965432109', '665432109', 'laura.martin@email.com'),
  ('Marcos González López', 'Avenida del Rey Juan Carlos I, 5', 'Valencia', '46001', 'Valencia', '890123456H', '954321001', '654321001', 'marcos.gonzalez@email.com'),
  ('Sandra Ruiz Pérez', 'Calle de Gran Vía, 40', 'Bilbao', '48001', 'Bilbao', '901234567I', '943210009', '643210009', 'sandra.ruiz@email.com'),
  ('Alberto Gutiérrez Moreno', 'Paseo de la Constitución, 25', 'Valladolid', '47001', 'Valladolid', '012345678J', '932100098', '632100098', 'alberto.gutierrez@email.com');


-- Tabla productos
-- Almacena los detalles de productos

DROP TABLE IF EXISTS productos;
CREATE TABLE productos (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    descripcion TEXT,
	ean_13 CHAR(13),
    categoria_id INT UNSIGNED,
    proveedor_id INT UNSIGNED,
    precio_coste DECIMAL(10 , 2 ) DEFAULT '0.00',
    precio_venta DECIMAL(10 , 2 ) DEFAULT '0.00',
    stock INT UNSIGNED DEFAULT '0',
    stock_min INT UNSIGNED DEFAULT '0',
    stock_max INT UNSIGNED DEFAULT '0',
    estado ENUM('Activo', 'En Reposición', 'Descontinuado', 'En Promoción', 'Bloqueado', 'En tránsito'),
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (categoria_id)
        REFERENCES categorias (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (proveedor_id)
        REFERENCES proveedores (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Datos gemini IA
--

INSERT INTO productos (nombre, descripcion, ean_13, categoria_id, proveedor_id, precio_coste, precio_venta, stock, stock_min, stock_max, estado)
VALUES
  ('Portátil Gamer Nitro 5', 'Portátil gaming con procesador Intel Core i5-11400H, 16 GB de RAM, SSD de 512 GB y tarjeta gráfica NVIDIA GeForce RTX 3050', '8415870017241', 1, 1, 799.99, 899.99, 10, 5, 20, 'Activo'),
  ('Smartphone Galaxy S23 Ultra', 'Smartphone Android con pantalla AMOLED de 6.8 pulgadas, procesador Snapdragon 8 Gen 2, 12 GB de RAM y cámara de 200 MP', '8887310245789', 2, 2, 1099.99, 1199.99, 15, 8, 25, 'Activo'),
  ('Smart TV 55" UHD 4K HDR', 'Smart TV con pantalla LED de 55 pulgadas, resolución 4K UHD HDR, sistema operativo Android TV y conectividad Wi-Fi y Bluetooth', '8415870017242', 3, 3, 499.99, 549.99, 20, 10, 30, 'En Reposición'),
  ('Auriculares inalámbricos Bluetooth', 'Auriculares inalámbricos con tecnología Bluetooth 5.0, cancelación de ruido activa y hasta 8 horas de autonomía', '8435670048375', 4, 4, 59.99, 69.99, 30, 15, 40, 'Activo'),
  ('Impresora multifunción láser', 'Impresora multifunción láser con impresión en blanco y negro y a color, escáner y fotocopiadora', '8479650032148', 5, 5, 199.99, 249.99, 12, 5, 20, 'Activo'),
  ('Ratón inalámbrico ergonómico', 'Ratón inalámbrico ergonómico con diseño vertical, ideal para largas jornadas de trabajo', '8435670048376', 4, 6, 29.99, 34.99, 25, 10, 35, 'Activo'),
  ('Teclado inalámbrico mecánico', 'Teclado inalámbrico mecánico con interruptores Cherry MX Blue, retroiluminación RGB y diseño compacto', '8435670048377', 4, 6, 69.99, 79.99, 15, 8, 25, 'Activo'),
  ('Disco duro externo SSD', 'Disco duro externo SSD de 500 GB con interfaz USB 3.0 y alta velocidad de transferencia de datos', '8479650032149', 5, 7, 59.99, 69.99, 20, 10, 30, 'En Promoción'),
  ('Router Wi-Fi 6 AX', 'Router Wi-Fi 6 AX con tecnología de doble banda, cobertura ampliada y mayor velocidad de conexión', '8479650032150', 3, 8, 99.99, 129.99, 15, 8, 25, 'Activo'),
  ('Tableta gráfica digital', 'Tableta gráfica digital con lápiz sensible a la presión, ideal para dibujar, pintar y editar fotos', '8435670048378', 4, 9, 99.99, 149.99, 10, 5, 15, 'En Reposición');


-- Tabla ventas
-- Detalles de las ventas de productos

DROP TABLE IF EXISTS ventas;
CREATE TABLE IF NOT EXISTS ventas (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT UNSIGNED,
    fecha DATE,
    importe_bruto DECIMAL(10 , 2 ) NOT NULL,
    importe_iva DECIMAL(10 , 2 ) NOT NULL,
    importe_total DECIMAL(10 , 2 ) NOT NULL,
    estado ENUM('Realizado', 'Presupuesto', 'En Preparación', 'Enviado', 'Entregado', 'Facturado', 'Pagado', 'Cancelado', 'Devuelto', 'Cerrado'),
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id)
        REFERENCES clientes (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);


DROP TABLE IF EXISTS lineasventas;
CREATE TABLE lineasventas (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    venta_id INT UNSIGNED NOT NULL,
    numero_linea SMALLINT UNSIGNED NOT NULL,
    producto_id INT UNSIGNED,
    iva DECIMAL(4 , 3 ) NOT NULL,
    cantidad MEDIUMINT UNSIGNED NOT NULL,
    precio DECIMAL(10 , 2 ) NOT NULL,
    importe DECIMAL(10 , 2 ) NOT NULL,
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    UNIQUE (venta_id , numero_linea),
    FOREIGN KEY (venta_id)
        REFERENCES ventas (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (producto_id)
        REFERENCES productos (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Insertar ventas y detalles de venta
--
-- Venta 1
INSERT INTO ventas (id, cliente_id, fecha, importe_bruto, importe_iva, importe_total, estado)
VALUES (1, 3, '2024-04-01', 406.00, 85.26, 491.26, 'Realizado');
-- Detalles de venta 1
INSERT INTO lineasventas(id, venta_id, numero_linea, producto_id, iva, cantidad, precio, importe ) VALUES 
(1,1,1,1,0.21,1,38.32,38.00),
(2,1,2,2,0.21,2,34.00,68.00),
(3,1,3,3,0.21,2,25.00,50.00),
(4,1,4,4,0.21,4,25.00,100.00),
(5,1,5,5,0.21,5,30.00,150.00);

-- Venta 1
INSERT INTO ventas (id, cliente_id, fecha, importe_bruto, importe_iva, importe_total, estado)
VALUES (2, 2, '2024-03-01', 119.93, 235.19, 1355.12, 'Realizado');
-- Detalles de venta 1
INSERT INTO lineasventas(id, venta_id, numero_linea, producto_id, iva, cantidad, precio, importe ) VALUES 
(6,2,1,5,0.21,3,249.99,749.97),
(7,2,2,7,0.21,2,79.99,239.97),
(8,2,3,9,0.21,1,129.99,129.99);