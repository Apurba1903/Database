-- Join on the basis of Multiple Column
SELECT * FROM sql_cx_live.students t1
JOIN sql_cx_live.class t2
ON t1.class_id = t2.class_id 
AND t1.enrollment_year = t2.class_year;