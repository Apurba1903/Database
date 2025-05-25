-- Cross Join
SELECT * FROM sql_cx_live.users1 t1 
CROSS JOIN sql_cx_live.groups t2;

-- Inner Join
SELECT * FROM sql_cx_live.membership t1
INNER JOIN sql_cx_live.users1 t2
ON t1.user_id = t2.user_id;

-- Left Join
SELECT * FROM sql_cx_live.membership t1
LEFT JOIN sql_cx_live.users1 t2
ON t1.user_id = t2.user_id;

-- Right Join
SELECT * FROM sql_cx_live.membership t1
RIGHT JOIN sql_cx_live.users1 t2
ON t1.user_id = t2.user_id;

-- Full Outer Join
SELECT * FROM sql_cx_live.membership t1
FULL OUTER JOIN sql_cx_live.users1 t2
ON t1.user_id = t2.user_id;
-- Full Outer Join Cannot be performed in SQL

-- Self Join
SELECT * FROM sql_cx_live.users1 t1
JOIN sql_cx_live.users1 t2
ON t1.emergency_contact = t2.user_id;