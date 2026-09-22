USE logistics_db;

-- 1. Check total record counts
SELECT 'customers' AS table_name, COUNT(*) AS record_count
FROM customers
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'payments', COUNT(*) FROM payments
UNION ALL
SELECT 'warehouses', COUNT(*) FROM warehouses
UNION ALL
SELECT 'employees', COUNT(*) FROM employees
UNION ALL
SELECT 'deliveries', COUNT(*) FROM deliveries
UNION ALL
SELECT 'inventory', COUNT(*) FROM inventory
UNION ALL
SELECT 'returns', COUNT(*) FROM returns
UNION ALL
SELECT 'suppliers', COUNT(*) FROM suppliers;


-- 2. Check orders without customers
SELECT COUNT(*) AS orders_without_customer
FROM orders o
LEFT JOIN customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;


-- 3. Check orders without warehouses
SELECT COUNT(*) AS orders_without_warehouse
FROM orders o
LEFT JOIN warehouses w
    ON o.warehouse_id = w.warehouse_id
WHERE w.warehouse_id IS NULL;


-- 4. Check orders without order items
SELECT COUNT(*) AS orders_without_items
FROM orders o
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE oi.order_id IS NULL;


-- 5. Check payment amount mismatches
SELECT COUNT(*) AS payment_mismatches
FROM payments p
JOIN orders o
    ON p.order_id = o.order_id
WHERE ABS(p.amount - o.total_amount) > 0.01;


-- 6. Check order total calculation
SELECT COUNT(*) AS incorrect_order_totals
FROM orders o
JOIN (
    SELECT
        order_id,
        SUM(quantity * unit_price) AS calculated_total
    FROM order_items
    GROUP BY order_id
) x
    ON o.order_id = x.order_id
WHERE ABS(o.total_amount - x.calculated_total) > 0.01;


-- 7. Check inventory below reorder level
SELECT
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


-- 8. Check deliveries with invalid dates
SELECT COUNT(*) AS invalid_delivery_dates
FROM deliveries
WHERE actual_delivery_date IS NOT NULL
  AND actual_delivery_date < dispatch_date;


-- 9. Check duplicate customer emails
SELECT
    email,
    COUNT(*) AS duplicate_count
FROM customers
GROUP BY email
HAVING COUNT(*) > 1;


-- 10. Check negative or zero order totals
SELECT COUNT(*) AS invalid_order_totals
FROM orders
WHERE total_amount <= 0;