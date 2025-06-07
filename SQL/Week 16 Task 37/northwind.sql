USE northwind_half;



#  Q-1 Rank Employee in terms of revenue generation. Show employee id, first name, revenue, and rank
SELECT t2.EmployeeID, 
				t3.FirstName, 
				SUM(t1.UnitPrice * t1.Quantity) AS 'Revenue',
				RANK() OVER(ORDER BY SUM(t1.UnitPrice * t1.Quantity) DESC) AS 'Emp_Rank'
FROM order_details t1
JOIN orders t2
ON t1.OrderID = t2.OrderID
JOIN employees t3
ON t2.EmployeeID = t3.EmployeeID
GROUP BY t2.EmployeeID, t3.FirstName
ORDER BY Emp_Rank;



# Q-2 Show All products cumulative sum of units sold each month.
SELECT 	t3.ProductID,
				MONTH(t1.OrderDate) AS 'Month',
                SUM(t2.Quantity) AS 'QuantitySum',
                SUM(SUM(t2.Quantity)) OVER(PARTITION BY t3.ProductID ORDER BY MONTH(t1.OrderDate) ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'QuantityCumSum'
FROM orders t1
JOIN order_details t2
ON t1.OrderID = t2.OrderID
JOIN products t3
ON t3.ProductID = t2.ProductID
GROUP BY t3.ProductID, MONTH(t1.OrderDate);



# Q-3 Show Percentage of total revenue by each suppliers
SELECT 	t1.SupplierID,
				ROUND(SUM(t3.Quantity + t3.UnitPrice), 2) AS 'Revenue',
                ROUND(SUM(t3.Quantity + t3.UnitPrice) / SUM(SUM(t3.Quantity + t3.UnitPrice)) OVER () * 100, 2) AS 'RevenuePercent'
FROM suppliers t1
JOIN products t2
ON t1.SupplierID = t2.SupplierID
JOIN order_details t3
ON t2.ProductID = t3.ProductID
GROUP BY t1.SupplierID
ORDER BY Revenue DESC;



# Q-4 Show Percentage of total orders by each suppliers
SELECT 	t1.SupplierID,
				COUNT(DISTINCT t3.OrderID) AS 'NumberOfOrders',
                ROUND(COUNT(DISTINCT t3.OrderID) / SUM(COUNT(DISTINCT t3.OrderID)) OVER() * 100, 2) AS 'PercentOfOrder'
 FROM suppliers t1
JOIN products t2
ON t1.SupplierID = t2.SupplierID
JOIN order_details t3
ON t3.ProductID = t2.ProductID
GROUP BY t1.SupplierID;



# Q-5 Show All Products Year Wise report of total Quantity sold, percentage change from last year.
SELECT 	*,
				100 * (Quantity - LAG(Quantity) OVER(PARTITION BY ProductID ORDER BY ProductID, Year)) / 
							LAG(Quantity) OVER(PARTITION BY ProductID ORDER BY ProductID, Year) AS 'PercentChange'
FROM(
			SELECT 	t3.ProductID, 
							YEAR(t1.OrderDate) AS 'Year',
							SUM(t2.Quantity) AS 'Quantity'
			FROM orders t1
			JOIN order_details t2
			ON t1.OrderID = t2.OrderID
			JOIN products t3
			ON t3.ProductID = t2.ProductID
			GROUP BY t3.ProductID, YEAR(t1.OrderDate)
            ORDER BY  t3.ProductID, YEAR(t1.OrderDate)
) t;



