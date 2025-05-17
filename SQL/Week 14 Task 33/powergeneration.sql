-- Problem 6: Display those power stations which have average 'Monitored Cap.(MW)' (display the values) 
-- 					between 1000 and 2000 and the number of occurance of the power stations 
-- 					(also display these values) are greater than 200. Also sort the result in ascending order.
SELECT `Power Station`,
ROUND(AVG(`Monitored Cap.(MW)`), 2) AS 'avg_monitored_cap',
COUNT(*) AS 'occurance'
FROM tasks.powergeneration
GROUP BY `Power Station`
HAVING (occurance > 200) AND (avg_monitored_cap BETWEEN 1000 AND 2000)
ORDER BY avg_monitored_cap ASC;