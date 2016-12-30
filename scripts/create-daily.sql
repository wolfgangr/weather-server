-- 
-- Tabellenstruktur für Tabelle `daily`
-- 

DROP TABLE IF EXISTS `daily`;
CREATE TABLE IF NOT EXISTS `daily` (
  `idx_day` date NOT NULL,
  `datapoints`  integer default NULL,
  `temp_out_min`  float default NULL,
  `temp_out_max`  float default NULL,
  `temp_out_avg`  float default NULL,
  `temp_out_q00`  float default NULL,
  `temp_out_q23`  float default NULL,
  `temp_out_q50`  float default NULL,
  `temp_out_q77`  float default NULL,
  `temp_out_q100` float default NULL,
  `hum_out_min`   float default NULL,
  `hum_out_max`   float default NULL,
  `hum_out_avg`   float default NULL,
  `rain_count_max`  double(20,2) default NULL,
  `rain_count_diff` double(20,2) default NULL,
  `wind_ave_avg`  float default NULL,
  `wind_gust_max` float default NULL,
  `wind_vec_sin`  float default NULL,
  `wind_vec_cos`  float default NULL,
  `wind_vec_dir`  float default NULL,
  `wind_vec_mag`  float default NULL,

  PRIMARY KEY  (`idx_day`)

) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_bin;
