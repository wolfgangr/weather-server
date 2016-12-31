-- MySQL dump 10.13  Distrib 5.5.53, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: wetter_sdr
-- ------------------------------------------------------
-- Server version	5.5.53-0+deb7u1

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
-- Table structure for table `daily`
--

DROP TABLE IF EXISTS `daily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `daily` (
  `idx_day` date NOT NULL,
  `datapoints` int(11) DEFAULT NULL,
  `temp_out_min` float DEFAULT NULL,
  `temp_out_max` float DEFAULT NULL,
  `temp_out_avg` float DEFAULT NULL,
  `temp_out_q00` float DEFAULT NULL,
  `temp_out_q23` float DEFAULT NULL,
  `temp_out_q50` float DEFAULT NULL,
  `temp_out_q77` float DEFAULT NULL,
  `temp_out_q100` float DEFAULT NULL,
  `hum_out_min` float DEFAULT NULL,
  `hum_out_max` float DEFAULT NULL,
  `hum_out_avg` float DEFAULT NULL,
  `rain_count_max` double(20,2) DEFAULT NULL,
  `rain_count_diff` double(20,2) DEFAULT NULL,
  `wind_ave_avg` float DEFAULT NULL,
  `wind_gust_max` float DEFAULT NULL,
  `wind_vec_sin` float DEFAULT NULL,
  `wind_vec_cos` float DEFAULT NULL,
  `wind_sumsq_sin` float DEFAULT NULL,
  `wind_sumsq_cos` float DEFAULT NULL,
  `wind_sum_sinxcos` float DEFAULT NULL,
  `wind_vec_dir` float DEFAULT NULL,
  `wind_vec_mag` float DEFAULT NULL,
  PRIMARY KEY (`idx_day`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_bin;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-12-31 16:45:42
