SELECT *
FROM tripdata;

#Total no of trips
SELECT DISTINCT COUNT(*)
FROM google.tripdata;

#No.of ride by each users
SELECT member_casual, 
COUNT(*), sec_to_time(AVG(time_to_sec(ride_length))) AS avg_time
FROM google.tripdata
GROUP BY member_casual;
#Members and Non-members used electric and classic bikes equally 

#Standard Deviation
SELECT member_casual,stddev(time_to_sec(ride_length)/60) as variability
FROM google.tripdata
GROUP BY 1;

#Bike Type Behavior of Members
SELECT rideable_type, COUNT(rideable_type),
COUNT(rideable_type)*100/(SELECT COUNT(*) FROM tripdata WHERE member_casual = 'member') AS perc_share
FROM google.tripdata
WHERE member_casual = 'member'
GROUP BY rideable_type
ORDER BY 2 DESC;

#Bike Type Behavior of Non-members
SELECT rideable_type, COUNT(rideable_type),
COUNT(rideable_type)*100/(SELECT COUNT(*) FROM tripdata WHERE member_casual = 'casual') AS perc_share
FROM google.tripdata
WHERE member_casual = 'casual'
GROUP BY rideable_type
ORDER BY 2 DESC;

#Seasons Column
ALTER TABLE tripdata
ADD COLUMN season TEXT;
UPDATE tripdata
SET season = CASE 
WHEN `month` IN ('Dec', 'Jan', 'Feb') THEN 'winter'
WHEN `month` IN ('Mar', 'Apr', 'May') THEN 'spring'
WHEN `month` IN ('Jun', 'Jul', 'Aug') THEN 'summer'
WHEN `month` IN ('Sep', 'Oct', 'Nov') THEN 'autumn'
END;

#Trend across season
SELECT season, COUNT(*) AS total_count
FROM google.tripdata
GROUP BY season
ORDER BY 2 DESC;

#Trend across different days of week
SELECT weekday, COUNT(*) AS total_count
FROM google.tripdata
WHERE member_casual = 'member'
GROUP BY 1
ORDER BY 2 DESC;

SELECT weekday, COUNT(*) AS total_count
FROM google.tripdata
WHERE member_casual = 'casual'
GROUP BY 1
ORDER BY 2 DESC;

#Time of the day
#Work Hours: 9:00 AM - 5:00 PM
#Commute Time: 7:00 AM - 9:00 AM & 5:00 PM - 7:00 PM
#Leisure Time: 6:00 PM - 10:00 PM
#Sleep Time: 10:00 PM - 6:00 AM

SELECT 
 CASE WHEN STR_TO_DATE(`time`, '%h:%i %p') BETWEEN TIME('07:00:00') AND TIME('09:00:00') THEN 'commute time'
 WHEN STR_TO_DATE(`time`, '%h:%i %p') BETWEEN TIME('09:00:00') AND TIME('17:00:00') THEN 'work hours' 
 WHEN STR_TO_DATE(`time`, '%h:%i %p') BETWEEN TIME('17:00:00') AND TIME('19:00:00') THEN 'commute time'
 WHEN STR_TO_DATE(`time`, '%h:%i %p') BETWEEN TIME('19:00:00') AND TIME('22:00:00') THEN 'leisure time'
 ELSE 'night'
 END AS activity,
COUNT(*) AS total_count
FROM google.tripdata
GROUP BY 1
ORDER BY 2 DESC;
#STR_TO_DATE() converts time from HH:MM AM/PM format to 24hr time object.

#Busiest locations for members
SELECT start_station_name, COUNT(*)
FROM tripdata
WHERE start_station_name <> '' AND member_casual = 'member'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

#Busiest locations for non-members
SELECT start_station_name, COUNT(*)
FROM tripdata
WHERE start_station_name <> '' AND member_casual = 'casual'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

#Busiest route
SELECT start_station_name, end_station_name, COUNT(*)
FROM tripdata
WHERE start_station_name <> '' AND member_casual = 'casual'
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 5;



