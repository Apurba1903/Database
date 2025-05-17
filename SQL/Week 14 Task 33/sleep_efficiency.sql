-- Problem 1: Find out the average sleep duration of top 15 male candidates who's sleep 
-- 					duration are equal to 7.5 or greater than 7.5.
SELECT 
AVG(`Sleep duration`) AS 'avg_sleep_duration'
FROM tasks.sleep_efficiency
WHERE `Sleep duration` >= 7.5 AND Gender = 'Male'
ORDER BY `Sleep duration` DESC
LIMIT 15;


-- Problem 2: Show avg deep sleep time for both gender. Round result at 2 decimal places.
-- Note: sleep time and deep sleep percentage will give you, deep sleep time.
SELECT Gender,
ROUND(AVG((`Sleep duration` * `Deep sleep percentage`)/100), 2) AS 'avg_deep_sleep_time'
FROM tasks.sleep_efficiency
GROUP BY Gender;


-- Problem 3: Find out the lowest 10th to 30th light sleep percentage records where 
-- 					deep sleep percentage values are between 25 to 45. Display age, light sleep 
-- 					percentage and deep sleep percentage columns only.
SELECT Age,
`Light sleep percentage`,
`Deep sleep percentage`
FROM tasks.sleep_efficiency
WHERE `Deep sleep percentage` BETWEEN 25 AND 45
ORDER BY `Light sleep percentage` ASC
LIMIT 10, 20;


-- Problem 4: Group by on exercise frequency and smoking status and show 
-- 				average deep sleep time, average light sleep time and avg rem sleep time.
-- Note the differences in deep sleep time for smoking and non smoking status
SELECT `Smoking status`, `Exercise frequency`,
ROUND(AVG((`Sleep duration` * `Deep sleep percentage`)/100), 2) AS 'avg_deep_sleep_time',
ROUND(AVG((`Sleep duration` * `Light sleep percentage`)/100), 2) AS 'avg_light_sleep_time',
ROUND(AVG((`Sleep duration` * `REM sleep percentage`)/100), 2) AS 'avg_rem_sleep_time'
FROM tasks.sleep_efficiency
GROUP BY `Exercise frequency`, `Smoking status`
ORDER BY avg_deep_sleep_time DESC;


-- Problem 5: Group By on Awekning and show AVG Caffeine consumption, AVG Deep 
-- 					sleep time and AVG Alcohol consumption only for people who do exercise 
-- 					atleast 3 days a week. Show result in descending order awekenings
SELECT 
Awakenings,
ROUND(AVG(`Caffeine consumption`), 2) AS 'avg_caffine_comp',
ROUND(AVG((`Sleep duration` * `Deep sleep percentage`)/100), 2) AS 'avg_deep_sleep_time',
ROUND(AVG(`Alcohol consumption`), 2) AS 'avg_alcoh_comp'
FROM tasks.sleep_efficiency
WHERE `Exercise frequency` >= 3
GROUP BY Awakenings
ORDER BY Awakenings DESC;