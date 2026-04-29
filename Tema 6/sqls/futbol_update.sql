CREATE DATABASE  IF NOT EXISTS `futbol` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `futbol`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: futbol
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `equipos`
--

DROP TABLE IF EXISTS `equipos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `estadio` varchar(50) NOT NULL,
  `aforo` int(10) unsigned DEFAULT NULL,
  `fundacion` smallint(4) unsigned DEFAULT NULL,
  `ciudad` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipos`
--

LOCK TABLES `equipos` WRITE;
/*!40000 ALTER TABLE `equipos` DISABLE KEYS */;
INSERT INTO `equipos` VALUES (1,'Real Madrid','Santiago Bernabéu',81044,1902,'Madrid'),(2,'FC Barcelona','Spotify Camp Nou',99354,1899,'Barcelona'),(3,'Atlético de Madrid','Cívitas Metropolitano',68456,1903,'Madrid'),(4,'Sevilla FC','Ramón Sánchez-Pizjuán',43883,1890,'Sevilla'),(5,'Real Betis Balompié','Benito Villamarín',60721,1907,'Sevilla'),(6,'Valencia CF','Mestalla',48600,1919,'Valencia'),(7,'Villarreal CF','Estadio de la Cerámica',23500,1923,'Villarreal'),(8,'Athletic Club','San Mamés',53289,1898,'Bilbao'),(9,'Real Sociedad','Reale Arena',39500,1909,'San Sebastián'),(10,'Girona FC','Estadi Montilivi',13500,1930,'Girona');
/*!40000 ALTER TABLE `equipos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goles`
--

DROP TABLE IF EXISTS `goles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `partido_id` int(10) unsigned NOT NULL,
  `minuto` tinyint(3) unsigned DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `jugador_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `partido_id` (`partido_id`),
  KEY `jugador_id` (`jugador_id`),
  CONSTRAINT `goles_ibfk_1` FOREIGN KEY (`partido_id`) REFERENCES `partidos` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `goles_ibfk_2` FOREIGN KEY (`jugador_id`) REFERENCES `jugadores` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goles`
--

LOCK TABLES `goles` WRITE;
/*!40000 ALTER TABLE `goles` DISABLE KEYS */;
INSERT INTO `goles` VALUES (1,1,10,'Golazo de Vinícius tras regatear al portero',1),(2,1,80,'Bellingham marca de cabeza',2),(3,1,85,'Lewandowski recorta distancias con un disparo lejano',4),(4,2,30,'Griezmann adelanta al Atlético tras una gran jugada',7),(5,3,20,'Pedri abre el marcador con un tiro ajustado',5),(6,3,50,'En-Nesyri empata tras un error defensivo',11),(7,3,65,'Lewandowski pone el 2-1 con un penalti',4),(8,3,89,'Navas sorprende con un gol en el último minuto',10),(9,4,25,'Bellingham abre el marcador con un disparo lejano',2),(10,4,55,'Rodrygo amplía la ventaja con una jugada individual',3),(11,4,85,'Vinícius sentencia tras asistencia de Modric',1),(12,4,91,'Morata marca el gol del honor para el Atlético',8),(13,5,15,'Isco marca con un disparo desde la frontal',13),(14,5,50,'Vinícius empata con un regate espectacular',1),(15,5,70,'Rodrygo adelanta al Madrid con un disparo raso',3),(16,5,85,'Bellingham sentencia con un cabezazo',2),(17,6,10,'Guido Rodríguez abre el marcador con un remate de córner',15),(18,6,30,'Morata empata tras una contra rápida',8),(19,6,60,'Borja Iglesias adelanta al Betis con un penalti',14),(20,6,80,'Griezmann iguala con un gol en el descuento',7),(21,7,35,'Hugo Duro remata dentro del área',17),(22,7,62,'Gerard Moreno empata de penalti',18),(23,8,20,'Iñaki Williams marca tras contra',20),(24,8,78,'Nico Williams sentencia con un disparo cruzado',21),(25,9,15,'Dovbyk abre el marcador de cabeza',24),(26,9,40,'Hugo Duro empata tras un rechace',17),(27,9,71,'Aleix García marca desde fuera del área',25),(28,10,55,'Iñaki Williams marca el gol de la victoria',20),(29,11,12,'Oyarzabal marca tras una jugada colectiva',22),(30,11,33,'Kubo amplía la ventaja con un disparo raso',23),(31,11,47,'Dovbyk recorta distancias',24),(32,11,68,'Aleix García empata desde el punto de penalti',25),(33,11,84,'Oyarzabal marca el gol decisivo',22),(34,12,18,'Gayà marca con un disparo lejano',16),(35,12,52,'Nico Williams empata tras jugada individual',21),(36,12,81,'Iñaki Williams culmina la remontada',20),(37,13,10,'Parejo marca de falta directa',19),(38,13,29,'Gerard Moreno amplía la ventaja',18),(39,13,60,'Oyarzabal recorta distancias',22),(40,13,88,'Kubo empata en el tramo final',23),(41,14,44,'Dovbyk marca antes del descanso',24),(42,14,73,'Nico Williams empata con un disparo cruzado',21),(43,15,25,'Kubo marca tras una gran jugada',23),(44,15,66,'Oyarzabal sentencia el partido',22),(45,16,14,'Iñaki Williams abre el marcador',20),(46,16,38,'Dovbyk empata de cabeza',24),(47,16,57,'Nico Williams marca tras una pared',21),(48,16,85,'Iñaki Williams cierra el partido',20);
/*!40000 ALTER TABLE `goles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jugadores`
--

DROP TABLE IF EXISTS `jugadores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jugadores` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `fecha_nac` date DEFAULT NULL,
  `equipo_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `equipo_id` (`equipo_id`),
  CONSTRAINT `jugadores_ibfk_1` FOREIGN KEY (`equipo_id`) REFERENCES `equipos` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jugadores`
--

LOCK TABLES `jugadores` WRITE;
/*!40000 ALTER TABLE `jugadores` DISABLE KEYS */;
INSERT INTO `jugadores` VALUES (1,'Vinícius Jr.','2000-07-12',1),(2,'Jude Bellingham','2003-06-29',1),(3,'Rodrygo Goes','2001-01-09',1),(4,'Robert Lewandowski','1988-08-21',2),(5,'Pedri','2002-11-25',2),(6,'Lamine Yamal','2007-07-13',2),(7,'Antoine Griezmann','1991-03-21',3),(8,'Álvaro Morata','1992-10-23',3),(9,'Rodrigo De Paul','1994-05-24',3),(10,'Jesús Navas','1985-11-21',4),(11,'Youssef En-Nesyri','1997-06-01',4),(12,'Ivan Rakitić','1988-03-10',4),(13,'Isco Alarcón','1992-04-21',5),(14,'Borja Iglesias','1993-01-17',5),(15,'Guido Rodríguez','1994-04-12',5),(16,'José Luis Gayà','1995-05-25',6),(17,'Hugo Duro','1999-11-10',6),(18,'Gerard Moreno','1992-04-07',7),(19,'Dani Parejo','1989-04-16',7),(20,'Iñaki Williams','1994-06-15',8),(21,'Nico Williams','2002-07-12',8),(22,'Mikel Oyarzabal','1997-04-21',9),(23,'Takefusa Kubo','2001-06-04',9),(24,'Artem Dovbyk','1997-06-21',10),(25,'Aleix García','1997-06-28',10);
/*!40000 ALTER TABLE `jugadores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partidos`
--

DROP TABLE IF EXISTS `partidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `partidos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `equipo_casa_id` int(10) unsigned DEFAULT NULL,
  `equipo_fuera_id` int(10) unsigned DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `goles_casa` tinyint(3) unsigned DEFAULT NULL,
  `goles_fuera` tinyint(3) unsigned DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `equipo_casa_id` (`equipo_casa_id`),
  KEY `equipo_fuera_id` (`equipo_fuera_id`),
  CONSTRAINT `partidos_ibfk_1` FOREIGN KEY (`equipo_casa_id`) REFERENCES `equipos` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `partidos_ibfk_2` FOREIGN KEY (`equipo_fuera_id`) REFERENCES `equipos` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `partidos_ck` CHECK (`equipo_casa_id` <> `equipo_fuera_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partidos`
--

LOCK TABLES `partidos` WRITE;
/*!40000 ALTER TABLE `partidos` DISABLE KEYS */;
INSERT INTO `partidos` VALUES (1,1,2,'2024-02-18 20:00:00',2,1,'Clásico con gol decisivo de Bellingham'),(2,3,4,'2024-03-02 17:30:00',1,0,'Victoria ajustada del Atlético'),(3,2,4,'2024-03-10 19:00:00',2,2,'Empate en un partido con muchas ocasiones'),(4,1,3,'2024-03-15 20:00:00',3,1,'El Madrid se impone con doblete de Vinícius'),(5,5,1,'2024-04-05 19:00:00',1,3,'El Madrid se impone con autoridad en el Villamarín'),(6,5,3,'2024-04-12 16:30:00',2,2,'Partido vibrante con empate final'),(7,6,7,'2024-04-20 16:30:00',1,1,'Empate muy disputado en Mestalla'),(8,8,9,'2024-04-21 19:00:00',2,0,'Gran partido del Athletic en San Mamés'),(9,10,6,'2024-04-22 18:00:00',2,1,'Victoria trabajada del Girona en Montilivi'),(10,7,8,'2024-04-23 17:00:00',0,1,'Athletic gana por la mínima como visitante'),(11,9,10,'2024-04-24 19:00:00',3,2,'Partido muy abierto con final ajustado'),(12,6,8,'2024-04-26 16:30:00',1,2,'Remontada del Athletic en la segunda parte'),(13,7,9,'2024-04-27 19:00:00',2,2,'Empate con alternativas para ambos equipos'),(14,10,8,'2024-04-28 14:15:00',1,1,'Reparto de puntos en un duelo intenso'),(15,6,9,'2024-04-29 18:00:00',0,2,'La Real se impone con solvencia fuera de casa'),(16,8,10,'2024-04-30 19:00:00',3,1,'Victoria clara del Athletic ante su afición');
/*!40000 ALTER TABLE `partidos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-21 10:12:24
