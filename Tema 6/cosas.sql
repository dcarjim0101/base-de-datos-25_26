select * from libros order by 1 asc LIMIT 2, 5;
select * from libros  order by 1 asc LIMIT 5 OFFSET 2;
SELECT distinct ciudad from corredores;
select ciudad, count(*) from corredores group by ciudad;
select count(distinct ciudad) from corredores;

SELECT 
    'corredores de ubrique',
    MAX(edad) Edad_Max,
    MIN(edad) Edad_Min,
    AVG(edad) Edad_Media,
    COUNT(*) Cantidad
FROM
    corredores
WHERE
    ciudad = 'ubrique';