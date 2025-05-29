# Independent Subquery - Table Subquery (Multiple Columns, Multiple Rows)
USE sql_cx_live;


# 1. Find the most profitable movie of each year
SELECT year, MAX(gross - budget)
FROM movies
GROUP BY year;

SELECT *
FROM movies
WHERE (year, gross - budget) IN (
										SELECT year, MAX(gross - budget)
										FROM movies
										GROUP BY year
);


# 2. Find the higest rated movie of each genre votes cutoff of 25000
SELECT genre, MAX(score)
FROM movies
WHERE votes > 25000
GROUP BY genre;

SELECT *
FROM movies
WHERE votes > 25000 AND (genre, score) IN (
																					SELECT genre, MAX(score)
																					FROM movies
																					WHERE votes > 25000
																					GROUP BY genre
);


# 3. Find the higest grossing movies of top 5 actor / direct combo in termns of total gross income
SELECT star, director, MAX(gross)
FROM movies
GROUP BY star, director
ORDER BY SUM(gross) DESC
LIMIT 5;


WITH top_duos AS (
									SELECT star, director, MAX(gross)
									FROM movies
									GROUP BY star, director
									ORDER BY SUM(gross) DESC
									LIMIT 5
)
SELECT *
FROM movies
WHERE (star, director, gross) IN (
								SELECT *
                                FROM top_duos
);