USE zomatodb;

# Autocommit ON by Default
-- SELECT * FROM menu;

-- UPDATE menu
-- SET price = 350
-- WHERE menu_id = 1;

# Autocommit OFF by Manual
-- SET autocommit = 0;

-- SELECT * FROM users;

-- INSERT INTO users(name) VALUES("Rahat");


# Transctions
SELECT * FROM menu;

START TRANSACTION;

SAVEPOINT A;
UPDATE menu SET price = 400 WHERE menu_id = 1;

SAVEPOINT B;
UPDATE menu SET price = 350 WHERE menu_id = 2;

COMMIT;
-- ROLLBACK;
-- ROLLBACK TO B;

SELECT * FROM menu;






