# 1. Find all the movies that have a rating higher than the average rating of movies in the same genre. [Animation]
USE sql_cx_live;

SELECT genre, AVG(score)
FROM movies
GROUP BY genre
HAVING genre = 'Animation';

SELECT * 
FROM movies m1
WHERE score > (
									SELECT AVG(score)
									FROM movies m2
									WHERE m1.genre = m2.genre
);


# 2. Find the favourite food of each customer.alter
USE zomatodb;


WITH fav_food AS (
								SELECT t2.user_id, name, f_name, COUNT(*) AS 'frequency'
								FROM users t1
								JOIN orders t2 ON t1.user_id = t2.user_id
								JOIN order_details t3 ON t2.order_id = t3.order_id
								JOIN food t4 ON t3.f_id = t4.f_id
								GROUP BY t2.user_id, t3.f_id
)
SELECT *
FROM fav_food f1
WHERE frequency = (
									SELECT MAX(frequency)
                                    FROM fav_food f2
                                    WHERE f1.user_id = f2.user_id
);









