

DROP TABLE IF EXISTS `tmp_day_hr`;
-- CREATE TEMPORARY TABLE IF NOT EXISTS `tmp_day_hr` 
CREATE TABLE IF NOT EXISTS `tmp_day_hr`

SELECT 
	DATE(`idx_hr`) AS idx_day , 
	idx_hr 
	FROM hourly 
	ORDER BY idx_hr ;


# CREATE TABLE `tmp_test` (
# `idx_day` DATETIME NOT NULL ,
# `idx_hr` DATETIME NOT NULL ,
# PRIMARY KEY ( `idx_hr` ) ,
# INDEX ( `idx_day` )
# ) TYPE = MYISAM ;




-- EXPLAIN SELECT

-- CREATE TABLE IF NOT EXISTS `daily`

REPLACE INTO `daily`
	( idx_day, datapoints,
	temp_out_min, temp_out_max, temp_out_avg,
	temp_out_q00, 
--	temp_out_q23, temp_out_q50, temp_out_q77, 
	temp_out_q100,
	hum_out_min, hum_out_max, hum_out_avg, 
	rain_count_max, rain_count_diff, 
	wind_ave_avg, wind_gust_max, 
	wind_vec_sin, wind_vec_cos, 
	wind_sumsq_sin, wind_sumsq_cos, wind_sum_sinxcos)
--	wind_vec_dir, wind_vec_mag)


SELECT
DATE(`idx_hr`) 		AS idx_day ,	########### can we replace this by join with tmp_day_hr
SUM(datapoints) 	AS datapoints,
	
MIN(temp_out_min) 	AS temp_out_min,
MAX(temp_out_max) 	AS temp_out_max,
AVG(temp_out_avg) 	AS temp_out_avg, 

MIN(temp_out_avg)       AS temp_out_q00,

-- (SELECT AVG(temp_out_avg) from( 
--	select temp_out_avg from hourly where DATE(hourly.idx_hr) = t1.idx_day ORDER BY temp_out_avg ASC LIMIT 11,2
-- ) AS t2) 		AS temp_out_q50,

-- (SELECT temp_out_avg FROM hourly as t2 WHERE DATE(`idx_hr`)=idx_day ORDER BY temp_out_avg ASC LIMIT 5,1)
--			AS temp_out_q23,

-- (SELECT AVG(temp_out_avg) from(
--      select temp_out_avg from hourly as t3 where DATE(`idx_hr`)=DATE(`idx_day`) ORDER BY temp_out_avg ASC LIMIT 11,2
-- ) AS t2 )             AS temp_out_q50,
-- (
#SELECT temp_out_avg FROM hourly as t2 WHERE DATE(`idx_hr`)=idx_day ORDER BY temp_out_avg ASC LIMIT 11,1) 
#+
#(SELECT temp_out_avg FROM hourly as t2 WHERE DATE(`idx_hr`)=idx_day ORDER BY temp_out_avg ASC LIMIT 12,1)
#) /2 			AS temp_out_q50,



-- (SELECT temp_out_avg FROM hourly as t2 WHERE DATE(`idx_hr`)=idx_day ORDER BY temp_out_avg ASC LIMIT 18,1)
--                        AS temp_out_q77,

MAX(temp_out_avg) 	AS temp_out_q100,

MIN(hum_out_min) 	AS hum_out_min,	
MAX(hum_out_max) 	AS hum_out_max,	
AVG(hum_out_avg) 	AS hum_out_avg,

MAX(rain_count_max) 	AS rain_count_max, 	
SUM(rain_count_diff) 	AS rain_count_diff,
	
AVG(wind_ave_avg)	AS wind_ave_avg,
MAX(wind_gust_max) 	AS wind_gust_max, 
AVG(wind_vec_sin)	AS wind_vec_sin,
AVG(wind_vec_cos) 	AS wind_vec_cos,

### wr 2016-12-31 keep statistical data
SUM(wind_sumsq_sin)    	AS wind_sumsq_sin,
SUM(wind_sumsq_cos)    	AS wind_sumsq_cos,
SUM(wind_sum_sinxcos) 	AS wind_sum_sinxcos
	
# NULL AS wind_vec_dir,
# NULL AS wind_vec_mag

FROM `hourly` AS t1
GROUP BY idx_day ASC
;


-- calculate fields dependent on aggregated values
UPDATE `daily` SET `wind_vec_mag` = SQRT( POWER( `wind_vec_sin`, 2) +  POWER( `wind_vec_cos`, 2)) WHERE ISNULL(  `wind_vec_mag` );
UPDATE `daily` SET `wind_vec_dir` = DEGREES(ATAN(`wind_vec_sin`, `wind_vec_cos`))  WHERE ISNULL(  `wind_vec_dir` );

############## TO DO :
# calculate the qantiles
# maybe add qnatiles for humidty, wind ???


