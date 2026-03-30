SELECT *
FROM ridership_clean
WHERE 
    station_id IS NULL
    OR station_name IS NULL
    OR month_beginning IS NULL
    OR avg_weekday_rides IS NULL
    OR avg_saturday_rides IS NULL
    OR avg_sunday_holiday_rides IS NULL
    OR total_rides IS NULL;

SELECT *
FROM ridership_clean
WHERE 
    avg_weekday_rides < 0
    OR avg_saturday_rides < 0
    OR avg_sunday_holiday_rides < 0
    OR total_rides < 0;

SELECT *
FROM l_stops_clean
WHERE 
    station_id IS NULL
    OR station_name IS NULL
    OR latitude IS NULL
    OR longitude IS NULL;

SELECT *
FROM l_stops_clean
WHERE 
    latitude NOT BETWEEN 41.5 AND 42.1
    OR longitude NOT BETWEEN -88.0 AND -87.5;

SELECT station_id, station_name, COUNT(*) as count
FROM l_stops_clean
GROUP BY station_id, station_name
HAVING count > 1;

SELECT *
FROM l_stops_clean
WHERE station_id = 41400;

CREATE TEMPORARY TABLE roosevelt_agg AS
SELECT
    station_id,
    MAX(station_name) AS station_name,
    MAX(station_descriptive_name) AS station_descriptive_name,
    MAX(ada) AS ada,
    MAX(red) AS red,
    MAX(blue) AS blue,
    MAX(green) AS green,
    MAX(brown) AS brown,
    MAX(purple) AS purple,
    MAX(yellow) AS yellow,
    MAX(pink) AS pink,
    MAX(orange) AS orange,
    SUM(num_lines) AS num_lines,
    ROUND(AVG(latitude), 6) AS latitude,
    ROUND(AVG(longitude), 6) AS longitude
FROM l_stops_clean
WHERE station_id = 41400
GROUP BY station_id;

DELETE FROM l_stops_clean
WHERE station_id = 41400;

INSERT INTO l_stops_clean
SELECT * FROM roosevelt_agg;

SELECT station_id, station_name, COUNT(*) as count
FROM l_stops_clean
GROUP BY station_id, station_name
HAVING count > 1;

SELECT *
FROM l_stops_clean
WHERE station_id = 41400;

SELECT *
FROM l_stops_clean
WHERE 
    red = 0 AND blue = 0 AND green = 0 AND brown = 0
    AND purple = 0 AND yellow = 0 AND pink = 0 AND orange = 0;

SELECT *
FROM l_stops
WHERE station_name LIKE '%Sheridan%';

DELETE FROM l_stops_clean
WHERE 
    red = 0 AND blue = 0 AND green = 0 AND brown = 0
    AND purple = 0 AND yellow = 0 AND pink = 0 AND orange = 0;

SELECT *
FROM l_stops_clean
WHERE 
    red = 0 AND blue = 0 AND green = 0 AND brown = 0
    AND purple = 0 AND yellow = 0 AND pink = 0 AND orange = 0;
