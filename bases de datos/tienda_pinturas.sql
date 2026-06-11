DROP DATABASE IF EXISTS tienda_pinturas;
CREATE DATABASE IF NOT EXISTS tienda_pinturas;
USE tienda_pinturas;

-- =========================================================
-- 1. Tablas principales (sin claves foráneas)
-- =========================================================

CREATE TABLE Proveedores (
    id_proveedor INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre       VARCHAR(100) NOT NULL,
    cif          CHAR(9)      UNIQUE NOT NULL,
    direccion    TEXT,
    telefono     VARCHAR(15),
    email        VARCHAR(100) UNIQUE
);

CREATE TABLE Clientes (
    id_cliente   INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre       VARCHAR(50)  NOT NULL,
    apellidos    VARCHAR(100),
    dni          CHAR(9)      UNIQUE NOT NULL,
    telefono     VARCHAR(15) UNIQUE,
    email        VARCHAR(100) UNIQUE,
    tipo_cliente ENUM('particular', 'empresa', 'mayorista')
);

CREATE TABLE Empleados (
    id_empleado INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre      VARCHAR(50)  NOT NULL,
    apellidos   VARCHAR(100),
    dni         CHAR(9)      UNIQUE NOT NULL,
    telefono    VARCHAR(15),
    email       VARCHAR(100) UNIQUE,
    puesto      VARCHAR(50)
);

CREATE TABLE Productos (
    id_producto  INT UNSIGNED   AUTO_INCREMENT PRIMARY KEY,
    nombre       VARCHAR(100)   NOT NULL,
    descripcion  TEXT,
    tipo         VARCHAR(50),
    marca        VARCHAR(50),
    precio       DECIMAL(10,2)  NOT NULL,
    stock        INT            NOT NULL
);

-- =========================================================
-- 2. Tablas dependientes (lado N de relaciones 1:N)
-- =========================================================

-- NOTA: Los campos 'total' en Ventas y Pedidos se mantienen
-- por motivos de rendimiento y auditoría, pero deben
-- mantenerse sincronizados con el sumatorio de sus detalles
-- (cantidad * precio_unitario) mediante lógica de aplicación
-- o triggers.

CREATE TABLE Ventas (
    id_venta     INT UNSIGNED  AUTO_INCREMENT PRIMARY KEY,
    fecha        DATE          NOT NULL,
    total        DECIMAL(10,2) NOT NULL,
    metodo_pago  ENUM('efectivo', 'tarjeta', 'transferencia', 'bizum'),
    cliente_id   INT UNSIGNED  NOT NULL,
    empleado_id  INT UNSIGNED  NOT NULL
);

CREATE TABLE Pedidos (
    id_pedido    INT UNSIGNED  AUTO_INCREMENT PRIMARY KEY,
    fecha        DATE          NOT NULL,
    estado       VARCHAR(50),
    total        DECIMAL(10,2) NOT NULL,
    proveedor_id INT UNSIGNED  NOT NULL
);

-- =========================================================
-- 3. Tablas intermedias (relaciones N:M)
-- =========================================================

CREATE TABLE Detalle_venta (
    venta_id        INT UNSIGNED  NOT NULL,
    producto_id     INT UNSIGNED  NOT NULL,
    cantidad        INT           NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (venta_id, producto_id)
);

CREATE TABLE Detalle_pedido (
    pedido_id       INT UNSIGNED  NOT NULL,
    producto_id     INT UNSIGNED  NOT NULL,
    cantidad        INT           NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (pedido_id, producto_id)
);

-- =========================================================
-- 4. Claves foráneas (FOREIGN KEYS)
-- =========================================================

