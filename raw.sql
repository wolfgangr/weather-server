-- phpMyAdmin SQL Dump
-- version 2.6.3-pl1
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Erstellungszeit: 23. Februar 2014 um 23:07
-- Server Version: 4.1.13
-- PHP-Version: 5.0.4
-- 
-- Datenbank: `wetter_sdr`
-- 

-- --------------------------------------------------------

-- 
-- Tabellenstruktur für Tabelle `raw`
-- 

CREATE TABLE `raw` (
  `idx` datetime NOT NULL default '0000-00-00 00:00:00',
  `hum_out` decimal(3,0) default NULL,
  `temp_out` decimal(4,1) default NULL,
  `wind_ave` decimal(5,1) default NULL,
  `wind_gust` decimal(5,1) default NULL,
  `wind_dir` decimal(3,0) default NULL,
  `rain_count` decimal(6,1) default NULL,
  PRIMARY KEY  (`idx`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- 
-- Daten für Tabelle `raw`
-- 

