-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb2+deb7u7
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Erstellungszeit: 30. Dez 2016 um 21:54
-- Server Version: 5.5.53
-- PHP-Version: 5.4.45-0+deb7u6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Datenbank: `wetter_sdr`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `raw`
--

CREATE TABLE IF NOT EXISTS `raw` (
  `idx` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `hum_out` decimal(3,0) DEFAULT NULL,
  `temp_out` decimal(4,1) DEFAULT NULL,
  `wind_ave` decimal(5,1) DEFAULT NULL,
  `wind_gust` decimal(5,1) DEFAULT NULL,
  `wind_dir` decimal(3,0) DEFAULT NULL,
  `rain_count` decimal(6,1) DEFAULT NULL,
  `lo_batt` int(2) DEFAULT NULL,
  PRIMARY KEY (`idx`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
