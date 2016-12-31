-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb2+deb7u7
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Erstellungszeit: 31. Dez 2016 um 15:29
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
-- Tabellenstruktur für Tabelle `wind-hist-bins`
--

CREATE TABLE IF NOT EXISTS `wind-hist-bins` (
  `idx` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `wind_dir` smallint(3) NOT NULL DEFAULT '0',
  `wind_ave` smallint(5) NOT NULL DEFAULT '0',
  `bin_count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idx`,`wind_dir`,`wind_ave`),
  KEY `idx` (`idx`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
