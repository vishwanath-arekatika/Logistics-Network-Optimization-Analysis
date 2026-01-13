USE amazon_logistics_project
SELECT COUNT(*) FROM shipments;

-- Career Performance & Delay Rate (Primary KPI) 
SELECT 
    delivery_partner, 
    COUNT(*) AS total_shipments,
    SUM(CASE WHEN is_delayed = 'yes' THEN 1 ELSE 0 END) AS late_deliveries,
    ROUND((SUM(CASE WHEN is_delayed = 'yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS delay_percentage
FROM shipments
GROUP BY delivery_partner
ORDER BY delay_percentage DESC;


-- High-Risk "Bottleneck" regions
SELECT 
    region, 
    COUNT(*) AS total_volumne,
    SUM(CASE WHEN is_delayed = 'yes' THEN 1 ELSE 0 END) AS late_count
FROM shipments
GROUP BY region
ORDER BY late_count DESC;


-- Weather Impact on Delivery Food
SELECT 
    weather_condition, 
    COUNT(*) AS total_shipments,
    SUM(CASE WHEN is_delayed = 'yes' THEN 1 ELSE 0 END) AS exceptions,
    ROUND(AVG(delivery_cost), 2) AS avg_cost
FROM shipments
GROUP BY weather_condition
ORDER BY exceptions DESC;


-- Vehicle Type Efficiency Analysis
SELECT 
    vehicle_type, 
    COUNT(*) AS volume,
    SUM(CASE WHEN is_delayed = 'yes' THEN 1 ELSE 0 END) AS delays,
    ROUND(AVG(distance_km), 2) AS avg_trip_distance
FROM shipments
GROUP BY vehicle_type
ORDER BY delays DESC;


-- Cost of inefficiency (Business Impact)
SELECT 
    is_delayed, 
    COUNT(*) AS shipment_count,
    SUM(delivery_cost) AS total_revenue_at_risk,
    ROUND(AVG(delivery_cost), 2) AS avg_shipment_value
FROM shipments
GROUP BY is_delayed;



