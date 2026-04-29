-- MariaDB dump 10.19  Distrib 10.4.27-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: futbol2023
-- ------------------------------------------------------
-- Server version	10.4.27-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Create Data Base Futbol203
--
DROP DATABASE IF EXISTS futbol2023;
CREATE DATABASE IF NOT EXISTS futbol2023;
USE futbol2023;

--
-- Table structure for table `clasificacion`
--

DROP TABLE IF EXISTS `clasificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clasificacion` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `equipo_id` int(10) unsigned DEFAULT NULL,
  `goles_favor` tinyint(3) unsigned DEFAULT NULL,
  `goles_contra` tinyint(3) unsigned DEFAULT NULL,
  `dif_goles` tinyint(4) DEFAULT NULL,
  `partidos_ganados` tinyint(3) unsigned DEFAULT NULL,
  `partidos_perdidos` tinyint(3) unsigned DEFAULT NULL,
  `partidos_empatados` tinyint(3) unsigned DEFAULT NULL,
  `partidos_jugados` tinyint(3) unsigned DEFAULT NULL,
  `puntos` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `equipo_id` (`equipo_id`),
  CONSTRAINT `clasificacion_ibfk_1` FOREIGN KEY (`equipo_id`) REFERENCES `equipos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clasificacion`
--

