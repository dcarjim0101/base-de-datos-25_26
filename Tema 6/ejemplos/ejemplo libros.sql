-- ejemplo
-- SELECT

-- Muestra todos los registros de la tabla libros,
-- con todas las columnas de la tabla
-- lista de columnas: *
SELECT * FROM libros;

-- especificamos lista de columnas
SELECT id, titulo, autor_id, editorial_id, precio_venta FROM libros;

-- especificamos lista de columnas con otro orden
SELECT 
    id,
    titulo,
    precio_venta,
    autor_id,
    editorial_id,
    precio_coste
FROM
    libros;
    
-- lista columnas con expresion
-- beneficio que obtengo de cada libro: precio_venta - precio_coste
-- coloca el beneficio al final de la columna
SELECT 
    id,
    titulo,
    autor_id,
    editorial_id,
    precio_venta,
    precio_coste,
    precio_venta - precio_coste as beneficio
FROM
    libros;
    
-- uso de prefijos
-- columnas: nombre de la base de datos, nombre de la tabla
-- tablas: nombre de la base de datos
SELECT 
    geslibros.libros.id,
    geslibros.libros.titulo,
    geslibros.libros.autor_id,
    geslibros.libros.editorial_id,
    geslibros.libros.precio_venta,
    geslibros.libros.precio_coste,
    libros.precio_venta - libros.precio_coste beneficio
FROM
    geslibros.libros;
    
-- clausula FROM
-- las tapas a partir de la cual extraigo los datos
SELECT 
    libros.id,
    libros.titulo,
    libros.autor_id,
    autores.id as id_autor,
    autores.nombre as autor,
    libros.id as id_libro,
    libros.precio_venta
FROM
    libros,
    autores;