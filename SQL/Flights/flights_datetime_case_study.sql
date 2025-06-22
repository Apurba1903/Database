USE flightsdb;

SELECT * FROM flights;

ALTER TABLE flights
DROP COLUMN Additional_Info;


# 1. Find the month with the most number of flights
SELECT MONTHNAME(Date_of_Journey), COUNT(*)
FROM flights
GROUP BY MONTHNAME(Date_of_Journey)
ORDER BY COUNT(*) DESC
LIMIT 1;


# 2. Which weekday has the most costly flights
SELECT DAYNAME(Date_of_Journey), ROUND(AVG(Price), 2)
FROM flights
GROUP BY DAYNAME(Date_of_Journey)
ORDER BY ROUND(AVG(Price), 2) DESC
LIMIT 1;


# 3. Find the number of Indigo flights every month
SELECT MONTHNAME(Date_of_Journey), COUNT(*)
FROM flights
WHERE Airline = 'IndiGo'
GROUP BY MONTHNAME(Date_of_Journey)
ORDER BY MONTH(Date_of_Journey) ASC;


# 4. Find the list of all flights that depart between 10 AM and 2 PM from Bangalore to Delhi
SELECT * 
FROM flights
WHERE Source = 'Banglore' AND Destination = 'Delhi' AND
Dep_Time > '10:00:00' AND Dep_Time < '14:00:00' ;


# 5. Find the number of flights departing on weekends from Bangalore
SELECT COUNT(*)
FROM flights
WHERE Source = 'Banglore' 
AND DAYNAME(Date_of_Journey) IN ('Sunday', 'Saturday');


# 6. Calculate the arrival time for all flights by adding the duration to the departure time
ALTER TABLE flights
ADD COLUMN departure DATETIME;

UPDATE flights
SET departure = STR_TO_DATE(CONCAT(Date_of_Journey, ' ', Dep_Time), '%Y-%m-%d %H:%i');

ALTER TABLE flights
ADD COLUMN duration_min INT,
ADD COLUMN arrival DATETIME;

UPDATE flights
SET duration_min = REPLACE(SUBSTRING_INDEX(Duration, ' ', 1), 'h', '')*60 +
									CASE
										WHEN SUBSTRING_INDEX(Duration, ' ', -1) = SUBSTRING_INDEX(Duration, ' ', 1) THEN  0
										ELSE REPLACE(SUBSTRING_INDEX(Duration, ' ', -1), 'm', '')
									END;

UPDATE flights
SET arrival = DATE_ADD(departure, INTERVAL duration_min MINUTE);


SELECT TIME(arrival)
FROM flights;


# 7. Calculate the arrival date for all the flights
SELECT DATE(arrival)
FROM flights;


# 8. Find the number of flights which travel on multiple dates
SELECT COUNT(*)
FROM flights
WHERE DATE(departure) != DATE(arrival);


# 9. Calculate the average duration of flights between all city pairs (output in `xh ym` format)
SELECT Source, Destination, 
TIME_FORMAT(SEC_TO_TIME(AVG(duration_min)*60), '%kh %im') AS 'Avg_Duration'
FROM flights
GROUP BY Source, Destination;


# 10. Find all flights which departed before midnight but arrived after midnight with 0 stops
SELECT *
FROM flights
WHERE DATE(departure) != DATE(arrival) AND Total_Stops = 'non-stop';


# 11. Find quarter-wise number of flights for each airline
SELECT Airline, QUARTER(departure), COUNT(*)
FROM flights
GROUP BY Airline, QUARTER(departure);


# 12. Find the longest flight distance (between cities in terms of time) in India
SELECT Source, Destination, 
TIME_FORMAT(SEC_TO_TIME(AVG(duration_min)*60), '%kh %im') AS 'Avg_Duration'
FROM flights
GROUP BY Source, Destination
ORDER BY duration_min DESC
LIMIT 1;


# 13. Calculate the average time duration for flights with 1 stop vs more than 1 stop
WITH temp_table AS (
		SELECT *,
		CASE
			WHEN Total_Stops = 'non-stop' THEN 'non-stop'
			ELSE 'with-stop'
		END AS 'temp'
		FROM flights
)
SELECT temp, 
TIME_FORMAT(SEC_TO_TIME(AVG(duration_min)*60), '%kh %im') AS 'Avg_Duration'
FROM temp_table
GROUP BY temp;


# 14. Find all Air India flights in a given date range originating from Delhi
SELECT *
FROM flights
WHERE Source = 'Delhi' AND Airline = 'Air India'
AND DATE(departure) BETWEEN '2019-01-01' AND '2019-01-03';


# 15. Find the longest flight of each airline
SELECT Airline, 
TIME_FORMAT(SEC_TO_TIME(MAX(duration_min)*60), '%kh %im') AS 'Max_Duration'
FROM flights
GROUP BY Airline
ORDER BY MAX(duration_min) DESC;


# 16. Find all pairs of cities having average flight duration greater than 3 hours
SELECT Source, Destination, 
TIME_FORMAT(SEC_TO_TIME(AVG(duration_min)*60), '%kh %im') AS 'Avg_Duration'
FROM flights
GROUP BY Source, Destination
HAVING AVG(duration_min) > 180
ORDER BY duration_min DESC;


# 17. Make a weekday vs time grid showing frequency of flights from Bangalore and Delhi
SELECT DAYNAME(departure),
SUM(CASE WHEN HOUR(departure) BETWEEN 0 AND 5 THEN 1 ELSE 0 END) AS '12AM - 6AM',
SUM(CASE WHEN HOUR(departure) BETWEEN 6 AND 11 THEN 1 ELSE 0 END) AS '6AM - 12PM',
SUM(CASE WHEN HOUR(departure) BETWEEN 12 AND 17 THEN 1 ELSE 0 END) AS '12PM - 6PM',
SUM(CASE WHEN HOUR(departure) BETWEEN 18 AND 23 THEN 1 ELSE 0 END) AS '6PM - 12AM'
FROM flights
WHERE Source = 'Banglore' AND Destination = 'Delhi'
GROUP BY DAYNAME(departure)
ORDER BY DAYOFWEEK(departure) ASC;


# 18. Make a weekday vs time grid showing average flight price from Bangalore and Delhi
SELECT DAYNAME(departure),
AVG(CASE WHEN HOUR(departure) BETWEEN 0 AND 5 THEN price ELSE NULL END) AS '12AM - 6AM',
AVG(CASE WHEN HOUR(departure) BETWEEN 6 AND 11 THEN price ELSE NULL END) AS '6AM - 12PM',
AVG(CASE WHEN HOUR(departure) BETWEEN 12 AND 17 THEN price ELSE NULL END) AS '12PM - 6PM',
AVG(CASE WHEN HOUR(departure) BETWEEN 18 AND 23 THEN price ELSE NULL END) AS '6PM - 12AM'
FROM flights
WHERE Source = 'Banglore' AND Destination = 'Delhi'
GROUP BY DAYNAME(departure)
ORDER BY DAYOFWEEK(departure) ASC;







