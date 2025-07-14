USE zomatodb;

-- Print Hello World
CALL hello_world();

-- Inserting New User
SET @message =' ';
CALL add_user('xyz', 'xyz@gmail.com', 'xyz', @message);
SELECT @message;

-- See Orders
CALL user_order('vartika@gmail.com');

-- Complete Order Procedure
SET @total = 0;

CALL place_order(3, 3, "6,7", @total);

SELECT @total;



