# Wildcard is used for Pattern Matching
# ____ and %%%



USE sql_cx_live;


SELECT name
FROM movies
WHERE name LIKE '_____';


SELECT name
FROM movies
WHERE name LIKE 'A____';


SELECT name
FROM movies
WHERE name LIKE '%man';



