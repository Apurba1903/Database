USE drug;



# Q-6 For each condition, what is the average satisfaction level of drugs that are "On Label" vs "Off Label"?
WITH temp_df AS (
								SELECT 	`Condition`, 
												Indication, 
												Satisfaction,
												ROUND(AVG(Satisfaction) OVER(PARTITION BY `Condition`, Indication ORDER BY Satisfaction ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 2) AS 'avg_satisfaction',
												DENSE_RANK() OVER(PARTITION BY `Condition`, Indication ORDER BY Satisfaction) AS 'rank_num'
								FROM drug_clean
								)
SELECT 	temp_df.Condition,
				temp_df.Indication,
                temp_df.avg_satisfaction
FROM temp_df
WHERE rank_num = 1;



# Q-7 For each drug type (RX, OTC, RX/OTC), what is the average ease of use and satisfaction level of drugs with a price above the median for their type?
WITH temp_df AS 	(
								SELECT 	Type,
												AVG(EaseOfUse) OVER(PARTITION BY Type) AS 'avg_ease_of_use',
												AVG(Satisfaction) OVER(PARTITION BY Type) AS 'avg_satisfaction'
                                FROM 	(
											SELECT 	Type,
															Price,
                                                            PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY Price) OVER(PARTITION BY Type) AS 'median_price',
                                                            EaseOfUse,
                                                            Satisfaction
											FROM drug_clean
                                            WHERE Type IN ('RX', 'OTC', 'RX/OTC')
											) AS subquery
                                            WHERE Price >= median_price
                                )
SELECT Type, avg_ease_of_use, avg_satisfaction
FROM temp_df
GROUP BY Type;



# Q-8 What is the cumulative distribution of EaseOfUse ratings for each drug type (RX, OTC, RX/OTC)? Show the results in descending order by drug type and cumulative distribution. (Use the built-in method and the manual method by calculating on your own. For the manual method, use the "ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW" and see if you get the same results as the built-in method.)
SELECT 	Type, 
				EaseOfUse,
				COUNT(*) OVER(PARTITION BY Type ORDER BY EaseOfUse) * 1.0 / COUNT(*) OVER(PARTITION BY Type)  AS 'cumulative_dist_manual',
				CUME_DIST() OVER(PARTITION BY Type ORDER BY EaseOfUse) AS 'cumulative_dist_builtin'
FROM drug_clean
WHERE Type IN ('RX', 'OTC', 'RX/OTC')
ORDER BY Type, cumulative_dist_builtin DESC;



# Q-9 What is the median satisfaction level for each medical condition? Show the results in descending order by median satisfaction level. (Don't repeat the same rows of your result.)
WITH temp_df AS (
								SELECT 	`Condition`,
												PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Satisfaction) OVER(PARTITION BY `Condition`) AS 'median_satisfaction'
								FROM drug_clean
)
SELECT 	`Condition`, median_satisfaction
FROM temp_df
GROUP BY temp_df.`Condition`
ORDER BY temp_df.median_satisfaction DESC;



# Q-10 What is the running average of the price of drugs for each medical condition? Show the results in ascending order by medical condition and drug name.
SELECT 	`Condition`,
				Drug,
                ROUND(Price, 2),
                ROUND(AVG(Price) OVER(PARTITION BY `Condition` ORDER BY Drug ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 2) AS 'running_avg_price'
FROM drug_clean
ORDER BY `Condition` ASC, Drug ASC;



# Q-11 What is the percentage change in the number of reviews for each drug between the previous row and the current row? Show the results in descending order by percentage change.
SELECT 	`Condition`,
				Drug,
                Reviews,
                (Reviews - LAG(Reviews) OVER(PARTITION BY `Condition`, Drug ORDER BY Reviews DESC)) * 100 
														/ LAG(Reviews) OVER(PARTITION BY `Condition`, Drug ORDER BY Reviews DESC) 
																						AS pct_change
FROM drug_clean
ORDER BY pct_change DESC;



# Q-12 What is the percentage of total satisfaction level for each drug type (RX, OTC, RX/OTC)? Show the results in descending order by drug type and percentage of total satisfaction.
WITH temp_df AS (
			SELECT Type,
							Satisfaction,
							ROUND(SUM(Satisfaction) OVER(PARTITION BY Type) * 100 
														/ SUM(Satisfaction) OVER(), 2) 
																			AS pct_total_satisfaction
			FROM drug_clean
			WHERE Type IN ('RX', 'OTC', 'RX/OTC')
)
SELECT DISTINCT Type, pct_total_satisfaction
FROM temp_df
ORDER BY Type ASC, pct_total_satisfaction DESC;



# Q-13 What is the cumulative sum of effective ratings for each medical condition and drug form combination? Show the results in ascending order by medical condition, drug form and the name of the drug.
SELECT 	`Condition`, 
				Form, 
				Drug, 
                Effective, 
				SUM(Effective) OVER(PARTITION BY `Condition`, Form ORDER BY Drug ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
													AS cumulative_sum_effective
FROM drug_clean
ORDER BY `Condition` ASC, Form ASC, Drug ASC;



# Q-14 What is the rank of the average ease of use for each drug type (RX, OTC, RX/OTC)? Show the results in descending order by rank and drug type.
SELECT	Type,
				AVG(EaseOfUse) AS 'average_ease_of_use',
                RANK() OVER(ORDER BY AVG(EaseOfUse) DESC) AS 'rank'
FROM drug_clean
WHERE Type IN ('RX', 'OTC', 'RX/OTC')
GROUP BY Type;



# Q-15 For each condition, what is the average effectiveness of the top 3 most reviewed drugs?
SELECT *
FROM (
			SELECT	`Condition`,
							Drug,
							ROUND(Reviews, 2) AS 'Reviews',
							ROUND(AVG(Effective) OVER(PARTITION BY `Condition`, Drug ORDER BY Reviews DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 2) AS avg_effectiveness,
							RANK() OVER(PARTITION BY `Condition` ORDER BY Reviews DESC) AS 'rank_num'
			FROM drug_clean
) t
WHERE rank_num <= 3;

