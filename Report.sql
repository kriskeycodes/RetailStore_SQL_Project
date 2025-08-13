-- REPORT.sql: Reporting queries for Marc's Health Food Store

-- Report 1: Revenue per month grouped by customer
SELECT FORMAT(o.order_date, 'yyyy-MM') AS order_month,
       c.customer_id, c.full_name,
       ROUND(SUM(od.quantity * od.unit_price), 2) AS revenue
FROM orders o
JOIN order_details od ON od.order_id = o.order_id
JOIN customers c ON c.customer_id = o.customer_id
WHERE YEAR(o.order_date) = 2025
GROUP BY FORMAT(o.order_date, 'yyyy-MM'), c.customer_id, c.full_name
ORDER BY order_month, revenue DESC;

-- Report 2: Revenue per month grouped by product
SELECT FORMAT(o.order_date, 'yyyy-MM') AS order_month,
       p.product_id, p.product_name,
       ROUND(SUM(od.quantity * od.unit_price), 2) AS revenue
FROM orders o
JOIN order_details od ON od.order_id = o.order_id
JOIN products p ON p.product_id = od.product_id
WHERE YEAR(o.order_date) = 2025
GROUP BY FORMAT(o.order_date, 'yyyy-MM'), p.product_id, p.product_name
ORDER BY order_month, revenue DESC;

-- Report 3: Product count grouped by category
SELECT c.category_id, c.category_name, COUNT(p.product_id) AS product_count
FROM categories c
LEFT JOIN products p ON p.category_id = c.category_id
GROUP BY c.category_id, c.category_name
ORDER BY product_count DESC, c.category_name;

-- Custom Report 1: Low stock reorder list
SELECT p.product_id, p.product_name, p.stock_level, p.reorder_level,
       cat.category_name, s.supplier_name, s.contact_info
FROM products p
JOIN categories cat ON cat.category_id = p.category_id
JOIN suppliers s ON s.supplier_id = p.supplier_id
WHERE p.stock_level <= p.reorder_level
ORDER BY p.stock_level ASC, p.product_name;

-- Custom Report 2: Top customers by revenue in 2025
SELECT TOP 5 c.customer_id, c.full_name,
             ROUND(SUM(od.quantity * od.unit_price), 2) AS total_revenue
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_details od ON od.order_id = o.order_id
WHERE YEAR(o.order_date) = 2025
GROUP BY c.customer_id, c.full_name
ORDER BY total_revenue DESC;

-- Custom Report 3: CROSSTAB monthly revenue by category
SELECT cat.category_name,
       ROUND(SUM(CASE WHEN YEAR(o.order_date) = 2025 AND MONTH(o.order_date) = 1
                     THEN od.quantity * od.unit_price ELSE 0 END), 2) AS Jan_2025,
       ROUND(SUM(CASE WHEN YEAR(o.order_date) = 2025 AND MONTH(o.order_date) = 2
                     THEN od.quantity * od.unit_price ELSE 0 END), 2) AS Feb_2025,
       ROUND(SUM(CASE WHEN YEAR(o.order_date) = 2025 AND MONTH(o.order_date) = 3
                     THEN od.quantity * od.unit_price ELSE 0 END), 2) AS Mar_2025,
       ROUND(SUM(CASE WHEN YEAR(o.order_date) = 2025 AND MONTH(o.order_date) = 4
                     THEN od.quantity * od.unit_price ELSE 0 END), 2) AS Apr_2025
FROM categories cat
JOIN products p ON p.category_id = cat.category_id
JOIN order_details od ON od.product_id = p.product_id
JOIN orders o ON o.order_id = od.order_id
GROUP BY cat.category_name
ORDER BY cat.category_name;
