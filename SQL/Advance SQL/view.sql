-- Simple View
USE flightdb;

SELECT * FROM flightdb;

CREATE VIEW indigo AS
SELECT * FROM flightdb
WHERE airline = 'Indigo';

SELECT * FROM indigo;

SHOW TABLES;



-- Complex Views
USE zomatodb;

CREATE VIEW joined_order_data AS
SELECT order_id, amount, r_name, name, date, delivery_time, delivery_rating, restaurant_rating FROM orders t1
JOIN users t2
ON t1.user_id = t2.User_id
JOIN restaurants t3
ON t1.r_id = t3.r_id;

SELECT r_name, MONTHNAME(date) AS month_name, SUM(amount) AS total_amount
FROM joined_order_data
GROUP BY r_name, MONTH(date), MONTHNAME(date);



-- Updateable View
USE flightdb;

UPDATE flightdb
SET Source = 'Bengaluru'
WHERE Source = 'Banglore';

SELECT * FROM indigo;

UPDATE indigo
SET Destination = 'Delhi'
WHERE Destination = 'New Delhi';

SELECT * FROM flightdb;




