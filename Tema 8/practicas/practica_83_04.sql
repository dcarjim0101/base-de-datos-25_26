-- Practica 8.3
-- David Carrero Jiménez

-- Actividad 1. Id de Categoría
USE maratoon;

DELIMITER $$

CREATE FUNCTION Categoria(p_edad INT UNSIGNED) RETURNS INT UNSIGNED
DETERMINISTIC
READS SQL DATA
BEGIN
    RETURN (
        SELECT id
        FROM Categorias
        WHERE (
            Descripcion LIKE 'Menores de %' AND p_edad < CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(Descripcion, 'Menores de ', -1), ' años', 1) AS UNSIGNED)
        ) OR (
            Descripcion LIKE 'A partir de %' AND p_edad >= CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(Descripcion, 'A partir de ', -1), ' años', 1) AS UNSIGNED)
        )
        LIMIT 1
    );
END$$

DELIMITER ;

SELECT Categoria(10) AS 'Categoria Edad 10';
SELECT Categoria(20) AS 'Categoria Edad 20';
SELECT Categoria(65) AS 'Categoria Edad 65';



-- Actividad 2. Procedimiento ActualizarCategoria
DELIMITER $$

CREATE PROCEDURE ActualizarCategoria()
BEGIN
    UPDATE Corredores
    SET categoria_id = Categoria(Edad);
END$$

DELIMITER ;

CALL ActualizarCategoria();
SELECT id, Nombre, Apellidos, Edad, categoria_id FROM Corredores;



-- Actividad 3. Procedmiento ProximoCumpleaños
DELIMITER $$

CREATE PROCEDURE ProximosCumpleanos()
BEGIN
    SELECT 
        id,
        Nombre,
        Apellidos,
        Ciudad,
        FechaNacimiento,
        DATE_FORMAT(
            IF(
                DATE_FORMAT(FechaNacimiento, CONCAT(YEAR(CURDATE()), '-%m-%d')) < CURDATE(),
                DATE_ADD(DATE_FORMAT(FechaNacimiento, CONCAT(YEAR(CURDATE()), '-%m-%d')), INTERVAL 1 YEAR),
                DATE_FORMAT(FechaNacimiento, CONCAT(YEAR(CURDATE()), '-%m-%d'))
            ),
            '%Y-%m-%d'
        ) AS 'ProximoCumpleanos'
    FROM Corredores
    WHERE 
        IF(
            DATE_FORMAT(FechaNacimiento, CONCAT(YEAR(CURDATE()), '-%m-%d')) < CURDATE(),
            DATE_ADD(DATE_FORMAT(FechaNacimiento, CONCAT(YEAR(CURDATE()), '-%m-%d')), INTERVAL 1 YEAR),
            DATE_FORMAT(FechaNacimiento, CONCAT(YEAR(CURDATE()), '-%m-%d'))
        ) BETWEEN CURDATE() + INTERVAL 1 DAY AND CURDATE() + INTERVAL 7 DAY;
END$$

DELIMITER ;

CALL ProximosCumpleanos();



-- Actividad 4. Función Números Primos
USE test;

DROP FUNCTION IF EXISTS NumerosPrimos;
DELIMITER $$
CREATE FUNCTION NumerosPrimos(p_valor INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT DEFAULT 0;
    DECLARE n INT DEFAULT 1;
    DECLARE i INT;
    DECLARE es_primo BOOLEAN;

    WHILE n <= p_valor DO
        IF n = 1 THEN
            SET total = total + 1;
        ELSE
            SET es_primo = TRUE;
            SET i = 2;
            WHILE i <= FLOOR(SQRT(n)) AND es_primo DO
                IF n % i = 0 THEN
                    SET es_primo = FALSE;
                END IF;
                SET i = i + 1;
            END WHILE;
            IF es_primo THEN
                SET total = total + n;
            END IF;
        END IF;
        SET n = n + 1;
    END WHILE;

    RETURN total;
END$$
DELIMITER ;

SELECT NumerosPrimos(7) AS 'SumaPrimosHasta7';



-- Actividad 5. Factorial
USE test;

DROP FUNCTION IF EXISTS factorial;
DELIMITER $$
CREATE FUNCTION factorial(p_valor INT) RETURNS BIGINT
DETERMINISTIC
BEGIN
    DECLARE resultado BIGINT DEFAULT 1;
    DECLARE contador INT DEFAULT 1;

    WHILE contador <= p_valor DO
        SET resultado = resultado * contador;
        SET contador = contador + 1;
    END WHILE;

    RETURN resultado;
END$$
DELIMITER ;

SELECT factorial(5) AS 'Factorial de 5';
