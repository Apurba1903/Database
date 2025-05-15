SELECT 
    AVG(battery_capacity) AS avg_battery_capacity,
    AVG(primary_camera_rear) AS avg_primary_camera_rear
FROM 
    smartprix.smartphones
WHERE 
    price >= 100000;