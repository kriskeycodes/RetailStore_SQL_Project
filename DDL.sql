-- DDL.sql: Create and populate database schema for Marc's Health Food Store
-- Drop tables in reverse order to avoid foreign key conflicts
IF OBJECT_ID('workshop_attendance', 'U') IS NOT NULL DROP TABLE workshop_attendance;
IF OBJECT_ID('wellness_workshops', 'U') IS NOT NULL DROP TABLE wellness_workshops;
IF OBJECT_ID('order_details', 'U') IS NOT NULL DROP TABLE order_details;
IF OBJECT_ID('orders', 'U') IS NOT NULL DROP TABLE orders;
IF OBJECT_ID('products', 'U') IS NOT NULL DROP TABLE products;
IF OBJECT_ID('employees', 'U') IS NOT NULL DROP TABLE employees;
IF OBJECT_ID('customers', 'U') IS NOT NULL DROP TABLE customers;
IF OBJECT_ID('suppliers', 'U') IS NOT NULL DROP TABLE suppliers;
IF OBJECT_ID('categories', 'U') IS NOT NULL DROP TABLE categories;

-- Create parent tables
CREATE TABLE categories (
    category_id INT PRIMARY KEY IDENTITY(1,1),
    category_name VARCHAR(100)
);

CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY IDENTITY(1,1),
    supplier_name VARCHAR(100),
    contact_info VARCHAR(100)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    full_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    dietary_preference VARCHAR(100),
    loyalty_points INT
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY IDENTITY(1,1),
    full_name VARCHAR(100),
    role VARCHAR(60)
);

