-- DROP TEMPORARY TABLE yearly_rides_per_station;
CREATE TEMPORARY TABLE yearly_rides_per_station AS
SELECT
    station_id,
    station_name,
    year,
    SUM(total_rides) AS yearly_rides
FROM ridership_clean
GROUP BY station_id, station_name, year;

CREATE TABLE yearly_rides_per_station_line AS
SELECT
    y.station_id,
    y.station_name,
    y.year,
    y.yearly_rides,
    ROUND(y.yearly_rides / s.num_lines) AS rides_per_line_unit,
    CASE WHEN s.red = 1 THEN ROUND(y.yearly_rides / s.num_lines) ELSE 0 END AS red_line_rides,
    CASE WHEN s.blue = 1 THEN ROUND(y.yearly_rides / s.num_lines) ELSE 0 END AS blue_line_rides,
    CASE WHEN s.green = 1 THEN ROUND(y.yearly_rides / s.num_lines) ELSE 0 END AS green_line_rides,
    CASE WHEN s.brown = 1 THEN ROUND(y.yearly_rides / s.num_lines) ELSE 0 END AS brown_line_rides,
    CASE WHEN s.purple = 1 THEN ROUND(y.yearly_rides / s.num_lines) ELSE 0 END AS purple_line_rides,
    CASE WHEN s.yellow = 1 THEN ROUND(y.yearly_rides / s.num_lines) ELSE 0 END AS yellow_line_rides,
    CASE WHEN s.pink = 1 THEN ROUND(y.yearly_rides / s.num_lines) ELSE 0 END AS pink_line_rides,
    CASE WHEN s.orange = 1 THEN ROUND(y.yearly_rides / s.num_lines) ELSE 0 END AS orange_line_rides,
    s.num_lines,
    s.latitude,
    s.longitude
FROM yearly_rides_per_station y
JOIN l_stops_clean s
    ON y.station_id = s.station_id
ORDER BY y.station_id, y.station_name, y.year;
