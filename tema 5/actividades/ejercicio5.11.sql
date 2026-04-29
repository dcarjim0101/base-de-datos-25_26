-- uso esta base de datos
USE restricciones_check;

DROP TABLE IF EXISTS operadorLike;
CREATE TABLE IF NOT EXISTS operadorLike(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR LIKE(A%),
    nombre VARCHAR LIKE(JU%),
    email VARCHAR LIKE(%),
    passwordd VARCHAR LIKE(__M____)
    cpostal VARCHAR LIKE(11___)
    codigo VARCHAR LIKE(ES____99)
);