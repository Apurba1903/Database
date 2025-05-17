-- Find top 5 Samsung phones with biggest screen size
SELECT * 
FROM smartprix.smartphones
WHERE brand_name = 'samsung'
ORDER BY screen_size DESC
LIMIT 5;

-- Sort all the phone with in decending order of number of total cameras
SELECT model, num_front_cameras + num_rear_cameras AS 'total_cameras'
FROM smartprix.smartphones
ORDER BY total_cameras DESC;

-- Sort data on the basis of ppi in decending order
SELECT model,
round(SQRT(resolution_width*resolution_width + resolution_height*resolution_height)/screen_size,2)
AS 'PPI'
FROM smartprix.smartphones
ORDER BY PPI DESC;

-- Find the phone with 2nd Largest Battery
SELECT model, battery_capacity
FROM smartprix.smartphones
ORDER BY battery_capacity DESC
LIMIT 1,1;

-- Find the name and rating of the worst rated apple phone
SELECT model, rating
FROM smartprix.smartphones
WHERE brand_name = 'apple'
ORDER BY rating ASC
LIMIT 1;

-- Sort phones Alphabetically and then on the basis of rating in desc order
SELECT *
FROM smartprix.smartphones
ORDER BY brand_name ASC, rating DESC;

-- Sort phones Alphabetically and then on the basis of price in asc order
SELECT *
FROM smartprix.smartphones
ORDER BY brand_name ASC, price ASC;