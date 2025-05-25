-- Union 
SELECT * FROM sql_cx_live.person1
UNION
SELECT * FROM sql_cx_live.person2;

-- Union All
SELECT * FROM sql_cx_live.person1
UNION ALL
SELECT * FROM sql_cx_live.person2;

-- Intersect
SELECT * FROM sql_cx_live.person1
INTERSECT
SELECT * FROM sql_cx_live.person2;

-- Except
SELECT * FROM sql_cx_live.person1
EXCEPT
SELECT * FROM sql_cx_live.person2;