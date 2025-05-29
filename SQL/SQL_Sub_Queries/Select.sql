USE sql_cx_live;

# 1. Get the percentage of votes for each movie compared to the total number of votes.
SELECT name, (votes/(SELECT SUM(votes) FROM movies))* 100
FROM movies;


# 2. Display all movie names, genre, score and avg(score) of genre
SELECT name, genre, score, (SELECT ROUND(AVG(score),2) FROM movies m2 WHERE m2.genre = m1.genre) AS 'avg_genre'
FROM movies m1;


SELECT AVG(score) FROM movies GROUP BY genre;


