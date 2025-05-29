USE sql_cx_live;


SELECT MAX(score)
FROM movies;


SELECT name, score 
FROM movies
WHERE score = (SELECT MAX(score) FROM movies);


# Bases on Result, Subqueries are 3 types. 
# 1. Scaler Subquery - Gives Single Data from inner script
# 2. Row Subquery - Gives Single Column from inner script
# 3. Table Subquery - Gives Table from inner script


# Bases on Execution, Subqueries are 2 types. 
# 1. Independent Subquery - Inner query is not related to outer query
# 2. Correated Subquery - Inner query is related to outer query