-- nombre del corredor
select
	registros.id,
    registros.corredor_id,
    corredores.nombre,
    corredores.apellidos,
    corredores.Categoria_id,
    categorias.nombrecorto,
    corredores.Club_id,
    clubs.nombre club,
    registros.TiempoInvertido
from
	((registros
		inner join
	corredores on registros.corredor_id = corredores.id)
    inner join clubs on corredores.club_id = clubs.id)
    inner join categorias on corredores.Categoria_id = categoria.id
where
	carrera_id = 1
order by TiempoInvertido;

-- creada la vista puedo usarla como una tabla
-- clasificacion VTB a partir de la vista
select * from clasificacion_nutrias where categoria = 'VTB';
select id, nombre, apellidos, categoria, club, tiempoinvertido from clasificacion_nutrias where categoria = 'VTB';
select id, nombre, apellidos, categoria, club, tiempoinvertido from clasificacion_nutrias where categoria = 'VTA';
-- cuantos corredores han llegado de cada categoria
select categoria, count(*) participantes from clasificacion_nutrias group by categoria;
select club, count(*) participantes from clasificacion_nutrias group by club;