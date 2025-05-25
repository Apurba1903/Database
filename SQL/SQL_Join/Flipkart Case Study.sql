-- 1. Find Order Name and corresponding User Name.
SELECT * 
FROM flipkart.order_details t1
JOIN flipkart.orders t2
ON t1.order_id = t2.order_id
JOIN flipkart.users t3
ON t2.user_id = t3.user_id;

-- 2. Find order_id, ammout and name.
SELECT t1.order_id, t1.amount, t3.name 
FROM flipkart.order_details t1
JOIN flipkart.orders t2
ON t1.order_id = t2.order_id
JOIN flipkart.users t3
ON t2.user_id = t3.user_id;

-- 3. Find order_id, name and city by joining users and orders.
SELECT t2.order_id, t1.name, t1.city
FROM flipkart.users t1
JOIN flipkart.orders t2
ON t1.user_id = t2.user_id;

-- 4. Find order_id, product category by joining order_details and category.
SELECT t1.order_id, t2.vertical
FROM flipkart.order_details t1
JOIN flipkart.category t2
ON t1.category_id = t2.category_id;

-- 5. Find all the orders placed in Pune
SELECT *
FROM flipkart.orders t1
JOIN flipkart.users t2
ON t1.user_id = t2.user_id
WHERE t2.city = 'Pune';

-- 6. Find all orders under Chair Category
SELECT *
FROM flipkart.order_details t1
JOIN flipkart.category t2
ON t1.category_id = t2.category_id
WHERE t2.vertical = 'Chairs';