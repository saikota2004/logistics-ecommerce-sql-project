USE logistics_db;

-- 1. Overall Business Performance
SELECT
    COUNT(*) AS total_orders,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM orders;


-- 2. Monthly Sales Performance
SELECT
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    COUNT(*) AS total_orders,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;


-- 3. Top 10 Products by Revenue
SELECT
    p.product_id,
    p.product_name,
    p.category,
    SUM(oi.quantity) AS units_sold,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY revenue DESC
LIMIT 10;


-- 4. Top 10 Customers by Spending
SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    c.state,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.total_amount), 2) AS total_spent,
    ROUND(AVG(o.total_amount), 2) AS average_order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name, c.city, c.state
ORDER BY total_spent DESC
LIMIT 10;


-- 5. Warehouse Performance
SELECT
    w.warehouse_id,
    w.warehouse_name,
    w.city,
    w.state,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.total_amount), 2) AS total_revenue,
    ROUND(AVG(o.total_amount), 2) AS average_order_value
FROM warehouses w
LEFT JOIN orders o
    ON w.warehouse_id = o.warehouse_id
GROUP BY w.warehouse_id, w.warehouse_name, w.city, w.state
ORDER BY total_revenue DESC;


-- 6. Delivery Status Analysis
SELECT
    delivery_status,
    COUNT(*) AS total_deliveries
FROM deliveries
GROUP BY delivery_status
ORDER BY total_deliveries DESC;


-- 7. Average Delivery Time
SELECT
    ROUND(
        AVG(DATEDIFF(actual_delivery_date, dispatch_date)),
        2
    ) AS average_delivery_days
FROM deliveries
WHERE actual_delivery_date IS NOT NULL;


-- 8. Courier Performance
SELECT
    courier_name,
    COUNT(*) AS total_deliveries,
    ROUND(
        AVG(DATEDIFF(actual_delivery_date, dispatch_date)),
        2
    ) AS average_delivery_days
FROM deliveries
WHERE actual_delivery_date IS NOT NULL
GROUP BY courier_name
ORDER BY average_delivery_days ASC;


-- 9. Payment Status Analysis
SELECT
    payment_status,
    COUNT(*) AS total_payments,
    ROUND(SUM(amount), 2) AS total_amount
FROM payments
GROUP BY payment_status
ORDER BY total_payments DESC;


-- 10. Return Analysis
SELECT
    return_reason,
    COUNT(*) AS total_returns,
    SUM(return_quantity) AS total_returned_units,
    ROUND(SUM(refund_amount), 2) AS total_refund_amount
FROM returns
GROUP BY return_reason
ORDER BY total_returns DESC;


-- 11. Inventory Reorder Analysis
SELECT
    i.inventory_id,
    w.warehouse_name,
    p.product_name,
    i.stock_quantity,
    i.reorder_level
FROM inventory i
JOIN warehouses w
    ON i.warehouse_id = w.warehouse_id
JOIN products p
    ON i.product_id = p.product_id
WHERE i.stock_quantity <= i.reorder_level
ORDER BY i.stock_quantity ASC;


-- 12. Supplier Performance
SELECT
    s.supplier_id,
    s.supplier_name,
    s.city,
    s.state,
    s.rating,
    COUNT(p.product_id) AS products_supplied
FROM suppliers s
LEFT JOIN products p
    ON s.supplier_id = p.supplier_id
GROUP BY
    s.supplier_id,
    s.supplier_name,
    s.city,
    s.state,
    s.rating
ORDER BY s.rating DESC;