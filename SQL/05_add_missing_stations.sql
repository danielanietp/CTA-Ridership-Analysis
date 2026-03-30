-- In stops but not in ridership
SELECT  distinct s.station_id, s.station_name
FROM l_stops_clean s
LEFT JOIN ridership_clean r
    ON s.station_id = r.station_id
WHERE r.station_name IS NULL
ORDER BY station_name ASC;

-- In ridership but not in stops
SELECT 
    r.station_id, 
    r.station_name,
    SUM(r.total_rides) AS total_rides
FROM ridership_clean r
LEFT JOIN l_stops_clean s
    ON r.station_id = s.station_id
WHERE s.station_id IS NULL
GROUP BY r.station_id, r.station_name
ORDER BY r.station_name ASC;

INSERT INTO l_stops_clean (station_id, station_name, station_descriptive_name, ada, red, blue, green, brown, purple, yellow, pink, orange, num_lines, latitude, longitude)
VALUES
( 40640, 
  'Madison/Wabash',
  'Madison/Wabash (Closed)', 
  0, 0, 0, 1, 1, 1, 0, 1, 1,
  5,
  41.882023, -87.626098);

INSERT INTO l_stops_clean (station_id, station_name, station_descriptive_name, ada, red, blue, green, brown, purple, yellow, pink, orange, num_lines, latitude, longitude)
VALUES
( 40200, 
  'Randolph/Wabash',
  'Randolph/Wabash (Closed)', 
  0, 0, 0, 1, 1, 1, 0, 1, 1,
  5,
  41.884431, -87.626149);

INSERT INTO l_stops_clean (station_id, station_name, station_descriptive_name, ada, red, blue, green, brown, purple, yellow, pink, orange, num_lines, latitude, longitude)
VALUES
( 40500, 
  'Washington/State',
  'Washington/State (Closed)', 
  0, 1, 0, 0, 0, 0, 0, 0, 0,
  1,
  41.8837, -87.6278);

DELETE FROM ridership_clean
WHERE station_id = 41580
