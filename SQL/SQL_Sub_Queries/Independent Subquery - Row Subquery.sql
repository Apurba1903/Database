# Independent Subquery - Row Subquery (One Column, Multiple Rows)


# 1. Find all the users who never ordered
USE zomatodb;

SELECT DISTINCT (user_id)
FROM orders;

SELECT *
FROM users
WHERE user_id
NOT IN (
				SELECT DISTINCT (user_id)
				FROM orders
);


# 2. Find all the movies made by top 3 directors (In terms of total gross income)
USE sql_cx_live;

SELECT director 
FROM movies 
GROUP BY director
ORDER BY SUM(gross) DESC
LIMIT 3;

SELECT *
FROM movies
WHERE director IN (
							SELECT director 
							FROM movies 
							GROUP BY director
							ORDER BY SUM(gross) DESC
							LIMIT 3
); # Does not work with thgis version of MySQL

WITH top_directors AS (
									SELECT director 
									FROM movies 
									GROUP BY director
									ORDER BY SUM(gross) DESC
									LIMIT 3
)
SELECT *
FROM movies
WHERE director IN (
								SELECT *
                                FROM top_directors
);


# 3. Find all movies of all those actors whose filmography's avg rating > 8.5 (Take 25000 votes as cutoff)
SELECT star
FROM movies 
WHERE votes > 25000
GROUP BY star
HAVING AVG(score) > 8.5
ORDER BY AVG(score)  DESC;

SELECT *
FROM movies
WHERE star  IN (
								SELECT star
								FROM movies 
								WHERE votes > 25000
								GROUP BY star
								HAVING AVG(score) > 8.5
								ORDER BY AVG(score)  DESC
);