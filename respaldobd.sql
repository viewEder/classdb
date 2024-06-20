CREATE DATABASE  IF NOT EXISTS `tickets` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `tickets`;
-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: tickets
-- ------------------------------------------------------
-- Server version	8.0.37-0ubuntu0.22.04.3

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
-- Table structure for table `detalle_solicitud`
--

DROP TABLE IF EXISTS `detalle_solicitud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_solicitud` (
  `iddetalle_solicitud` int NOT NULL AUTO_INCREMENT,
  `observacion` mediumtext NOT NULL,
  `creado` datetime NOT NULL,
  `modificado` datetime NOT NULL,
  `idsolicitud` int NOT NULL,
  `responsable` int NOT NULL,
  PRIMARY KEY (`iddetalle_solicitud`,`idsolicitud`,`responsable`),
  KEY `fk_detalle_solicitud_solicitud1_idx` (`idsolicitud`),
  KEY `fk_detalle_solicitud_usuarios1_idx` (`responsable`),
  CONSTRAINT `fk_detalle_solicitud_solicitud1` FOREIGN KEY (`idsolicitud`) REFERENCES `solicitud` (`idsolicitud`),
  CONSTRAINT `fk_detalle_solicitud_usuarios1` FOREIGN KEY (`responsable`) REFERENCES `usuarios` (`idusuarios`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_solicitud`
--

LOCK TABLES `detalle_solicitud` WRITE;
/*!40000 ALTER TABLE `detalle_solicitud` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_solicitud` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado_solicitud`
--

DROP TABLE IF EXISTS `estado_solicitud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estado_solicitud` (
  `idestado_solicitud` int NOT NULL AUTO_INCREMENT,
  `nombre_estado` varchar(45) NOT NULL,
  PRIMARY KEY (`idestado_solicitud`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_solicitud`
--

LOCK TABLES `estado_solicitud` WRITE;
/*!40000 ALTER TABLE `estado_solicitud` DISABLE KEYS */;
INSERT INTO `estado_solicitud` VALUES (1,'Abierto'),(2,'En Progreso'),(3,'En Pausa'),(4,'Resuelto');
/*!40000 ALTER TABLE `estado_solicitud` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupos`
--

DROP TABLE IF EXISTS `grupos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grupos` (
  `idgrupos` int NOT NULL AUTO_INCREMENT,
  `nombre_grupo` varchar(45) NOT NULL,
  `creado` datetime NOT NULL,
  `modificado` datetime NOT NULL,
  PRIMARY KEY (`idgrupos`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupos`
--

LOCK TABLES `grupos` WRITE;
/*!40000 ALTER TABLE `grupos` DISABLE KEYS */;
INSERT INTO `grupos` VALUES (1,'Gerencia','2024-06-19 22:41:38','2024-06-19 22:41:38'),(2,'Coordinación','2024-06-19 22:41:38','2024-06-19 22:41:38'),(3,'Operación','2024-06-19 22:41:38','2024-06-19 22:41:38'),(4,'Infraestructura','2024-06-19 22:41:38','2024-06-19 22:41:38'),(5,'Soluciones 1er Nivel','2024-06-19 22:41:38','2024-06-19 22:41:38'),(6,'Soluciones 2do Nivel','2024-06-19 22:41:38','2024-06-19 22:41:38'),(7,'Análisis y Soluciones','2024-06-19 22:41:38','2024-06-19 22:41:38'),(8,'Desarrollo','2024-06-19 22:41:38','2024-06-19 22:41:38'),(9,'Bases de Datos','2024-06-19 22:41:38','2024-06-19 22:41:38');
/*!40000 ALTER TABLE `grupos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `perfil`
--

DROP TABLE IF EXISTS `perfil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perfil` (
  `idperfil` int NOT NULL AUTO_INCREMENT,
  `nombre_perfil` varchar(45) NOT NULL COMMENT 'El nombre del perfil hace referencia a las actividades macro del usuario\nTecnico\nOperario\nAuxiliar\nProfesional\nDirector',
  `creado` datetime NOT NULL,
  `modificado` datetime NOT NULL,
  `idroles` int NOT NULL,
  `idusuarios` int NOT NULL,
  `idgrupos` int NOT NULL,
  PRIMARY KEY (`idperfil`,`idroles`,`idusuarios`,`idgrupos`),
  KEY `fk_perfil_roles_idx` (`idroles`),
  KEY `fk_perfil_usuarios1_idx` (`idusuarios`),
  KEY `fk_perfil_grupos1_idx` (`idgrupos`),
  CONSTRAINT `fk_perfil_grupos1` FOREIGN KEY (`idgrupos`) REFERENCES `grupos` (`idgrupos`),
  CONSTRAINT `fk_perfil_roles` FOREIGN KEY (`idroles`) REFERENCES `roles` (`idroles`),
  CONSTRAINT `fk_perfil_usuarios1` FOREIGN KEY (`idusuarios`) REFERENCES `usuarios` (`idusuarios`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perfil`
--

LOCK TABLES `perfil` WRITE;
/*!40000 ALTER TABLE `perfil` DISABLE KEYS */;
/*!40000 ALTER TABLE `perfil` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `idroles` int NOT NULL AUTO_INCREMENT,
  `nombre_rol` varchar(45) NOT NULL,
  PRIMARY KEY (`idroles`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Gerente'),(2,'Coordinador'),(3,'Operario'),(4,'Técnico');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `solicitud`
--

DROP TABLE IF EXISTS `solicitud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `solicitud` (
  `idsolicitud` int NOT NULL AUTO_INCREMENT,
  `asunto` varchar(45) NOT NULL,
  `descripcion` mediumtext NOT NULL,
  `adjunto` varchar(45) NOT NULL,
  `creado` datetime NOT NULL,
  `modificado` datetime NOT NULL,
  `idtipo_solicitud` int NOT NULL,
  `idestado_solicitud` int NOT NULL,
  `solicitante` int NOT NULL,
  PRIMARY KEY (`idsolicitud`,`idtipo_solicitud`,`idestado_solicitud`,`solicitante`),
  KEY `fk_solicitud_tipo_solicitud1_idx` (`idtipo_solicitud`),
  KEY `fk_solicitud_estado_solicitud1_idx` (`idestado_solicitud`),
  KEY `fk_solicitud_usuarios1_idx` (`solicitante`),
  CONSTRAINT `fk_solicitud_estado_solicitud1` FOREIGN KEY (`idestado_solicitud`) REFERENCES `estado_solicitud` (`idestado_solicitud`),
  CONSTRAINT `fk_solicitud_tipo_solicitud1` FOREIGN KEY (`idtipo_solicitud`) REFERENCES `tipo_solicitud` (`idtipo_solicitud`),
  CONSTRAINT `fk_solicitud_usuarios1` FOREIGN KEY (`solicitante`) REFERENCES `usuarios` (`idusuarios`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `solicitud`
--

LOCK TABLES `solicitud` WRITE;
/*!40000 ALTER TABLE `solicitud` DISABLE KEYS */;
/*!40000 ALTER TABLE `solicitud` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_solicitud`
--

DROP TABLE IF EXISTS `tipo_solicitud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_solicitud` (
  `idtipo_solicitud` int NOT NULL AUTO_INCREMENT,
  `nombre_tipo` varchar(45) NOT NULL,
  PRIMARY KEY (`idtipo_solicitud`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_solicitud`
--

LOCK TABLES `tipo_solicitud` WRITE;
/*!40000 ALTER TABLE `tipo_solicitud` DISABLE KEYS */;
INSERT INTO `tipo_solicitud` VALUES (1,'Solicitud'),(2,'Incidente');
/*!40000 ALTER TABLE `tipo_solicitud` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `idusuarios` int NOT NULL AUTO_INCREMENT,
  `nombres` varchar(45) NOT NULL,
  `apellidos` varchar(45) NOT NULL,
  `correo` varchar(45) NOT NULL,
  `claveus` varchar(45) NOT NULL,
  `cargo` varchar(155) NOT NULL,
  `estado` tinyint NOT NULL,
  `creado` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modificado` datetime NOT NULL,
  PRIMARY KEY (`idusuarios`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Hasad','Brown','tincidunt.vehicula@yahoo.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2024-02-22 01:56:14','2023-10-13 21:17:57'),(2,'Sara','Schroeder','adipiscing@hotmail.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2024-10-13 15:05:53','2024-02-01 12:58:50'),(3,'Fredericka','Pate','vestibulum@aol.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2024-04-13 14:27:48','2025-02-21 01:11:43'),(4,'Plato','Bartlett','quisque.ac@aol.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2024-04-04 03:51:44','2024-09-16 02:26:53'),(5,'Gretchen','Clarke','velit.aliquam.nisl@google.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2024-10-11 05:56:42','2024-02-04 17:12:11'),(6,'Kitra','Shannon','sem.ut@outlook.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2024-12-25 03:57:11','2024-04-27 02:30:10'),(7,'Donovan','Johnston','porttitor.tellus.non@aol.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2023-12-29 09:26:23','2025-04-05 16:40:13'),(8,'Ivory','Montgomery','elementum.dui.quis@protonmail.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2024-05-20 04:30:52','2024-01-09 05:37:01'),(9,'Colt','Hahn','orci.luctus.et@icloud.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2025-05-19 16:46:21','2024-08-28 12:38:22'),(10,'Fay','Cooley','ipsum.primis@aol.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2023-06-30 08:43:49','2024-10-23 07:19:06'),(11,'Florence','Marshall','sem.nulla.interdum@aol.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2024-12-12 04:18:44','2023-07-31 09:42:29'),(12,'Angela','Merrill','nisi.aenean.eget@icloud.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2024-12-09 02:20:05','2024-03-22 10:53:05'),(13,'Bradley','Valdez','enim.commodo@google.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2024-02-06 20:00:44','2024-02-05 05:39:57'),(14,'Francesca','Parker','rhoncus.nullam@icloud.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2024-12-02 20:07:38','2024-02-13 08:59:07'),(15,'Leah','Lancaster','neque.nullam@aol.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2023-06-25 05:27:50','2023-09-28 01:49:42'),(16,'Cyrus','Emerson','elit.nulla@outlook.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2023-12-25 23:09:53','2024-04-16 14:50:23'),(17,'Pascale','Pollard','ultrices@google.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2023-11-07 20:02:53','2023-06-21 13:35:24'),(18,'Lillith','Hardy','vitae.erat@yahoo.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2025-04-28 12:54:36','2023-09-02 04:59:27'),(19,'Ora','Johns','non.egestas@protonmail.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2024-06-28 06:46:55','2025-02-11 17:08:44'),(20,'Chaney','Larson','tincidunt.dui@hotmail.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2023-09-04 03:34:55','2025-01-07 20:34:25'),(21,'Adrian','Cole','nibh.phasellus.nulla@icloud.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2023-12-24 10:58:09','2023-08-24 02:49:00'),(22,'Libby','Austin','vivamus.nibh.dolor@outlook.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2025-04-21 08:44:49','2024-09-01 21:09:44'),(23,'Perry','Flores','donec@yahoo.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2024-05-15 06:32:48','2024-11-04 23:30:49'),(24,'Acton','Cortez','rutrum.fusce@aol.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2025-02-13 02:05:20','2024-10-24 06:47:21'),(25,'Jessica','Wong','urna.suscipit.nonummy@hotmail.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2024-02-17 06:14:16','2023-12-05 00:40:39'),(26,'Kirby','Carter','quisque.porttitor@yahoo.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2024-02-06 13:05:50','2023-10-04 11:40:12'),(27,'Ingrid','Blanchard','lectus@aol.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2023-08-02 09:59:05','2024-05-17 22:06:50'),(28,'Thaddeus','Tucker','libero.at@icloud.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2024-07-19 21:23:59','2024-09-30 02:37:24'),(29,'Rhoda','Irwin','eget@icloud.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2023-10-05 20:46:28','2023-12-05 21:20:19'),(30,'Katell','Reynolds','penatibus@yahoo.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2024-07-13 16:31:20','2023-07-16 21:01:02'),(31,'Zelda','Blake','aptent.taciti.sociosqu@yahoo.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2024-01-18 07:04:53','2023-08-04 13:24:43'),(32,'Indigo','Tran','consequat.nec@google.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2025-05-01 08:40:09','2025-06-14 15:37:48'),(33,'Matthew','Dunn','lectus.nullam@protonmail.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2024-06-23 20:17:48','2025-01-04 19:04:45'),(34,'William','Jackson','malesuada.id@hotmail.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2025-05-19 17:56:52','2023-12-03 00:29:39'),(35,'Lisandra','Patton','suspendisse@aol.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2024-09-28 17:49:41','2024-06-03 11:22:02'),(36,'Cheyenne','Sexton','mi.enim.condimentum@hotmail.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2024-10-16 19:02:48','2025-04-29 15:02:27'),(37,'Hedwig','Clay','est.ac@hotmail.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2023-06-27 13:06:46','2023-10-27 11:04:52'),(38,'Quinlan','Velez','nisi.cum@google.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2024-05-09 01:27:26','2025-04-15 18:44:09'),(39,'Bruno','Christensen','pellentesque.habitant@aol.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2023-08-02 03:04:45','2024-01-18 08:25:33'),(40,'Isadora','Gardner','neque.nullam@protonmail.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2025-01-16 00:02:00','2024-05-01 17:11:41'),(41,'Hiram','Gillespie','dictum@yahoo.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2023-07-17 14:18:25','2023-10-31 15:57:33'),(42,'Justina','Fleming','risus.a@yahoo.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2025-01-03 17:33:12','2024-01-18 14:01:06'),(43,'Myles','Ramirez','fusce@hotmail.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2024-09-20 17:20:57','2024-02-03 18:00:36'),(44,'Dominic','Rich','quis@icloud.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2024-03-24 11:22:54','2025-03-01 09:57:21'),(45,'Debra','Powers','enim@hotmail.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2024-10-19 11:42:36','2024-06-28 14:15:20'),(46,'Leo','Parks','a.mi@google.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2023-11-03 10:55:09','2023-12-27 14:44:59'),(47,'Kelsey','Ferguson','libero@google.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2024-04-04 11:31:24','2024-07-14 09:10:57'),(48,'Henry','Franklin','erat.etiam@google.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2025-04-12 07:07:50','2024-08-16 17:23:44'),(49,'Amena','Dotson','dolor@outlook.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2024-03-07 02:49:14','2024-09-05 04:35:00'),(50,'Eric','Castillo','porttitor@protonmail.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2023-08-15 23:28:09','2024-04-25 00:08:00'),(51,'Kerry','Cook','cum.sociis@icloud.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2025-04-24 02:38:49','2025-03-30 21:11:51'),(52,'Kadeem','Shaw','porttitor@aol.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2023-11-14 05:56:33','2025-04-02 06:49:33'),(53,'Oscar','Yates','id@google.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2023-06-20 19:18:06','2025-05-29 04:37:18'),(54,'Donna','Reese','ante.vivamus.non@google.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2025-05-28 21:33:32','2024-07-24 21:47:19'),(55,'Sarah','Luna','condimentum.eget@outlook.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2024-01-26 08:59:59','2024-07-20 20:56:44'),(56,'Stuart','Park','et@icloud.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2024-05-30 08:52:05','2023-10-21 12:29:51'),(57,'Lawrence','Hodges','sem.ut@aol.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2025-01-09 19:25:20','2023-11-25 09:31:22'),(58,'Graham','Randall','magnis.dis@google.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2024-09-20 17:29:00','2024-12-10 19:09:41'),(59,'Yardley','Mcgowan','feugiat.metus@hotmail.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2025-05-27 05:55:20','2025-04-08 06:36:40'),(60,'Basil','Wooten','mauris@outlook.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2024-05-31 14:50:44','2024-06-30 14:24:45'),(61,'Karleigh','Mosley','ante.iaculis@aol.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2023-07-10 10:31:39','2023-09-09 11:42:08'),(62,'Reuben','Pollard','quis@outlook.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2025-05-20 02:48:04','2024-10-30 01:21:46'),(63,'Rana','Cooper','magna.praesent@protonmail.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2024-01-23 06:29:50','2025-05-20 15:29:55'),(64,'Jayme','Howard','venenatis@icloud.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2024-04-20 18:22:47','2024-02-10 21:41:01'),(65,'Rafael','Clarke','sit@hotmail.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2025-03-31 06:47:58','2024-04-07 20:18:19'),(66,'Keelie','Martin','cras.vulputate@icloud.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2025-06-09 08:00:25','2024-09-21 02:10:30'),(67,'Bert','Gamble','nec@hotmail.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2024-02-24 18:00:01','2023-09-29 10:07:52'),(68,'Murphy','Stuart','tellus@hotmail.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2023-12-15 00:06:56','2024-12-30 17:50:02'),(69,'Gareth','Oneal','mauris.vel@yahoo.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2025-05-15 02:49:03','2025-05-22 12:53:38'),(70,'Tad','Mcclain','quisque.ac.libero@outlook.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2023-12-26 19:20:40','2024-05-25 21:04:37'),(71,'Nash','Kaufman','sed.leo@protonmail.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2024-06-24 08:51:04','2024-06-17 08:47:36'),(72,'Lana','Vazquez','magna.suspendisse@protonmail.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2025-05-13 22:04:53','2025-04-19 01:06:16'),(73,'Jordan','House','magna@protonmail.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2023-08-10 10:17:35','2024-02-24 01:48:21'),(74,'Lacy','Estes','eu@hotmail.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2024-08-16 03:32:00','2023-07-29 14:04:43'),(75,'Adrienne','Gutierrez','fringilla.est@outlook.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2025-06-06 01:26:35','2023-12-12 03:06:16'),(76,'May','Peters','diam.pellentesque@google.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2024-08-08 15:43:24','2023-07-01 15:26:28'),(77,'Abdul','Guerra','consequat.purus@outlook.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2024-02-09 02:51:35','2023-08-03 06:16:01'),(78,'Vivian','Bond','urna@yahoo.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2025-01-08 16:13:10','2024-05-25 23:33:04'),(79,'Kane','Ortiz','euismod@hotmail.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2023-09-11 05:47:16','2024-05-25 14:26:00'),(80,'Simone','Jacobson','sit.amet@aol.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2023-08-17 11:46:54','2024-10-02 12:46:48'),(81,'Iola','Lawrence','bibendum@icloud.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2024-11-29 05:44:24','2024-10-12 01:03:18'),(82,'Amir','Quinn','cum.sociis@hotmail.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2025-05-22 06:28:40','2023-08-16 03:05:25'),(83,'Kelsie','Petty','ipsum@yahoo.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2024-05-15 02:25:40','2024-03-18 05:16:05'),(84,'Keith','Vang','tellus.faucibus@icloud.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2024-05-16 12:58:31','2024-12-15 10:23:45'),(85,'Dustin','Galloway','cras@yahoo.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2024-08-30 04:51:34','2023-12-04 03:44:13'),(86,'India','Gill','nunc.est@aol.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2023-06-29 11:48:45','2024-01-03 01:24:46'),(87,'Elaine','Dale','nonummy@yahoo.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2023-09-26 20:31:32','2024-08-26 02:18:27'),(88,'Audrey','Soto','nunc.mauris@yahoo.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2023-12-24 07:11:57','2024-04-25 05:43:08'),(89,'Steel','Myers','nec.mauris@aol.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2024-03-11 15:04:21','2024-04-21 22:35:16'),(90,'Mohammad','Berry','in.faucibus@aol.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2024-01-26 21:09:57','2024-10-09 02:01:19'),(91,'Timothy','Reese','sem@aol.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2023-10-15 10:36:55','2024-05-21 03:52:48'),(92,'Sacha','Dalton','magna.praesent@protonmail.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2025-04-03 10:46:43','2023-06-29 17:57:18'),(93,'Justine','George','aliquam.adipiscing.lacus@protonmail.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2023-07-16 01:37:27','2024-04-04 16:10:01'),(94,'Dieter','Valencia','lobortis.quis@hotmail.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2025-06-12 17:10:59','2024-03-04 03:50:29'),(95,'Trevor','Shaw','fusce.mi@google.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2025-04-19 22:10:08','2024-06-21 03:44:38'),(96,'Amos','Jordan','scelerisque.mollis.phasellus@aol.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2025-05-07 21:31:51','2024-09-03 11:19:15'),(97,'Olivia','Floyd','malesuada.fringilla.est@protonmail.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',0,'2024-06-09 10:20:11','2024-10-14 14:14:09'),(98,'Kay','Morris','penatibus@google.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2023-09-18 13:43:17','2024-05-30 01:36:24'),(99,'Shea','Spears','euismod@yahoo.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2023-10-04 07:07:01','2023-06-29 10:35:26'),(100,'Nicole','Dean','eu.sem.pellentesque@hotmail.com','43deffec4949f1dbedd391d58057240f749b0070','Empleado',1,'2024-10-30 21:35:59','2024-02-04 01:16:19');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'tickets'
--

--
-- Dumping routines for database 'tickets'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-19 22:45:05
