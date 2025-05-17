-- Problem 10: Display total and average values of Discount_offered for all the combinations 
-- 						of 'Mode_of_Shipment' (display this feature) and 'Warehouse_block' 
-- 						(display this feature also) for all male ('M') and 'High' Product_importance. 
-- 						Also sort the values in descending order of Mode_of_Shipment and 
-- 						ascending order of Warehouse_block.
SELECT Mode_of_Shipment,
Warehouse_block,
SUM(Discount_offered) AS 'total_discount_number',
AVG(Discount_offered) AS 'avg_discount_offered'
FROM tasks.shipping_ecommerce
WHERE Gender = 'M' AND Product_importance = 'High'
GROUP BY Mode_of_Shipment, Warehouse_block
ORDER BY Mode_of_Shipment DESC, Warehouse_block ASC;