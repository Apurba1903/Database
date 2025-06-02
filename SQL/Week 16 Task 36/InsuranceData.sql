USE insurance;
SELECT * FROM insurance_data;

# Problem 1: What are the top 5 patients who claimed the highest insurance amounts?
SELECT *,
DENSE_RANK() OVER(ORDER BY claim DESC)
FROM insurance_data
LIMIT 5;

# Problem 2: What is the average insurance claimed by patients based on the number of 
#					children they have?
SELECT children,  ROUND(avg_claim, 2)
FROM(
			SELECT *, 
			AVG(claim) OVER(PARTITION BY children) AS avg_claim,
			ROW_NUMBER() OVER(PARTITION BY children) AS row_num
			FROM insurance_data
) t
WHERE t.row_num = 1;

# Problem 3: What is the highest and lowest claimed amount by patients in each region?
SELECT region, max_claim, min_claim, row_num
FROM(
	SELECT *,
	MAX(claim) OVER(PARTITION BY region) AS max_claim,
	MIN(claim) OVER(PARTITION BY region) AS min_claim,
    ROW_NUMBER() OVER(PARTITION BY region) AS row_num
	FROM insurance_data
) t
WHERE t.row_num = 1;

# Problem 4: What is the percentage of smokers in each age group?
SELECT DISTINCT age,
       ROUND(
           (COUNT(CASE WHEN smoker = 'Yes' THEN 1 END) OVER(PARTITION BY age) * 100.0) / 
           COUNT(*) OVER(PARTITION BY age), 
           2
       ) AS smoker_percentage
FROM insurance_data
ORDER BY age;

# Problem 5: What is the difference between the claimed amount of each patient and the  
#					first claimed amount of the first patient?
SELECT *,
ROUND(claim - FIRST_VALUE(claim) OVER(), 3) AS 'diff'
FROM insurance_data; 

# Problem 6: For each patient, calculate the difference between their claimed amount and  
# 					the average claimed amount of patients with the same number of children.
SELECT *, 
ROUND(AVG(claim) OVER(PARTITION BY children), 2) AS avg_claim,
ROUND(claim - AVG(claim) OVER(PARTITION BY children), 2) AS claim_diff
FROM insurance_data;

# Problem 7: Show the patient with the highest BMI in each region and their respective rank.
SELECT *
FROM (
			SELECT *, 
			RANK() OVER(PARTITION BY region ORDER BY bmi DESC) AS 'region_rank',
			RANK() OVER(ORDER BY bmi DESC) AS 'overall_rank'
			FROM insurance_data
) t
WHERE t.region_rank = 1;

# Problem 8: Calculate the difference between the claimed amount of each patient and the 
#					claimed amount of the patient who has the highest BMI in their region.
SELECT *,
FIRST_VALUE(claim) OVER(PARTITION BY region ORDER BY bmi DESC) AS highest_bmi,
ROUND(claim - FIRST_VALUE(claim) OVER(PARTITION BY region ORDER BY bmi DESC), 2) AS diff
FROM insurance_data;

# Problem 9: For each patient, calculate the difference in claim amount between the patient 
#					and the patient with the highest claim amount among patients with the same smoker 
#					status, within the same region. Return the result in descending order difference.
SELECT *,
MAX(claim) OVER(PARTITION BY region, smoker) AS max_claim,
ROUND(MAX(claim) OVER(PARTITION BY region, smoker) - claim) AS claim_diff
FROM insurance_data
ORDER BY claim_diff DESC;

# Problem 10: For each patient, find the maximum BMI value among their next three records 
#					(ordered by age).
SELECT *,
MAX(bmi) OVER(ORDER BY age ROWS BETWEEN 1 FOLLOWING AND 3 FOLLOWING) AS max_bmi
FROM insurance_data;

# Problem 11: For each patient, find the rolling average of the last 2 claims.
SELECT *,
AVG(claim) OVER(ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING) AS rolling_avg
FROM insurance_data;

# Problem 12: Find the first claimed insurance value for male and female patients, within each  
#					region order the data by patient age in ascending order, and only include patients 
#					who are non-diabetic and have a bmi value between 25 and 30.
WITH filtered_data AS (
		SELECT *
        FROM insurance_data
        WHERE diabetic = 'No' AND bmi BETWEEN 25 AND 30
)

SELECT region, gender, first_claim
FROM (
				SELECT *,
				FIRST_VALUE(claim) OVER(PARTITION BY region, gender ORDER BY age ASC) AS 'first_claim',
				ROW_NUMBER() OVER(PARTITION BY region, gender ORDER BY age ASC) AS 'row_number'
				FROM filtered_data
) t
WHERE t.row_number = 1;