ALTER TABLE Ventas
    ADD CONSTRAINT fk_ventas_cliente
    FOREIGN KEY (cliente_id)  REFERENCES Clientes(id_cliente)
    ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Ventas
    ADD CONSTRAINT fk_ventas_empleado
    FOREIGN KEY (empleado_id) REFERENCES Empleados(id_empleado)
    ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Pedidos
    ADD CONSTRAINT fk_pedidos_proveedor
    FOREIGN KEY (proveedor_id) REFERENCES Proveedores(id_proveedor)
    ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Detalle_venta
    ADD CONSTRAINT fk_detalleventa_venta
    FOREIGN KEY (venta_id)    REFERENCES Ventas(id_venta)
    ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Detalle_venta
    ADD CONSTRAINT fk_detalleventa_producto
    FOREIGN KEY (producto_id) REFERENCES Productos(id_producto)
    ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Detalle_pedido
    ADD CONSTRAINT fk_detallepedido_pedido
    FOREIGN KEY (pedido_id)   REFERENCES Pedidos(id_pedido)
    ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Detalle_pedido
    ADD CONSTRAINT fk_detallepedido_producto
    FOREIGN KEY (producto_id) REFERENCES Productos(id_producto)
    ON DELETE CASCADE ON UPDATE CASCADE;

-- =========================================================
-- 5. Índices adicionales
-- =========================================================

CREATE INDEX idx_ventas_fecha    ON Ventas(fecha);
CREATE INDEX idx_pedidos_fecha   ON Pedidos(fecha);
CREATE INDEX idx_productos_nombre ON Productos(nombre);
CREATE INDEX idx_productos_tipo  ON Productos(tipo);
CREATE INDEX idx_productos_marca ON Productos(marca);


USE tienda_pinturas;

-- =========================================================
-- MINA DE DATOS — tienda_pinturas
-- Empresa ubicada en Ubrique (Sierra de Cádiz)
-- =========================================================

-- =========================================================
-- 1. PROVEEDORES
-- =========================================================

INSERT INTO Proveedores (nombre, cif, direccion, telefono, email) VALUES
('Pinturas Titán S.A.',           'A28123456', 'Polígono Industrial Norte, Nave 12, Madrid',          '915550101', 'comercial@titan.es'),
('Valentine Pintures S.L.',       'B08234567', 'Carrer de la Indústria, 45, Barcelona',                '932550202', 'ventas@valentine.es'),
('Andalucía Pinturas S.L.',       'B41345678', 'Calle Resolana, 8, Sevilla',                           '954550303', 'pedidos@andaluciapinturas.es'),
('Bruguer Distribuciones S.A.',   'A28456789', 'Avenida de la Industria, 23, Alcobendas, Madrid',      '916550404', 'dist@bruguer.es'),
('Pinturas Jafep S.L.',           'B46567890', 'Polígono Industrial Fuente del Jarro, Valencia',       '963550505', 'info@jafep.es'),
('Suministros Sierra S.L.',       'B11678901', 'Calle Alcalá, 10, Ronda, Málaga',                     '952550606', 'sierra@suministros.es'),
('Colorines del Sur S.L.',        'B41789012', 'Avenida de Andalucía, 34, Jerez de la Frontera',       '956550707', 'info@colorisnessur.es'),
('Materiales Grazalema S.L.',     'B11890123', 'Calle La Fuente, 5, Grazalema, Cádiz',                '956550808', 'ventas@grazalemamateriales.es'),
('Distribuidora Serrania S.L.',   'B11901234', 'Polígono El Tesoro, Nave 3, Arcos de la Frontera',    '956550909', 'pedidos@serraniadist.es'),
('Pinturas Olvera S.L.',          'B11012345', 'Calle Real, 22, Olvera, Cádiz',                       '956551010', 'comercial@pinturasolvera.es');

-- =========================================================
-- 2. CLIENTES
-- =========================================================

INSERT INTO Clientes (nombre, apellidos, dni, telefono, email, tipo_cliente) VALUES
('Manuel',    'Domínguez Pérez',     '31111111A', '956601001', 'manuel.dominguez@gmail.com',    'particular'),
('Carmen',    'Sánchez Romero',      '31222222B', '956601002', 'carmen.sanchez@hotmail.com',    'particular'),
('Francisco', 'Vega Morales',        '31333333C', '956601003', 'fvega@constructoravega.es',     'empresa'),
('Lucía',     'Jiménez Cortés',      '31444444D', '956601004', 'lucia.jimenez@gmail.com',       'particular'),
('Antonio',   'Ruiz Fernández',      '31555555E', '956601005', 'aruiz@pintoresrural.es',        'empresa'),
('Isabel',    'García Montoya',      '31666666F', '956601006', 'isabel.garcia@yahoo.es',        'particular'),
('José',      'Herrera Téllez',      '31777777G', '956601007', 'jherrera@reformassierra.com',   'empresa'),
('María',     'López Carrasco',      '31888888H', '956601008', 'maria.lopez@gmail.com',         'particular'),
('Pedro',     'Naranjo Blanco',      '31999999I', '956601009', 'pnaranjo@almacenesnaranjo.es',  'mayorista'),
('Dolores',   'Pinto Alcántara',     '32000000J', '956601010', 'dolores.pinto@gmail.com',       'particular');

