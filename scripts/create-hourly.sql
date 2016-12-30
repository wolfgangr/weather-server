-- Tabellenstruktur für Tabelle `hourly`
-- 

# | idx_hr        | datapoints | temp_out_min | temp_out_max | temp_out_avg | hum_out_min | hum_out_max | hum_out_avg | rain_count_min | rain_count_max | rain_count_diff | wind_ave_min | wind_ave_max | wind_ave_avg | wind_gust_max | wind_vec_sin       | wind_vec_cos       | wind_sumsq_sin | wind_sumsq_cos | wind_sum_sinxcos    | wind_vec_dir | wind_vec_mag |



DROP TABLE IF EXISTS `hourly`;
CREATE TABLE IF NOT EXISTS `hourly` (
  `idx_hr` datetime NOT NULL default '0000-00-00 00:00:00',
  `datapoints` int(11) NOT NULL default '0',

  temp_out_min		FLOAT default 0,
  temp_out_max   	FLOAT default 0,
  temp_out_avg   	FLOAT default 0,
  hum_out_min  		FLOAT default 0,
  hum_out_max   	FLOAT default 0,
  hum_out_avg  		FLOAT default 0,
  rain_count_min  	FLOAT default 0,
  rain_count_max  	FLOAT default 0,
  rain_count_diff  	FLOAT default 0,
  wind_ave_min   	FLOAT default 0,
  wind_ave_max  	FLOAT default 0,
  wind_ave_avg  	FLOAT default 0,
  wind_gust_max  	FLOAT default 0,
  wind_vec_sin  	FLOAT default 0,
  wind_vec_cos  	FLOAT default 0,
  wind_sumsq_sin      	FLOAT default 0,
  wind_sumsq_cos      	FLOAT default 0,
  wind_sum_sinxcos    	FLOAT default 0,
  wind_vec_dir        	FLOAT default 0,
  wind_vec_mag        	FLOAT default 0,

  PRIMARY KEY  (`idx_hr`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- 
-- Daten für Tabelle `hourly`
-- 
