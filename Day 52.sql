use 90daysofsql;

WITH city_month_revenue AS (
    SELECT 
        r.city,
        MONTH(p.payment_date) AS month_num,
        SUM(p.amount) AS total_revenue
    FROM restaurants r
    INNER JOIN onlineorders o 
        ON r.restaurant_id = o.restaurant_id
    INNER JOIN payments p 
        ON o.order_id = p.order_id
    WHERE YEAR(p.payment_date) = 2024
    GROUP BY r.city, MONTH(p.payment_date)
),
ranked AS (
    SELECT 
        city,
        month_num,
        total_revenue,
        DENSE_RANK() OVER (PARTITION BY city ORDER BY total_revenue DESC) AS rn
    FROM city_month_revenue
)
SELECT 
    city,
    month_num AS best_month,
    total_revenue
FROM ranked
WHERE rn = 1
ORDER BY city, best_month;
