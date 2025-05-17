-- Group Smartphones by brand and get the count, average price, max, rating, avg screen size and avg battery capacity
SELECT brand_name, 
COUNT(*) AS 'Num_Phones', 
ROUND(AVG(price)) AS 'avg_price',
ROUND(MAX(rating)) AS 'max_rating',
ROUND(AVG(screen_size), 2) AS 'avg_screen_size',
ROUND(AVG(battery_capacity)) AS 'avg_battery_capacity'
FROM smartprix.smartphones
GROUP BY brand_name
ORDER BY Num_Phones DESC;


-- Group Smartphones by whether they have an NFC and get the average price and rating
SELECT has_nfc,
ROUND(AVG(price)) AS 'avg_price',
ROUND(AVG(rating)) AS 'avg_rating'
FROM smartprix.smartphones
GROUP BY has_nfc;


SELECT has_5g,
ROUND(AVG(price)) AS 'avg_price',
ROUND(AVG(rating)) AS 'avg_rating'
FROM smartprix.smartphones
GROUP BY has_5g;


SELECT has_5g,
ROUND(AVG(price)) AS 'avg_price',
ROUND(AVG(rating)) AS 'avg_rating'
FROM smartprix.smartphones
GROUP BY has_5g;


-- Group Smartphones by the extended memory available and get the average price



-- Group Smartphones by the brand and processor brand and get the count og models and the average primary rear camera resolution



-- Find top 5 most costly phone brands



-- Which brand makes the smallest screen smartphones



-- Avg price of 4g phones vs avg price of non 5g phones



-- Group smartphones by the brand, and find the brand with the higest number of models that have both NFC and an IR Blaster



-- Find all the samsung 5g enables smarphoners and find out the avg price for NFC and Non-NFC phones 



-- Find the phone name, price of the costliest phone


