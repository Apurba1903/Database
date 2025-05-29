# Independent Subquery - Scaler Subquery
USE sql_cx_live;


# 1. Find the movie with higest profit(vs order by)
SELECT MAX(gross - budget) 
FROM movies;

SELECT *
FROM movies 
WHERE (gross - budget) = (
											SELECT MAX(gross - budget) 
											FROM movies
);

SELECT *
FROM movies
ORDER BY (gross - budget) DESC
LIMIT 1;


# 2. Find how many movies have a rating > the avg of all the movies rating (Find the count of above average movies)
SELECT AVG(score)
FROM movies;

SELECT COUNT(*) 
FROM movies
WHERE score > (
								SELECT AVG(score)
								FROM movies
);


# 3. Find the higest rated movie of 2000
SELECT MAX(score)
FROM movies
WHERE year = 2000;

SELECT *
FROM movies
WHERE year = 2000 AND score = (
														SELECT MAX(score)
														FROM movies
														WHERE year = 2000
);


# 4. Find the higest rated movie among all movies whose number of votes are > the dataset avg votes
SELECT AVG(votes)
FROM movies;

SELECT MAX(score)
FROM movies
WHERE votes > (
							SELECT AVG(votes)
							FROM movies
);

SELECT * 
FROM movies
WHERE score = (
							SELECT MAX(score)
							FROM movies
							WHERE votes > (
														SELECT AVG(votes)
														FROM movies
							)
);