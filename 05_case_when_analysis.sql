-- ==========================================
--     FOOD DELIVERY ANALYTICS PROJECT
-- 	   CASE WHEN ANALYSIS
-- ==========================================

---25.	LIST OF RESTAURANT WITH THEIR RATING CATEGORY.
SELECT DISTINCT rd.restaurant_name, sd.swiggy_rating, zd.zomato_rating,
	CASE 
		WHEN sd.swiggy_rating  > 4.5 THEN 'Excellent'
		WHEN sd.swiggy_rating  BETWEEN 4 AND 4.5 THEN 'Good'
		ELSE 'Average'
	END AS restaurant_swiggy_rating,
	CASE 
		WHEN zd.zomato_rating  > 4.5 THEN 'Excellent'
		WHEN zd.zomato_rating  BETWEEN 4 AND 4.5 THEN 'Good'
		ELSE 'Average'
	END AS restaurant_zomato_rating
	
FROM restaurants AS rd
LEFT JOIN swiggy_data AS sd
ON rd.restaurant_id = sd.restaurant_id
LEFT JOIN zomato_data AS zd 
ON sd.restaurant_id = zd.restaurant_id;

---26. LIST OF RESTAURANTS WITH DELIVERY SPEED
SELECT DISTINCT
	rd.restaurant_name, 
	sd.swiggy_avg_delivery_time_minutes, 
	zd.zomato_avg_delivery_time_minutes,
	CASE 
		WHEN sd.swiggy_avg_delivery_time_minutes  < 25 THEN 'Fast'
		WHEN sd.swiggy_avg_delivery_time_minutes  BETWEEN 25 AND 40 THEN 'Medium'
		ELSE 'Slow'
	END AS swiggy_delivery_speed,
	CASE 
		WHEN zd.zomato_avg_delivery_time_minutes  < 25 THEN 'Fast'
		WHEN zd.zomato_avg_delivery_time_minutes  BETWEEN 25 AND 40 THEN 'Medium'
		ELSE 'Slow'
	END AS zomato_delivery_speed
	
FROM restaurants AS rd
LEFT JOIN swiggy_data AS sd
ON rd.restaurant_id = sd.restaurant_id
LEFT JOIN zomato_data AS zd 
ON sd.restaurant_id = zd.restaurant_id;

---27.	Show whether Swiggy or Zomato performs better using CASE WHEN.
SELECT DISTINCT
	rd.restaurant_name, 
	sd.swiggy_estimated_monthly_revenue_inr,
	zd.zomato_estimated_monthly_revenue_inr,
	CASE 
		WHEN sd.swiggy_estimated_monthly_revenue_inr > 
		zd.zomato_estimated_monthly_revenue_inr
		THEN 'Swiggy Better!'
		
		WHEN sd.swiggy_estimated_monthly_revenue_inr < 
		zd.zomato_estimated_monthly_revenue_inr 
		THEN 'Zomato Better!'
		
		ELSE 'Both Equal!'
	END AS comparison
	
FROM restaurants AS rd
LEFT JOIN swiggy_data AS sd
ON rd.restaurant_id = sd.restaurant_id
LEFT JOIN zomato_data AS zd 
ON sd.restaurant_id = zd.restaurant_id;

