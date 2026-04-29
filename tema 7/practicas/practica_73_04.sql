-- actividad 7.3 Base de datos
-- David Carrero Jiménez

-- 1. Revocar a Juan todos los privilegios a nivel global
REVOKE ALL PRIVILEGES, GRANT OPTION FROM juan@localhost;

-- 2. Revocar a pedro el privilegio de poder acceder en modo consulta (SELECT) a la base de datos geslibros.
REVOKE SELECT ON geslibros FROM pedro@localhost;

-- 3. Revocar maria privilegios de acceso a las bases de datos geslibros y maratoon para los comandos ALTER, CREATE y UPDATE.
REVOKE ALTER, CREATE, UPDATE ON geslibros FROM maria@localhost;
REVOKE ALTER, CREATE, UPDATE ON maratoon FROM maria@localhost;

-- 4. Revocar roberto privilegios de GRANT OPTIONS
REVOKE ALL PRIVILEGES, GRANT OPTION FROM roberto@localhost;

-- 5. Revocar rocio el privilegio INSERT sobre la base de datos geslibros
REVOKE INSERT ON geslibros FROM rocio@localhost;

-- 6. Revocar carlos privilegios sobre las tablas editoriales y clientes de la base de datos geslibros, y también el privilegio UPDATE.
REVOKE UPDATE ON geslibros.editoriales FROM carlos@localhost;
REVOKE UPDATE ON geslibros.clientes FROM carlos@localhost;

-- 7. Revocar anamari privilegios para acceder a las columnas titulo, ean, isbn y precio_venta de la tabla libros de la base de datos geslibros para consultar.
REVOKE SELECT(titulo, ean, isbn, precio_venta) ON geslibros.libros FROM anamari@localhost;

-- 8. Revocar anamari privilegios para acceder a las columnas nombre, telefono, email de la tabla clientes de la base de datos geslibros para consultar.
REVOKE SELECT(nombre, telefono, email) ON geslibros.clientes FROM anamari@localhost;