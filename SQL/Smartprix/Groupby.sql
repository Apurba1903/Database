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


SELECT fast_charging_available,
ROUND(AVG(price)) AS 'avg_price',
ROUND(AVG(rating)) AS 'avg_rating'
FROM smartprix.smartphones
GROUP BY fast_charging_available;


-- Group Smartphones by the extended memory available and get the average price
SELECT extended_memory_available,
ROUND(AVG(price)) AS 'avg_price'
FROM smartprix.smartphones
GROUP BY extended_memory_available;


-- Group Smartphones by the brand and processor brand and get the count og models and the average primary rear camera resolution
SELECT brand_name, 
processor_brand,
COUNT(model) AS 'model_count',
ROUND(AVG(primary_camera_rear)) AS 'avg_prim_camera_rear'
FROM smartprix.smartphones
GROUP BY brand_name, processor_brand
ORDER BY brand_name ASC;


-- Find top 5 most costly phone brands
SELECT brand_name,
ROUND(AVG(price)) AS 'avg_cost'
FROM smartprix.smartphones
GROUP BY brand_name
ORDER BY avg_cost DESC
LIMIT 5;


-- Which brand makes the smallest screen smartphones
SELECT brand_name,
AVG(screen_size) AS 'avg_screen_size'
FROM smartprix.smartphones
GROUP BY brand_name
ORDER BY avg_screen_size ASC
LIMIT 1;


-- Avg price of 5g phones vs avg price of non 5g phones
SELECT has_5g,
ROUND(AVG(price)) AS 'avg_price'
FROM smartprix.smartphones
GROUP BY has_5g;


-- Group smartphones by the brand, and find the brand with the higest number of models that have both NFC and an IR Blaster
SELECT brand_name,
COUNT(brand_name) AS 'num'
FROM smartprix.smartphones
WHERE has_ir_blaster = 'True' AND has_nfc = 'True'
GROUP BY brand_name
ORDER BY num DESC;


-- Find all the samsung 5g enables smarphoners and find out the avg price for NFC and Non-NFC phones 
SELECT brand_name,
ROUND(AVG(price)) AS 'avg_price',
has_nfc
FROM smartprix.smartphones
WHERE brand_name = 'samsung' AND has_5g = 'True'
GROUP BY has_nfc;


-- Find the phone name, price of the costliest phone
SELECT model, price
FROM smartprix.smartphones
ORDER BY price DESC
LIMIT 1;

