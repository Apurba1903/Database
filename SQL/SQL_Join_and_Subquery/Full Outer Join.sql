-- Full Outer Join
SELECT * FROM sql_cx_live.membership t1
LEFT JOIN sql_cx_live.users1 t2
ON t1.user_id = t2.user_id

UNION

SELECT * FROM sql_cx_live.membership t1
RIGHT JOIN sql_cx_live.users1 t2
ON t1.user_id = t2.user_id;