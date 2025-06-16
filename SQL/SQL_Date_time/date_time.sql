USE sql_cx_live;

CREATE TABLE uber_rides(
	ride_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    user_id INTEGER,
    cab_id INTEGER,
    start_time DATETIME,
    end_time DATETIME
);

INSERT INTO uber_rides(user_id, cab_id, start_time, end_time)
VALUES
(1, 1, '2023-03-09 08:15:00', '2023-03-09 08:45:00'),
(2, 3, '2023-03-10 12:30:00', '2023-03-10 13:10:00'),
(5, 2, '2023-03-11 18:45:00', '2023-03-11 19:20:00'),
(3, 4, '2023-03-12 09:00:00', '2023-03-12 09:35:00'),
(4, 1, '2023-03-13 17:30:00', '2023-03-13 18:15:00');

SELECT * FROM uber_rides;


# Temporal DataTypes
SELECT CURRENT_DATE();
SELECT CURRENT_TIME();
SELECT NOW();


# Datetime Function
SELECT 	 	DATE(start_time), 
					TIME(start_time), 
                    
                    YEAR(start_time),
                    MONTH(start_time),
                    WEEK(start_time),
                    
					DAYNAME(start_time),
                    MONTHNAME(start_time),
                    
                    HOUR(start_time),
                    MINUTE(start_time),
                    SECOND(start_time),
                    
                    DAYOFMONTH(start_time),
                    DAYOFYEAR(start_time),
                    DAYOFWEEK(start_time),
                    WEEKOFYEAR(start_time),
                    
                    DAY(start_time),
                    QUARTER(start_time),
                    LAST_DAY(start_time)
                    
FROM uber_rides;


# Datetime Format
SELECT start_time, DATE_FORMAT(start_time, '%d %b %y') 
FROM uber_rides;

SELECT start_time, DATE_FORMAT(start_time, '%l:%i %p') 
FROM uber_rides;


# Type Conversion

-- Implicit Type Conversion
SELECT MONTHNAME('2023-03-11');

-- Explicit Type Conversion
SELECT DAYNAME(STR_TO_DATE('19 - Mar / 2000', '%e - %b / %Y'));


# Datetime Arithmetic
SELECT DATEDIFF(CURRENT_DATE(), '2025-01-17');

SELECT DATEDIFF(end_time, start_time)
FROM uber_rides;

SELECT TIMEDIFF(end_time, start_time)
FROM uber_rides;

SELECT NOW(), DATE_ADD(NOW(), INTERVAL 10 YEAR);
SELECT NOW(), DATE_ADD(NOW(), INTERVAL 10 MONTH);
SELECT NOW(), DATE_ADD(NOW(), INTERVAL 10 DAY);

SELECT NOW(), DATE_SUB(NOW(), INTERVAL 10 YEAR);
SELECT NOW(), DATE_SUB(NOW(), INTERVAL 10 MONTH);
SELECT NOW(), DATE_SUB(NOW(), INTERVAL 10 DAY);



# TimeStamp

CREATE TABLE posts(
		post_id INTEGER PRIMARY KEY AUTO_INCREMENT,
		user_id INTEGER,
        content TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP
);


INSERT INTO posts (post_id, user_id, content, created_at, updated_at)
VALUES
(1, 101, 'Just had an amazing cup of coffee.', '2023-05-15 08:30:45', '2023-05-15 08:30:45'),
(2, 205, 'Beautiful sunset view from my balcony.', '2023-05-16 18:22:10', '2023-05-16 18:25:33'),
(3, 178, 'Working on a new project.', '2023-05-17 11:05:00', '2023-05-18 09:15:00'),
(4, 302, 'Happy Friday everyone!', '2023-05-19 16:45:20', '2023-05-19 17:30:15'),
(5, 101, 'Recipe for my famous chocolate chip cookies.', '2023-05-20 14:10:00', '2023-05-20 15:45:00');


UPDATE posts
SET content = 'No More Hello World'
WHERE post_id = 3;


SELECT * FROM posts;