-- =========================================================
-- 3. EMPLEADOS
-- =========================================================

INSERT INTO Empleados (nombre, apellidos, dni, telefono, email, puesto) VALUES
('Rafael',    'Márquez Vidal',       '45111111K', '956701001', 'rafael.marquez@tiendapinturas.es',  'Gerente'),
('Sofía',     'Castro Palomino',     '45222222L', '956701002', 'sofia.castro@tiendapinturas.es',    'Dependienta'),
('Alejandro', 'Mena Cordón',         '45333333M', '956701003', 'alejandro.mena@tiendapinturas.es',  'Dependiente'),
('Teresa',    'Guerrero Leiva',      '45444444N', '956701004', 'teresa.guerrero@tiendapinturas.es', 'Encargada de almacén'),
('Carlos',    'Infante Ríos',        '45555555O', '956701005', 'carlos.infante@tiendapinturas.es',  'Repartidor'),
('Pilar',     'Moreno Espada',       '45666666P', '956701006', 'pilar.moreno@tiendapinturas.es',    'Dependienta'),
('Jesús',     'Vargas Solano',       '45777777Q', '956701007', 'jesus.vargas@tiendapinturas.es',    'Repartidor'),
('Ana',       'Flores Pedraza',      '45888888R', '956701008', 'ana.flores@tiendapinturas.es',      'Contable'),
('Javier',    'Romero Caballero',    '45999999S', '956701009', 'javier.romero@tiendapinturas.es',   'Dependiente'),
('Rocío',     'Delgado Trujillo',    '46000000T', '956701010', 'rocio.delgado@tiendapinturas.es',   'Dependienta');

-- =========================================================
-- 4. PRODUCTOS (pinturas y accesorios)
-- =========================================================

INSERT INTO Productos (nombre, descripcion, tipo, marca, precio, stock) VALUES
('Pintura plástica blanca mate 15L',        'Pintura interior de alta cubrición, acabado mate',                          'Pintura interior',  'Titán',    28.50,  80),
('Pintura plástica blanca mate 5L',         'Pintura interior de alta cubrición, acabado mate',                          'Pintura interior',  'Titán',    11.90,  120),
('Pintura plástica color arena 15L',        'Pintura interior tono arena, acabado liso',                                 'Pintura interior',  'Valentine', 30.00,  60),
('Pintura exterior blanca 15L',             'Pintura para fachadas, resistente a la intemperie',                         'Pintura exterior',  'Bruguer',  35.75,  50),
('Pintura exterior terracota 15L',          'Pintura para fachadas, tono terracota, resistente UV',                      'Pintura exterior',  'Bruguer',  37.00,  40),
('Esmalte sintético blanco brillo 750ml',   'Esmalte para madera y metal, secado rápido',                                'Esmalte',           'Titán',    12.50,  90),
('Esmalte sintético negro satinado 750ml',  'Esmalte para madera y metal, acabado satinado',                             'Esmalte',           'Titán',    12.50,  70),
('Barniz madera interior 750ml',            'Barniz protector para madera en interiores',                                'Barniz',            'Valentine',  9.95, 100),
('Barniz madera exterior 750ml',            'Barniz resistente al agua y rayos UV para exterior',                        'Barniz',            'Valentine', 11.50,  75),
('Imprimación universal 1L',                'Imprimación adherente para todo tipo de superficies',                       'Imprimación',       'Jafep',     8.75, 110),
('Pintura pizarra 750ml',                   'Pintura especial efecto pizarra, color negro',                              'Pintura especial',  'Bruguer',  14.90,  35),
('Pintura chalk paint blanco roto 1L',      'Pintura tiza para muebles y decoración, acabado vintage',                   'Pintura decorativa','Valentine', 16.50,  45),
('Pintura chalk paint azul mar 1L',         'Pintura tiza para muebles y decoración, tono marino',                      'Pintura decorativa','Valentine', 16.50,  40),
('Rodillo pelo corto 23cm',                 'Rodillo para pinturas lisas en paredes y techos',                           'Accesorio',         'Titán',     4.25, 200),
('Brocha plana 70mm',                       'Brocha plana para esmaltes y barnices',                                     'Accesorio',         'Titán',     2.80, 250),
('Bandeja de pintura con rejilla',          'Bandeja plástica con rejilla escurridor para rodillo',                      'Accesorio',         'Jafep',     3.50, 180),
('Cinta de carrocero 25m',                  'Cinta adhesiva de baja adherencia para protección',                        'Accesorio',         'Jafep',     2.10, 300),
('Disolvente universal 1L',                 'Disolvente para esmaltes sintéticos y limpieza de útiles',                  'Disolvente',        'Jafep',     4.80, 150),
('Pintura antihumedad 5L',                  'Pintura especial para zonas con humedad, color blanco',                     'Pintura especial',  'Bruguer',  22.00,  55),
('Masilla tapagrietas 500g',                'Masilla lista para usar, para grietas y agujeros en paredes',               'Preparación',       'Titán',     5.60, 130);

