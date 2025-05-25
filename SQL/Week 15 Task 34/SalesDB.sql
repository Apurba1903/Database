-- Q-3: Find top-5 most sold products.
SELECT Name, SUM(Quantity) AS 'Total_Quantity'
FROM salesdb.sales1 t1
JOIN salesdb.products t2
ON t1.ProductID = t2.ProductID
GROUP BY t1.ProductID,  t2.Name
ORDER BY Total_Quantity DESC
LIMIT 5;

-- Q-4: Find sales man who sold most no of products.
SELECT t1.SalesPersonID, FirstName, LastName, SUM(Quantity) AS 'Number_Sold' 
FROM salesdb.sales1 t1
JOIN salesdb.employees t2
ON t1.SalesPersonID = t2.EmployeeID
GROUP BY t1.SalesPersonID, t2.FirstName, t2.LastName
ORDER BY Number_Sold DESC
LIMIT 1;

-- Q-5: Sales man name who has most no of unique customer.
SELECT t1.SalesPersonID, FirstName, LastName, COUNT(DISTINCT CustomerID) AS 'Unique_Customers' 
FROM salesdb.sales1 t1
JOIN salesdb.employees t2
ON t1.SalesPersonID = t2.EmployeeID
GROUP BY t1.SalesPersonID, t2.FirstName, t2.LastName
ORDER BY Unique_Customers DESC
LIMIT 1;

-- Q-6: Sales man who has generated most revenue. Show top 5.
SELECT t1.SalesPersonID, t3.FirstName, t3.LastName, ROUND(SUM(t1.Quantity * t2.Price), 2) AS 'Sale'
FROM salesdb.sales1 t1
JOIN salesdb.products t2
ON t1.ProductID = t2.ProductID
JOIN salesdb.employees t3
ON t1.SalesPersonID = t3.EmployeeID
GROUP BY t1.SalesPersonID, t3.FirstName, t3.LastName
ORDER BY Sale DESC
LIMIT 5;

-- Q-7: List all customers who have made more than 10 purchases.
SELECT t1.CustomerID, t2.FirstName, t2.LastName, COUNT(*) AS 'Total_Purchase'
FROM salesdb.sales1 t1
JOIN salesdb.customers t2
ON t1.CustomerID = t2.CustomerID
GROUP BY t1.CustomerID, t2.FirstName, t2.LastName
HAVING Total_Purchase > 10;

-- Q-8: List all salespeople who have made sales to more than 5 customers.
SELECT t1.SalesPersonID, FirstName, LastName, COUNT(DISTINCT CustomerID) AS 'Unique_Customers' 
FROM salesdb.sales1 t1
JOIN salesdb.employees t2
ON t1.SalesPersonID = t2.EmployeeID
GROUP BY t1.SalesPersonID, t2.FirstName, t2.LastName
HAVING Unique_Customers > 5;

-- Q-9: List all pairs of customers who have made purchases with the same salesperson.
SELECT 
CONCAT(B.FirstName, ' ', B.LastName) AS 'First_Customer_Name',
CONCAT(C.FirstName, ' ', C.LastName) AS 'Second_Customer_Name',
CONCAT(D.FirstName, ' ', D.LastName) AS 'Salesperson_Name'
FROM 

(SELECT DISTINCT t1.CustomerID AS 'First_Customer', 
t2.CustomerID AS 'Second_Customer',
t2.SalesPersonID
FROM salesdb.sales1 t1
JOIN salesdb.sales1 t2
ON t1.SalesPersonID = t2.SalesPersonID
AND t1.CustomerID != t2.CustomerID) A

JOIN salesdb.customers B
ON A.First_Customer = B.CustomerID

LEFT JOIN salesdb.customers C
ON A.Second_Customer = C.CustomerID

LEFT JOIN salesdb.employees D
ON A.SalesPersonID = D.EmployeeID;