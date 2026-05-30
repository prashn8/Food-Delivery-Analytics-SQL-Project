 ---1. All Data From Restaurants, Swiggy_data, And Zomato_data Tables...

SELECT * 
FROM restaurants AS r_data
JOIN swiggy_data AS s_data
ON r_data.restaurant_id = s_data.restaurant_id 
JOIN zomato_data AS z_data 
ON s_data.restaurant_id = z_data.restaurant_id;
			

---2. List Of ALL UNIQUE CITIES LISTED..
SELECT DISTINCT city FROM restaurants;

---3. List Of All Unique Cuisines...
SELECT DISTINCT cuisines FROM restaurants;

---4. List Of Total Number of Restaurants...
SELECT COUNT(*) FROM restaurants;

---5. Minimum And Maximum Ratings For Swiggy and Zomato...
SELECT
MIN(sd.swiggy_rating) AS min_rating_swiggy,
MAX(sd.swiggy_rating) AS max_rating_swiggy,
MIN(zd.zomato_rating) AS min_rating_zomato,
MAX(zd.zomato_rating) AS max_rating_zomato
FROM swiggy_data AS sd
JOIN zomato_data AS zd
ON sd.restaurant_id = zd.restaurant_id; 

---6. List Of All Restaurants Where Swiggy Rating > 4.5...
SELECT DISTINCT rd.restaurant_name, sd.swiggy_rating FROM restaurants AS rd
JOIN swiggy_data AS sd 
ON rd.restaurant_id = sd.restaurant_id
WHERE swiggy_rating > 4.5;

---7. List Of All Restaurants From Mumbai...
SELECT * FROM restaurants 
WHERE city = 'Mumbai';

---8. List Of Restaurants Having Own Website...
SELECT * FROM restaurants
WHERE has_own_website = TRUE;

---9. Average Swiggy Delivery Time And Zomato Delivery Time.
SELECT 
AVG(sd.swiggy_avg_delivery_time_minutes) AS avg_swiggy_delivery_time,
AVG(zd.zomato_avg_delivery_time_minutes) AS avg_zomato_delivery_time
FROM swiggy_data AS sd
JOIN zomato_data AS zd
ON sd.restaurant_id = zd.restaurant_id;

---10. List Of Top 10 Restaurants By Swiggy Revenue.
SELECT 
    rd.restaurant_name, 
    sd.total_revenue
FROM restaurants AS rd
JOIN (
    SELECT 
        restaurant_id, 
        SUM(swiggy_estimated_net_profit_inr) AS total_revenue 
    FROM swiggy_data 
    GROUP BY restaurant_id
) AS sd 
    ON rd.restaurant_id = sd.restaurant_id
ORDER BY sd.total_revenue DESC
LIMIT 10;

