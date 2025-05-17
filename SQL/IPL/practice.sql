-- Find the top 5 Batsman in IPL
SELECT batter,
SUM(batsman_run) AS 'total_run'
FROM ipl.ipl_ball_by_ball_2008_2022
GROUP BY batter
ORDER BY total_run DESC
LIMIT 5;


-- Find the 2nd higest 6's hitter in IPL
SELECT batter,
COUNT(*) AS 'total_sixes'
FROM ipl.ipl_ball_by_ball_2008_2022
WHERE batsman_run = 6
GROUP BY batter
ORDER BY total_sixes DESC
LIMIT 1,1;


-- Find Virat Kohli's performance against all IPL teams [balling team info not given]
SELECT batter, 
SUM(batsman_run)
FROM ipl.ipl_ball_by_ball_2008_2022
WHERE batter = 'V Kohli';


-- Find top 10 batmans with centuries in IPL
SELECT batter,
ID,
SUM(batsman_run) AS 'total_run'
FROM ipl.ipl_ball_by_ball_2008_2022
GROUP BY ID, batter
HAVING total_run >= 100;


-- Find top 5 batsman with higest strike rate who have played a min of 1000 balls
SELECT batter,
SUM(batsman_run) AS 'total_run',
COUNT(batsman_run) AS 'balls_played',
ROUND((SUM(batsman_run)/COUNT(batsman_run))*100, 2) AS 'strike_rate'
FROM ipl.ipl_ball_by_ball_2008_2022
GROUP BY batter
HAVING balls_played > 1000
ORDER BY strike_rate DESC
LIMIT 5;