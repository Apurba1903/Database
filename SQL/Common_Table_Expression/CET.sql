USE sql_cx_live;


CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    emp_department VARCHAR(50),
    emp_salary DECIMAL(10, 2),
    emp_duration_in_days INT
);


INSERT INTO Employees (emp_id, emp_name, emp_department, emp_salary, emp_duration_in_days)
VALUES
(1, 'John Doe', 'IT', 60000, 365),
(2, 'Jane Smith', 'HR', 50000, 730),
(3, 'Bob Brown', 'Sales', 55000, 180),
(4, 'Alice White', 'IT', 70000, 540),
(5, 'Charlie Black', 'HR', 45000, 120),
(6, 'David Green', 'Marketing', 48000, 300),
(7, 'Eva Blue', 'Sales', 52000, 250),
(8, 'Frank Gray', 'IT', 62000, 400),
(9, 'Grace Yellow', 'Finance', 58000, 600),
(10, 'Henry Pink', 'Marketing', 47000, 365),
(11, 'Isla Purple', 'HR', 46000, 220),
(12, 'Jack Red', 'Sales', 51000, 540),
(13, 'Karen Orange', 'Finance', 61000, 730),
(14, 'Liam Cyan', 'IT', 64000, 365),
(15, 'Mia Violet', 'Marketing', 49000, 180),
(16, 'Noah Indigo', 'Sales', 53000, 450),
(17, 'Olivia Silver', 'HR', 47000, 500),
(18, 'Paul Bronze', 'IT', 69000, 600),
(19, 'Quincy Gold', 'Finance', 66000, 720),
(20, 'Rachel Platinum', 'Marketing', 46000, 365);


select * from employees;


-- CTE-  STANDS FOR COMMON TABLE EXPRESSION , THAT WE GENERALLY USE WHEN WE ARE USING A SAME SUB-QUERY MULTIPLE TIMES
-- TO ENHANCE REDABILITY ,REDUCE COMPLEXITY , ENHANCE PERFORMANCE.
-- WE WRITE IT USING WITH CLAUSE.
-- CTE LIFE IS  ONLY TILL  THE EXECUTION+FORMATION {TOGETHER} OF THE QUERY
-- QUERY WITH "WITH CLAUSE"
-- QUERY SUB-FOLDING.


-- FIND THE EMPLOYEES WHOSE SALARY IS IN THE RANGE +-2000 OF AVERAGE SALARY WHERE DEPARTMENT IS abc  AND EMP_DURA>200.
-- LOGIC
--  STEP 1 WE NEED TO FIND AVERAGE SALARY ON THE BASIS OF GIVEN CONDITION.

--  STEP 2 FROM  THE TABLE , FIND THE EMPLOYESS WHO LIE IN RANGE OF THE GIVEN AVERAGE.


-- ISSUE 
     -- DECREASES REDABILITY.
     -- COMPLEXITY INCREASES.
     -- DECREASES PERFORMANCE.
     
     
-- USING CTE.


-- SELECT THE DEPARTMENT FROM EMPLOYEES TABLE  WHOSE AVERAGE SALARY  IS MORE THAN AVERAGE SALARY  ACROSS ALL DEPARTMENTS
-- LOGIC
-- STEP 1 -  AVERAGE SALARY OF EACH DEPARTMENT    [DEP_AVG]


-- STEP 2 - FIND AVERAGE SALARY WITH RESPECT TO ALL THE DEPARTMENT   [ENTIRE_AVG]


-- STEP 3 - FIND THE DEPARTMENT WHERE DEP_AVG> ENTIRE_AVG


-- WITH CTE.













































































