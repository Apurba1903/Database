USE olympic;
SELECT * FROM athlete_events LIMIT 5;

# Problem 1: Display the names of athletes who won a gold medal in the 2008 Olympics and 
#					whose height is greater than the average height of all athletes in the 2008 Olympics.

SELECT Name
FROM athlete_events
WHERE Medal = 'Gold' 
AND Year = 2008 
AND height > (
						SELECT AVG(Height)
                        FROM athlete_events
                        WHERE Year = 2008
);


# Problem 2: Display the names of athletes who won a medal in the sport of basketball in 
#					the 2016 Olympics and whose weight is less than the average weight of all 
#					athletes who won a medal in the 2016 Olympics.

SELECT Name
FROM athlete_events
WHERE Medal IS NOT NULL
AND Year = 2016 
AND Sport = 'Basketball'
AND Height < (
						SELECT AVG(Height)
						FROM athlete_events
						WHERE Year = 2016 
                        AND Medal IS NOT NULL
);


# Problem 3: Display the names of all athletes who have won a medal in the sport of 
#					swimming in both the 2008 and 2016 Olympics.

SELECT Name
FROM athlete_events
WHERE Medal IS NOT NULL
AND Sport = 'Swimming'
AND Year IN (2008, 2016);


# Problem 4: Display the names of all countries that have won more than 50 medals 
#					in a single year.

SELECT Team, COUNT(*), Year
FROM athlete_events
WHERE Medal IS NOT NULL AND Team IS NOT NULL
GROUP BY Team, Year
HAVING COUNT(*) > 50
ORDER BY Year, Team;


# Problem 5: Display the names of all athletes who have won medals in more than 
#					one sport in the same year.

SELECT DISTINCT(Name)
FROM athlete_events
WHERE ID IN (
						SELECT DISTINCT(ID)
						FROM athlete_events
						WHERE Medal IS NOT NULL
						GROUP BY ID, Year, Name, Sport
						HAVING COUNT(Medal) > 1
						ORDER BY  COUNT(Medal) DESC
);


# Problem 6: What is the average weight difference between male and female athletes 
#					in the Olympics who have won a medal in the same event?

WITH result AS (
							SELECT * 
							FROM athlete_events
							WHERE Medal IS NOT NULL
)
SELECT AVG(A.Weight - B.Weight)
FROM result A
JOIN result B
ON A.Event = B.Event
AND A.Sex != B.Sex;