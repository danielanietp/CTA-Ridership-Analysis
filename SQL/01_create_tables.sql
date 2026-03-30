CREATE DATABASE cta_database;
USE cta_database;

CREATE TABLE ridership (
    station_id INT,
    station_name VARCHAR(100),
    month_beginning VARCHAR(50),
    avg_weekday_rides DECIMAL(10,2),
    avg_saturday_rides DECIMAL(10,2),
    avg_sunday_holiday_rides DECIMAL(10,2),
    total_rides INT
);

CREATE TABLE l_stops (
    stop_id INT,
    direction_id VARCHAR(5),
    stop_name VARCHAR(100),
    station_name VARCHAR(100),
    station_descriptive_name VARCHAR(150),
    station_id INT,
    ada VARCHAR(5),
    red VARCHAR(5),
    blue VARCHAR(5),
    green VARCHAR(5),
    brown VARCHAR(5),
    purple VARCHAR(5),
    yellow VARCHAR(5),
    pink VARCHAR(5),
    orange VARCHAR(5),
    location TEXT
);
