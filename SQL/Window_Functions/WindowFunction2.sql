USE ipl;

# Find all the team and their top 5 batsman name from IPL dataset. (Ranking)

SELECT *
FROM (
			SELECT BattingTeam, batter, SUM(batsman_run) AS 'total_runs',
			DENSE_RANK() OVER(PARTITION BY BattingTeam ORDER BY SUM(batsman_run) DESC) AS 'rank_within_team'
			FROM ipl
			GROUP BY BattingTeam, batter
) t
WHERE t.rank_within_team < 6
ORDER BY t.BattingTeam, t.rank_within_team;



# What is the career run of V Kohli after his 50th, 100th and 200th match?  (Cumulative Sum)

SELECT t.match_no, t.career_run
FROM (
SELECT 
CONCAT("Match-", CAST(ROW_NUMBER() OVER(ORDER BY ID) AS CHAR)) AS 'match_no',
SUM(batsman_run) AS 'runs_scored',
SUM(SUM(batsman_run)) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'career_run'
FROM ipl
WHERE batter = 'V Kohli'
GROUP BY ID
) t
WHERE match_no = 'Match-50' OR match_no = 'Match-100' OR match_no = 'Match-200';



# What is the career run of V Kohli after his 50th, 100th and 200th match?  (Cumulative Average)

SELECT t.match_no, t.avg_run
FROM (
SELECT 
CONCAT("Match-", CAST(ROW_NUMBER() OVER(ORDER BY ID) AS CHAR)) AS 'match_no',
SUM(batsman_run) AS 'runs_scored',
SUM(SUM(batsman_run)) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'career_run',
AVG(SUM(batsman_run)) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'avg_run'
FROM ipl
WHERE batter = 'V Kohli'
GROUP BY ID
) t
WHERE match_no = 'Match-50' OR match_no = 'Match-100' OR match_no = 'Match-200';



# Find current trends for every 10 match for V Kohli. (Running Average)

SELECT *
FROM (
SELECT 
CONCAT("Match-", CAST(ROW_NUMBER() OVER(ORDER BY ID) AS CHAR)) AS 'match_no',
SUM(batsman_run) AS 'runs_scored',
SUM(SUM(batsman_run)) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'career_run',
AVG(SUM(batsman_run)) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'avg_run',
AVG(SUM(batsman_run)) OVER (ROWS BETWEEN 9 PRECEDING AND CURRENT ROW) AS 'running_avg'
FROM ipl
WHERE batter = 'V Kohli'
GROUP BY ID
) t;



SELECT * FROM zomatodb;
# For a particular restaurant, Which is the most valuable food that sales the most?

SELECT f_name,
(total_value / SUM(total_value) OVER()) * 100 AS 'percent_of_total'
FROM (
			SELECT f_id, SUM(amount) AS 'total_value'
			FROM orders t1
			JOIN order_details t2
			ON t1.order_id = t2.order_id
			WHERE r_id = 1
			GROUP BY f_id
) t
JOIN food t3
ON t.f_id = t3.f_id
ORDER BY (total_value / SUM(total_value) OVER()) * 100 DESC;

















