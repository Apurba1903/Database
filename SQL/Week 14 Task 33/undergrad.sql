-- Problem 7: Display top 10 lowest "value" State names of which the Year either belong to 
-- 					2013 or 2017 or 2021 and type is 'Public In-State'. Also the number of occurance 
-- 					should be between 6 to 10. Display the average value upto 2 decimal places, 
-- 					state names and the occurance of the states.
SELECT State,
COUNT(*) AS 'occurance',
ROUND(AVG(Value), 2) AS 'avg_values'
FROM tasks.nces330_20
WHERE Year = 2013 OR Year = 2017 OR Year =  202 AND Type = 'Public In-State'
GROUP BY State
HAVING occurance BETWEEN 6 AND 10
ORDER BY avg_values ASC
LIMIT 10;


-- Problem -8: Best state in terms of low education cost (Tution Fees) in 'Public' type university.
SELECT State,
ROUND(AVG(Value), 2) AS 'avg_values'
FROM tasks.nces330_20
WHERE Type LIKE '%Public%'  AND Expense LIKE '%Tuition%'
GROUP BY State
ORDER BY avg_values ASC
LIMIT 1;


-- Problem 9: 2nd Costliest state for Private education in year 2021. Consider, Tution and Room fee both.
SELECT State,
ROUND(AVG(Value), 2) AS 'avg_values'
FROM tasks.nces330_20
WHERE Year = 2021 AND Type LIKE '%Private%'
GROUP BY State
ORDER BY avg_values DESC
LIMIT 1,1;