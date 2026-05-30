---16.	List Of Total Restaurants In Each City.
SELECT city, COUNT(restaurant_name) FROM restaurants
GROUP BY city;

---17.	List Of Average Swiggy Rating By City.
SELECT rd.city, ROUND(AVG(sd.swiggy_rating), 2) AS avg_swiggy_rating
FROM restaurants AS rd
JOIN swiggy_data AS sd 
ON rd.restaurant_id = sd.restaurant_id
GROUP BY city;

---18.	List Of Average Zomato Rating By Cuisine.
SELECT rd.cuisines, ROUND(AVG(zd.zomato_rating), 2) AS avg_zomato_rating
FROM restaurants AS rd
JOIN zomato_data AS zd 
ON rd.restaurant_id = zd.restaurant_id
GROUP BY rd.cuisines;

---19.	List Of Total Rvenue Gnerated By Each Cuisine
SELECT rd.cuisines,
	SUM(zd.zomato_estimated_monthly_revenue_inr)
	AS avg_zomato_revenue,
	SUM(sd.swiggy_estimated_monthly_revenue_inr)
	AS Avg_swiggy_revenue
FROM restaurants AS rd
JOIN zomato_data AS zd 
ON rd.restaurant_id = zd.restaurant_id
JOIN swiggy_data AS sd
ON zd.restaurant_id = sd.restaurant_id
GROUP BY rd.cuisines;

---20.	Average Delivery Time City-Wise.	
SELECT
	rd.city,
	ROUND(AVG(sd.swiggy_avg_delivery_time_minutes), 2) AS avg_swiggy_delivery_time,
	ROUND (AVG(zd.zomato_avg_delivery_time_minutes), 2) AS avg_zomato_delivery_time
FROM restaurants AS rd

LEFT JOIN swiggy_data AS sd 
ON rd.restaurant_id = sd.restaurant_id

LEFT JOIN zomato_data AS zd
ON sd.restaurant_id = zd.restaurant_id
GROUP BY city;

---21.	List Of Top 5 Cities By Total Swiggy Revenue.
SELECT rd.city, SUM(sd.swiggy_estimated_monthly_revenue_inr) AS swiggy_revenue
FROM restaurants AS rd
LEFT JOIN swiggy_data AS sd
ON rd.restaurant_id = sd.restaurant_id
GROUP BY rd.city
ORDER BY  SUM(sd.swiggy_estimated_monthly_revenue_inr) DESC
LIMIT 5;

---22. List Of Top Cuisines By Monthly Orders.
SELECT 
	rd.cuisines,
	SUM(sd.swiggy_estimated_monthly_orders) AS swiggy_orders,
	SUM(zd.zomato_estimated_monthly_orders) AS zomato_orders

FROM restaurants AS rd
LEFT JOIN swiggy_data AS sd
ON rd.restaurant_id = sd.restaurant_id 
LEFT JOIN zomato_data AS zd
ON sd.restaurant_id = zd.restaurant_id

GROUP BY rd.cuisines

ORDER BY zomato_orders DESC;

---23. List Of Top 10 City Having Highest Average Rating.
SELECT rd.city, ROUND(AVG(sd.swiggy_rating),2) AS avg_swiggy_rating, ROUND(AVG(zd.zomato_rating),2) AS avg_zomato_rating
FROM restaurants AS rd 
LEFT JOIN swiggy_data AS sd 
ON rd.restaurant_id = sd.restaurant_id
LEFT JOIN zomato_data AS zd
ON sd.restaurant_id = zd.restaurant_id

GROUP BY rd.city
ORDER BY avg_swiggy_rating DESC
LIMIT 10;

---24.	List Of Top 10 Cuisine With Higest Revenue
SELECT rd.cuisines,
	SUM(zd.zomato_estimated_monthly_revenue_inr)
	AS avg_zomato_revenue,
	SUM(sd.swiggy_estimated_monthly_revenue_inr)
	AS Avg_swiggy_revenue
FROM restaurants AS rd
JOIN zomato_data AS zd 
ON rd.restaurant_id = zd.restaurant_id
JOIN swiggy_data AS sd
ON zd.restaurant_id = sd.restaurant_id
GROUP BY rd.cuisines
ORDER BY avg_zomato_revenue DESC
LIMIT 10;
