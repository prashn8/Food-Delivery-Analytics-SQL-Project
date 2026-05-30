CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY,
    restaurant_name TEXT,
    city TEXT,
    locality TEXT,
    restaurant_type TEXT,
    cuisines TEXT,
    listing_date DATE,
    days_listed INT,
    distance_from_city_center_km NUMERIC,
    opening_time TIME,
    closing_time TIME,
    days_operational INT,
    price_category TEXT,
    platform_performance_better TEXT,
    amenities TEXT,
    amenities_count INT,
    has_own_website BOOLEAN,
    has_own_app BOOLEAN,
    food_license_verified BOOLEAN,
    avg_cost_per_person_inr NUMERIC
);

CREATE TABLE swiggy_data (
    restaurant_id INT,
    swiggy_rating NUMERIC,
    swiggy_total_reviews INT,
    swiggy_delivery_fee_inr NUMERIC,
    swiggy_avg_delivery_time_minutes INT,
    swiggy_platform_commission_pct NUMERIC,
    swiggy_discount_frequency_pct NUMERIC,
    swiggy_estimated_monthly_orders INT,
    swiggy_estimated_monthly_revenue_inr NUMERIC,
    swiggy_estimated_net_profit_inr NUMERIC,
    swiggy_market_share_pct NUMERIC
);

CREATE TABLE zomato_data (
    restaurant_id INT,
    zomato_rating NUMERIC,
    zomato_total_reviews INT,
    zomato_delivery_fee_inr NUMERIC,
    zomato_avg_delivery_time_minutes INT,
    zomato_platform_commission_pct NUMERIC,
    zomato_discount_frequency_pct NUMERIC,
    zomato_estimated_monthly_orders INT,
    zomato_estimated_monthly_revenue_inr NUMERIC,
    zomato_estimated_net_profit_inr NUMERIC,
    zomato_market_share_pct NUMERIC
);

COPY restaurants
FROM 'D:/sql_project/restaurants.csv'
DELIMITER ','
CSV HEADER;

COPY swiggy_data
FROM 'D:/sql_project/swiggy_data.csv'
DELIMITER ','
CSV HEADER;

COPY zomato_data
FROM 'D:/sql_project/zomato_data.csv'
DELIMITER ','
CSV HEADER;