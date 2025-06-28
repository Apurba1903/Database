USE campusx;


CREATE TABLE dt_demo(
	user_id TINYINT,
    course_id TINYINT UNSIGNED
);




SELECT * FROM dt_demo;

INSERT INTO dt_demo
VALUES (200,200);

ALTER TABLE dt_demo ADD COLUMN price DECIMAL(5,2);

UPDATE dt_demo
SET price = 455.64;

SELECT * FROM dt_demo;




ALTER TABLE dt_demo ADD COLUMN height FLOAT;

ALTER TABLE dt_demo ADD COLUMN weight DOUBLE;

UPDATE dt_demo
SET height = 172.655467865;

UPDATE dt_demo
SET weight = 60.45634563464573346534674574577;

SELECT * FROM dt_demo;




ALTER TABLE dt_demo ADD COLUMN gender ENUM('Male', 'Female', 'Others');

UPDATE dt_demo
SET gender = 'Female';

SELECT * FROM dt_demo;




ALTER TABLE dt_demo ADD COLUMN hobby SET('Sports', 'Gaming');

INSERT INTO dt_demo (hobby)
VALUES ('Sports'),('Gaming');

SELECT * FROM dt_demo;




ALTER TABLE dt_demo ADD COLUMN dp MEDIUMBLOB;

INSERT INTO dt_demo (dp)
VALUES (LOAD_FILE('C:/Users/ACER/Desktop/Screenshot.png'));

SELECT * FROM dt_demo;




ALTER TABLE dt_demo ADD COLUMN latlong GEOMETRY;

INSERT INTO dt_demo (latlong) VALUES (POINT(51.564537,-0.105171));

SELECT ST_ASTEXT(latlong), ST_X(latlong), ST_Y(latlong) FROM dt_demo;

SELECT * FROM dt_demo;




ALTER TABLE dt_demo ADD COLUMN descr JSON;

INSERT INTO dt_demo (descr) VALUES ('{"os":"android", "type":"smartphone"}');

SELECT JSON_EXTRACT(descr, '$.type') FROM dt_demo;

SELECT JSON_EXTRACT(descr, '$.os') FROM dt_demo;










