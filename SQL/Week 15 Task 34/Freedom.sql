-- Q-1 Find out top 10 countries' which have maximum A and D values.
SELECT A.Country, A, D FROM
(SELECT Country, A
FROM freedomranking.country_ab
ORDER BY A DESC
LIMIT 10) A

LEFT JOIN

(SELECT Country, D
FROM freedomranking.country_cd
ORDER BY D DESC
LIMIT 10) B

ON A.Country = B.Country


UNION 


SELECT B.Country, A, D FROM
(SELECT Country, A
FROM freedomranking.country_ab
ORDER BY A DESC
LIMIT 10) A

RIGHT JOIN

(SELECT Country, D
FROM freedomranking.country_cd
ORDER BY D DESC
LIMIT 10) B

ON A.Country = B.Country
ORDER BY Country;




-- Q-2 Find out highest CL value for 2020 for every region. Also sort the result in descending order. 
--         Also display the CL values in descending order.

SELECT t2.Region, MAX(CL)
FROM freedomranking.country_cl t1
JOIN freedomranking.country_ab t2
ON t1.Country = t2.Country
WHERE t1.Edition = '2020'
GROUP BY t2.Region
ORDER BY MAX(CL) DESC;