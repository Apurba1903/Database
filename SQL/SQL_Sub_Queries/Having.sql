# 1. Find genres having avg score > avg score of all the movies
USE sql_cx_live;

SELECT AVG(score)
FROM movies;

SELECT genre, AVG(score)
FROM movies
GROUP BY genre
HAVING AVG(score) > (
										SELECT AVG(score)
										FROM movies
);



