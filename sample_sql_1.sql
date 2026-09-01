WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('MONTH', order_date) AS order_month,
        customer_id,
        SUM(order_amount) AS total_sales,
        COUNT(order_id) AS order_count
    FROM analytics.orders
    WHERE order_status = 'COMPLETED'
      AND order_date >= DATEADD('MONTH', -12, CURRENT_DATE())
    GROUP BY DATE_TRUNC('MONTH', order_date), customer_id
)
SELECT
    ms.order_month,
    c.customer_segment,
    SUM(ms.total_sales) AS total_sales,
    SUM(ms.order_count) AS order_count
FROM monthly_sales AS ms
JOIN analytics.customers AS c
    ON ms.customer_id = c.customer_id
JOIN analytics.customer_regions AS r
    ON 1 = 1
WHERE c.customer_status <> 'INACTIVE'
GROUP BY ms.order_month, c.customer_segment
ORDER BY ms.order_month;
