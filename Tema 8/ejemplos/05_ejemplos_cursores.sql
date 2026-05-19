
DELIMITER $$ 
DROP PROCEDURE IF EXISTS Corredores_Poblacion$$ 
CREATE procedure Corredores_Poblacion(PCiudad VARCHAR(20)) 
BEGIN  
 DECLARE Vid INT; 
    DECLARE VNombre VARCHAR(20); 
    DECLARE VApellidos VARCHAR(40); 
    DECLARE VCiudad VARCHAR(20); 
    DECLARE lrf BOOLEAN; 
    DECLARE nreg INT; 
    DECLARE Cursor01 CURSOR FOR SELECT id, Nombre, Apellidos, Ciudad FROM Corredores  
    WHERE Ciudad=PCiudad; 
    DECLARE CONTINUE HANDLER  FOR NOT FOUND SET lrf=1; 
    SET lrf=0, nreg=0; 
    OPEN Cursor01; 
    REPEAT 
  FETCH Cursor01 INTO Vid, VNombre, VApellidos, VCiudad; 
          SELECT 'Registro: ', nreg, Vid, VNombre, VApellidos, VCiudad; 
          SET nreg=nreg+1;
          UNTIL lrf 
END REPEAT; 
CLOSE Cursor01; 
SELECT nreg; 
END $$