-- Create child tables
CREATE TABLE products (
    product_id INT PRIMARY KEY IDENTITY(1,1),
    product_name VARCHAR(120),
    price DECIMAL(8,2),
    stock_level INT,
    reorder_level INT,
    category_id INT,
    supplier_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY IDENTITY(101,1),
    order_date DATE,
    customer_id INT,
    employee_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE order_details (
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(8,2),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE wellness_workshops (
    workshop_id INT PRIMARY KEY IDENTITY(1,1),
    title VARCHAR(120),
    scheduled_date DATE,
    capacity INT,
    employee_id INT,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE workshop_attendance (
    attendance_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT,
    workshop_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (workshop_id) REFERENCES wellness_workshops(workshop_id)
);

-- Insert 20 records into each table
INSERT INTO categories (category_name) VALUES
('Organic Produce'), ('Bulk Grains and Legumes'), ('Plant-Based Proteins'), ('Herbal Supplements'),
('Cold Beverages and Kombucha'), ('Hot Beverages and Tea'), ('Gluten-Free Bakery'), ('Nut Butters and Spreads'),
('Dairy Alternatives'), ('Healthy Snacks and Bars'), ('Cooking Oils and Vinegars'), ('Spices and Seasonings'),
('Natural Sweeteners'), ('Personal Care and Beauty'), ('Household and Cleaning'), ('Frozen Fruits and Veggies'),
('Fermented Foods'), ('Breakfast and Cereals'), ('Hydration and Electrolytes'), ('Kids Health and Lunchbox');

INSERT INTO suppliers (supplier_name, contact_info) VALUES
('Crimson Creek Provisions', 'orders@crimsoncreek.com'), ('Twilight Roots', 'support@twilightroots.com'),
('Velvet Valley Naturals', 'contact@velvetvalleynaturals.com'), ('Blue Fern Co.', 'hello@bluefernco.com'),
('Cedar & Sage', 'sales@cedarsage.com'), ('Echo Harvest Supply', 'info@echoharvest.com'),
('Wild Ember Foods', 'admin@wildember.com'), ('Moss & Moon Organics', 'mossmoon@suppliers.com'),
('WanderRoot Partners', 'orders@wanderroot.com'), ('Clover Canyon Distributors', 'service@clovercanyon.com'),
('FloraRise Co.', 'contact@florarise.com'), ('Dune Bloom Supply', 'orders@dunebloom.com'),
('HearthGlow Market', 'sales@hearthglow.com'), ('Brassleaf Naturals', 'brassleaf@suppliers.com'),
('Kindled Grove Co.', 'hello@kindledgrove.com'), ('Crescent Acres', 'support@crescentacres.com'),
('Nimbus Nest Supply', 'orders@nimbusnest.com'), ('Ambertrail Foods', 'info@ambertrail.com'),
('Hollow Pine Provisions', 'contact@hollowpine.com'), ('Sundew Farms Collective', 'admin@sundewfarms.com');

INSERT INTO customers (full_name, email, phone, dietary_preference, loyalty_points) VALUES
('Dana Jones', 'dana@example.com', '555-0110', 'Vegan', 20), ('Nailah Smith', 'nailah@example.com', '555-0111', 'Gluten-Free', 35),
('Orion Sky', 'orion.sky@example.com', '555-0112', 'Paleo', 15), ('River Lynn', 'river.lynn@example.com', '555-0113', 'Vegetarian', 12),
('Luna Vance', 'luna.vance@example.com', '555-0114', 'Vegan', 30), ('Zane Cruz', 'zane.cruz@example.com', '555-0115', 'Keto', 8),
('Nova Reese', 'nova.reese@example.com', '555-0116', 'Dairy-Free', 25), ('Elias Reed', 'elias.reed@example.com', '555-0117', 'None', 5),
('Sage Monroe', 'sage.monroe@example.com', '555-0118', 'Gluten-Free', 40), ('Indigo Vale', 'indigo.vale@example.com', '555-0119', 'Vegan', 18),
('Kai Bennett', 'kai.bennett@example.com', '555-0120', 'Low-Sodium', 10), ('Skye Emerson', 'skye.emerson@example.com', '555-0121', 'Vegetarian', 22),
('Phoenix Lane', 'phoenix.lane@example.com', '555-0122', 'Keto', 16), ('Jasper Storm', 'jasper.storm@example.com', '555-0123', 'None', 12),
('Azaria Blue', 'azaria.blue@example.com', '555-0124', 'Vegan', 33), ('Milo Dash', 'milo.dash@example.com', '555-0125', 'Dairy-Free', 11),
('Zuri West', 'zuri.west@example.com', '555-0126', 'Gluten-Free', 27), ('Lyric Moon', 'lyric.moon@example.com', '555-0127', 'Low-Carb', 14),
('Calla Brooks', 'calla.brooks@example.com', '555-0128', 'Vegetarian', 19), ('Sol Eden', 'sol.eden@example.com', '555-0129', 'None', 9);

INSERT INTO employees (full_name, role) VALUES
('Sage Moon', 'Cashier'), ('River Knight', 'Stock Associate'), ('Lyric Hart', 'Nutrition Specialist'),
('Zion Wilder', 'Floor Manager'), ('Nova Quinn', 'Cashier'), ('Cypress Lane', 'Shift Supervisor'),
('Indigo Ray', 'Marketing Assistant'), ('Phoenix Snow', 'Stock Associate'), ('Skye Ocean', 'Nutrition Specialist'),
('Rowan Blaze', 'Inventory Coordinator'), ('Juniper Blue', 'Cashier'), ('Orion Steele', 'Floor Manager'),
('Vesper Rain', 'Workshop Coordinator'), ('Zephyr Cloud', 'Nutrition Specialist'), ('Solstice Day', 'Customer Service'),
('Atlas Vale', 'Maintenance'), ('Echo Star', 'Cashier'), ('Draven Ash', 'Shift Supervisor'),
('Tansy Wren', 'Workshop Assistant'), ('Lazlo Frost', 'Logistics Support');

INSERT INTO products (product_name, price, stock_level, reorder_level, category_id, supplier_id) VALUES
('Sunrise Kale Bunch', 2.49, 85, 20, 1, 1), ('Canyon Chickpea Dry Pack 2 lb', 4.79, 120, 30, 2, 10),
('Maple Herb Tempeh 8 oz', 5.99, 60, 15, 3, 7), ('Calm Focus Ashwagandha 90 ct', 16.95, 40, 10, 4, 14),
('Citrus Ginger Kombucha 16 oz', 3.49, 140, 35, 5, 2), ('Cinnamon Chai Wellness Tea 20 ct', 6.25, 75, 18, 6, 11),
('Almond Flour Morning Muffin 4 pack', 7.49, 32, 8, 7, 13), ('Stoneground Almond Butter 12 oz', 8.99, 50, 12, 8, 15),
('Barista Oat Milk 32 oz', 3.29, 110, 28, 9, 16), ('Trail Glow Nut Bar Single', 1.99, 200, 50, 10, 18),
('Cold-Pressed Avocado Oil 16 oz', 12.95, 45, 12, 11, 19), ('Smoked Paprika Glass Jar 2 oz', 4.25, 90, 22, 12, 4),
('Wildflower Honey 12 oz', 7.75, 55, 14, 13, 20), ('Lavender Shea Hand Cream 3 oz', 9.50, 38, 10, 14, 5),
('Citrus Thyme Cleaner Refill 32 oz', 6.99, 62, 16, 15, 6), ('Frozen Mango Chunks 16 oz', 3.89, 130, 32, 16, 8),
('Classic Kimchi Pint', 5.49, 44, 12, 17, 9), ('Ancient Grain Granola 12 oz', 6.49, 72, 18, 18, 12),
('Cucumber Mint Electrolyte Drink', 2.29, 150, 36, 19, 17), ('Kids Apple Cinnamon Bites 5 ct', 4.59, 58, 14, 20, 3);

INSERT INTO orders (order_date, customer_id, employee_id) VALUES
('2025-01-03', 1, 2), ('2025-01-04', 3, 4), ('2025-01-05', 5, 1), ('2025-01-06', 2, 3),
('2025-01-08', 4, 5), ('2025-01-09', 6, 2), ('2025-01-10', 8, 1), ('2025-01-12', 10, 3),
('2025-01-14', 7, 4), ('2025-01-15', 9, 5), ('2025-02-01', 1, 2), ('2025-02-02', 3, 4),
('2025-02-03', 5, 1), ('2025-02-05', 2, 3), ('2025-02-07', 4, 5), ('2025-02-08', 6, 2),
('2025-02-09', 8, 1), ('2025-02-10', 10, 3), ('2025-02-12', 7, 4), ('2025-02-14', 9, 5);

INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES
(101, 5, 2, 3.49), (102, 1, 3, 2.49), (103, 8, 1, 8.99), (104, 12, 2, 4.25),
(105, 3, 2, 5.99), (106, 11, 1, 12.95), (107, 9, 3, 3.29), (108, 14, 1, 9.50),
(109, 7, 2, 7.49), (110, 16, 4, 3.89), (111, 19, 2, 2.29), (112, 6, 1, 6.25),
(113, 13, 1, 7.75), (114, 17, 2, 5.49), (115, 2, 2, 4.79), (116, 15, 1, 6.99),
(117, 18, 1, 6.49), (118, 4, 1, 16.95), (119, 20, 2, 4.59), (120, 10, 5, 1.99);

INSERT INTO wellness_workshops (title, scheduled_date, capacity, employee_id) VALUES
('Gut Health 101: Fermented Foods at Home', '2025-03-05', 20, 13),
('Plant Powered Meal Prep for Busy Weeks', '2025-03-08', 24, 3),
('Intro to Herbal Immunity Support', '2025-03-12', 18, 14),
('Low Sugar Baking Basics', '2025-03-15', 16, 7),
('Smoothie Lab: Protein and Greens', '2025-03-19', 22, 9),
('Reading Labels: Spotting Hidden Ingredients', '2025-03-22', 25, 12),
('Family Lunchbox Makeover', '2025-03-26', 20, 15),
('Tea Rituals for Calm and Focus', '2025-03-29', 18, 11),
('Gluten Free Kitchen Setup', '2025-04-02', 20, 14),
('Keto Friendly Pantry Staples', '2025-04-05', 18, 3),
('Budget Friendly Organic Shopping', '2025-04-09', 26, 12),
('Anti Inflammatory Cooking Made Simple', '2025-04-12', 22, 9),
('Electrolytes and Hydration for Spring Training', '2025-04-16', 28, 17),
('Fermentation: Kimchi and Kraut Workshop', '2025-04-19', 16, 13),
('Dairy Free Desserts that Satisfy', '2025-04-23', 20, 5),
('Spice Cabinet Masterclass', '2025-04-26', 18, 12),
('Breakfast Reset: High Fiber Starts', '2025-04-30', 24, 3),
('Kids in the Kitchen: Safe Knife Skills', '2025-05-03', 14, 20),
('Spring Clean Your Home the Non Toxic Way', '2025-05-07', 22, 6),
('Vegan Protein Three Ways: Tempeh, Tofu, and Beans', '2025-05-10', 20, 3);

INSERT INTO workshop_attendance (customer_id, workshop_id) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8), (9, 9), (10, 10),
(1, 11), (2, 12), (3, 13), (4, 14), (5, 15), (6, 16), (7, 17), (8, 18), (9, 19), (10, 20);

-- Sanity checks (optional, for verification)
SELECT COUNT(*) AS categories_rows FROM categories;
SELECT COUNT(*) AS suppliers_rows FROM suppliers;
SELECT COUNT(*) AS customers_rows FROM customers;
SELECT COUNT(*) AS employees_rows FROM employees;
SELECT COUNT(*) AS products_rows FROM products;
SELECT COUNT(*) AS orders_rows FROM orders;
SELECT COUNT(*) AS order_details_rows FROM order_details;
SELECT COUNT(*) AS workshops_rows FROM wellness_workshops;
SELECT COUNT(*) AS attendance_rows FROM workshop_attendance;
