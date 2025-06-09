USE sql_cx_live;


SELECT name, UPPER(name), LOWER(name)
FROM movies;


SELECT CONCAT(name, ' ', director, ' ', star)
FROM movies;


SELECT CONCAT_WS('/', name, director, star)
FROM movies;


SELECT name, SUBSTR(name, 1,5)
FROM movies;


SELECT name, SUBSTR(name, -6,1)
FROM movies;


SELECT REPLACE("Hello World", "World", "Bangladesh");


SELECT 5+6;


SELECT name, REPLACE(name, 'man', 'woman') 
FROM movies;


SELECT SUBSTR("Hello", -4,3);


SELECT REVERSE("Hello");


SELECT name
FROM movies
WHERE name = REVERSE(name);


SELECT name, LENGTH(name)
FROM movies;


SELECT name, CHAR_LENGTH(name)
FROM movies;


SELECT name, LENGTH(name), CHAR_LENGTH(name)
FROM movies
WHERE LENGTH(name) != CHAR_LENGTH(name);


SELECT INSERT("Hello World", 7, 5, "Bangladesh");


SELECT name, LEFT(name, 3), RIGHT(name, 3)
FROM movies;


SELECT REPEAT(name, 3)
FROM movies;


SELECT TRIM("         Apurba Halder                                       ");

SELECT TRIM(BOTH "." FROM ".............................Apurba Halder.............................");


SELECT TRIM(LEADING "." FROM ".............................Apurba Halder.............................");

SELECT TRIM(TRAILING "." FROM ".............................Apurba Halder.............................");


SELECT LENGTH(LTRIM("     Apurba     "));

SELECT LENGTH(RTRIM("     Apurba     "));


SELECT "www.apurba1903.com", SUBSTRING_INDEX("www.apurba1903.com", ".", 2);


SELECT STRCMP("Delhi", "Mumbai");

SELECT STRCMP("Mumbai", "Delhi");

SELECT STRCMP("Delhi", "DELHI");


SELECT LOCATE("w", "Hello World");


SELECT LPAD('1234567890', 14 ,'+880');

SELECT RPAD('1234567890', 14 ,'+880')
