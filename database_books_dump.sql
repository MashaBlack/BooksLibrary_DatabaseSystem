CREATE DATABASE  IF NOT EXISTS `books` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `books`;
-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: books
-- ------------------------------------------------------
-- Server version	8.0.26

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
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `author` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `second_name` varchar(45) NOT NULL,
  `patronymic` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES (1,'Ray','Bradbury',''),(2,'Alexander','Pushkin','Sergeevich'),(4,'Mikhail','Bulgakov','Afanasevich'),(12,'Nikolai','Gogol','Vasilyevich'),(13,'Mikhail','Lermontov','Yuryevich'),(14,'Stephen','King',''),(15,'Xuedong','Huang',''),(16,'Alex','Acero',''),(17,'Hsiao-Wuen','Hon',''),(23,'William','Shakespeare','');
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(150) NOT NULL,
  `genre_id` int DEFAULT NULL,
  `publishing_year` int NOT NULL,
  `publishing_house_id` int DEFAULT NULL,
  `ISBN` varchar(25) NOT NULL,
  `cover_type_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idBook_UNIQUE` (`id`),
  UNIQUE KEY `ISBN_UNIQUE` (`ISBN`),
  KEY `book_genre_id_fk_idx` (`genre_id`),
  KEY `book_publishing_house_id_fk_idx` (`publishing_house_id`),
  KEY `book_cover_type_id_fk_idx` (`cover_type_id`),
  CONSTRAINT `book_cover_type_fk` FOREIGN KEY (`cover_type_id`) REFERENCES `book_cover_type` (`id`) ON DELETE SET NULL,
  CONSTRAINT `book_genre_id_fk` FOREIGN KEY (`genre_id`) REFERENCES `genre` (`id`) ON DELETE SET NULL,
  CONSTRAINT `book_publishing_house_id_fk` FOREIGN KEY (`publishing_house_id`) REFERENCES `publishing_house` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES (1,'Fahrenheit 451',7,2019,4,'978-5-17-088216-8',1),(2,'Eugene Onegin',3,2015,4,'978-5-17-093121-7',2),(3,'Hamlet',8,2020,5,'978-5-389-06475-1',2),(5,'The Queen of Spades',6,2021,4,'978-5-17-105782-4',2),(24,'Romeo and Juliet',8,2020,4,'978-5-17-121600-9',2),(26,'The Bronze Horseman',10,2018,2,'978-5-9925-1341-7',2),(36,'The Mist',9,2021,9,'978-1-52-937931-0',2),(37,'Spoken language processing: a guide to theory, algorithm, and system development',13,2001,10,'0-13-022616-5',2),(38,'A Hero of Our Time',3,2017,4,' 978-5-9925-1254-0',2);
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_author`
--

DROP TABLE IF EXISTS `book_author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_author` (
  `id` int NOT NULL AUTO_INCREMENT,
  `book_id` int NOT NULL,
  `author_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `id_idx` (`book_id`),
  KEY `author_book_author_id_fk_idx` (`author_id`),
  CONSTRAINT `author_book_author_id_fk` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`) ON DELETE CASCADE,
  CONSTRAINT `author_book_book_id_fk` FOREIGN KEY (`book_id`) REFERENCES `book` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_author`
--

LOCK TABLES `book_author` WRITE;
/*!40000 ALTER TABLE `book_author` DISABLE KEYS */;
INSERT INTO `book_author` VALUES (1,1,1),(3,2,2),(4,5,2),(32,26,2),(34,36,14),(35,37,15),(36,37,16),(37,37,17),(40,38,13),(51,24,23),(52,3,23);
/*!40000 ALTER TABLE `book_author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_cover_type`
--

DROP TABLE IF EXISTS `book_cover_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_cover_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cover_type` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `cover_type_UNIQUE` (`cover_type`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_cover_type`
--

LOCK TABLES `book_cover_type` WRITE;
/*!40000 ALTER TABLE `book_cover_type` DISABLE KEYS */;
INSERT INTO `book_cover_type` VALUES (1,'hardcover'),(2,'paperback');
/*!40000 ALTER TABLE `book_cover_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genre`
--

DROP TABLE IF EXISTS `genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genre` (
  `id` int NOT NULL AUTO_INCREMENT,
  `genre_name` varchar(25) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Id_UNIQUE` (`id`),
  UNIQUE KEY `Genre name_UNIQUE` (`genre_name`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genre`
--

LOCK TABLES `genre` WRITE;
/*!40000 ALTER TABLE `genre` DISABLE KEYS */;
INSERT INTO `genre` VALUES (4,'adventure'),(2,'detective'),(7,'dystopian novel'),(5,'fantastic'),(1,'fantasy'),(9,'horror'),(11,'love story'),(3,'novel'),(6,'novella'),(10,'poem'),(13,'scientific journalistic'),(8,'tragedy');
/*!40000 ALTER TABLE `genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publishing_house`
--

DROP TABLE IF EXISTS `publishing_house`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publishing_house` (
  `id` int NOT NULL AUTO_INCREMENT,
  `publishing_name` varchar(65) NOT NULL,
  `phone` varchar(12) NOT NULL,
  `email` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Id_UNIQUE` (`id`),
  UNIQUE KEY `Publishing_name_UNIQUE` (`publishing_name`),
  UNIQUE KEY `Phone_UNIQUE` (`phone`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publishing_house`
--

LOCK TABLES `publishing_house` WRITE;
/*!40000 ALTER TABLE `publishing_house` DISABLE KEYS */;
INSERT INTO `publishing_house` VALUES (1,'ROSMAN','84959337070','rosman@rosman.ru'),(2,'Litera','88124413648','sales@litera.spb.ru'),(3,'Drofa','84957950550','drofa@drofa.msk.ru'),(4,'AST','84952321625','zakaz@ast.ru'),(5,'Azbooka','88123270455','main@azbooka.spb.ru'),(7,'Eksmo','84954116886','info@eksmo.ru'),(9,'HODDER & STOUGHTON','442031226000','enquiries@hachette.co.uk'),(10,'PrenticeoHall PTR','8003823419','corpsales@prenhall.com');
/*!40000 ALTER TABLE `publishing_house` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-12-10 22:13:02
