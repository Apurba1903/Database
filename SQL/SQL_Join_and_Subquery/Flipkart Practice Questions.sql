-- 1. Find all profitable orders. 
SELECT t1.order_id, SUM(t2.profit) AS 'Total_Profit'
FROM flipkart.orders t1
JOIN flipkart.order_details t2
ON t1.order_id = t2.order_id
GROUP BY t1.order_id
HAVING Total_Profit > 0;

-- 2. Find the customer who has placed max number of orders.
SELECT t2.name,COUNT(*) AS 'num_orders'
FROM flipkart.orders t1
JOIN flipkart.users t2
ON t1.user_id = t2.user_id
GROUP BY t2.name
ORDER BY num_orders DESC
LIMIT 1;

-- 3. Which is the most profitable category. 
SELECT t2.vertical, SUM(profit) AS 'Profit'
FROM flipkart.order_details t1
JOIN flipkart.category t2
ON t1.category_id = t2.category_id
GROUP BY t2.vertical
ORDER BY Profit DESC
LIMIT 1;

-- 4. Which is the most profitable state.
SELECT t3.state, SUM(profit) AS 'Profit'

FROM flipkart.orders t1
JOIN flipkart.order_details t2
ON t1.order_id = t2.order_id

JOIN flipkart.users t3
ON t1.user_id = t3.user_id

GROUP BY t3.state
ORDER BY Profit DESC
LIMIT 1;

-- 5. Find all categories with profit higher than 3000. 
SELECT t2.vertical, SUM(profit) AS 'Profit'
FROM flipkart.order_details t1
JOIN flipkart.category t2
ON t1.category_id = t2.category_id
GROUP BY t2.vertical
HAVING Profit > 3000;