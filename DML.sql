-- DML.sql: Data manipulation scripts for Marc's Health Food Store

-- Delete an entire order by order_id
BEGIN TRANSACTION;
DELETE FROM order_details WHERE order_id = 111;
DELETE FROM orders WHERE order_id = 111;
COMMIT;
-- Verify
SELECT * FROM orders WHERE order_id = 111;
SELECT * FROM order_details WHERE order_id = 111;

-- Update product price by product_id
UPDATE products
SET price = 6.79
WHERE product_id = 18;
-- Verify
SELECT product_id, product_name, price
FROM products
WHERE product_id = 18;

-- Custom DML 1: Award loyalty points from order total (5% of total, rounded down)
UPDATE customers c
SET c.loyalty_points = c.loyalty_points + FLOOR(t.order_total * 0.05)
FROM (
    SELECT o.customer_id, SUM(od.quantity * od.unit_price) AS order_total
    FROM orders o
    JOIN order_details od ON od.order_id = o.order_id
    WHERE o.order_id = 113
    GROUP BY o.customer_id
) t
WHERE c.customer_id = t.customer_id;
-- Verify
SELECT c.customer_id, c.full_name, c.loyalty_points
FROM customers c
WHERE c.customer_id IN (SELECT customer_id FROM orders WHERE order_id = 113);

-- Custom DML 2: Receive inventory for a product (add 40 units)
UPDATE products
SET stock_level = stock_level + 40
WHERE product_id = 9;
-- Verify
SELECT product_id, product_name, stock_level
FROM products
WHERE product_id = 9;

-- Custom DML 3: Correct supplier contact information
UPDATE suppliers
SET contact_info = 'service@cedarsage.com'
WHERE supplier_id = 5;
-- Verify
SELECT supplier_id, supplier_name, contact_info
FROM suppliers
WHERE supplier_id = 5;
