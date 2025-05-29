USE zomatodb;

CREATE TABLE loyal_users
(
	user_id INT,
    name VARCHAR(50),
    money FLOAT
);

# FOR INSERT
# 1. Populate a already created loyal _customers table with records of only those customers who have ordered food more than 3 times
INSERT INTO loyal_users
(user_id, name)
							SELECT t1.user_id, name
							FROM orders t1
							JOIN users t2
							ON t1.user_id = t2.user_id
							GROUP BY user_id
							HAVING COUNT(*) > 3;


# FOR UPDATE
# 2. Populate the money col of loyal_customer table using the orders table. Provide a 10% app money to all the customer based on their order value.

UPDATE loyal_users
SET money =  (
							SELECT SUM(amount)*0.1
							FROM orders
							WHERE orders.user_id = loyal_users.user_id
);


# FOR DELETE
# 3. Delete all the customers record who have never ordered.

DELETE 
FROM users
WHERE user_id IN (
									SELECT user_id
									FROM users
									WHERE user_id  NOT IN (
																		SELECT DISTINCT(user_id)
																		FROM orders
									)
);