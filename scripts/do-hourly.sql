
SET @last_intvl := IFNULL( (SELECT MAX(idx_hr) FROM `hourly`), '0000-00-00');


REPLACE into `hourly`
	(`idx_hr`,  `datapoints`,
	`temp_out_min`, `temp_out_max`, `temp_out_avg`,
	`hum_out_min`, `hum_out_max`, `hum_out_avg`, 
	`rain_count_min`, `rain_count_max`, `rain_count_diff`, 
	`wind_ave_min`, `wind_ave_max`, `wind_ave_avg`, `wind_gust_max`, 
	`wind_vec_sin`, `wind_vec_cos`,  `wind_sumsq_sin`, 
	`wind_sumsq_cos`, `wind_sum_sinxcos`, 
	`wind_vec_dir`, `wind_vec_mag` )

SELECT 
LEFT(`idx`, 13 ) AS idx_hr, 
COUNT(`idx`) as datapoints, 

MIN(`temp_out`) as temp_out_min,
MAX(`temp_out`) as temp_out_max,
AVG(`temp_out`) as temp_out_avg,

MIN(`hum_out`) as hum_out_min,
MAX(`hum_out`) as hum_out_max,
AVG(`hum_out`) as hum_out_avg,

MIN(`rain_count`) as rain_count_min,
MAX(`rain_count`) as rain_count_max,
-- MAX( `rain_count` ) - MIN( `rain_count` ) AS rain_count_diff,

# subselsects show huge performance costs ..... try update later
-- MAX( `rain_count` ) - (
--   SELECT `rain_count` FROM raw 
--      WHERE `idx` = (
--         SELECT MAX( `idx` ) FROM `raw` WHERE `idx` < idx_hr )
-- ) AS rain_count_diff,
NULL AS rain_count_diff,

MIN(`wind_ave`) as wind_ave_min,
MAX(`wind_ave`) as wind_ave_max,
AVG(`wind_ave`) as wind_ave_avg,
MAX(`wind_gust`) as wind_gust_max,

AVG(  SIN( RADIANS(`wind_dir`) ) * `wind_ave`) as wind_vec_sin,
AVG(  COS( RADIANS(`wind_dir`) ) * `wind_ave`) as wind_vec_cos,
SUM( POWER( (SIN( RADIANS(`wind_dir`) ) * `wind_ave`), 2) ) as wind_sumsq_sin,
SUM( POWER( (COS( RADIANS(`wind_dir`) ) * `wind_ave`), 2) ) as wind_sumsq_cos,
SUM( (COS( RADIANS(`wind_dir`) ) * `wind_ave`) * (SIN( RADIANS(`wind_dir`) ) * `wind_ave`) ) as wind_sum_sinxcos,

-- DEGREES (ATAN (`wind_vec_sin`, `wind_vec_cos`)) as wind_vec_dir,
-- SQRT( `wind_vec_sin` * `wind_vec_sin` + `wind_vec_cos` * `wind_vec_cos` ) as wind_vec_mag
NULL as wind_vec_dir,
NULL as wind_vec_mag


FROM `raw`
WHERE idx >= @last_intvl  # LIKE '2014-02-28%'
GROUP BY  idx_hr ASC
;


-- calculate fields dependent on aggregated values
UPDATE `hourly` SET `wind_vec_mag` = SQRT( POWER( `wind_vec_sin`, 2) +  POWER( `wind_vec_cos`, 2)) WHERE ISNULL(  `wind_vec_mag` );
UPDATE `hourly` SET `wind_vec_dir` = DEGREES(ATAN(`wind_vec_sin`, `wind_vec_cos`))  WHERE ISNULL(  `wind_vec_dir` );

-- total rain requires access to last hour
UPDATE 	hourly AS h1 , hourly AS h2  	
	SET 	 h1.rain_count_diff  =	ROUND((h1.rain_count_max - h2.rain_count_max), 2) 
	WHERE  ISNULL(h1.rain_count_diff )
	AND DATE_SUB(h1.idx_hr, INTERVAL 1 HOUR) = h2.idx_hr 
;


