# Youtube views month by month percentage. (Percent Change)

SELECT YEAR(Date), MONTHNAME(Date), SUM(Views) AS 'views',
((SUM(Views) - LAG(SUM(Views)) OVER(ORDER BY YEAR(Date), MONTH(Date))) 
						/ LAG(SUM(Views)) OVER(ORDER BY YEAR(Date), MONTH(Date))) * 100 
								AS 'percent_change'
FROM youtube_views
GROUP BY YEAR(Date), MONTHNAME(Date)
ORDER BY YEAR(Date), MONTH(Date);



# Youtube views week by week percentage.  (Percent Change)

SELECT *,
((Views - LAG(Views, 7) OVER(ORDER BY Date)) 
					/ LAG(Views, 7) OVER(ORDER BY Date)) * 100 
								AS 'weekly_percent_change'
FROM youtube_views;



USE sql_cx_live;
# Find the median marks of all the students. (Percentiles & Quantiles)

SELECT *,
PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY marks) OVER() AS 'median_marks'
FROM marks;



# Find branch wise median of student marks. (Percentiles & Quantiles)

SELECT *,
PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY marks) 
											OVER(PARTITION BY branch) AS 'median_marks'
FROM marks;



# Query to remove outliers

SELECT *
FROM
		(SELECT *,
		PERCENTILE_CONT(0.25) GROUP(ORDER BY marks) OVER() AS 'Q1',
		PERCENTILE_CONT(0.75) GROUP(ORDER BY marks) OVER() AS 'Q3'
		FROM marks) t
WHERE t.marks > t.Q1 - (1.5*(t.Q3 - t.Q1)) 
AND t.marks < t.Q3 + (1.5*(t.Q3 - t.Q1))
ORDER BY t.student_id;



# Query to check outliers

SELECT *
FROM
		(SELECT *,
		PERCENTILE_CONT(0.25) GROUP(ORDER BY marks) OVER() AS 'Q1',
		PERCENTILE_CONT(0.75) GROUP(ORDER BY marks) OVER() AS 'Q3'
		FROM marks) t
WHERE t.marks <= t.Q1 - (1.5*(t.Q3 - t.Q1)) 
OR t.marks >= t.Q3 + (1.5*(t.Q3 - t.Q1))
ORDER BY t.student_id;



# Divide all the students into 3 equal sized groups (Segmentation)

SELECT *,
NTILE(3) OVER(ORDER BY marks DESC) AS 'buckets'
FROM marks;



# Make phones into 3 type Category (Segmentation | NTILE | Case/End (IF/ELSE))

USE smartprix;

SELECT brand_name, model, price,
CASE
		WHEN bucket = 1 THEN 'budget'
        WHEN bucket = 2 THEN 'mid_range'
        WHEN bucket = 3 THEN 'premium'
END AS 'phone_type'
FROM (
			SELECT brand_name, model, price,
			NTILE(3) OVER(PARTITION BY brand_name ORDER BY price) AS 'bucket'
			FROM smartphones
) t;



USE sql_cx_live;
# Find the percentile value of students (Cumulative Distribution)

SELECT *
FROM (
	SELECT *,
	CUME_DIST() OVER(ORDER BY marks) AS 'percentile_score'
	FROM marks
) t
WHERE t.percentile_score > 0.90;



USE flightdb;
# Cheapest flight between two cities. (Partition by Multiple Columns)

SELECT *
FROM
			(SELECT source, destination, airline, AVG(price) AS 'avg_fare',
			DENSE_RANK() OVER(PARTITION BY source, destination ORDER BY AVG(price)) AS 'rank'
			FROM flightdb
			GROUP BY source, destination, airline
) t
WHERE t.rank < 2;

