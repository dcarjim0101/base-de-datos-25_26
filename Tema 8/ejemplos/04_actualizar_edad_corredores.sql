-- actualizo edad de los corredores

DELIMITER $$
DROP PROCEDURE IF EXISTS maratoon.actualizar_edad_corredores$$
CREATE PROCEDURE IF NOT EXISTS maratoon.actualizar_edad_corredores()
BEGIN
    UPDATE maratoon.corredores
    SET edad = TIMESTAMPDIFF(YEAR, FechaNacimiento, CURDATE());
END$$