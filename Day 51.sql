use 90daysofsql;

-- Q97. Find the top 3 restaurants in each city that generated the highest average order value (AOV) in Q2 (April–June).

with cityAOV as (
select r.city,
        r.restaurant_id,
        r.restaurant_name,
        SUM(p.amount) * 1.0 / COUNT(DISTINCT o.order_id) AS avg_order_value
    FROM restaurants r
    INNER JOIN onlineorders o 
        ON r.restaurant_id = o.restaurant_id
    INNER JOIN payments p 
        ON o.order_id = p.order_id
    WHERE QUARTER(p.payment_date) = 2    
    GROUP BY r.city, r.restaurant_id, r.restaurant_name
),

ranked as (select city, restaurant_id, restaurant_name, avg_order_value,
	dense_rank() over(partition by city order by avg_order_value desc) as rn
    from cityAOV

)

select * from ranked where rn <= 3