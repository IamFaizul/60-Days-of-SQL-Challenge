use 90daysofsql;

-- Q99. Find the top 2 customers in each city who have spent the most in Q2 of 2024 (April–June). Show city, customer name, and total spending.

WITH customer_spend AS (
    SELECT 
        r.city,
        c.customer_id,
        c.customer_name,
        SUM(p.amount) AS total_spent
    FROM onlinecustomers c
    INNER JOIN onlineorders o 
        ON c.customer_id = o.customer_id
    INNER JOIN restaurants r 
        ON o.restaurant_id = r.restaurant_id
    INNER JOIN payments p 
        ON o.order_id = p.order_id
    WHERE QUARTER(p.payment_date) = 2
      AND YEAR(p.payment_date) = 2024
    GROUP BY r.city, c.customer_id, c.customer_name
),
ranked AS (
    SELECT 
        city,
        customer_name,
        total_spent,
        DENSE_RANK() OVER (PARTITION BY city ORDER BY total_spent DESC) AS rn
    FROM customer_spend
)
SELECT 
    city,
    customer_name,
    ROUND(total_spent, 2) AS total_spent
FROM ranked
WHERE rn <= 2
ORDER BY city, rn;
