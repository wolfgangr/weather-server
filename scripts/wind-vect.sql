SELECT
`idx_hr`,
`datapoints`,
`wind_ave_min`,
`wind_ave_max`,
`wind_ave_avg`,
`wind_gust_max`,
`wind_vec_sin`, 
`wind_vec_cos`,
DEGREES(ATAN(`wind_vec_sin` , `wind_vec_cos`)) as wind_vec_dir,
SQRT( `wind_vec_sin` * `wind_vec_sin` + `wind_vec_cos` * `wind_vec_cos` ) as wind_vec_mag

FROM(
SELECT LEFT( `idx` , 13 ) AS idx_hr, COUNT( `idx` ) AS datapoints, 

MIN( `wind_ave` ) AS wind_ave_min, 
MAX( `wind_ave` ) AS wind_ave_max, 
AVG( `wind_ave` ) AS wind_ave_avg, 
MAX( `wind_gust` ) AS wind_gust_max,

AVG( SIN( `wind_dir_rad` ) * `wind_ave` ) AS wind_vec_sin, 
AVG( COS( `wind_dir_rad` ) * `wind_ave` ) AS wind_vec_cos

FROM (

SELECT `idx` , `wind_ave` , `wind_gust` , `wind_dir` , RADIANS( `wind_dir` ) AS wind_dir_rad
FROM `raw`
WHERE idx LIKE '2014-02-28%'
) AS A1
GROUP BY idx_hr ASC
) AS A2
