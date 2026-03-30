USE cta_database;
CREATE TABLE l_stops_clean AS
SELECT
    station_id,
    station_name, station_descriptive_name,
    MAX(CASE WHEN ada='TRUE' THEN 1 ELSE 0 END) AS ada,
    MAX(CASE WHEN red='TRUE' THEN 1 ELSE 0 END) AS red,
    MAX(CASE WHEN blue='TRUE' THEN 1 ELSE 0 END) AS blue,
    MAX(CASE WHEN green='TRUE' THEN 1 ELSE 0 END) AS green,
    MAX(CASE WHEN brown='TRUE' THEN 1 ELSE 0 END) AS brown,
    MAX(CASE WHEN purple='TRUE' THEN 1 ELSE 0 END) AS purple,
    MAX(CASE WHEN yellow='TRUE' THEN 1 ELSE 0 END) AS yellow,
    MAX(CASE WHEN pink='TRUE' THEN 1 ELSE 0 END) AS pink,
    MAX(CASE WHEN orange='TRUE' THEN 1 ELSE 0 END) AS orange,
    -- Count how many lines are served
    (MAX(CASE WHEN LOWER(red)='true' THEN 1 ELSE 0 END)
     + MAX(CASE WHEN LOWER(blue)='true' THEN 1 ELSE 0 END)
     + MAX(CASE WHEN LOWER(green)='true' THEN 1 ELSE 0 END)
     + MAX(CASE WHEN LOWER(brown)='true' THEN 1 ELSE 0 END)
     + MAX(CASE WHEN LOWER(purple)='true' THEN 1 ELSE 0 END)
     + MAX(CASE WHEN LOWER(yellow)='true' THEN 1 ELSE 0 END)
     + MAX(CASE WHEN LOWER(pink)='true' THEN 1 ELSE 0 END)
     + MAX(CASE WHEN LOWER(orange)='true' THEN 1 ELSE 0 END)
    ) AS num_lines,
    -- Clean latitude
    CASE 
        WHEN location IS NOT NULL AND location <> '' 
        THEN CAST(
            SUBSTRING_INDEX(SUBSTRING_INDEX(REPLACE(REPLACE(location,'"',''), ',', ' '), '(', -1), ' ', 1) AS DECIMAL(9,6)
        )
        ELSE NULL
    END AS latitude,
    -- Clean longitude
    CASE 
        WHEN location IS NOT NULL AND location <> '' 
        THEN CAST(
            SUBSTRING_INDEX(REPLACE(REPLACE(location,'"',''), ')',''), ' ', -1) AS DECIMAL(9,6)
        )
        ELSE NULL
    END AS longitude
FROM l_stops
GROUP BY station_id, station_name, station_descriptive_name, latitude, longitude;

CREATE TABLE ridership_clean AS
SELECT
    station_id,
    station_name,
    -- Convert datetime string → DATE
    CAST(LEFT(month_beginning, 10) AS DATE) as month_beginning,
    -- Extract year
    YEAR(CAST(LEFT(month_beginning, 10) AS DATE)) AS year,
    -- Extract month
    MONTH(CAST(LEFT(month_beginning, 10) AS DATE)) AS month,
    avg_weekday_rides,
    avg_saturday_rides,
    avg_sunday_holiday_rides,
    total_rides
FROM ridership;



