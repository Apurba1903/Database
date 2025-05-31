USE sql_cx_live;
SELECT * FROM sql_cx_live.marks;


CREATE TABLE marks (
 student_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    branch VARCHAR(255),
    marks INTEGER
);


INSERT INTO marks (name,branch,marks)VALUES 
('Nitish','EEE',82),
('Rishabh','EEE',91),
('Anukant','EEE',69),
('Rupesh','EEE',55),
('Shubham','CSE',78),
('Ved','CSE',43),
('Deepak','CSE',98),
('Arpan','CSE',95),
('Vinay','ECE',95),
('Ankit','ECE',88),
('Anand','ECE',81),
('Rohit','ECE',95),
('Prashant','MECH',75),
('Amit','MECH',69),
('Sunny','MECH',39),
('Gautam','MECH',51);


# Per Group Basis Outcome
SELECT branch, AVG(marks)
FROM marks
GROUP BY branch;


# Per Row Basis Outcome
SELECT *,
AVG(marks) OVER(PARTITION BY branch)
FROM marks;


# Normal Aggregate Function
SELECT AVG(marks)
FROM marks;


# Using with over clause
SELECT *, 
AVG(marks) OVER(PARTITION BY branch)
FROM marks;


# Print Higest marks and Lowest marks
SELECT *,
AVG(marks) OVER(),
MIN(marks) OVER(),
MAX(marks) OVER(),
MIN(marks) OVER(PARTITION BY branch),
MAX(marks) OVER(PARTITION BY branch)
FROM marks;


# Find all the students who have marks higher than the avg marks of their respective branch
SELECT *
FROM (
			SELECT *,
			AVG(marks) OVER(PARTITION BY branch) AS 'branch_avg_marks'
			FROM marks
) t1
WHERE t1.marks > t1.branch_avg_marks;


# RANK / DENSE_RANK / ROW_NUMBER
# Overall Rank
SELECT *,
RANK() OVER(ORDER BY marks DESC)
FROM marks;


# Branch Wise Rank
SELECT *,
RANK() OVER(PARTITION BY branch ORDER BY marks DESC)
FROM marks;


# Create Roll no from branch and marks
# Branch Wise Dense_Rank
SELECT *,
DENSE_RANK() OVER(PARTITION BY branch ORDER BY marks DESC)
FROM marks;


# Row_Number
SELECT *,
ROW_NUMBER() OVER(PARTITION BY branch)
FROM marks;


# Assigning Unique ID
SELECT *,
CONCAT(branch, '-', ROW_NUMBER() OVER(PARTITION BY branch)) AS 'ID'
FROM marks;


# Find top 2 most paying customers of each month
USE zomatodb;


SELECT *
FROM (
			SELECT MONTHNAME(date) AS 'month', SUM(amount) AS 'total', user_id,
			RANK() OVER(PARTITION BY MONTHNAME(date) 
										ORDER BY SUM(amount) DESC) AS 'month_rank'
			FROM orders
			GROUP BY user_id, MONTHNAME(date)
			ORDER BY MONTHNAME(date) DESC
) t
WHERE t.month_rank < 3
ORDER BY month DESC, month_rank ASC;


# FIRST_VALUE / LAST_VALUE / NTH_VALUE
# FIRST_VALUE
SELECT *,
FIRST_VALUE(name) OVER(ORDER BY marks DESC)
FROM marks;


# LAST_VALUE
SELECT *,
LAST_VALUE(name) OVER(ORDER BY marks DESC)
FROM marks;


# NTH_VALUE
# Find the branch 2nd Toppers
SELECT *,
NTH_VALUE(name, 2) OVER(PARTITION BY branch ORDER BY marks DESC
					ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM marks;


# Find the branch Toppers
SELECT name, marks, branch
FROM (
				SELECT *,
				FIRST_VALUE(name) OVER(PARTITION BY branch ORDER BY marks DESC) AS 'topper_name',
				FIRST_VALUE(marks) OVER(PARTITION BY branch ORDER BY marks DESC) AS 'topper_marks'
				FROM marks
) t
WHERE t.name = t.topper_name AND t.marks = t.topper_marks;


# Frame Clause
SELECT *,
LAST_VALUE(name) OVER(PARTITION BY branch ORDER BY marks DESC 
					ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM marks;


SELECT *,
FIRST_VALUE(name) OVER(PARTITION BY branch ORDER BY marks DESC
					ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM marks;


# Find the last guy of each branch
SELECT name, marks, branch
FROM (
					SELECT *,
					LAST_VALUE(name) OVER(PARTITION BY branch ORDER BY marks DESC
										ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'bottom_name',
					LAST_VALUE(marks) OVER(PARTITION BY branch ORDER BY marks DESC
										ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'bottom_marks'
					FROM marks
) t
WHERE t.name = t.bottom_name AND t.marks = t.bottom_marks;


# Alternate way of writing Window Functions
SELECT name, marks, branch
FROM (
					SELECT *,
					LAST_VALUE(name) OVER w AS 'bottom_name',
					LAST_VALUE(marks) OVER w AS 'bottom_marks'
					FROM marks
                    WINDOW w AS (PARTITION BY branch ORDER BY marks DESC 
												ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
) t
WHERE t.name = t.bottom_name AND t.marks = t.bottom_marks;


# Find the 2nd last guy of each branch, 5th topper of each branch
SELECT name, marks, branch
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY branch ORDER BY marks ASC) as rank_asc
    FROM marks
) t
WHERE t.rank_asc = 2;


SELECT name, marks, branch
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY branch ORDER BY marks DESC) as rank_desc
    FROM marks
) t
WHERE t.rank_desc = 5;


# LEAD & LAG
SELECT *,
LAG(marks) OVER(PARTITION BY branch ORDER BY student_id) AS 'LAG',
LEAD(marks) OVER(PARTITION BY branch ORDER BY student_id) AS 'LEAD'
FROM marks;


# Find the MoM revenue growth of Zomato
USE zomatodb;

SELECT MONTHNAME(date), SUM(amount), 
LAG(SUM(amount)) OVER(ORDER BY MONTHNAME(date) DESC) AS 'LAG',
((SUM(amount) - LAG(SUM(amount)) OVER(ORDER BY MONTHNAME(date) DESC))
									/LAG(SUM(amount)) OVER(ORDER BY MONTHNAME(date) DESC))*100 
                                    AS 'MoM Revenue Growth'
FROM orders
GROUP BY MONTHNAME(date)
ORDER BY MONTHNAME(date) DESC;








