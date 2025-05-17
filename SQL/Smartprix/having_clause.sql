-- Find the avg price of smartphone brands which have more than 20 phones. 
SELECT brand_name,
COUNT(brand_name) AS 'count',
ROUND(AVG(price)) AS 'avg_price'
FROM smartprix.smartphones
GROUP BY brand_name
HAVING count > 20
ORDER BY avg_price DESC;


-- Find the avg rating of smartphone brands which have more than 20 phones. 
SELECT brand_name,
COUNT(brand_name) AS 'count',
ROUND(AVG(rating)) AS 'avg_rating'
FROM smartprix.smartphones
GROUP BY brand_name
HAVING count > 20
ORDER BY avg_rating DESC;


-- Find the top 3 brands with the higest avg ram that have a refresh rate of at least 90 Hz and fast charging available and dont consider brands which have less than 10 phones.
SELECT brand_name, 
COUNT(brand_name) AS 'count',
ROUND(AVG(ram_capacity)) AS 'avg_ram'
FROM smartprix.smartphones
WHERE refresh_rate > 90 AND fast_charging_available = '1'
GROUP BY brand_name
HAVING count > 10
ORDER BY avg_ram DESC
LIMIT 3;


-- Find the avg price of all the phone brands with avg rating > 70 and num_phones more than 10 among all 5g enabled phones
SELECT brand_name, 
ROUND(AVG(price)) AS 'avg_price'
FROM smartprix.smartphones
WHERE has_5g = 'True'
GROUP BY brand_name
HAVING COUNT(*) > 10 AND ROUND(AVG(rating)) > 70
ORDER BY avg_price DESC;
