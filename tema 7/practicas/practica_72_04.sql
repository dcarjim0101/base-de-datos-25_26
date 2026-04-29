-- actividad 7.2 Base de datos
-- David Carrero Jiménez

-- 1. Asignar al usuario juan todos los privilegios a nivel global.
GRANT ALL PRIVILEGES ON *.* TO juan@localhost WITH GRANT OPTION;

-- 2. Asignar al usuario pedro el privilegio de poder acceder a todas las bases de datos pero sólo para consultar (SELECT)
GRANT SELECT ON *.* TO pedro@localhost;

-- 3. Asignar al usuario maria privilegios de acceso a las bases de datos gestlibros y maratoon sólo para ejecutar los comandos ALTER, CREATE, UPDATE Y SELECT.
GRANT ALTER, CREATE, UPDATE, SELECT ON geslibros TO maria@localhost;
GRANT ALTER, CREATE, UPDATE, SELECT ON maratoon TO maria@localhost;

-- 4. Asignar  al nuevo usuario roberto/roberto_67 privilegios de super administrador.
GRANT ALL PRIVILEGES ON *.* TO roberto@localhost WITH GRANT OPTION;

-- 5. Asignar al nuevo usuario rocio/rocio_69 todos los privilegios sobre la base de datos geslibros
GRANT ALL PRIVILEGES ON geslibros TO rocio@localhost;

-- 6. Asignar al nuevo usuario carlos/carlos_90 privilegios sobre la tabla libros, editoriales y clientes de la base de datos geslibros, además sólo podrá realizar consultas y actualizaciones.
GRANT SELECT, UPDATE ON geslibros.libros TO carlos@localhost;
GRANT SELECT, UPDATE ON geslibros.editoriales TO carlos@localhost;
GRANT SELECT, UPDATE ON geslibros.clientes TO carlos@localhost;

-- 7. Asignar al nuevo usuario anamari/anamari_2000 privilegios para acceder a las columnas titulo, ean, isbn y precio_venta de la tabla libros de la base de datos geslibros sólo para consultar.
GRANT SELECT ON geslibros.libros.titulo TO anamari@localhost;
GRANT SELECT ON geslibros.libros.ean TO anamari@localhost;
GRANT SELECT ON geslibros.libros.isbn TO anamari@localhost;
GRANT SELECT ON geslibros.libros.precio_venta TO anamari@localhost;

-- 8. Asignar al usuario anamari privilegios para acceder a las columnas nombre, telefono, email de la tabla clientes de la base de datos geslibros sólo para consultar y actualizar.
GRANT SELECT, UPDATE ON geslibros.clientes.nombre TO anamari@localhost;
GRANT SELECT, UPDATE ON geslibros.clientes.telefono TO anamari@localhost;
GRANT SELECT, UPDATE ON geslibros.clientes.email TO anamari@localhost;