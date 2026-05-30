-- ==========================================
--     FOOD DELIVERY ANALYTICS PROJECT
-- 	   WINDOW FUNCTIONS 
-- ==========================================

---28.	LIST OF RESTAURANTS RANKED BY SWIGGY REVENUE
SELECT rd.restaurant_name, sd.swiggy_estimated_monthly_revenue_inr, DENSE_RANK()
OVER(ORDER BY sd.swiggy_estimated_monthly_revenue_inr DESC)
AS swiggy_revenue_ranking
FROM restaurants AS rd 
LEFT JOIN swiggy_data  AS sd
ON rd.restaurant_id = sd.restaurant_id;

---29.	TOP 3 MOST EARNING RESTAURANTS FORM SWIGGY
WITH rankedrestaurant AS
		
		(SELECT rd.restaurant_name, rd.city, sd.swiggy_estimated_monthly_revenue_inr, ROW_NUMBER()
		OVER(PARTITION BY rd.city ORDER BY sd.swiggy_estimated_monthly_revenue_inr DESC)
		AS swiggy_revenue_ranking
		FROM restaurants AS rd 
		LEFT JOIN swiggy_data  AS sd
		ON rd.restaurant_id = sd.restaurant_id)

SELECT * FROM rankedrestaurant 
WHERE swiggy_revenue_ranking <= 3;

---30.	TOP RESTAURANTS FOR EACH CUISINE AS PER REVENUE
WITH cuisine_ranked_restaurant AS
		
		(SELECT
			rd.restaurant_name, 
			rd.cuisines, 
			sd.swiggy_estimated_monthly_revenue_inr, 
			ROW_NUMBER() OVER(PARTITION BY rd.cuisines ORDER BY sd.swiggy_estimated_monthly_revenue_inr DESC)
			AS swiggy_cuisines_restaurant_ranking
		FROM restaurants AS rd 
		LEFT JOIN swiggy_data  AS sd
		ON rd.restaurant_id = sd.restaurant_id)

SELECT * FROM cuisine_ranked_restaurant
WHERE swiggy_cuisines_restaurant_ranking = 1;

---31.	LIST OF TOP RATED RESTURANTS IN SWIGGY
WITH top_rated_restaurant AS
		
		(SELECT
			rd.restaurant_name, 
			rd.city, 
			sd.swiggy_rating, 
			ROW_NUMBER() OVER(PARTITION BY rd.city ORDER BY sd.swiggy_rating DESC)
			AS top_ranked
		FROM restaurants AS rd 
		LEFT JOIN swiggy_data  AS sd
		ON rd.restaurant_id = sd.restaurant_id)

SELECT * FROM top_rated_restaurant
WHERE top_ranked = 1;

---32.	CUMULATIVE REVENUE.
WITH revenue AS
		
		(SELECT
			rd.restaurant_name, 
			rd.city, 
			sd.swiggy_estimated_monthly_revenue_inr,
			SUM(swiggy_estimated_monthly_revenue_inr) OVER( ORDER BY sd.swiggy_estimated_monthly_revenue_inr)
			AS cumulative_revenue
		FROM restaurants AS rd 
		LEFT JOIN swiggy_data  AS sd
		ON rd.restaurant_id = sd.restaurant_id)

SELECT * FROM revenue

---33.	COMPARISON OF CURRENT RESTAURANT REVENUE WITH PREVIOUS
WITH revenue AS
		
		(SELECT
			rd.restaurant_name, 
			rd.city, 
			sd.swiggy_estimated_monthly_revenue_inr,
			LAG(swiggy_estimated_monthly_revenue_inr) OVER( ORDER BY sd.swiggy_estimated_monthly_revenue_inr)
			AS revenue_difference
		FROM restaurants AS rd 
		LEFT JOIN swiggy_data  AS sd
		ON rd.restaurant_id = sd.restaurant_id)

SELECT * FROM revenue;