-- =========================================================
-- 5. VENTAS
-- total = suma(cantidad * precio_unitario) de Detalle_venta
-- V1:  2*28.50 + 2*4.25  + 3*2.10  = 71.80
-- V2:  2*12.50 + 2*2.80  + 2*4.80  = 40.20
-- V3:  4*35.75 + 3*8.75  + 3*4.25  + 3*3.50  = 192.50
-- V4:  1*16.50 + 1*16.50            = 33.00
-- V5:  3*37.00 + 3*8.75  + 1*4.80  = 142.05
-- V6:  2*5.60  + 4*2.10  + 2*2.80  = 25.20
-- V7:  4*35.75 + 2*37.00 + 4*8.75  + 4*4.25  = 269.00
-- V8:  2*11.50 + 2*12.50 + 2*2.80  = 53.60
-- V9:  6*28.50 + 4*35.75 + 4*22.00 + 4*8.75  = 437.00
-- V10: 2*30.00 + 2*4.25  + 1*3.50  + 1*2.10  = 74.10
-- V11: 2*16.50 + 2*2.80             = 38.60
-- V12: 4*14.90 + 4*8.75  + 4*4.80  + 4*9.95  = 153.60
-- V13: 3*22.00 + 3*5.60  + 3*2.10  = 89.10
-- V14: 2*11.50 + 1*12.50 + 2*4.80  + 1*2.10  = 47.20
-- V15: 6*11.90 + 3*35.75 + 4*8.75  + 4*4.25  = 230.65
-- =========================================================

INSERT INTO Ventas (fecha, total, metodo_pago, cliente_id, empleado_id) VALUES
('2025-01-10',   71.80, 'tarjeta',        1,  2),
('2025-01-15',   40.20, 'efectivo',       2,  3),
('2025-01-22',  192.50, 'tarjeta',        3,  2),
('2025-02-03',   33.00, 'bizum',          4,  6),
('2025-02-14',  142.05, 'transferencia',  5,  1),
('2025-02-20',   25.20, 'efectivo',       6,  9),
('2025-03-05',  269.00, 'transferencia',  7,  1),
('2025-03-11',   53.60, 'tarjeta',        8,  3),
('2025-03-18',  437.00, 'transferencia',  9,  1),
('2025-04-02',   74.10, 'tarjeta',       10,  2),
('2025-04-08',   38.60, 'efectivo',       1,  6),
('2025-04-17',  153.60, 'tarjeta',        3,  9),
('2025-05-06',   89.10, 'bizum',          5,  2),
('2025-05-20',   47.20, 'efectivo',       7,  3),
('2025-06-03',  230.65, 'transferencia',  9,  1);

-- =========================================================
-- 6. DETALLE_VENTA
-- =========================================================

