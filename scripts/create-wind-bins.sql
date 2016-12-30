-- phpMyAdmin SQL Dump
-- version 2.6.3-pl1
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Erstellungszeit: 02. März 2014 um 00:56
-- Server Version: 4.1.13
-- PHP-Version: 5.0.4
-- 
-- Datenbank: `wetter_sdr`
-- 

-- --------------------------------------------------------

-- 
-- Tabellenstruktur für Tabelle `wind-hist-bins`
-- 

DROP TABLE IF EXISTS `wind-hist-bins`;
CREATE TABLE IF NOT EXISTS `wind-hist-bins` (
#   `idx` datetime NOT NULL default '0000-00-00 00:00:00',
# --  `wind_ave` decimal(5,1) NOT NULL default '0.0',
#   `wind_dir` decimal(3,1) NULL default NULL,
#   `wind_ave` decimal(5,1) NOT NULL default '0.0',
#  `bin_count` int(11) NOT NULL default '0'
# ) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_bin;



# CREATE TABLE `wind-hist-bins` (
  `idx` datetime NOT NULL default '0000-00-00 00:00:00',
  `wind_dir` decimal(3,1) NOT NULL default '0.0',
  `wind_ave` decimal(5,1) NOT NULL default '0.0',
  `bin_count` int(11) NOT NULL default '0',
  PRIMARY KEY  (`idx`,`wind_dir`,`wind_ave`),
  KEY `idx` (`idx`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_bin;


