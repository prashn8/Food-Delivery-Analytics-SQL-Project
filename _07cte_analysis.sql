---34.	LIST OR CITY AND THEIR REVENUE
WITH city_revenue AS  

		(SELECT DISTINCT rd.city,
		SUM(sd.swiggy_estimated_monthly_revenue_inr) 
		AS total_revenue 
		FROM restaurants AS rd
		LEFT JOIN swiggy_data AS sd 
		ON rd.restaurant_id = sd.restaurant_id
		
		GROUP BY rd.city)
		
SELECT * FROM city_revenue;

---35.	TOP RESTAURANT IN ZOMATO
WITH top_restaurant AS
		(SELECT DISTINCT rd.restaurant_name, 
		zd.zomato_estimated_monthly_revenue_inr, ROW_NUMBER() OVER(ORDER BY zd.zomato_estimated_monthly_revenue_inr DESC)
		AS ranking 
		FROM restaurants AS rd
		LEFT JOIN zomato_data AS zd 
		ON rd.restaurant_id = zd.restaurant_id
		)
SELECT * FROM top_restaurant
LIMIT 1

---36.	TOP REVENUE CITY IN SWIGGY 
WITH city_top_revenue AS  

		(SELECT rd.city,
		SUM(sd.swiggy_estimated_monthly_revenue_inr) 
		AS total_revenue 
		FROM restaurants AS rd
		LEFT JOIN swiggy_data AS sd 
		ON rd.restaurant_id = sd.restaurant_id
		GROUP BY rd.city)
		
		
SELECT * FROM city_top_revenue
ORDER BY total_revenue DESC
LIMIT 1;

---37.	LIST OF BEST CUISINE IN EACH CITY.
WITH city_details AS 
		(SELECT rd.city, rd.cuisines, SUM(sd.swiggy_estimated_monthly_orders + zd.zomato_estimated_monthly_orders) 
		AS total_orders FROM restaurants AS rd
		LEFT JOIN swiggy_data AS sd 
		ON rd.restaurant_id = sd.restaurant_id
		LEFT JOIN zomato_data AS zd
		ON sd.restaurant_id = zd.restaurant_id
		GROUP BY rd.city, rd.cuisines),
		
ranked_data AS 
		(SELECT city, cuisines, total_orders, 
		ROW_NUMBER() OVER(PARTITION BY city ORDER BY total_orders DESC) AS order_ranking
		FROM city_details)
SELECT * FROM ranked_data
WHERE order_ranking = 1


		