# SET @last_intvl := IFNULL( (SELECT MAX(idx_hr) FROM `hourly`), '0000-00-00');
SET @last_intvl := IFNULL( (SELECT MAX(idx) FROM `wind-hist-bins`), '0000-00-00');


REPLACE INTO `wind-hist-bins`
SELECT FROM_UNIXTIME( (
  FLOOR( (
    (
      (
        UNIX_TIMESTAMP( `idx` ) ) /3600 ) -4
      ) /6
    ) *6 +4
  ) *3600
) AS intvl, 
# MIN( `idx` ) AS idx_min, 
# MAX( `idx` ) AS idx_max,
IF (
  `wind_ave` >=1, `wind_dir` , -1 
) AS wind_dir_if, 
FLOOR( `wind_ave` ) AS wind_ave_floor, 
COUNT( `idx` ) AS bin_count
FROM `raw`
WHERE (`idx` >= @last_intvl)
GROUP BY intvl ASC , wind_dir_if ASC , wind_ave_floor ASC