LOCK TABLES `clasificacion` WRITE;
/*!40000 ALTER TABLE `clasificacion` DISABLE KEYS */;
INSERT INTO `clasificacion` VALUES (1,1,0,0,0,0,0,0,0,0),(2,2,0,0,0,0,0,0,0,0),(3,3,0,0,0,0,0,0,0,0),(4,4,0,0,0,0,0,0,0,0),(5,5,0,0,0,0,0,0,0,0),(6,6,0,0,0,0,0,0,0,0);
/*!40000 ALTER TABLE `clasificacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipos`
--

DROP TABLE IF EXISTS `equipos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `equipos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `estadio` varchar(50) NOT NULL,
  `aforo` int(6) DEFAULT NULL,
  `fundacion` int(4) unsigned DEFAULT NULL,
  `ciudad` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipos`
--

LOCK TABLES `equipos` WRITE;
/*!40000 ALTER TABLE `equipos` DISABLE KEYS */;
INSERT INTO `equipos` VALUES (1,'Real Madrid','Santiago Bernabeu',81044,1902,'Madrid'),(2,'Barcelona','Nou Camp',99354,1899,'Barcelona'),(3,'At. Madrid','Wanda Metropolitano ',68476,1903,'Madrid'),(4,'Valencia','Mestalla',48600,1919,'Valencia'),(5,'Sevilla','Ramón Sánchez-Pizjuán',43883,1890,'Sevilla'),(6,'Betis','Benito Villamarín',60721,1907,'Sevilla');
/*!40000 ALTER TABLE `equipos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estadisticas`
--

DROP TABLE IF EXISTS `estadisticas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estadisticas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `jugador_id` int(10) unsigned DEFAULT NULL,
  `goles` tinyint(3) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `jugador_id` (`jugador_id`),
  CONSTRAINT `estadisticas_ibfk_1` FOREIGN KEY (`jugador_id`) REFERENCES `jugadores` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estadisticas`
--

LOCK TABLES `estadisticas` WRITE;
/*!40000 ALTER TABLE `estadisticas` DISABLE KEYS */;
INSERT INTO `estadisticas` VALUES (1,1,0),(2,2,0),(3,3,0),(4,4,0),(5,5,0),(6,6,0),(7,7,0),(8,8,0),(9,9,0),(10,10,0),(11,11,0),(12,12,0),(13,13,0),(14,14,0),(15,15,0),(16,16,0),(17,17,0),(18,18,0),(19,19,0),(20,20,0),(21,21,0),(22,22,0),(23,23,0),(24,24,0),(25,25,0),(26,26,0),(27,27,0),(28,28,0),(29,29,0),(30,30,0),(31,31,0),(32,32,0),(33,33,0),(34,34,0),(35,35,0),(36,36,0),(37,37,0),(38,38,0),(39,39,0),(40,40,0),(41,41,0),(42,42,0),(43,43,0),(44,44,0);
/*!40000 ALTER TABLE `estadisticas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goles`
--

DROP TABLE IF EXISTS `goles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `goles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `partido_id` int(10) unsigned DEFAULT NULL,
  `minuto` tinyint(3) unsigned DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `jugador_id` int(10) unsigned DEFAULT NULL,
  `goles_casa` tinyint(3) unsigned DEFAULT NULL,
  `goles_fuera` tinyint(3) unsigned DEFAULT NULL,
  `equipo_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `partido_id` (`partido_id`),
  KEY `jugador_id` (`jugador_id`),
  KEY `equipo_id` (`equipo_id`),
  CONSTRAINT `goles_ibfk_1` FOREIGN KEY (`partido_id`) REFERENCES `partidos` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `goles_ibfk_2` FOREIGN KEY (`jugador_id`) REFERENCES `jugadores` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `goles_ibfk_3` FOREIGN KEY (`equipo_id`) REFERENCES `equipos` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goles`
--

LOCK TABLES `goles` WRITE;
/*!40000 ALTER TABLE `goles` DISABLE KEYS */;
INSERT INTO `goles` VALUES (1,1,9,'Golazo de cabeza',3,1,0,1),(2,1,19,'Carambola',11,1,1,2),(3,1,45,'Zurdazo impresionantes',11,1,2,2),(4,1,90,'De penalti',8,2,2,1),(5,2,9,'Golazo de cabeza',20,1,0,3),(6,2,19,'Carambola',26,2,0,3),(7,2,45,'Zurdazo impresionantes',25,3,0,3),(8,3,9,'Golazo de cabeza',38,0,1,6),(9,3,19,'Carambola',40,0,2,6),(10,3,45,'Zurdazo impresionantes',42,0,3,6),(11,4,9,'Golazo de cabeza',4,1,0,1),(12,4,19,'Carambola',8,2,0,1),(13,5,9,'Golazo de cabeza',11,1,0,2),(14,5,19,'Carambola',17,2,0,2),(15,5,45,'Carambola',16,3,0,2),(16,5,65,'Centro y remate',26,3,1,4),(17,6,9,'Golazo de cabeza',20,1,0,3),(18,7,30,'Golazo de cabeza',12,1,0,2),(19,7,32,'Carambola',17,13,2,2),(20,7,55,'Carambola',21,2,1,3),(21,8,13,'Golazo de cabeza',28,1,0,4),(22,8,20,'Carambola',29,2,0,4),(23,8,65,'Carambola',31,2,1,5),(24,8,90,'Centro y remate',34,2,2,5),(25,9,13,'Golazo de cabeza',11,1,0,2),(26,9,20,'Carambola',21,1,1,3),(27,9,65,'Carambola',22,1,2,3);
/*!40000 ALTER TABLE `goles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jugadores`
--

DROP TABLE IF EXISTS `jugadores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jugadores` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `puesto` varchar(50) DEFAULT NULL,
  `fecha_nac` date DEFAULT NULL,
  `nacionalidad` varchar(40) DEFAULT NULL,
  `equipo_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `equipo_id` (`equipo_id`),
  CONSTRAINT `jugadores_ibfk_1` FOREIGN KEY (`equipo_id`) REFERENCES `equipos` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jugadores`
--

LOCK TABLES `jugadores` WRITE;
/*!40000 ALTER TABLE `jugadores` DISABLE KEYS */;
INSERT INTO `jugadores` VALUES (1,'Thibaut Courtois','Portero','1962-05-11','Bélgica',1),(2,'Dani Carvajal','Defensa','1992-04-01','España',1),(3,'Sergio Ramos','Defensa','1990-02-02','España',1),(4,'Raphael Varane','Defensa','1995-01-05','Francia',1),(5,'Toni Kroos','Centrocampista','1990-05-02','Alemania',1),(6,'Marco Asensio','Delantero','1998-05-03','España',1),(7,'Rodrygo Goes','Delantero','2000-11-01','Brasil',1),(8,'Vinicius','Delantero','2000-03-12','Brasil',1),(9,'Éder Militão','Defensa','1999-11-03','Brasil',1),(10,'Lionel Messi','Delantero','1987-04-01','Argentina',2),(11,'Gerard Piqué','Defensa','1987-02-02','España',2),(12,'Sergio Busquets','Centrocampista','1988-01-05','España',2),(13,'Jordi Alba','Defensa','1989-05-02','España',2),(14,'Frenkie de Jong','Centrocampista','1997-05-03','Holanda',2),(15,'Pedri','Centrocampista','2002-11-01','España',2),(16,'Ousmane Dembélé','Delantero','1997-03-12','Francia',2),(17,'Marc-André ter Stegen','Portero','1992-11-03','Alemania',2),(18,'Jan Oblak','Portero','1993-05-03','Eslovenia',3),(19,'José María Giménez','Defensa','1995-11-01','México',3),(20,'Mario Hermoso','Defensa','1195-03-12','España',3),(21,'Marcos Llorente ','Centrocampista','1995-11-03','España',3),(22,'Koke ','Centrocampista ','1992-11-01','España',3),(23,'Saúl Ñíguez','Centrocampista','1994-03-12','España',3),(24,'Ángel Correa','Delantero','1987-11-03','Argentina',3),(25,'José Gayà','Defensa','1195-05-03','España',4),(26,'Toni Lato','Defensa','1997-11-01','España',4),(27,'Hugo Guillamón','Defensa','2000-03-12','España',4),(28,'Carlos Soler','Centrocampista','1997-11-03','España',4),(29,'Jasper Cillessen','Portero ','1989-11-01','Holanda',4),(30,'Yassine Bounou','Portero','1989-05-03','Marruecos',5),(31,'Jesús Navas','Delantero','1985-11-01','España',5),(32,'Joan Jordan','Centrocampista','1994-03-12','España',5),(33,'Ivan Rakitic','Centrocampista','1988-11-03','Croacia',5),(34,'Nemanja Gudelj','Defensa','1991-11-01','Serbia',5),(35,'Suso','Delantero','1993-11-01','España',5),(36,'Youssef En-Nesyri','Delantero','1997-11-01','Marruecos',5),(37,'Juan Miranda','Defensa','2000-05-03','España',6),(38,'Álex Moreno','Defensa','1993-11-01','España',6),(39,'Andrés Guardado','Centrocampista','1986-03-12','México',6),(40,'Guido Rodríguez','Centrocampista','1994-11-03','Argentina',6),(41,'William Carvalho','Centrocampista','1992-11-01','Portugal',6),(42,'Nabil Fekir','Delantero','1993-11-01','Francia',6),(43,'Sergio Canales','Delantero','1991-11-01','España',6),(44,'Joaquín ','Delantero','1981-11-01','España',6);
/*!40000 ALTER TABLE `jugadores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partidos`
--

DROP TABLE IF EXISTS `partidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partidos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `jornada` tinyint(3) unsigned DEFAULT NULL,
  `equipo_casa_id` int(10) unsigned DEFAULT NULL,
  `equipo_fuera_id` int(10) unsigned DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `goles_casa` smallint(6) DEFAULT NULL,
  `goles_fuera` smallint(6) DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `equipo_casa_id` (`equipo_casa_id`),
  KEY `equipo_fuera_id` (`equipo_fuera_id`),
  CONSTRAINT `partidos_ibfk_1` FOREIGN KEY (`equipo_casa_id`) REFERENCES `equipos` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `partidos_ibfk_2` FOREIGN KEY (`equipo_fuera_id`) REFERENCES `equipos` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `partidos_ck` CHECK (`equipo_casa_id` <> `equipo_fuera_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partidos`
--

LOCK TABLES `partidos` WRITE;
/*!40000 ALTER TABLE `partidos` DISABLE KEYS */;
INSERT INTO `partidos` VALUES (1,1,1,2,'2023-10-08 18:00:00',1,2,'Se aplazó al día siguiente'),(2,1,3,4,'2023-10-08 19:00:00',2,0,'4 penaltis para el equipo de casa'),(3,1,5,6,'2023-10-08 16:00:00',4,2,'Se inundó el vestuario de billetes de 500 €'),(4,2,1,5,'2023-10-15 17:00:00',0,2,'Las abejas no dejaron de picar al árbitro'),(5,2,2,4,'2023-10-15 18:00:00',0,0,'Un rayo se cargó la pelota'),(6,2,3,6,'2023-10-15 19:00:00',2,2,'Los jugadores estaban algo distraidos'),(7,3,1,6,'2023-10-15 17:00:00',0,2,'Las abejas no dejaron de picar al árbitro'),(8,3,4,5,'2023-10-15 18:00:00',0,0,'Un rayo se cargó la pelota'),(9,3,2,3,'2023-10-15 19:00:00',2,2,'Los jugadores estaban algo distraidos');
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

-- Dump completed on 2023-05-14 21:18:10