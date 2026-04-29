-- actividad 7.9

use maratoon;
-- 1.
/*
	-- nombre, apellidos, ciudad, fechanacimiento, sexo, club_id
	"Carlos"; "López Martín"; "Sevilla"; "1995-03-12"; "H"; 3
	"Ana"; "Sánchez Ruiz"; "Jerez"; "1988-07-22"; "M"; 5
	"Miguel"; "Torres Gómez"; "Cádiz"; "2001-11-05"; "H"; 2
	"Lucía"; "Navarro Díaz"; "Arcos"; "1979-01-30"; "M"; 4
	"David"; "Castro Romero"; "Ubrique"; "1968-09-18"; "H"; 1
*/

-- 2.
LOAD DATA INFILE "C:/Users/02_1DAW_alum/Desktop/base de datos 25_26/csvs/corredores.csv"
IGNORE INTO TABLE maratoon.registros FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n'
IGNORE 4 LINES;

-- 3.
UPDATE Corredores SET Edad = TIMESTAMPDIFF(YEAR, FechaNacimiento, CURDATE());

-- 4.
/*
	id,carrera_id,corredor_id,Salida,Llegada,TiempoInvertido
	17,3,17,2026-05-10 09:00:00,2026-05-10 10:48:35,01:48:35
	18,3,18,2026-05-10 09:00:00,2026-05-10 10:35:20,01:35:20
	19,3,19,2026-05-10 09:00:00,2026-05-10 10:25:10,01:25:10
	20,3,20,2026-05-10 09:00:00,2026-05-10 10:55:42,01:55:42
	21,3,21,2026-05-10 09:00:00,2026-05-10 11:05:18,02:05:18
*/

-- 5. 
LOAD DATA INFILE "C:/Users/02_1DAW_alum/Desktop/base de datos 25_26/csvs/registros.csv"
IGNORE INTO TABLE maratoon.registros FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n'
IGNORE 4 LINES;

-- 6. 
UPDATE Registros
SET TiempoInvertido = TIMEDIFF(Llegada, Salida)
WHERE TiempoInvertido IS NULL;

-- 7.
/* 
	<?xml version="1.0" encoding="UTF-8"?>
	<clubs>
		<club>
			<NombreCorto>ATL</NombreCorto>
			<Nombre>Atletismo Sevilla Sur</Nombre>
			<Ciudad>Sevilla</Ciudad>
			<FecFundacion>1992-06-15</FecFundacion>
			<NumSocios>180</NumSocios>
		</club>

		<club>
			<NombreCorto>RUN</NombreCorto>
			<Nombre>Runners Cádiz Club</Nombre>
			<Ciudad>Cádiz</Ciudad>
			<FecFundacion>2001-03-22</FecFundacion>
			<NumSocios>95</NumSocios>
		</club>
	</clubs>
*/

-- 8.
/*
	<?xml version="1.0" encoding="UTF-8"?>
	<carreras>
		<carrera>
			<Nombre>Maratón Costa del Sol</Nombre>
			<Ciudad>Málaga</Ciudad>
			<Distancia>42195</Distancia>
			<MesCelebracion>10</MesCelebracion>
		</carrera>

		<carrera>
			<Nombre>Media Maratón Sierra de Cádiz</Nombre>
			<Ciudad>Ubrique</Ciudad>
			<Distancia>21097</Distancia>
			<MesCelebracion>5</MesCelebracion>
		</carrera>
	</carreras>
*/

-- 9.
LOAD DATA INFILE "C:/Users/02_1DAW_alum/Desktop/base de datos 25_26/xml/clubs.xml"
IGNORE INTO TABLE maratoon.registros FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n'
IGNORE 4 LINES;

-- 10.
LOAD DATA INFILE "C:/Users/02_1DAW_alum/Desktop/base de datos 25_26/xml/carreras.xml"
IGNORE INTO TABLE maratoon.registros FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n'
IGNORE 4 LINES;

-- 11.
SELECT *
FROM corredores
INTO OUTFILE "C:/Users/02_1DAW_alum/Desktop/base de datos 25_26/csvs/copiacorredores.csv"
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- 12.
SELECT *
FROM registros
INTO OUTFILE "C:/Users/02_1DAW_alum/Desktop/base de datos 25_26/csvs/copiaregistros.csv"
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- 13. 
SELECT 
    r.corredor_id AS IdCorredor,
    c.Apellidos,
    c.Nombre,
    cl.Nombre AS Club,
    cat.Nombre AS Categoria,
    r.TiempoInvertido
FROM Registros r
JOIN Corredores c ON r.corredor_id = c.id
JOIN Clubs cl ON c.Club_id = cl.id
JOIN Categorias cat ON c.Categoria_id = cat.id
WHERE r.carrera_id = 1
ORDER BY r.TiempoInvertido
INTO OUTFILE "C:/Users/02_1DAW_alum/Desktop/base de datos 25_26/csvs/clasificacion_carrera1.csv"
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- 14.
-- mysqldump -u root -p maratoon > maratoon_backup.sql

-- 15.
-- mysqldump -u root -p maratoon Carreras Registros > backup_carreras_registros.sql

-- 16. 
-- mysqldump -u root -p --xml maratoon > maratoon.xml

-- 17. 
-- mysqldump -u root -p --xml --no-create-info maratoon > maratoondatos.xml