INSERT INTO Detalle_venta (venta_id, producto_id, cantidad, precio_unitario) VALUES
-- Venta 1 (71.80): pintura blanca 15L + rodillo + cinta
(1,  1,  2, 28.50),
(1, 14,  2,  4.25),
(1, 17,  3,  2.10),
-- Venta 2 (40.20): esmalte negro + brocha + disolvente
(2,  7,  2, 12.50),
(2, 15,  2,  2.80),
(2, 18,  2,  4.80),
-- Venta 3 (192.50): pintura exterior blanca + imprimación + rodillo + bandeja
(3,  4,  4, 35.75),
(3, 10,  3,  8.75),
(3, 14,  3,  4.25),
(3, 16,  3,  3.50),
-- Venta 4 (33.00): chalk paint blanco roto + chalk paint azul
(4, 12,  1, 16.50),
(4, 13,  1, 16.50),
-- Venta 5 (142.05): pintura exterior terracota + imprimación + disolvente
(5,  5,  3, 37.00),
(5, 10,  3,  8.75),
(5, 18,  1,  4.80),
-- Venta 6 (25.20): masilla + cinta + brocha
(6, 20,  2,  5.60),
(6, 17,  4,  2.10),
(6, 15,  2,  2.80),
-- Venta 7 (269.00): pintura exterior blanca y terracota + imprimación + rodillos
(7,  4,  4, 35.75),
(7,  5,  2, 37.00),
(7, 10,  4,  8.75),
(7, 14,  4,  4.25),
-- Venta 8 (53.60): barniz exterior + esmalte blanco + brocha
(8,  9,  2, 11.50),
(8,  6,  2, 12.50),
(8, 15,  2,  2.80),
-- Venta 9 (437.00): pedido mayorista — pintura blanca 15L + exterior + antihumedad + imprimación
(9,  1,  6, 28.50),
(9,  4,  4, 35.75),
(9, 19,  4, 22.00),
(9, 10,  4,  8.75),
-- Venta 10 (74.10): pintura arena + rodillo + bandeja + cinta
(10,  3,  2, 30.00),
(10, 14,  2,  4.25),
(10, 16,  1,  3.50),
(10, 17,  1,  2.10),
-- Venta 11 (38.60): chalk paint azul + brocha
(11, 13,  2, 16.50),
(11, 15,  2,  2.80),
-- Venta 12 (153.60): pintura pizarra + imprimación + disolvente + barniz interior
(12, 11,  4, 14.90),
(12, 10,  4,  8.75),
(12, 18,  4,  4.80),
(12,  8,  4,  9.95),
-- Venta 13 (89.10): pintura antihumedad + masilla + cinta
(13, 19,  3, 22.00),
(13, 20,  3,  5.60),
(13, 17,  3,  2.10),
-- Venta 14 (47.20): barniz exterior + esmalte blanco + disolvente
(14,  9,  2, 11.50),
(14,  6,  1, 12.50),
(14, 18,  2,  4.80),
(14, 17,  1,  2.10),
-- Venta 15 (230.65): pedido mayorista — pintura blanca 5L + exterior + imprimación + rodillos
(15,  2,  6, 11.90),
(15,  4,  3, 35.75),
(15, 10,  4,  8.75),
(15, 14,  4,  4.25);

-- =========================================================
-- 7. PEDIDOS
-- total = suma(cantidad * precio_unitario) de Detalle_pedido
-- P1:  10*28.50 + 10*11.90                          = 404.00
-- P2:   8*30.00 +  8*8.75  +  6*5.60               = 343.60
-- P3:   5*14.90 +  6*16.50 +  6*16.50              = 272.50
-- P4:  10*35.75 +  6*37.00                          = 579.50
-- P5:  20*4.25  + 20*2.80  + 15*3.50  + 30*2.10    = 256.50
-- P6:  10*12.50 + 10*12.50 + 10*9.95  + 10*11.50   = 464.50
-- P7:  20*4.80  + 20*8.75                           = 271.00
-- P8:  10*28.50 +  8*22.00                          = 461.00
-- P9:  15*3.50  + 25*2.10  + 10*5.60               = 161.00
-- P10: 12*11.90 +  8*30.00 +  6*16.50              = 481.80
-- P11:  5*35.75 +  5*37.00 +  5*8.75               = 407.50
-- P12:  6*12.50 +  6*12.50 +  5*4.80               = 174.00
-- P13:  8*28.50 + 10*11.90 + 15*4.25  + 15*2.80    = 452.75
-- P14: 10*9.95  + 10*11.50 +  8*8.75               = 284.50
-- P15:  8*22.00 +  6*14.90 + 10*5.60               = 321.40
-- =========================================================

