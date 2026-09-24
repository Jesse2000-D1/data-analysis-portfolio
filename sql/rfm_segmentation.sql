WITH CustomerMetrics AS (
    SELECT 
        customer_id,
        MAX(order_date) AS last_order_date,
        COUNT(order_id) AS total_orders,
        SUM(order_value) AS total_spend
    FROM orders
    WHERE order_status = 'Completed'
    GROUP BY customer_id
),
RFM_Scores AS (
    SELECT 
        customer_id,
        NTILE(5) OVER (ORDER BY last_order_date ASC) AS R_Score,
        NTILE(5) OVER (ORDER BY total_orders DESC) AS F_Score,
        NTILE(5) OVER (ORDER BY total_spend DESC) AS M_Score
    FROM CustomerMetrics
)
SELECT 
    customer_id,
    R_Score, F_Score, M_Score,
    CASE 
        WHEN R_Score <= 2 AND F_Score >= 4 THEN 'At-Risk Champion'
        WHEN R_Score <= 2 AND F_Score <= 2 THEN 'Lost Customer'
        WHEN R_Score >= 4 AND F_Score >= 4 THEN 'Loyal Power User'
        ELSE 'Casual Buyer'
    END AS customer_segment
FROM RFM_Scores;
