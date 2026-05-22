-- variable global scheduler para activar o desactivar el programador de eventos

USE bancos;
SET GLOBAL event_scheduler = ON;
SHOW VARIABLES like 'event_scheduler';

-- crear evento listado_clientes
-- listado de clientes base de datos bancos
-- solo una vez
-- a las 9:35
DELIMITER $$
CREATE EVENT bancos.listado_clientes
ON SCHEDULE AT '2026-05-24 09:40:00'
DO
BEGIN
    SELECT * FROM bancos.clientes;
END$$

DELIMITER ;
SELECT * FROM information_schema.events;