INSERT INTO Pedidos (fecha, estado, total, proveedor_id) VALUES
('2025-01-05',  'entregado',   404.00,  1),
('2025-01-12',  'entregado',   343.60,  3),
('2025-01-20',  'entregado',   272.50,  2),
('2025-02-01',  'entregado',   579.50,  4),
('2025-02-10',  'entregado',   256.50,  5),
('2025-02-18',  'entregado',   464.50,  6),
('2025-03-02',  'entregado',   271.00,  7),
('2025-03-10',  'entregado',   461.00,  1),
('2025-03-22',  'entregado',   161.00,  8),
('2025-04-05',  'entregado',   481.80,  2),
('2025-04-15',  'en tránsito', 407.50,  9),
('2025-04-28',  'en tránsito', 174.00,  3),
('2025-05-10',  'pendiente',   452.75, 10),
('2025-05-22',  'pendiente',   284.50,  4),
('2025-06-01',  'pendiente',   321.40,  5);

-- =========================================================
-- 8. DETALLE_PEDIDO
-- =========================================================

INSERT INTO Detalle_pedido (pedido_id, producto_id, cantidad, precio_unitario) VALUES
-- Pedido 1 (404.00): reposición pintura blanca 15L y 5L
(1,  1, 10, 28.50),
(1,  2, 10, 11.90),
-- Pedido 2 (343.60): reposición pinturas de interior
(2,  3,  8, 30.00),
(2, 10,  8,  8.75),
(2, 20,  6,  5.60),
-- Pedido 3 (272.50): chalk paint y pintura pizarra
(3, 11,  5, 14.90),
(3, 12,  6, 16.50),
(3, 13,  6, 16.50),
-- Pedido 4 (579.50): pinturas exteriores
(4,  4, 10, 35.75),
(4,  5,  6, 37.00),
-- Pedido 5 (256.50): accesorios
(5, 14, 20,  4.25),
(5, 15, 20,  2.80),
(5, 16, 15,  3.50),
(5, 17, 30,  2.10),
-- Pedido 6 (464.50): esmaltes y barnices
(6,  6, 10, 12.50),
(6,  7, 10, 12.50),
(6,  8, 10,  9.95),
(6,  9, 10, 11.50),
-- Pedido 7 (271.00): disolventes e imprimaciones
(7, 18, 20,  4.80),
(7, 10, 20,  8.75),
-- Pedido 8 (461.00): reposición pintura blanca 15L + antihumedad
(8,  1, 10, 28.50),
(8, 19,  8, 22.00),
-- Pedido 9 (161.00): accesorios y masilla
(9, 16, 15,  3.50),
(9, 17, 25,  2.10),
(9, 20, 10,  5.60),
-- Pedido 10 (481.80): pintura interior y chalk paint
(10,  2, 12, 11.90),
(10,  3,  8, 30.00),
(10, 12,  6, 16.50),
-- Pedido 11 (407.50): pinturas exteriores
(11,  4,  5, 35.75),
(11,  5,  5, 37.00),
(11, 10,  5,  8.75),
-- Pedido 12 (174.00): esmaltes y disolvente
(12,  6,  6, 12.50),
(12,  7,  6, 12.50),
(12, 18,  5,  4.80),
-- Pedido 13 (452.75): reposición general interior + accesorios
(13,  1,  8, 28.50),
(13,  2, 10, 11.90),
(13, 14, 15,  4.25),
(13, 15, 15,  2.80),
-- Pedido 14 (284.50): barnices e imprimación
(14,  8, 10,  9.95),
(14,  9, 10, 11.50),
(14, 10,  8,  8.75),
-- Pedido 15 (321.40): pintura antihumedad + pizarra + masilla
(15, 19,  8, 22.00),
(15, 11,  6, 14.90),
(15, 20, 10,  5.60);