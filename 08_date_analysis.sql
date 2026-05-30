-- ==========================================
--     FOOD DELIVERY ANALYTICS PROJECT
--     BUSINESS INSIGHTS ANALYSIS
-- ==========================================

---43.	DOES FASTER  DELIVERY IMPROVES RATINGS
SELECT 
	CASE 
		WHEN swiggy_avg_delivery_time_minutes < 30 THEN 'Faster Delivery'
		WHEN swiggy_avg_delivery_time_minutes BETWEEN 30 AND 40 THEN 'Medium Delivery'
		ELSE 'Slow delivery'
	END AS delivery_speed,

	ROUND(AVG (swiggy_rating), 02) AS avg_rating
FROM swiggy_data
GROUP BY delivery_speed;
	
---44.	DOES HIGH COMMISSION REDUCES PROFIT
SELECT 
	CASE 
		WHEN swiggy_platform_commission_pct < 10 THEN 'Low Commission'
		WHEN swiggy_platform_commission_pct BETWEEN 10 AND 15 THEN 'Medium Commission'
		ELSE 'High Commission'
	END AS commission_category,

	avg(swiggy_estimated_net_profit_inr) AS avg_profit
FROM swiggy_data
GROUP BY commission_category;

---45.	Find the best city for opening a food business based on total monthly revenue.
SELECT rd.city, SUM(sd.swiggy_estimated_monthly_revenue_inr + zd.zomato_estimated_monthly_revenue_inr)
AS total_revenue
FROM restaurants AS rd
LEFT JOIN swiggy_data AS sd 
ON rd.restaurant_id = sd.restaurant_id
LEFT JOIN zomato_data AS zd
ON sd.restaurant_id = zd.restaurant_id
GROUP BY rd.city 
ORDER BY total_revenue DESC;

---46.	WHICH PLATFORM DOMINATES THE MARKET SHARE
SELECT SUM(sd.swiggy_estimated_monthly_orders) AS Swiggy_total_orders, SUM(zd.zomato_estimated_monthly_orders) AS zomato_total_orders,
	CASE
		WHEN SUM(sd.swiggy_estimated_monthly_orders) > SUM(zd.zomato_estimated_monthly_orders)
		THEN 'Swiggy Dominates The Market'
		WHEN SUM(sd.swiggy_estimated_monthly_orders) < SUM(zd.zomato_estimated_monthly_orders)
		THEN 'Zomato Dominates The Market'
		ELSE 'Both Are Performing Well'
		END AS market_domination 
FROM swiggy_data AS sd 
INNER JOIN zomato_data AS zd
ON sd.restaurant_id = zd.restaurant_id;

---47.	LIST OF LOW RATED BUT HIGH REVENUE RESTAURANTS 
SELECT
    rd.restaurant_name,
    ROUND(AVG(sd.swiggy_rating), 2) AS avg_rating,
    SUM(sd.swiggy_estimated_monthly_revenue_inr) AS total_revenue
FROM restaurants AS rd
JOIN swiggy_data AS sd
ON rd.restaurant_id = sd.restaurant_id
GROUP BY rd.restaurant_name
HAVING
    AVG(sd.swiggy_rating) < 3
    AND
    SUM(sd.swiggy_estimated_monthly_revenue_inr) >
    (SELECT AVG(swiggy_estimated_monthly_revenue_inr)
     FROM swiggy_data)

ORDER BY total_revenue DESC;

---48. LIST OF RESTAURANTS WITH LOW RATINGS BUT HIGH ORDERS
SELECT 
	rd.restaurant_name, 
	ROUND(AVG(sd.swiggy_rating), 02), 
	SUM(sd.swiggy_estimated_monthly_orders)
	AS total_orders
FROM restaurants AS rd
LEFT JOIN swiggy_data AS sd
ON rd.restaurant_id = sd.restaurant_id
GROUP BY rd.restaurant_name
HAVING 
	SUM(sd.swiggy_estimated_monthly_orders)> 
	(SELECT AVG(swiggy_estimated_monthly_orders)
	FROM swiggy_data)
ORDER BY total_orders DESC;

---49.	LIST OF MOST PROFITAVLE CUISINES
SELECT
	rd.cuisines, 
	SUM(sd.swiggy_estimated_monthly_revenue_inr + zd.zomato_estimated_monthly_revenue_inr) AS total_revenue
FROM restaurants AS rd
LEFT JOIN swiggy_data AS sd
ON rd.restaurant_id = sd.restaurant_id
LEFT JOIN zomato_data AS zd
ON sd.restaurant_id = zd.restaurant_id
GROUP BY rd.cuisines
ORDER BY total_revenue DESC
LIMIT 10;

---50.	LIST OF RESTAURANTS PERFORMING WELL ON BOTH APPS
SELECT rd.restaurant_name, sd.swiggy_rating, zd.zomato_rating  FROM restaurants AS rd
INNER JOIN swiggy_data AS sd
ON rd.restaurant_id = sd.restaurant_id
INNER JOIN zomato_data AS zd
ON sd.restaurant_id = zd.restaurant_id
WHERE sd.swiggy_rating > 4.5 AND zd.zomato_rating > 4.5
GROUP BY rd.restaurant_name, sd.swiggy_rating, zd.zomato_rating;




