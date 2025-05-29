USE insurance;
SELECT * FROM insurance_data LIMIT 5;

# Problem 7: How many patients have claimed more than the average claim amount for patients who 
#					are smokers and have at least one child, and belong to the southeast region?

SELECT COUNT(PatientID)
FROM insurance_data
WHERE claim > (
							SELECT AVG(claim)
							FROM insurance_data
                            WHERE smoker = 'Yes'
							AND children > 0
							AND region = 'southeast'
);


# Problem 8: How many patients have claimed more than the average claim amount for patients who 
#					are not smokers and have a BMI greater than the average BMI for patients who have at least one child?

SELECT COUNT(PatientID)
FROM insurance_data
WHERE claim > (
							SELECT AVG(claim)
							FROM insurance_data
                            WHERE smoker = 'No'
							AND bmi > (
												SELECT AVG(bmi)
                                                FROM insurance_data
                                                WHERE children > 0
                            )
);


# Problem 9: How many patients have claimed more than the average claim amount for patients who 
#					have a BMI greater than the average BMI for patients who are diabetic, have at least one child, 
#					and are from the southwest region?

SELECT COUNT(PatientID)
FROM insurance_data
WHERE claim > (
							SELECT AVG(claim)
							FROM insurance_data
                            WHERE bmi > (
												SELECT AVG(bmi)
                                                FROM insurance_data
                                                WHERE children > 0
                                                AND diabetic = 'Yes'
                                                AND region = 'southwest'
                            )
);


# Problem 10: What is the difference in the average claim amount between patients who 
#					are smokers and patients who are non-smokers, and have the same BMI 
#					and number of children?

SELECT AVG(A.claim - B.claim) FROM insurance_data A
JOIN insurance_data B
ON A.bmi = B.bmi 
AND A.smoker != B.smoker
AND A.children = B.children;