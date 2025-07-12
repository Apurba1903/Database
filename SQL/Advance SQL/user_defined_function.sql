-- Non-Parameterise User Define Function
SELECT hello_world() AS message;

SELECT hello_world() FROM flightdb.flightdb;

SELECT UPPER(airline) FROM flightdb.flightdb;


-- Parameterise User Define Function
SELECT calculate_age('2002-03-19');


SELECT * FROM salesdb.employees;

UPDATE salesdb.employees
SET FirstName = LOWER(FirstName);


SELECT * FROM flightdb.flightdb;


SELECT *, format_date(date_of_journey) FROM flightdb.flightdb;


SELECT flights_between('Bengaluru', 'New Delhi') AS num_flights;




