SELECT @@sql_mode;
SET sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- 1. Select a particular database
USE zomatodb;

-- 2. Count number of rows
SELECT COUNT(*)
FROM order_details;

-- 3. Return n random records
SELECT *
FROM orders
ORDER BY RAND()
LIMIT 5;

-- 4. Find null values
SELECT *
FROM orders
WHERE restaurant_rating IS NULL;

UPDATE orders 
SET restaurant_rating = NULL 
WHERE restaurant_rating = '';

-- 5. Find the number of orders placed by each customer
SELECT t1.name, COUNT(*) AS '#Orders'
FROM users t1
JOIN orders t2
ON t1.user_id = t2.user_id
GROUP BY t1.user_id;

-- 6. Find restaurant with most number of menu items
SELECT t1.r_name, COUNT(t2.r_id) AS '#Menu Items'
FROM restaurants t1
JOIN menu t2
ON t1.r_id = t2.r_id
GROUP BY t2.r_id;

-- 7. Find number of votes and avg rating for all the restaurants
SELECT r_name, COUNT(*) AS 'Num_of_Votes', ROUND(AVG(restaurant_rating), 2) AS 'Rating'
FROM orders t1
JOIN restaurants t2
ON t1.r_id = t2.r_id
WHERE restaurant_rating IS NOT NULL
GROUP BY t1.r_id;

-- 8. Find the food that is being sold at most number of restaurants
SELECT f_name, COUNT(*) AS 'Count'
FROM menu t1
JOIN food t2
ON t1.f_id = t2.f_id
GROUP BY t1.f_id
ORDER BY Count DESC
LIMIT 1;

-- 9. Find resturants with max revenue in a given month
-- SELECT MONTHNAME(DATE(date)) AS 'Month', date AS 'Date' FROM Orders;
SELECT r_name, SUM(amount) AS 'Revenue'
FROM orders t1
JOIN restaurants t2
ON t1.r_id = t2.r_id
WHERE MONTHNAME(DATE(date)) = 'May'
GROUP BY t1.r_id
ORDER BY Revenue DESC;

-- Extra. Month by Month revenue for a particular resturant.
SELECT  MONTHNAME(DATE(date)) AS 'Month_Name', SUM(amount) AS 'Revenue'
FROM orders t1
JOIN restaurants t2
ON t1.r_id = t2.r_id
WHERE r_name = 'kfc'
GROUP BY  MONTHNAME(DATE(date));

-- 10. Find restaurants with sals > x


-- 11. Find customers who have never ordered


-- 12. Show order details of a particular customer in a given date range


-- 13. Customer favourite food


-- 14. Find most costly restaurants(AVG price/dish)


-- 15. Find delivery partner compensation using the formula (deliveries * 100 + 1000*avg_rating)


-- 16. Find revenue per month for a restaurant


-- 17. Find correlation between delivery_time and total rating


-- 18. Find correlation between order and avg price for all restaurants


-- 19. Find all the veg restaurants


-- 20. Find min and max order value for all the customers

