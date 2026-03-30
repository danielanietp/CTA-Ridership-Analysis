CREATE TABLE yearly_rides_yoy_per_line AS
WITH yearly_rides_per_line AS (
    SELECT
        year,
        SUM(red_line_rides) AS red,
        SUM(blue_line_rides) AS blue,
        SUM(green_line_rides) AS green,
        SUM(brown_line_rides) AS brown,
        SUM(purple_line_rides) AS purple,
        SUM(yellow_line_rides) AS yellow,
        SUM(pink_line_rides) AS pink,
        SUM(orange_line_rides) AS orange
    FROM yearly_rides_per_station_line
    GROUP BY year
)

, unpivoted AS (
    SELECT year, 'Red' AS line, red AS rides FROM yearly_rides_per_line
    UNION ALL
    SELECT year, 'Blue', blue FROM yearly_rides_per_line
    UNION ALL
    SELECT year, 'Green', green FROM yearly_rides_per_line
    UNION ALL
    SELECT year, 'Brown', brown FROM yearly_rides_per_line
    UNION ALL
    SELECT year, 'Purple', purple FROM yearly_rides_per_line
    UNION ALL
    SELECT year, 'Yellow', yellow FROM yearly_rides_per_line
    UNION ALL
    SELECT year, 'Pink', pink FROM yearly_rides_per_line
    UNION ALL
    SELECT year, 'Orange', orange FROM yearly_rides_per_line
)

SELECT
    line,
    year,
    rides,
    rides - LAG(rides) OVER (
        PARTITION BY line
        ORDER BY year
    ) AS yoy_change,
    
    ROUND(
        (rides - LAG(rides) OVER (
            PARTITION BY line
            ORDER BY year
        )) 
        / LAG(rides) OVER (
            PARTITION BY line
            ORDER BY year
        ) * 100,
        2
    ) AS yoy_pct_change
FROM unpivoted
ORDER BY line, year;
