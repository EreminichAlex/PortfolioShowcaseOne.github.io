-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: web_portfolio_db
-- ------------------------------------------------------
-- Server version	8.3.0

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
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact` (
  `contact_id` int NOT NULL AUTO_INCREMENT,
  `portfolio_id` int NOT NULL,
  `link` varchar(255) NOT NULL,
  `link_name` varchar(30) NOT NULL,
  PRIMARY KEY (`contact_id`),
  KEY `contact_ibfk_1` (`portfolio_id`),
  CONSTRAINT `contact_ibfk_1` FOREIGN KEY (`portfolio_id`) REFERENCES `portfolio` (`portfolio_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact`
--

LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
INSERT INTO `contact` VALUES (16,22,'https://www.youtube.com/@ScenicRelaxationFilms','youtube channel');
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portfolio`
--

DROP TABLE IF EXISTS `portfolio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `portfolio` (
  `portfolio_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `portfolio_name` varchar(70) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` text,
  `avatar_path` varchar(255) DEFAULT NULL,
  `background_color` varchar(255) DEFAULT '#CCCCCC',
  `background_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`portfolio_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `fk_portfolio_userId` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portfolio`
--

LOCK TABLES `portfolio` WRITE;
/*!40000 ALTER TABLE `portfolio` DISABLE KEYS */;
INSERT INTO `portfolio` VALUES (22,7,'порт','123123123asd','Описание для портфолио',NULL,'#e0e0e0','ufsosLihlh.jpg'),(23,7,'для презентации','имя фамилия','описание',NULL,'#CCCCCC','7QmqUW34N2.jpg'),(24,1,'portfoliyka','sasha','',NULL,'#CCCCCC',NULL);
/*!40000 ALTER TABLE `portfolio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sections` (
  `id` int NOT NULL AUTO_INCREMENT,
  `portfolio_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `portfolio_id` (`portfolio_id`),
  CONSTRAINT `sections_ibfk_1` FOREIGN KEY (`portfolio_id`) REFERENCES `portfolio` (`portfolio_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
INSERT INTO `sections` VALUES (36,22,'Изображения'),(37,22,'Видеоролики'),(38,22,'Текстовые документы'),(39,23,'изображения ');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `nickname` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `avatar_path` varchar(255) DEFAULT NULL,
  `refresh_token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin01','alexxandr343@gmail.com','$2a$10$vH3M.ai.wuxxDGwJOrKoSuSClcp4.RBfyhfHrtkbWYzXQTP2wdZES',NULL,'P6CrwL2q8f.jpg',NULL),(2,'admin01','alexxandr343@gmail.com','$2a$10$k91Z0UNVTDGAvT2MzMmxROJoPwNnx/xmVNKwPRBbA4ujQtP8VB3vK',NULL,NULL,NULL),(3,'admin01','alexxandr343@gmail.com','$2a$10$MRKWT8WfSeCcYQ4Y/7z3dOTo.PerC/4obG2RVJMvhDikvUn9r2nkO',NULL,NULL,NULL),(4,'admin01','alexxandr343@gmail.com','$2a$10$Ns6aE7/QsTus.CYPVQ5kbecq1Fxo0hiR40zq7mNWyXRJy4cNOSBt.',NULL,NULL,NULL),(5,'admin02','alexxandr343@gmail.com','$2a$10$GkiaGyGU6VLgHFdJWz6LfepLymxMwQ/oguda/cwGINvhTSjBy0/NC',NULL,NULL,NULL),(6,'admin03','alexxandr343@gmail.com','$2a$10$cwwT3wAuJr/wz1MCvCw0p.GAWmVFPb6wQlziMOCLPFAQ7.lzejWSe',NULL,NULL,NULL),(7,'admin04','alexxandr343@gmail.com','$2a$10$sewPjshA5qBpt9ClNz9tIeKykqtTQ4xm.xH.6gEAVbUkx2tFZHngO',NULL,'cVjqGMz5Mr.png',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `work`
--

DROP TABLE IF EXISTS `work`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `work` (
  `work_id` int NOT NULL AUTO_INCREMENT,
  `portfolio_id` int NOT NULL,
  `section_id` int DEFAULT NULL,
  `work_name` varchar(160) NOT NULL,
  `description` text,
  `link` varchar(255) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`work_id`),
  KEY `fk_child_parent` (`section_id`),
  CONSTRAINT `fk_child_parent` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work`
--

LOCK TABLES `work` WRITE;
/*!40000 ALTER TABLE `work` DISABLE KEYS */;
INSERT INTO `work` VALUES (62,22,36,'работа 1 ','','','Rw2LoUHsj8.jpg'),(63,22,36,'изображение 2','','','VArOYUOEZU.jpg'),(64,22,36,'Изображение 3','','','U09ynKtbbC.jpg'),(65,22,36,'изображение 4','','','VBHXOiCPzB.jpg'),(71,22,38,'txt 3','','','vOhWFKakq8.txt'),(72,22,37,'Видеоролик #1','','https://www.youtube.com/watch?v=CxwJrzEdw1U','dCmRipqBFI.jpg'),(74,22,37,'Видеоролик 2','','https://www.youtube.com/watch?v=y13JsbpHaT4','GCNimZaRJV.jpg'),(75,23,36,'Изображение #1','','','EDSLXYjSmq.jpg'),(76,23,39,'Изображение #1','','','mCSe6jUDpz.jpg'),(77,23,39,'Изображение #2','','','UpufT3lV6C.jpg'),(78,23,39,'Изображение #3','','','GyrQcuBCPF.jpg');
/*!40000 ALTER TABLE `work` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-18 22:15:53
