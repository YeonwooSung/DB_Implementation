-- MySQL dump 10.16  Distrib 10.2.19-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: ys60_cs3101
-- ------------------------------------------------------
-- Server version	10.2.19-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary table structure for view `Q1`
--

DROP TABLE IF EXISTS `Q1`;
/*!50001 DROP VIEW IF EXISTS `Q1`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `Q1` (
  `personalID` tinyint NOT NULL,
  `email_address` tinyint NOT NULL,
  `Full_Name` tinyint NOT NULL,
  `Total_Number_Of_Purchases` tinyint NOT NULL,
  `Total_Spent` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `Q2`
--

DROP TABLE IF EXISTS `Q2`;
/*!50001 DROP VIEW IF EXISTS `Q2`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `Q2` (
  `ISBN` tinyint NOT NULL,
  `title` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `Q3`
--

DROP TABLE IF EXISTS `Q3`;
/*!50001 DROP VIEW IF EXISTS `Q3`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `Q3` (
  `contributor_ID` tinyint NOT NULL,
  `Full_Name` tinyint NOT NULL,
  `Titles` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `audiobook`
--

DROP TABLE IF EXISTS `audiobook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audiobook` (
  `ISBN` varchar(20) COLLATE utf8_bin NOT NULL,
  `title` varchar(1024) COLLATE utf8_bin NOT NULL,
  `narrator_id` int(11) DEFAULT NULL,
  `running_time` time DEFAULT NULL,
  `age_rating` int(11) DEFAULT NULL,
  `purchase_price` decimal(8,2) DEFAULT NULL,
  `publisher_name` varchar(1024) COLLATE utf8_bin DEFAULT NULL,
  `published_date` date DEFAULT NULL,
  `audiofile` blob DEFAULT NULL,
  PRIMARY KEY (`ISBN`),
  KEY `narrator_id` (`narrator_id`),
  KEY `publisher_name` (`publisher_name`),
  CONSTRAINT `audiobook_ibfk_1` FOREIGN KEY (`narrator_id`) REFERENCES `person` (`ID`),
  CONSTRAINT `audiobook_ibfk_2` FOREIGN KEY (`publisher_name`) REFERENCES `publisher` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audiobook`
--

LOCK TABLES `audiobook` WRITE;
/*!40000 ALTER TABLE `audiobook` DISABLE KEYS */;
INSERT INTO `audiobook` VALUES ('860-1404211171','Fantastic Beasts and Where to Find Them',3,'01:45:00',NULL,12.00,'Pottermore Publishing','2017-03-14',NULL),('978-0099457046','Moab Is My Washpot',3,'11:33:00',12,22.00,'Random House AudioBooks','2017-01-01',NULL),('978-0393957242','Gulliver\'s Travels',4,'05:35:00',NULL,38.00,'Penguin Books Ltd','2012-05-12',NULL),('978-1408855652','Harry Potter and the Philosopher\'s Stone',3,'08:44:00',NULL,7.19,'Pottermore Publishing','2014-09-01',NULL),('978-1611749731','The Gun Seller',6,'10:45:00',16,16.00,'HighBridge Audio','2012-10-16',NULL);
/*!40000 ALTER TABLE `audiobook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audiobook_authors`
--

DROP TABLE IF EXISTS `audiobook_authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audiobook_authors` (
  `contributor_ID` int(11) NOT NULL,
  `ISBN` varchar(20) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`contributor_ID`,`ISBN`),
  KEY `ISBN` (`ISBN`),
  CONSTRAINT `audiobook_authors_ibfk_1` FOREIGN KEY (`contributor_ID`) REFERENCES `contributor` (`personalID`),
  CONSTRAINT `audiobook_authors_ibfk_2` FOREIGN KEY (`ISBN`) REFERENCES `audiobook` (`ISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audiobook_authors`
--

LOCK TABLES `audiobook_authors` WRITE;
/*!40000 ALTER TABLE `audiobook_authors` DISABLE KEYS */;
INSERT INTO `audiobook_authors` VALUES (3,'978-0099457046'),(4,'978-1611749731'),(7,'860-1404211171'),(7,'978-1408855652'),(8,'860-1404211171'),(11,'978-0393957242');
/*!40000 ALTER TABLE `audiobook_authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audiobook_purchases`
--

DROP TABLE IF EXISTS `audiobook_purchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audiobook_purchases` (
  `customer_ID` int(11) NOT NULL,
  `ISBN` varchar(20) COLLATE utf8_bin NOT NULL,
  `purchase_date` datetime NOT NULL,
  PRIMARY KEY (`customer_ID`,`ISBN`),
  KEY `ISBN` (`ISBN`),
  CONSTRAINT `audiobook_purchases_ibfk_1` FOREIGN KEY (`customer_ID`) REFERENCES `customer` (`personalID`),
  CONSTRAINT `audiobook_purchases_ibfk_2` FOREIGN KEY (`ISBN`) REFERENCES `audiobook` (`ISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audiobook_purchases`
--

LOCK TABLES `audiobook_purchases` WRITE;
/*!40000 ALTER TABLE `audiobook_purchases` DISABLE KEYS */;
INSERT INTO `audiobook_purchases` VALUES (3,'978-0099457046','2018-10-23 21:34:02'),(3,'978-1408855652','2018-10-23 21:29:48'),(4,'978-0393957242','2018-10-23 21:30:10'),(5,'978-0393957242','2018-10-23 21:35:54'),(7,'978-0393957242','2018-10-23 21:30:34'),(7,'978-1408855652','2018-10-23 21:31:08'),(9,'978-1611749731','2018-10-23 21:30:47');
/*!40000 ALTER TABLE `audiobook_purchases` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`ys60`@`%`*/ /*!50003 TRIGGER `enforceAgeRating` before insert on `audiobook_purchases`
for each row
begin
	SET @rating = 0;
	(SELECT audiobook.age_rating INTO @rating
	FROM audiobook
	where audiobook.ISBN = NEW.ISBN);

	SET @customer_age = 0;
	(SELECT timestampdiff(year,person.date_of_birth,now()) INTO @customer_age
	FROM person
	where person.ID = NEW.customer_ID);
	
    if (@rating > @customer_age) then
   	SIGNAL sqlstate '45001' set message_text = "Underaged To Buy this Audiobook";
    end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `audiobook_reviews`
--

DROP TABLE IF EXISTS `audiobook_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audiobook_reviews` (
  `customer_ID` int(11) NOT NULL,
  `ISBN` varchar(20) COLLATE utf8_bin NOT NULL,
  `rating` int(11) DEFAULT NULL,
  `title` varchar(1024) COLLATE utf8_bin DEFAULT NULL,
  `comment` varchar(1024) COLLATE utf8_bin DEFAULT NULL,
  `verified` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`customer_ID`,`ISBN`),
  KEY `ISBN` (`ISBN`),
  CONSTRAINT `audiobook_reviews_ibfk_1` FOREIGN KEY (`customer_ID`) REFERENCES `customer` (`personalID`),
  CONSTRAINT `audiobook_reviews_ibfk_2` FOREIGN KEY (`ISBN`) REFERENCES `audiobook` (`ISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audiobook_reviews`
--

LOCK TABLES `audiobook_reviews` WRITE;
/*!40000 ALTER TABLE `audiobook_reviews` DISABLE KEYS */;
INSERT INTO `audiobook_reviews` VALUES (1,'860-1404211171',4,'Fantastic Book','Loved listening to this book before bed.',0),(7,'978-1408855652',5,'Best audio book EVER!','Best audio book I ever listened to. Stephen Fry does an excellent job reading the superb prose written by a genius author.',0),(10,'860-1404211171',2,'Not as good as Harry Potter','Never read the book, seen the movie or listened to the audio book but I can tell you right now - its not as good as harry potter',0);
/*!40000 ALTER TABLE `audiobook_reviews` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`ys60`@`%`*/ /*!50003 TRIGGER `verifyBookRating` before insert on `audiobook_reviews`
for each row
begin
    if (NEW.rating > 6 OR NEW.rating < 0) then
    SIGNAL sqlstate '45001' set message_text = "The rating has to be between 1 and 5";
    end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`ys60`@`%`*/ /*!50003 TRIGGER `verifyBookReviews` before insert on `audiobook_reviews`
for each row
begin
	SET @purchased_boolean = 0;
	(SELECT COUNT(audiobook_purchases.customer_ID AND audiobook_purchases.ISBN) INTO @purchased_boolean
	FROM audiobook_purchases
	where audiobook_purchases.customer_ID = NEW.customer_ID AND audiobook_purchases.ISBN = NEW.ISBN);
	
    if (@purchased_boolean = 0) then
   	set NEW.verified = 0;
   	ELSE
   	set NEW.verified = 1;
    end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `chapter`
--

DROP TABLE IF EXISTS `chapter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chapter` (
  `ISBN` varchar(20) COLLATE utf8_bin NOT NULL,
  `number` int(11) NOT NULL,
  `title` varchar(1024) COLLATE utf8_bin DEFAULT NULL,
  `start` time DEFAULT NULL,
  PRIMARY KEY (`ISBN`,`number`),
  CONSTRAINT `chapter_ibfk_1` FOREIGN KEY (`ISBN`) REFERENCES `audiobook` (`ISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chapter`
--

LOCK TABLES `chapter` WRITE;
/*!40000 ALTER TABLE `chapter` DISABLE KEYS */;
INSERT INTO `chapter` VALUES ('978-0393957242',1,'Part I: A Voyage to Lilliput','00:00:00'),('978-0393957242',2,'Part II: A Voyage to Brobdingnag','01:40:07'),('978-0393957242',3,' Part III: A Voyage to Laputa, Balnibarbi, Luggnagg, Glubbdubdrib and Japan','03:01:09'),('978-0393957242',4,'Part IV: A Voyage to the Land of the Houyhnhnms','04:22:05'),('978-1408855652',1,'The Boy Who Lived','00:00:00'),('978-1408855652',2,'The Vanishing Glass','00:35:03'),('978-1408855652',3,'The Letters from No One','01:07:27'),('978-1408855652',4,'The Keeper of Keys','01:38:01'),('978-1408855652',5,'Diagon Alley','02:08:25'),('978-1408855652',6,' The Journey from Platform Nine and Three-Quarters','02:38:50'),('978-1408855652',7,'The Sorting Hat','03:09:43'),('978-1408855652',8,'The Potions Master','03:40:03'),('978-1408855652',9,'The Midnight Due','04:10:27'),('978-1408855652',10,'Hallowe\'en','04:40:48'),('978-1408855652',11,'Quidditch','05:11:06'),('978-1408855652',12,'The Mirror of Erised','05:32:38'),('978-1408855652',13,'Nicholas Flamel','06:11:56'),('978-1408855652',14,'Norbert the Norwegian Ridgeback','06:52:20'),('978-1408855652',15,'The Forbidden Forest','07:12:43'),('978-1408855652',16,'Through the Trapdoor','07:43:05'),('978-1408855652',17,'The Man with Two Faces','08:15:30');
/*!40000 ALTER TABLE `chapter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contributor`
--

DROP TABLE IF EXISTS `contributor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contributor` (
  `personalID` int(11) NOT NULL,
  `biography` varchar(1024) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`personalID`),
  CONSTRAINT `contributor_ibfk_1` FOREIGN KEY (`personalID`) REFERENCES `person` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contributor`
--

LOCK TABLES `contributor` WRITE;
/*!40000 ALTER TABLE `contributor` DISABLE KEYS */;
INSERT INTO `contributor` VALUES (3,'An English comedian, actor, writer, presenter, and activist.'),(4,'An English actor, musician, comedian, and writer.'),(6,'An English actor and narrator. Initially a stage actor, he has a wide-ranging career in television drama, was a game show announcer in Britain, and a voice-over narrator for television, and film. In recent years he has narrated a large number of audio books and received an Audie (Audio book Oscar) in 2010.'),(7,'After finishing the first book and whilst training as a teacher, Harry Potter was accepted for publication by Bloomsbury. Harry Potter and the Philosopher’s Stone quickly became a bestseller on publication in 1997. As the book was translated into other languages, Harry Potter started spreading round the globe – and J.K. Rowling was soon receiving thousands of letters from fans.'),(8,'Famed expert in the field of Magizoology.'),(11,'Irish author, clergyman and satirist Jonathan Swift received a bachelor\'s degree from Trinity College and then worked as a statesman\'s assistant. Eventually, he became dean of St. Patrick\'s Cathedral in Dublin.');
/*!40000 ALTER TABLE `contributor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `personalID` int(11) NOT NULL,
  `email_address` varchar(100) COLLATE utf8_bin NOT NULL,
  `pwd` varchar(150) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`personalID`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`personalID`) REFERENCES `person` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'bob_jnr@bobson.com','3106b34f512efbb6492815ecaa5063974aee43267f384e432158ede9929e6e7cb59727e3582acf467dc61d35073a004ceded6cf1ff1579687ed39a1b4bf2a024'),(2,'bob_snr@bobson.com','99a358ed95026250bbed2dccb7b9e521479bbf002c2e3a811310530b7cca1d452ce8b510a46e23ad12cf145f2b7d4eee5a4e576941e7df1f23667fcb1e7e0068'),(3,'sfry@email.com','3d5c9a88751b39a1e0c353451cd7efa149f04b5f82243267494d254edeeee284fd73ceedd019088016efe11578dd8e2f03bbab7de528b5710e7196ff90e6e502'),(4,'hugh@laurie.com','ea51d318dd454042655bb2cd03fd5a024545c5c1f9c173a7e758ff607108370057e739699193a47df8ea11580fc262e8c3481fa1fee5332b81b704101f04d10c'),(5,'ruth@letham.com','e5c03615e56e5fe13e45a194fe10601ff3d5f8afe95303b28f975a6d2ec80ac47767bbd38acc23ba69f7edf140bb40fcdd050ad1eb753fdf2846e479f5e54697'),(7,'jk@rowling.com','9ad2c8fa8aa23d91d21dff9faa0ba1d5db5c75101a5a834c99e141566bdaeb8b25679896d8bf7e1871ab5e028d041bc1282d728a824b461ab7ec92b5184e3518'),(9,'pippa.smith@email.com','d3983e244c743651491176d90f8ba9a0850b5c86a75b06646e45815a9fdcd80353c712c4e07ebd61fe428894be65bf21287a8d4a717c05829fdb5301b919e495'),(10,'jon@spellbad.com','134b3c970a0d36c652ae01b535b093255673fcdf2a43fddfa25327afb3b2e3d387aa178864d3e243a547d2215855c4fcc7eb82d9651483fc4ec811af1648984a');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person` (
  `ID` int(11) NOT NULL,
  `forename` varchar(20) COLLATE utf8_bin NOT NULL,
  `middle_initials` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `surname` varchar(20) COLLATE utf8_bin NOT NULL,
  `date_of_birth` date NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (1,'Bob','B A','Bobson','2009-12-31'),(2,'Bob','A B','Bobson','1978-10-23'),(3,'Stephen',NULL,'Fry','1957-08-24'),(4,'Hugh',NULL,'Laurie','1959-06-10'),(5,'Ruth',NULL,'Letham','1978-11-23'),(6,'Simon',NULL,'Prebble','1942-02-13'),(7,'JK',NULL,'Rowling','1965-07-31'),(8,'Newton','A F','Scamander','1897-02-24'),(9,'Pippa','A','Smith','2005-01-01'),(10,'Jon','Q','Spellbad','2007-01-01'),(11,'Jonathan',NULL,'Swift','1667-11-30');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phone_number`
--

DROP TABLE IF EXISTS `phone_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phone_number` (
  `customer_ID` int(11) NOT NULL,
  `phone_number` varchar(20) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`customer_ID`,`phone_number`),
  CONSTRAINT `phone_number_ibfk_1` FOREIGN KEY (`customer_ID`) REFERENCES `customer` (`personalID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phone_number`
--

LOCK TABLES `phone_number` WRITE;
/*!40000 ALTER TABLE `phone_number` DISABLE KEYS */;
INSERT INTO `phone_number` VALUES (5,'02222 111 333'),(9,'01111 222 333'),(9,'07777 222 333');
/*!40000 ALTER TABLE `phone_number` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publisher`
--

DROP TABLE IF EXISTS `publisher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publisher` (
  `name` varchar(1024) COLLATE utf8_bin NOT NULL,
  `building` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `street` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `city` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `country` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `postcode` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `phone_number` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `established_date` date DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publisher`
--

LOCK TABLES `publisher` WRITE;
/*!40000 ALTER TABLE `publisher` DISABLE KEYS */;
INSERT INTO `publisher` VALUES ('HighBridge Audio','270','Skipjack Road','Prince Frederick','USA','MD 20678','1-800-755-8532','1901-01-01'),('Penguin Books Ltd','80','Strand','London','UK','WC2R 0RL','861590','1981-01-01'),('Pottermore Publishing','PO Box 7828',NULL,'London','UK','W1A 4GE','12345','2011-07-31'),('Random House AudioBooks','20','Vauxhall Bridge Road','London','UK','SW1V2SA','+4402078408400','1928-09-01');
/*!40000 ALTER TABLE `publisher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'ys60_cs3101'
--
/*!50003 DROP PROCEDURE IF EXISTS `insertAsContributor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ys60`@`%` PROCEDURE `insertAsContributor`(personalID INT, biography VARCHAR(1024))
BEGIN
	INSERT INTO contributor (personalID, biography) values (personalID, biography);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertAsCustomer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ys60`@`%` PROCEDURE `insertAsCustomer`(personalID INT, email_address VARCHAR(100), pwd VARCHAR(150))
BEGIN
	INSERT INTO customer (personalID, email_address, pwd) values (personalID, email_address, SHA2(pwd, 512));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertContributor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ys60`@`%` PROCEDURE `insertContributor`(biography VARCHAR(1024), forename VARCHAR(20), middle_initials VARCHAR(20), surname VARCHAR(20), date_of_birth DATE)
BEGIN
	DECLARE personExist INT;
	DECLARE personCount INT;
	SET personExist = 0;
	SET personCount = 0;
	(SELECT COUNT(person.ID) INTO personExist FROM person where
	person.forename = forename AND person.middle_initials = middle_initials AND person.surname = surname AND person.date_of_birth = date_of_birth);
	IF(personExist = 0) THEN
		(SELECT COUNT(person.ID) INTO personCount FROM person);
		SET personCount = personCount + 1;
		call insertPerson(personCount, forename, middle_initials, surname, date_of_birth);
	ELSE
		SET personCount = (SELECT person.ID FROM person where (person.forename = forename AND person.middle_initials = middle_initials AND person.surname = surname AND person.date_of_birth = date_of_birth));
	END IF;
	call insertAsContributor(personCount, biography);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertCustomer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ys60`@`%` PROCEDURE `insertCustomer`(email_address VARCHAR(100), pwd VARCHAR(150), forename VARCHAR(20), middle_initials VARCHAR(20), surname VARCHAR(20), date_of_birth DATE)
BEGIN
	DECLARE personExist INT;
	DECLARE personCount INT;
	SET personExist = 0;
	SET personCount = 0;
	(SELECT COUNT(person.ID) INTO personExist FROM person where
	person.forename = forename AND person.middle_initials = middle_initials AND person.surname = surname AND person.date_of_birth = date_of_birth);
	IF(personExist = 0) AND (email_address IS NOT NULL) AND (pwd IS NOT NULL) THEN
		(SELECT COUNT(person.ID) INTO personCount FROM person);
		SET personCount = personCount + 1;
		call insertPerson(personCount, forename, middle_initials, surname, date_of_birth);
	ELSE
		SET personCount = (SELECT person.ID FROM person where (person.forename = forename AND person.middle_initials = middle_initials AND person.surname = surname AND person.date_of_birth = date_of_birth));
	END IF;
	call insertAsCustomer(personCount, email_address, pwd);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertPerson` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ys60`@`%` PROCEDURE `insertPerson`(personalID INT,forename VARCHAR(20), middle_initials VARCHAR(20), surname VARCHAR(20), date_ofbirth DATE)
BEGIN
	INSERT INTO 
	person(ID, forename, middle_initials, surname, date_of_birth)
	values (personalID, forename, middle_initials, surname, date_of_birth);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `Q1`
--

/*!50001 DROP TABLE IF EXISTS `Q1`*/;
/*!50001 DROP VIEW IF EXISTS `Q1`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ys60`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `Q1` AS select `customer`.`personalID` AS `personalID`,`customer`.`email_address` AS `email_address`,case when `person`.`middle_initials` is null then concat(`person`.`forename`,' ',`person`.`surname`) else concat(`person`.`forename`,' ',`person`.`middle_initials`,' ',`person`.`surname`) end AS `Full_Name`,count(`audiobook_purchases`.`ISBN`) AS `Total_Number_Of_Purchases`,ifnull(sum(`audiobook`.`purchase_price`),0) AS `Total_Spent` from (((`customer` left join `audiobook_purchases` on(`customer`.`personalID` = `audiobook_purchases`.`customer_ID`)) left join `audiobook` on(`audiobook`.`ISBN` = `audiobook_purchases`.`ISBN`)) left join `person` on(`person`.`ID` = `customer`.`personalID`)) group by `person`.`ID` order by ifnull(sum(`audiobook`.`purchase_price`),0) desc,`person`.`forename`,`person`.`surname`,`person`.`middle_initials` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Q2`
--

/*!50001 DROP TABLE IF EXISTS `Q2`*/;
/*!50001 DROP VIEW IF EXISTS `Q2`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ys60`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `Q2` AS select `audiobook`.`ISBN` AS `ISBN`,`audiobook`.`title` AS `title` from `audiobook` where !(`audiobook`.`ISBN` in (select `audiobook_purchases`.`ISBN` from `audiobook_purchases`)) order by `audiobook`.`title` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Q3`
--

/*!50001 DROP TABLE IF EXISTS `Q3`*/;
/*!50001 DROP VIEW IF EXISTS `Q3`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ys60`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `Q3` AS select `audiobook_authors`.`contributor_ID` AS `contributor_ID`,case when `person`.`middle_initials` is null then concat(`person`.`forename`,' ',`person`.`surname`) else concat(`person`.`forename`,' ',`person`.`middle_initials`,' ',`person`.`surname`) end AS `Full_Name`,group_concat(`audiobook`.`title` order by `audiobook`.`title` ASC separator ',') AS `Titles` from (((`audiobook_authors` join `audiobook_purchases` on(`audiobook_authors`.`contributor_ID` = `audiobook_purchases`.`customer_ID` and `audiobook_authors`.`ISBN` = `audiobook_purchases`.`ISBN`)) join `audiobook`) join `person`) where `audiobook`.`ISBN` = `audiobook_authors`.`ISBN` and `audiobook_authors`.`contributor_ID` = `person`.`ID` group by `audiobook_authors`.`contributor_ID` order by `audiobook_authors`.`contributor_ID` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-27 20:43:02
