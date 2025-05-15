SELECT AVG(internal_memory) AS 'Average ROM'
FROM smartprix.smartphones
WHERE refresh_rate >= 120 AND primary_camera_front >=20