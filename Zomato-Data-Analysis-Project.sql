/*

Zomato Data Analysis Project (Using SQL)
										
Table relationship                - 					Type
----------------------------------------------------------------------
customers → orders                - 					one-to-many  
restaurants → menu_items          - 					one-to-many  
restaurants → employees           - 					one-to-many  
restaurants → reviews             - 					one-to-many
customers → reviews               - 					one-to-many
orders → order_items              - 					one-to-many
orders → payments				  -						one-to-one	  
orders → delivery				  -						one-to-one
menu_items → order_items		  -	  					one-to-many

*/

-- -------------------------------------------------------------------------------------------------------------------------------------------
-- Delete Database
-- -------------------------------------------------------------------------------------------------------------------------------------------
DROP DATABASE Zomato_Data_Analysis_Project;

-- -------------------------------------------------------------------------------------------------------------------------------------------
-- Create Database
-- -------------------------------------------------------------------------------------------------------------------------------------------
CREATE DATABASE Zomato_Data_Analysis_Project;

-- -------------------------------------------------------------------------------------------------------------------------------------------
-- Use Database
-- -------------------------------------------------------------------------------------------------------------------------------------------
USE Zomato_Data_Analysis_Project;

-- -------------------------------------------------------------------------------------------------------------------------------------------
-- Create Customers Table and Insert Values
-- -------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    gender ENUM('Male','Female','Other') DEFAULT 'Other',
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50) DEFAULT 'India',
    join_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    membership ENUM('Regular','Gold','Platinum') DEFAULT 'Regular'
);

INSERT INTO customers (full_name, gender, email, phone, city, state, membership) VALUES
('Ravi Kumar','Male','ravi.kumar@gmail.com','9876543210','Delhi','Delhi','Regular'),
('Priya Sharma','Female','priya.sharma@gmail.com','9812345678','Mumbai','Maharashtra','Gold'),
('Amit Singh','Male','amit.singh@gmail.com','9821122334','Lucknow','Uttar Pradesh','Regular'),
('Sneha Patel','Female','sneha.patel@gmail.com','9911223344','Ahmedabad','Gujarat','Platinum'),
('Vikram Das','Male','vikram.das@gmail.com','9900011223','Kolkata','West Bengal','Gold'),
('Neha Reddy','Female','neha.reddy@gmail.com','9988776655','Hyderabad','Telangana','Regular'),
('Rahul Mehta','Male','rahul.mehta@gmail.com','9797979797','Pune','Maharashtra','Gold'),
('Kavita Nair','Female','kavita.nair@gmail.com','9665544332','Chennai','Tamil Nadu','Regular'),
('Arjun Verma','Male','arjun.verma@gmail.com','9554433221','Bengaluru','Karnataka','Platinum'),
('Pooja Bansal','Female','pooja.bansal@gmail.com','9443322110','Jaipur','Rajasthan','Regular'),
('Suresh Rao','Male','suresh.rao@gmail.com','9332211009','Visakhapatnam','Andhra Pradesh','Gold'),
('Ananya Ghosh','Female','ananya.ghosh@gmail.com','9221100987','Kolkata','West Bengal','Regular');

-- -------------------------------------------------------------------------------------------------------------------------------------------
-- Create Restaurants Table and Insert Values
-- -------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE restaurants (
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50) DEFAULT 'India',
    address VARCHAR(255),
    cuisine_type VARCHAR(50),
    rating DECIMAL(2,1) DEFAULT 0.0,
    is_active BOOLEAN DEFAULT TRUE
);

INSERT INTO restaurants (restaurant_name, city, state, address, cuisine_type, rating)
VALUES
('Spice Villa','Delhi','Delhi','Connaught Place','North Indian',4.5),
('Taste of Mumbai','Mumbai','Maharashtra','Bandra West','Seafood',4.3),
('Punjabi Zaika','Amritsar','Punjab','Lawrence Road','Punjabi',4.7),
('Dosa House','Chennai','Tamil Nadu','T Nagar','South Indian',4.4),
('Biryani Hub','Hyderabad','Telangana','Gachibowli','Biryani',4.6),
('Royal Treat','Kolkata','West Bengal','Park Street','Bengali',4.2),
('Urban Café','Bengaluru','Karnataka','Koramangala','Continental',4.5),
('Tandoori Flame','Jaipur','Rajasthan','MI Road','Mughlai',4.1),
('Veggie Delight','Ahmedabad','Gujarat','SG Highway','Vegetarian',4.3),
('Chill & Grill','Pune','Maharashtra','FC Road','Fast Food',4.0),
('The Green Bowl','Kochi','Kerala','MG Road','Healthy',4.6),
('Street Spice','Lucknow','Uttar Pradesh','Hazratganj','Street Food',4.2);

-- -------------------------------------------------------------------------------------------------------------------------------------------
-- Create Menu_Items Table and Insert Values
-- -------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE menu_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT,
    item_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(8,2),
    is_available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id) ON DELETE CASCADE
);

INSERT INTO menu_items (restaurant_id, item_name, category, price) VALUES
(1,'Butter Chicken','Main Course',350.00),
(1,'Paneer Tikka','Starter',250.00),
(2,'Prawn Curry','Main Course',450.00),
(3,'Amritsari Kulcha','Main Course',200.00),
(4,'Masala Dosa','Main Course',180.00),
(5,'Hyderabadi Biryani','Main Course',300.00),
(6,'Fish Curry','Main Course',320.00),
(7,'Veg Pasta','Main Course',280.00),
(8,'Tandoori Chicken','Main Course',340.00),
(9,'Veg Thali','Main Course',260.00),
(10,'Cheese Burger','Fast Food',150.00),
(11,'Green Salad','Healthy',120.00);

-- -------------------------------------------------------------------------------------------------------------------------------------------
-- Create Orders Table and Insert Values
-- -------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    restaurant_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2),
    status ENUM('Pending','Preparing','Delivered','Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE SET NULL,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id) ON DELETE SET NULL
);

INSERT INTO orders (customer_id, restaurant_id, total_amount, status)
VALUES
(1,1,600.00,'Delivered'),
(2,2,450.00,'Delivered'),
(3,5,300.00,'Preparing'),
(4,3,200.00,'Pending'),
(5,4,180.00,'Delivered'),
(6,6,320.00,'Delivered'),
(7,7,280.00,'Cancelled'),
(8,8,340.00,'Delivered'),
(9,9,260.00,'Delivered'),
(10,10,150.00,'Preparing'),
(11,11,120.00,'Delivered'),
(12,12,420.00,'Delivered');

-- -------------------------------------------------------------------------------------------------------------------------------------------
-- Create Order_Items Table and Insert Values
-- -------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    item_id INT,
    quantity INT DEFAULT 1,
    price DECIMAL(8,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES menu_items(item_id) ON DELETE CASCADE
);

INSERT INTO order_items (order_id, item_id, quantity, price)
VALUES
(1,1,2,700.00),
(1,2,1,250.00),
(2,3,1,450.00),
(3,5,1,300.00),
(4,4,2,400.00),
(5,5,1,180.00),
(6,7,1,320.00),
(7,8,1,280.00),
(8,9,1,260.00),
(9,10,2,300.00),
(10,11,1,120.00),
(12,6,1,420.00);

-- -------------------------------------------------------------------------------------------------------------------------------------------
-- Create Delivery Table and Insert Values
-- -------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE delivery (
    delivery_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    delivery_boy_name VARCHAR(100),
    phone VARCHAR(20),
    delivery_address VARCHAR(255),
    delivery_status ENUM('Pending','On the way','Delivered','Cancelled') DEFAULT 'Pending',
    delivery_time DATETIME,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);

INSERT INTO delivery (order_id, delivery_boy_name, phone, delivery_address, delivery_status)
VALUES
(1,'Rohit Sharma','9001112233','Connaught Place, Delhi','Delivered'),
(2,'Arun Nair','9002223344','Bandra, Mumbai','Delivered'),
(3,'Sahil Khan','9003334455','Gachibowli, Hyderabad','On the way'),
(4,'Deepak Yadav','9004445566','Lawrence Road, Amritsar','Pending'),
(5,'Sanjay Rao','9005556677','T Nagar, Chennai','Delivered'),
(6,'Karan Patel','9006667788','Park Street, Kolkata','Delivered'),
(7,'Ravi Joshi','9007778899','Koramangala, Bengaluru','Cancelled'),
(8,'Ramesh Das','9008889900','MI Road, Jaipur','Delivered'),
(9,'Anil Kumar','9110001112','SG Highway, Ahmedabad','Delivered'),
(10,'Vivek Singh','9121112223','FC Road, Pune','On the way'),
(11,'Sathish Reddy','9132223334','MG Road, Kochi','Delivered'),
(12,'Alok Gupta','9143334445','Hazratganj, Lucknow','Delivered');

-- -------------------------------------------------------------------------------------------------------------------------------------------
-- Create Payments Table and Insert Values
-- -------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_method ENUM('Cash','Card','UPI','Wallet') DEFAULT 'Cash',
    payment_status ENUM('Pending','Completed','Failed') DEFAULT 'Pending',
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);

INSERT INTO payments (order_id, payment_method, payment_status, amount)
VALUES
(1,'Card','Completed',600.00),
(2,'UPI','Completed',450.00),
(3,'Cash','Pending',300.00),
(4,'Wallet','Pending',200.00),
(5,'Card','Completed',180.00),
(6,'UPI','Completed',320.00),
(7,'Cash','Failed',280.00),
(8,'Card','Completed',340.00),
(9,'UPI','Completed',260.00),
(10,'Cash','Pending',150.00),
(11,'Wallet','Completed',120.00),
(12,'Card','Completed',420.00);

-- -------------------------------------------------------------------------------------------------------------------------------------------
-- Create Reviews Table and Insert Values
-- -------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    restaurant_id INT,
    rating DECIMAL(2,1) CHECK (rating >= 0 AND rating <= 5),
    review_text TEXT,
    review_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE SET NULL,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id) ON DELETE CASCADE
);

INSERT INTO reviews (customer_id, restaurant_id, rating, review_text)
VALUES
(1,1,4.5,'Delicious food and quick delivery!'),
(2,2,4.0,'Loved the seafood!'),
(3,5,4.7,'Authentic biryani taste.'),
(4,3,3.8,'Good but bit oily.'),
(5,4,4.6,'Crispy dosa and chutney combo!'),
(6,6,4.2,'Fish curry was perfect.'),
(7,7,3.5,'Average experience.'),
(8,8,4.4,'Tandoori was juicy and flavorful.'),
(9,9,4.1,'Great vegetarian thali.'),
(10,10,4.0,'Nice fast food options.'),
(11,11,4.5,'Healthy and tasty bowl.'),
(12,12,4.3,'Street food flavors were amazing.');

-- -------------------------------------------------------------------------------------------------------------------------------------------
-- Create Employees Table and Insert Values
-- -------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT,
    full_name VARCHAR(100),
    role ENUM('Chef','Waiter','Manager','Delivery') DEFAULT 'Waiter',
    phone VARCHAR(20),
    hire_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id) ON DELETE CASCADE
);

INSERT INTO employees (restaurant_id, full_name, role, phone)
VALUES
(1,'Rajesh Kumar','Manager','9001010101'),
(1,'Manoj Singh','Chef','9002020202'),
(2,'Sunil Sharma','Waiter','9003030303'),
(3,'Ajay Das','Chef','9004040404'),
(4,'Suresh Reddy','Manager','9005050505'),
(5,'Ankit Jain','Chef','9006060606'),
(6,'Deepa Roy','Waiter','9007070707'),
(7,'Arun Kumar','Chef','9008080808'),
(8,'Ravi Meena','Manager','9009090909'),
(9,'Kiran Patel','Waiter','9010101010'),
(10,'Abhishek Rao','Chef','9011111111'),
(11,'Vimal Nair','Manager','9012121212');

-- Category 1: Basic SELECT & Filtering (20 Questions)

-- 1. Retrieve all customers with full_name, email, and phone.
SELECT full_name, email, phone FROM customers;

-- 2. List all restaurants in 'Mumbai' along with city and state.
SELECT restaurant_name, city, state FROM restaurants WHERE city = 'Mumbai';

-- 3. Show all menu items with price > 300.
SELECT item_name, price FROM menu_items WHERE price > 300;

-- 4. Display orders with status = 'Pending'.
SELECT * FROM orders WHERE status = 'Pending';

-- 5. List deliveries with delivery_status = 'On the way'.
SELECT * FROM delivery WHERE delivery_status = 'On the way';

-- 6. Show employees with role 'Manager'.
SELECT full_name, role, restaurant_id FROM employees WHERE role = 'Manager';

-- 7. Retrieve reviews with rating > 4.5.
SELECT * FROM reviews WHERE rating > 4.5;

-- 8. List all payments with payment_status = 'Completed'.
SELECT * FROM payments WHERE payment_status = 'Completed';

-- 9. Display customers from 'Delhi' with membership type.
SELECT full_name, city, membership FROM customers WHERE city = 'Delhi';

-- 10. Show restaurants serving 'Biryani' cuisine.
SELECT restaurant_name, cuisine_type FROM restaurants WHERE cuisine_type = 'Biryani';

-- 11. List menu items in the 'Starter' category.
SELECT item_name, category FROM menu_items WHERE category = 'Starter';

-- 12. Retrieve orders placed in the last 7 days.
SELECT * FROM orders WHERE order_date >= NOW() - INTERVAL 7 DAY;

-- 13. List deliveries scheduled today.
SELECT * FROM delivery WHERE DATE(delivery_time) = CURRENT_DATE;

-- 14. Show employees hired after '2025-01-01'.
SELECT * FROM employees WHERE hire_date > '2025-01-01';

-- 15. Display payments made via 'UPI'.
SELECT * FROM payments WHERE payment_method = 'UPI';

-- 16. Show reviews written in the last 30 days.
SELECT * FROM reviews WHERE review_date >= NOW() - INTERVAL 30 DAY;

-- 17. List active restaurants (is_active = TRUE).
SELECT * FROM restaurants WHERE is_active = TRUE;

-- 18. Show available menu items (is_available = TRUE).
SELECT * FROM menu_items WHERE is_available = TRUE;

-- 19. List customers with membership 'Gold'.
SELECT full_name, membership FROM customers WHERE membership = 'Gold';

-- 20. Retrieve orders with total_amount > 500.
SELECT * FROM orders WHERE total_amount > 500;

-- Category 2: Sorting & Limiting (10 Questions)

-- 21. Top 5 customers by total orders placed.
SELECT c.full_name, COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY total_orders DESC
LIMIT 5;

-- 22. 10 most expensive menu items.
SELECT item_name, price
FROM menu_items
ORDER BY price DESC
LIMIT 10;

-- 23. Top 5 restaurants by average rating.
SELECT r.restaurant_name, AVG(rv.rating) AS avg_rating
FROM restaurants r
JOIN reviews rv ON r.restaurant_id = rv.restaurant_id
GROUP BY r.restaurant_id
ORDER BY avg_rating DESC
LIMIT 5;

-- 24. Last 10 orders placed.
SELECT *
FROM orders
ORDER BY order_date DESC
LIMIT 10;

-- 25. Top 5 delivery boys by number of completed deliveries.
SELECT delivery_boy_name, COUNT(delivery_id) AS total_deliveries
FROM delivery
WHERE delivery_status = 'Delivered'
GROUP BY delivery_boy_name
ORDER BY total_deliveries DESC
LIMIT 5;

-- 26. Top 3 employees by hire date per restaurant.
SELECT *
FROM (
    SELECT e.*, ROW_NUMBER() OVER(PARTITION BY restaurant_id ORDER BY hire_date) AS rn
    FROM employees e
) t
WHERE rn <= 3;

-- 27. Top 10 menu items by quantity sold.
SELECT mi.item_name, SUM(oi.quantity) AS total_sold
FROM menu_items mi
JOIN order_items oi ON mi.item_id = oi.item_id
GROUP BY mi.item_id
ORDER BY total_sold DESC
LIMIT 10;

-- 28. 5 customers who spent the most.
SELECT c.full_name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 5;

-- 29. 5 most recent reviews.
SELECT *
FROM reviews
ORDER BY review_date DESC
LIMIT 5;

-- 30. Restaurants with highest rating, limited to top 5.
SELECT restaurant_name, rating
FROM restaurants
ORDER BY rating DESC
LIMIT 5;

-- Category 3: Aggregate Functions & Grouping (20 Questions)

-- 31. Count total customers.
SELECT COUNT(*) AS total_customers FROM customers;

-- 32. Count restaurants per city.
SELECT city, COUNT(*) AS total_restaurants
FROM restaurants
GROUP BY city;

-- 33. Sum total revenue from all orders.
SELECT SUM(total_amount) AS total_revenue FROM orders;

-- 34. Average rating per restaurant.
SELECT restaurant_id, AVG(rating) AS avg_rating
FROM reviews
GROUP BY restaurant_id;

-- 35. Maximum order amount.
SELECT MAX(total_amount) AS max_order_amount FROM orders;

-- 36. Minimum order amount.
SELECT MIN(total_amount) AS min_order_amount FROM orders;

-- 37. Count orders by status.
SELECT status, COUNT(*) AS total_orders
FROM orders
GROUP BY status;

-- 38. Count menu items per restaurant.
SELECT restaurant_id, COUNT(*) AS total_items
FROM menu_items
GROUP BY restaurant_id;

-- 39. Average menu item price per restaurant.
SELECT restaurant_id, AVG(price) AS avg_price
FROM menu_items
GROUP BY restaurant_id;

-- 40. Total quantity sold per menu item.
SELECT item_id, SUM(quantity) AS total_quantity_sold
FROM order_items
GROUP BY item_id;

-- 41. Total revenue per restaurant.
SELECT o.restaurant_id, SUM(o.total_amount) AS total_revenue
FROM orders o
GROUP BY o.restaurant_id;

-- 42. Count deliveries per delivery status.
SELECT delivery_status, COUNT(*) AS total_deliveries
FROM delivery
GROUP BY delivery_status;

-- 43. Average payment amount per method.
SELECT payment_method, AVG(amount) AS avg_payment
FROM payments
GROUP BY payment_method;

-- 44. Count reviews per customer.
SELECT customer_id, COUNT(*) AS total_reviews
FROM reviews
GROUP BY customer_id;

-- 45. Count orders per customer.
SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id;

-- 46. Count customers per membership type.
SELECT membership, COUNT(*) AS total_customers
FROM customers
GROUP BY membership;

-- 47. Maximum delivery time per delivery boy.
SELECT delivery_boy_name, MAX(delivery_time) AS last_delivery_time
FROM delivery
GROUP BY delivery_boy_name;

-- 48. Total items ordered per order.
SELECT order_id, SUM(quantity) AS total_items
FROM order_items
GROUP BY order_id;

-- 49. Sum of payments per payment status.
SELECT payment_status, SUM(amount) AS total_amount
FROM payments
GROUP BY payment_status;

-- 50. Count employees per restaurant.
SELECT restaurant_id, COUNT(*) AS total_employees
FROM employees
GROUP BY restaurant_id;

-- Category 4: Joins – INNER JOIN (20 Questions)

-- 51. List orders with customer names and total amount.
SELECT o.order_id, c.full_name, o.total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- 52. Show order items with menu item names and prices.
SELECT oi.order_item_id, mi.item_name, oi.quantity, oi.price
FROM order_items oi
JOIN menu_items mi ON oi.item_id = mi.item_id;

-- 53. Orders with restaurant names and status.
SELECT o.order_id, r.restaurant_name, o.status
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id;

-- 54. Deliveries with order and customer details.
SELECT d.delivery_id, o.order_id, c.full_name, d.delivery_status
FROM delivery d
JOIN orders o ON d.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id;

-- 55. Payments with customer and order status.
SELECT p.payment_id, c.full_name, o.status, p.amount
FROM payments p
JOIN orders o ON p.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id;

-- 56. Reviews with customer and restaurant names.
SELECT rv.review_id, c.full_name, r.restaurant_name, rv.rating, rv.review_text
FROM reviews rv
JOIN customers c ON rv.customer_id = c.customer_id
JOIN restaurants r ON rv.restaurant_id = r.restaurant_id;

-- 57. Employees with restaurant names.
SELECT e.full_name, e.role, r.restaurant_name
FROM employees e
JOIN restaurants r ON e.restaurant_id = r.restaurant_id;

-- 58. Total revenue per restaurant combining orders and payments.
SELECT r.restaurant_name, SUM(o.total_amount) AS total_revenue
FROM restaurants r
JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id;

-- 59. Orders with delivery status and delivery boy name.
SELECT o.order_id, d.delivery_boy_name, d.delivery_status
FROM orders o
JOIN delivery d ON o.order_id = d.order_id;

-- 60. Menu items with restaurant names and cuisine type.
SELECT mi.item_name, mi.price, r.restaurant_name, r.cuisine_type
FROM menu_items mi
JOIN restaurants r ON mi.restaurant_id = r.restaurant_id;

-- 61. Orders with total number of items.
SELECT o.order_id, SUM(oi.quantity) AS total_items
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id;

-- 62. Reviews with rating > 4 including customer and restaurant.
SELECT rv.review_id, c.full_name, r.restaurant_name, rv.rating
FROM reviews rv
JOIN customers c ON rv.customer_id = c.customer_id
JOIN restaurants r ON rv.restaurant_id = r.restaurant_id
WHERE rv.rating > 4;

-- 63. Payments with delivered orders.
SELECT p.payment_id, o.order_id, p.amount
FROM payments p
JOIN orders o ON p.order_id = o.order_id
WHERE o.status = 'Delivered';

-- 64. Delivery boys with total deliveries completed.
SELECT d.delivery_boy_name, COUNT(*) AS total_deliveries
FROM delivery d
WHERE d.delivery_status = 'Delivered'
GROUP BY d.delivery_boy_name;

-- 65. Menu items sold more than 10 times with restaurant info.
SELECT mi.item_name, r.restaurant_name, SUM(oi.quantity) AS total_sold
FROM menu_items mi
JOIN order_items oi ON mi.item_id = oi.item_id
JOIN restaurants r ON mi.restaurant_id = r.restaurant_id
GROUP BY mi.item_id
HAVING total_sold > 10;

-- 66. Orders and revenue per customer.
SELECT c.full_name, COUNT(o.order_id) AS total_orders, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;

-- 67. Customers with latest order details.
SELECT c.full_name, o.order_id, o.order_date, o.total_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_date = (
    SELECT MAX(order_date) FROM orders o2 WHERE o2.customer_id = c.customer_id
);

-- 68. Menu items with price and restaurant rating.
SELECT mi.item_name, mi.price, r.rating
FROM menu_items mi
JOIN restaurants r ON mi.restaurant_id = r.restaurant_id;

-- 69. Orders with payment method and status.
SELECT o.order_id, p.payment_method, p.payment_status
FROM orders o
JOIN payments p ON o.order_id = p.order_id;

-- 70. Employees with total orders at their restaurant.
SELECT e.full_name, r.restaurant_name, COUNT(o.order_id) AS total_orders
FROM employees e
JOIN restaurants r ON e.restaurant_id = r.restaurant_id
JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY e.employee_id;

-- Category 5: Joins – LEFT / RIGHT / FULL OUTER (15 Questions)

-- 71. Customers and their orders (include customers with no orders).
SELECT c.full_name, o.order_id, o.total_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- 72. Restaurants and number of menu items (include restaurants with none).
SELECT r.restaurant_name, COUNT(mi.item_id) AS total_items
FROM restaurants r
LEFT JOIN menu_items mi ON r.restaurant_id = mi.restaurant_id
GROUP BY r.restaurant_id;

-- 73. Menu items with order count (include items never ordered).
SELECT mi.item_name, COUNT(oi.order_item_id) AS total_orders
FROM menu_items mi
LEFT JOIN order_items oi ON mi.item_id = oi.item_id
GROUP BY mi.item_id;

-- 74. Customers and total payments (include those with none).
SELECT c.full_name, SUM(p.amount) AS total_payments
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_id;

-- 75. Restaurants and average review rating (include restaurants with none).
SELECT r.restaurant_name, AVG(rv.rating) AS avg_rating
FROM restaurants r
LEFT JOIN reviews rv ON r.restaurant_id = rv.restaurant_id
GROUP BY r.restaurant_id;

-- 76. Orders and delivery details (include orders without delivery).
SELECT o.order_id, d.delivery_boy_name, d.delivery_status
FROM orders o
LEFT JOIN delivery d ON o.order_id = d.order_id;

-- 77. Employees and total orders in their restaurant.
SELECT e.full_name, r.restaurant_name, COUNT(o.order_id) AS total_orders
FROM employees e
LEFT JOIN restaurants r ON e.restaurant_id = r.restaurant_id
LEFT JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY e.employee_id;

-- 78. Restaurants with orders and total revenue (include restaurants with no orders).
SELECT r.restaurant_name, SUM(o.total_amount) AS total_revenue
FROM restaurants r
LEFT JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id;

-- 79. Customers with reviews (include customers with none).
SELECT c.full_name, COUNT(rv.review_id) AS total_reviews
FROM customers c
LEFT JOIN reviews rv ON c.customer_id = rv.customer_id
GROUP BY c.customer_id;

-- 80. Menu items with total quantity sold (include items not sold).
SELECT mi.item_name, SUM(oi.quantity) AS total_quantity
FROM menu_items mi
LEFT JOIN order_items oi ON mi.item_id = oi.item_id
GROUP BY mi.item_id;

-- 81. Restaurants and assigned delivery boys (include none).
SELECT r.restaurant_name, d.delivery_boy_name
FROM restaurants r
LEFT JOIN orders o ON r.restaurant_id = o.restaurant_id
LEFT JOIN delivery d ON o.order_id = d.order_id;

-- 82. Customers and membership with total orders.
SELECT c.full_name, c.membership, COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;

-- 83. Payments and associated orders (include failed payments).
SELECT p.payment_id, o.order_id, p.payment_status, p.amount
FROM payments p
LEFT JOIN orders o ON p.order_id = o.order_id;

-- 84. Orders with customer and delivery info (show all orders).
SELECT o.order_id, c.full_name, d.delivery_boy_name, d.delivery_status
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN delivery d ON o.order_id = d.order_id;

-- 85. Reviews with restaurants (include restaurants with none).
SELECT rv.review_id, rv.rating, r.restaurant_name
FROM reviews rv
LEFT JOIN restaurants r ON rv.restaurant_id = r.restaurant_id;

-- Category 6: Subqueries & Nested Queries (15 Questions)

-- 86. Customers with orders above 500.
SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING SUM(total_amount) > 500
);

-- 87. Menu items priced above average price.
SELECT *
FROM menu_items
WHERE price > (SELECT AVG(price) FROM menu_items);

-- 88. Restaurants with rating above average.
SELECT *
FROM restaurants
WHERE rating > (SELECT AVG(rating) FROM restaurants);

-- 89. Customers who haven’t placed any orders.
SELECT *
FROM customers
WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM orders);

-- 90. Orders above average total amount.
SELECT *
FROM orders
WHERE total_amount > (SELECT AVG(total_amount) FROM orders);

-- 91. Delivery boys with more than 5 deliveries.
SELECT delivery_boy_name
FROM delivery
GROUP BY delivery_boy_name
HAVING COUNT(*) > 5;

-- 92. Payments greater than average payment per method.
SELECT *
FROM payments p1
WHERE amount > (SELECT AVG(amount) FROM payments p2 WHERE p2.payment_method = p1.payment_method);

-- 93. Customers with total spent > 1000.
SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING SUM(total_amount) > 1000
);

-- 94. Orders where all items belong to one category.
SELECT order_id
FROM order_items oi
JOIN menu_items mi ON oi.item_id = mi.item_id
GROUP BY oi.order_id
HAVING COUNT(DISTINCT mi.category) = 1;

-- 95. Menu items never ordered.
SELECT *
FROM menu_items
WHERE item_id NOT IN (SELECT DISTINCT item_id FROM order_items);

-- 96. Restaurants with no reviews.
SELECT *
FROM restaurants
WHERE restaurant_id NOT IN (SELECT DISTINCT restaurant_id FROM reviews);

-- 97. Customers with maximum orders.
SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC
LIMIT 1;

-- 98. Orders where payment is pending but delivered.
SELECT o.order_id
FROM orders o
JOIN payments p ON o.order_id = p.order_id
WHERE o.status = 'Delivered' AND p.payment_status = 'Pending';

-- 99. Employees without orders in their restaurant.
SELECT e.full_name, r.restaurant_name
FROM employees e
JOIN restaurants r ON e.restaurant_id = r.restaurant_id
LEFT JOIN orders o ON r.restaurant_id = o.restaurant_id
WHERE o.order_id IS NULL;

-- 100. Reviews with highest rating.
SELECT *
FROM reviews
WHERE rating = (SELECT MAX(rating) FROM reviews);

-- Category 7: Window Functions & Ranking (10 Questions)

-- 101. Rank customers by total spending.
SELECT 
    c.customer_id, 
    c.full_name, 
    SUM(o.total_amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(o.total_amount) DESC) AS rank_pos
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name;

-- 102. Rank restaurants by total revenue.
SELECT 
    r.restaurant_id, 
    r.restaurant_name, 
    SUM(o.total_amount) AS total_revenue,
    RANK() OVER (ORDER BY SUM(o.total_amount) DESC) AS rank_pos
FROM restaurants r
JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name;

-- 103. Rank menu items by quantity sold.
SELECT 
    mi.item_id, 
    mi.item_name, 
    SUM(oi.quantity) AS total_sold,
    RANK() OVER (ORDER BY SUM(oi.quantity) DESC) AS rank_pos
FROM menu_items mi
JOIN order_items oi ON mi.item_id = oi.item_id
GROUP BY mi.item_id, mi.item_name;


-- 104. Running total of payments per day.
SELECT DATE(payment_date) AS payment_day, SUM(amount) OVER (ORDER BY DATE(payment_date)) AS running_total
FROM payments
ORDER BY payment_day;

-- 105. Cumulative revenue per restaurant.
SELECT o.restaurant_id, SUM(o.total_amount) OVER (PARTITION BY o.restaurant_id ORDER BY o.order_date) AS cumulative_revenue
FROM orders o;

-- 106. Top 5 customers by number of orders.
-- ✅ Fix: wrap in a CTE or subquery to filter by rank.
WITH ranked_customers AS (
    SELECT 
        c.customer_id, 
        c.full_name, 
        COUNT(o.order_id) AS total_orders,
        RANK() OVER (ORDER BY COUNT(o.order_id) DESC) AS rank_pos
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.full_name
)
SELECT * 
FROM ranked_customers
WHERE rank_pos <= 5;

-- 107. Top 3 menu items per restaurant.
-- ✅ Fix: use CTE since you cannot use alias 'rank' in WHERE.
WITH ranked_items AS (
    SELECT 
        restaurant_id, 
        item_name, 
        price,
        RANK() OVER (PARTITION BY restaurant_id ORDER BY price DESC) AS rank_pos
    FROM menu_items
)
SELECT * 
FROM ranked_items
WHERE rank_pos <= 3;

-- 108. Rank deliveries by delivery time per delivery boy.
SELECT 
    delivery_boy_name, 
    delivery_time,
    RANK() OVER (PARTITION BY delivery_boy_name ORDER BY delivery_time) AS rank_pos
FROM delivery;

-- 109. Average rating per restaurant with rank.
SELECT 
    restaurant_id, 
    AVG(rating) AS avg_rating,
    RANK() OVER (ORDER BY AVG(rating) DESC) AS rank_pos
FROM reviews
GROUP BY restaurant_id;

-- 110. Rank employees by hire date per restaurant.
SELECT 
    employee_id, 
    full_name, 
    restaurant_id,
    RANK() OVER (PARTITION BY restaurant_id ORDER BY hire_date) AS rank_pos
FROM employees;

-- Category 8: CTEs & Recursive Queries (10 Questions)

-- 111. Top 5 revenue-generating restaurants using CTE.
WITH revenue_cte AS (
    SELECT r.restaurant_id, r.restaurant_name, SUM(o.total_amount) AS total_revenue
    FROM restaurants r
    JOIN orders o ON r.restaurant_id = o.restaurant_id
    GROUP BY r.restaurant_id, r.restaurant_name
)
SELECT *
FROM revenue_cte
ORDER BY total_revenue DESC
LIMIT 5;

-- 112. Customers with orders above average using CTE.
WITH customer_total AS (
    SELECT customer_id, SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT *
FROM customer_total
WHERE total_spent > (SELECT AVG(total_spent) FROM customer_total);

-- 113. Total revenue per city using CTE.
WITH city_revenue AS (
    SELECT r.city, SUM(o.total_amount) AS total_revenue
    FROM restaurants r
    JOIN orders o ON r.restaurant_id = o.restaurant_id
    GROUP BY r.city
)
SELECT *
FROM city_revenue;

-- 114. Menu items ordered > 5 times using CTE.
WITH item_sales AS (
    SELECT item_id, SUM(quantity) AS total_sold
    FROM order_items
    GROUP BY item_id
)
SELECT mi.item_name, isales.total_sold
FROM item_sales isales
JOIN menu_items mi ON isales.item_id = mi.item_id
WHERE isales.total_sold > 5;

-- 115. Recursive CTE for employee hierarchy (example assumes manager-child relation).
WITH RECURSIVE employee_hierarchy AS (
    SELECT employee_id, full_name, manager_id, 1 AS level
    FROM employees
    WHERE manager_id IS NULL
    UNION ALL
    SELECT e.employee_id, e.full_name, e.manager_id, eh.level + 1
    FROM employees e
    JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
)
SELECT * FROM employee_hierarchy;

-- 116. Pending payments per customer using CTE.
WITH pending_cte AS (
    SELECT o.customer_id, SUM(p.amount) AS pending_amount
    FROM orders o
    JOIN payments p ON o.order_id = p.order_id
    WHERE p.payment_status = 'Pending'
    GROUP BY o.customer_id
)
SELECT c.full_name, pending_amount
FROM pending_cte pc
JOIN customers c ON pc.customer_id = c.customer_id;

-- 117. Top 3 dishes per restaurant by revenue using CTE.
WITH dish_revenue AS (
    SELECT 
        mi.restaurant_id, 
        mi.item_id, 
        SUM(oi.price) AS revenue
    FROM menu_items mi
    JOIN order_items oi ON mi.item_id = oi.item_id
    GROUP BY mi.restaurant_id, mi.item_id
)
SELECT restaurant_id, item_id, revenue
FROM (
    SELECT 
        *, 
        RANK() OVER (PARTITION BY restaurant_id ORDER BY revenue DESC) AS rank_pos
    FROM dish_revenue
) t
WHERE rank_pos <= 3;


-- 118. Cumulative order totals per customer using CTE.
WITH customer_orders AS (
    SELECT customer_id, order_date, total_amount
    FROM orders
)
SELECT customer_id, order_date,
       SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS cumulative_total
FROM customer_orders;

-- 119. Average delivery time per delivery boy using CTE.
WITH delivery_cte AS (
    SELECT delivery_boy_name, TIMESTAMPDIFF(MINUTE, NOW(), delivery_time) AS delivery_minutes
    FROM delivery
)
SELECT delivery_boy_name, AVG(delivery_minutes) AS avg_delivery_minutes
FROM delivery_cte
GROUP BY delivery_boy_name;

-- 120. Monthly revenue per restaurant using recursive CTE.
WITH RECURSIVE months AS (
    SELECT MIN(DATE_FORMAT(order_date, '%Y-%m-01')) AS month_start
    FROM orders
    UNION ALL
    SELECT month_start + INTERVAL 1 MONTH
    FROM months
    WHERE month_start + INTERVAL 1 MONTH <= CURDATE()
)
SELECT m.month_start, r.restaurant_name, SUM(o.total_amount) AS monthly_revenue
FROM months m
JOIN orders o ON DATE_FORMAT(o.order_date, '%Y-%m-01') = m.month_start
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
GROUP BY m.month_start, r.restaurant_name;

-- Category 9: Conditional & CASE Queries (10 Questions)

-- 121. Classify customers as High/Medium/Low spender.
SELECT full_name, SUM(o.total_amount) AS total_spent,
       CASE 
           WHEN SUM(o.total_amount) > 1000 THEN 'High'
           WHEN SUM(o.total_amount) BETWEEN 500 AND 1000 THEN 'Medium'
           ELSE 'Low'
       END AS spender_category
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, full_name;

-- 122. Categorize orders as Small/Medium/Large based on total_amount.
SELECT order_id, total_amount,
       CASE 
           WHEN total_amount > 500 THEN 'Large'
           WHEN total_amount BETWEEN 200 AND 500 THEN 'Medium'
           ELSE 'Small'
       END AS order_size
FROM orders;

-- 123. Flag menu items as Expensive (>300) or Cheap.
SELECT item_name, price,
       CASE 
           WHEN price > 300 THEN 'Expensive'
           ELSE 'Cheap'
       END AS price_category
FROM menu_items;

-- 124. Show delivery status with custom labels (Pending → Red, Delivered → Green).
SELECT delivery_boy_name, delivery_status,
       CASE 
           WHEN delivery_status = 'Pending' THEN 'Red'
           WHEN delivery_status = 'Delivered' THEN 'Green'
           ELSE 'Yellow'
       END AS status_color
FROM delivery;

-- 125. Show payment status with custom messages.
SELECT payment_id, payment_status,
       CASE 
           WHEN payment_status = 'Completed' THEN 'Paid'
           WHEN payment_status = 'Pending' THEN 'Awaiting Payment'
           ELSE 'Failed'
       END AS status_message
FROM payments;

-- 126. Average rating with grade (A/B/C).
SELECT restaurant_id, AVG(rating) AS avg_rating,
       CASE 
           WHEN AVG(rating) >= 4.5 THEN 'A'
           WHEN AVG(rating) >= 4 THEN 'B'
           ELSE 'C'
       END AS grade
FROM reviews
GROUP BY restaurant_id;

-- 127. Customers with loyalty badge based on total orders.
SELECT c.full_name, COUNT(o.order_id) AS total_orders,
       CASE 
           WHEN COUNT(o.order_id) >= 10 THEN 'Gold'
           WHEN COUNT(o.order_id) >= 5 THEN 'Silver'
           ELSE 'Bronze'
       END AS loyalty_badge
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;

-- 128. Orders flagged as late if delivery > 2 hours.
SELECT o.order_id, d.delivery_time, 
       CASE 
           WHEN TIMESTAMPDIFF(HOUR, o.order_date, d.delivery_time) > 2 THEN 'Late'
           ELSE 'On Time'
       END AS delivery_flag
FROM orders o
JOIN delivery d ON o.order_id = d.order_id;

-- 129. Employee tenure in months.
SELECT full_name, hire_date,
       TIMESTAMPDIFF(MONTH, hire_date, CURDATE()) AS tenure_months
FROM employees;

-- 130. Restaurants categorized by active menu items count.
SELECT r.restaurant_name, COUNT(mi.item_id) AS active_items,
       CASE 
           WHEN COUNT(mi.item_id) >= 10 THEN 'Large'
           WHEN COUNT(mi.item_id) BETWEEN 5 AND 9 THEN 'Medium'
           ELSE 'Small'
       END AS restaurant_category
FROM restaurants r
LEFT JOIN menu_items mi ON r.restaurant_id = mi.restaurant_id AND mi.is_available = TRUE
GROUP BY r.restaurant_id;

-- Category 10: Ranking, Top-N & Percentiles (10 Questions)

-- 131. Top 5 customers by total spending.
SELECT customer_id, full_name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY customer_id, full_name
ORDER BY total_spent DESC
LIMIT 5;

-- 132. Bottom 5 customers by total spending.
SELECT customer_id, full_name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY customer_id, full_name
ORDER BY total_spent ASC
LIMIT 5;

-- 133. Top 3 menu items per restaurant by quantity sold.
WITH item_sales AS (
    SELECT 
        mi.restaurant_id, 
        mi.item_name, 
        SUM(oi.quantity) AS total_sold,
        RANK() OVER (PARTITION BY mi.restaurant_id ORDER BY SUM(oi.quantity) DESC) AS rank_pos
    FROM menu_items mi
    JOIN order_items oi ON mi.item_id = oi.item_id
    GROUP BY mi.restaurant_id, mi.item_name
)
SELECT * 
FROM item_sales
WHERE rank_pos <= 3;


-- 134. Top 10% of orders by total_amount.
SELECT *
FROM (
    SELECT *, PERCENT_RANK() OVER (ORDER BY total_amount DESC) AS pr
    FROM orders
) t
WHERE pr <= 0.1;

-- 135. Customers in top 20% by total orders.
SELECT *
FROM (
    SELECT c.customer_id, c.full_name, COUNT(o.order_id) AS total_orders,
           PERCENT_RANK() OVER (ORDER BY COUNT(o.order_id) DESC) AS pr
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id
) t
WHERE pr <= 0.2;

-- 136. Rank restaurants by average rating.
SELECT 
    r.restaurant_id,
    r.restaurant_name,
    AVG(rv.rating) AS avg_rating,
    RANK() OVER (ORDER BY AVG(rv.rating) DESC) AS rank_pos
FROM reviews rv
JOIN restaurants r ON rv.restaurant_id = r.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name;


-- 137. Rank deliveries by delivery time.
SELECT delivery_id, delivery_boy_name, delivery_time,
       RANK() OVER (ORDER BY delivery_time) AS delivery_rank
FROM delivery;

-- 138. Percentile rank of each order based on total_amount.
SELECT order_id, total_amount,
       PERCENT_RANK() OVER (ORDER BY total_amount) AS percentile_rank
FROM orders;

-- 139. Top 5 employees based on number of deliveries handled.
WITH employee_deliveries AS (
    SELECT 
        e.full_name, 
        COUNT(d.delivery_id) AS total_deliveries,
        RANK() OVER (ORDER BY COUNT(d.delivery_id) DESC) AS rank_pos
    FROM employees e
    LEFT JOIN delivery d ON e.full_name = d.delivery_boy_name
    GROUP BY e.full_name
)
SELECT *
FROM employee_deliveries
WHERE rank_pos <= 5;


-- 140. Restaurants in bottom 10% by revenue.
SELECT restaurant_id, restaurant_name, SUM(o.total_amount) AS total_revenue,
       PERCENT_RANK() OVER (ORDER BY SUM(o.total_amount)) AS pr
FROM restaurants r
JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY restaurant_id, restaurant_name
HAVING pr <= 0.1;

-- Category 11: Data Modification & Transactions (10 Questions)

-- 141. Update membership of customers who spent > 1000 to 'Platinum'.
UPDATE customers
SET membership = 'Platinum'
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING SUM(total_amount) > 1000
);

-- 142. Increase price of menu items in 'Biryani' category by 10%.
UPDATE menu_items
SET price = price * 1.10
WHERE category = 'Main Course' AND item_name LIKE '%Biryani%';

-- 143. Delete orders that are 'Cancelled'.
DELETE FROM orders
WHERE status = 'Cancelled';

-- 144. Insert a new customer.
INSERT INTO customers (full_name, gender, email, phone, city, state, membership)
VALUES ('Aditya Kumar', 'Male', 'aditya.kumar@gmail.com', '9876543211', 'Delhi', 'Delhi', 'Regular');

-- 145. Insert new menu items for a restaurant.
INSERT INTO menu_items (restaurant_id, item_name, category, price)
VALUES (1, 'Chicken Curry', 'Main Course', 320.00),
       (1, 'Veg Manchurian', 'Starter', 220.00);

-- 146. Start a transaction to update order status and payment simultaneously.
START TRANSACTION;
UPDATE orders SET status = 'Delivered' WHERE order_id = 3;
UPDATE payments SET payment_status = 'Completed' WHERE order_id = 3;
COMMIT;

-- 147. Rollback an incorrect update.
START TRANSACTION;
UPDATE menu_items SET price = price + 100 WHERE item_id = 5;
ROLLBACK;

-- 148. Delete customers with no orders.
DELETE FROM customers
WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM orders);

-- 149. Update delivery status to 'On the way' for pending deliveries.
UPDATE delivery
SET delivery_status = 'On the way'
WHERE delivery_status = 'Pending';

-- 150. Update restaurant rating based on average review.
UPDATE restaurants r
SET rating = (
    SELECT AVG(rating)
    FROM reviews rv
    WHERE rv.restaurant_id = r.restaurant_id
);


-- For Practices of Data Analysis


CREATE TABLE customer_data_issues (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    city VARCHAR(50),
    join_date DATE,
    membership VARCHAR(20),
    notes VARCHAR(255)
);

INSERT INTO customer_data_issues (full_name, email, phone, city, join_date, membership, notes) VALUES
-- 1. Incomplete Data
('Ravi Kumar', NULL, '9876543210', 'Delhi', '2022-01-10', 'Regular', 'Missing email'),

-- 2. Inaccurate Data
('Priya Sharma', 'priya.sharma@gmail.com', 'abc123', 'Mumbai', '2021-05-12', 'Gold', 'Phone incorrect'),

-- 3. Inconsistent Data
('AMIT Singh', 'amit.singh@gmail.com', '9821122334', 'Lucknow', '2020-08-15', 'regular', 'Mixed case membership'),

-- 4. Outdated Data
('Sneha Patel', 'sneha.patel@gmail.com', '9911223344', 'Ahmedabad', '2010-12-01', 'Platinum', 'Old join date'),

-- 5. Duplicate Data
('Vikram Das', 'vikram.das@gmail.com', '9900011223', 'Kolkata', '2023-03-10', 'Gold', 'Duplicate entry'),
('Vikram Das', 'vikram.das@gmail.com', '9900011223', 'Kolkata', '2023-03-10', 'Gold', 'Duplicate entry'),

-- 6. Incorrectly Formatted Data
('Neha Reddy', 'neha.reddy[at]gmail.com', '9988776655', 'Hyderabad', '2022-07-19', 'Regular', 'Invalid email format'),

-- 7. Violates Business Logic
('Rahul Mehta', 'rahul.mehta@gmail.com', '-9797979797', 'Pune', '2022-11-22', 'Gold', 'Negative phone number'),

-- 8. Non-Standardized Data
('Kavita Nair', 'KAVITA.NAIR@gmail.com', '9665544332', 'Chennai', '2023-01-15', 'REGULAR', 'Uppercase email and membership'),

-- 9. Spell Error
('Arjun Verma', 'arjun.verma@gmail.com', '9554433221', 'Bangaluru', '2021-09-01', 'Platinum', 'City spelled incorrectly'),

-- 10. Human Error
('Pooja Bansal', 'pooja.bansal@gmail.com', '', 'Jaipur', '2022-06-10', 'Regular', 'Missing phone'),

-- 11. Mixed uppercase and lowercase
('SURESH Rao', 'suresh.rao@gmail.com', '9332211009', 'Visakhapatnam', '2023-02-25', 'Gold', 'Name in uppercase'),

-- 12. Incomplete Data
(NULL, 'ananya.ghosh@gmail.com', '9221100987', 'Kolkata', '2021-12-15', 'Regular', 'Missing full name'),

-- 13. Inaccurate Data
('Amit Singh', 'amit.singh@gmail.com', '999999999999', 'Lucknow', '2020-08-15', 'Regular', 'Phone too long'),

-- 14. Inconsistent Data
('Ravi Kumar', 'ravi.kumar@gmail.com', '9876543210', 'delhi', '2022-01-10', 'Regular', 'City lowercase'),

-- 15. Outdated Data
('Priya Sharma', 'priya.sharma@gmail.com', '9812345678', 'Mumbai', '2005-05-12', 'Gold', 'Old join date'),

-- 16. Duplicate Data
('Neha Reddy', 'neha.reddy@gmail.com', '9988776655', 'Hyderabad', '2022-07-19', 'Regular', 'Duplicate entry'),

-- 17. Incorrectly Formatted Data
('Kavita Nair', 'kavita.nair@gmail', '9665544332', 'Chennai', '2023-01-15', 'Regular', 'Invalid email missing domain'),

-- 18. Violates Business Logic
('Rahul Mehta', 'rahul.mehta@gmail.com', '0', 'Pune', '2022-11-22', 'Gold', 'Phone cannot be 0'),

-- 19. Non-Standardized Data
('Sneha Patel', 'SNEHA.PATEL@GMAIL.COM', '9911223344', 'Ahmedabad', '2010-12-01', 'PLATINUM', 'Uppercase email & membership'),

-- 20. Spell Error
('Vikram Das', 'vikram.das@gmail.com', '9900011223', 'Kolkatta', '2023-03-10', 'Gold', 'City spelled incorrectly'),

-- 21. Human Error
('Ananya Ghosh', 'ananya.ghosh@gmail.com', 'abcd', 'Kolkata', '2021-12-15', 'Regular', 'Phone letters'),

-- 22. Mixed uppercase and lowercase
('Amit Singh', 'aMiT.sInGh@gmail.com', '9821122334', 'Lucknow', '2020-08-15', 'Regular', 'Mixed case email'),

-- 23. Incomplete Data
('Suresh Rao', 'suresh.rao@gmail.com', NULL, 'Visakhapatnam', '2023-02-25', 'Gold', 'Missing phone'),

-- 24. Inaccurate Data
('Pooja Bansal', 'pooja.bansal@gmail.com', '12345', 'Jaipur', '2022-06-10', 'Regular', 'Phone too short'),

-- 25. Non-Standardized Data
('Ravi Kumar', 'ravi.kumar@Gmail.Com', '9876543210', 'DELHI', '2022-01-10', 'Regular', 'Non-standard email & city');


-- DATA CLEANING & VALIDATION SQL QUESTIONS (75 TOTAL)

-- Category 1: Identify Missing / Incomplete Data (Q1–Q10)

-- 1. Find records with missing (NULL) full_name.
SELECT * FROM customer_data_issues WHERE full_name IS NULL;

-- 2. Find records where email is NULL or empty ('').
SELECT * FROM customer_data_issues WHERE email IS NULL OR TRIM(email) = '';

-- 3. Identify rows with missing phone numbers (NULL or empty).
SELECT * FROM customer_data_issues WHERE phone IS NULL OR TRIM(phone) = '';

-- 4. Count how many records have incomplete data (any column is NULL).
SELECT COUNT(*) AS incomplete_rows
FROM customer_data_issues
WHERE full_name IS NULL
   OR email IS NULL
   OR phone IS NULL
   OR city IS NULL
   OR join_date IS NULL
   OR membership IS NULL;

-- 5. Find customers missing both email and phone.
SELECT * FROM customer_data_issues WHERE (email IS NULL OR TRIM(email) = '') AND (phone IS NULL OR TRIM(phone) = '');

-- 6. Check how many records have missing join_date.
SELECT COUNT(*) AS missing_join_date FROM customer_data_issues WHERE join_date IS NULL;

-- 7. List customers whose membership is NULL or empty.
SELECT * FROM customer_data_issues WHERE membership IS NULL OR TRIM(membership) = '';

-- 8. Detect rows with incomplete or partial data (more than one missing field).
SELECT *, 
 (CASE WHEN full_name IS NULL OR TRIM(full_name) = '' THEN 1 ELSE 0 END
  + CASE WHEN email IS NULL OR TRIM(email) = '' THEN 1 ELSE 0 END
  + CASE WHEN phone IS NULL OR TRIM(phone) = '' THEN 1 ELSE 0 END
  + CASE WHEN city IS NULL OR TRIM(city) = '' THEN 1 ELSE 0 END
  + CASE WHEN join_date IS NULL THEN 1 ELSE 0 END
  + CASE WHEN membership IS NULL OR TRIM(membership) = '' THEN 1 ELSE 0 END) AS missing_count
FROM customer_data_issues
HAVING missing_count > 1;

-- 9. Replace missing phone numbers with 'Unknown' (UPDATE).
UPDATE customer_data_issues
SET phone = 'Unknown'
WHERE phone IS NULL OR TRIM(phone) = '';

-- 10. Calculate percentage of incomplete records in the table.
SELECT 
  (SUM(CASE WHEN full_name IS NULL OR TRIM(full_name) = '' 
            OR email IS NULL OR TRIM(email) = '' 
            OR phone IS NULL OR TRIM(phone) = '' 
            OR city IS NULL OR TRIM(city) = ''
            OR join_date IS NULL
            OR membership IS NULL OR TRIM(membership) = '' THEN 1 ELSE 0 END) * 100.0
   / COUNT(*)) AS pct_incomplete
FROM customer_data_issues;

-- Category 2: Detect Inaccurate or Invalid Data (Q11–Q20)

-- 11. Find phone numbers containing non-numeric characters (excluding +, space, -, parentheses).
SELECT * FROM customer_data_issues
WHERE phone IS NOT NULL AND phone <> ''
  AND phone NOT REGEXP '^[0-9()+ -]+$';

-- 12. Identify emails without '@' or '.' (very basic email validity).
SELECT * FROM customer_data_issues
WHERE email IS NOT NULL AND TRIM(email) <> '' 
  AND (email NOT LIKE '%@%' OR email NOT LIKE '%.%');

-- 13. List rows where phone numbers are too short (<10 digits) or too long (>12 digits ignoring non-digits).
SELECT *,
       (LENGTH(REGEXP_REPLACE(COALESCE(phone,''),'[^0-9]','')) ) AS digit_count
FROM customer_data_issues
WHERE LENGTH(REGEXP_REPLACE(COALESCE(phone,''),'[^0-9]','')) < 10
   OR LENGTH(REGEXP_REPLACE(COALESCE(phone,''),'[^0-9]','')) > 12;

-- 14. Detect negative phone numbers (contains '-' as the first character or only '-' and digits).
SELECT * FROM customer_data_issues
WHERE TRIM(phone) LIKE '-%';

-- 15. Find invalid or unexpected join_date values (non-YYYY-MM-DD is blocked by DATE type,
--     but detect out-of-range or null and non-sensical years).
SELECT * FROM customer_data_issues
WHERE join_date IS NULL
   OR YEAR(join_date) < 1900
   OR YEAR(join_date) > YEAR(CURDATE());

-- 16. Identify memberships not in ('Regular', 'Gold', 'Platinum') (case-insensitive).
SELECT * FROM customer_data_issues
WHERE membership IS NOT NULL
  AND LOWER(TRIM(membership)) NOT IN ('regular','gold','platinum');

-- 17. Detect emails ending incorrectly (e.g. missing domain extensions: no dot after @).
SELECT *
FROM customer_data_issues
WHERE email IS NOT NULL AND TRIM(email) <> ''
  AND (LOCATE('@', email) = 0 OR LOCATE('.', SUBSTRING(email, LOCATE('@', email)+1)) = 0);

-- 18. List rows where phone number has special characters aside from digits, +, -, space, parentheses.
SELECT * FROM customer_data_issues
WHERE phone IS NOT NULL
  AND phone <> ''
  AND phone REGEXP '[^0-9 +()\\-]';

-- 19. Find invalid characters in full_name (digits or excessive punctuation).
SELECT * FROM customer_data_issues
WHERE full_name IS NOT NULL AND full_name REGEXP '[0-9]';

-- 20. Count invalid entries for each column type (email invalid, phone invalid, membership invalid).
SELECT 
  SUM(CASE WHEN email IS NULL OR TRIM(email) = '' OR email NOT LIKE '%@%.%' THEN 1 ELSE 0 END) AS invalid_emails,
  SUM(CASE WHEN phone IS NULL OR TRIM(phone) = '' OR REGEXP_REPLACE(phone,'[^0-9]','') NOT REGEXP '^[0-9]{10,12}$' THEN 1 ELSE 0 END) AS invalid_phones,
  SUM(CASE WHEN membership IS NULL OR LOWER(TRIM(membership)) NOT IN ('regular','gold','platinum') THEN 1 ELSE 0 END) AS invalid_membership
FROM customer_data_issues;

-- Category 3: Handle Inconsistent Data (Q21–Q30)

-- 21. Detect inconsistent capitalization in city names (e.g. 'Delhi' vs 'delhi').
SELECT city, COUNT(*) AS occurrences
FROM customer_data_issues
WHERE city IS NOT NULL
GROUP BY city
HAVING SUM(CASE WHEN BINARY city <> UPPER(city) AND BINARY city <> LOWER(city) THEN 1 ELSE 0 END) > 0
   OR COUNT(DISTINCT LOWER(city)) > 1;

-- 22. Identify inconsistent membership cases (e.g. 'regular' vs 'Regular').
SELECT LOWER(TRIM(membership)) AS membership_normalized, COUNT(*) AS cnt
FROM customer_data_issues
GROUP BY LOWER(TRIM(membership));

-- 23. List cities appearing in multiple inconsistent forms.
SELECT LOWER(TRIM(city)) AS city_key, GROUP_CONCAT(DISTINCT city SEPARATOR ', ') AS variants, COUNT(*) AS cnt
FROM customer_data_issues
WHERE city IS NOT NULL AND TRIM(city) <> ''
GROUP BY city_key
HAVING COUNT(DISTINCT city) > 1;

-- 24. Count distinct versions of each city name.
SELECT LOWER(TRIM(city)) AS city_key, COUNT(DISTINCT city) AS distinct_variants
FROM customer_data_issues
GROUP BY city_key
ORDER BY distinct_variants DESC;

-- 25. Detect inconsistent email case (e.g. uppercase vs lowercase).
SELECT LOWER(email) AS email_key, GROUP_CONCAT(DISTINCT email SEPARATOR ', ') AS variants, COUNT(*) AS cnt
FROM customer_data_issues
WHERE email IS NOT NULL AND TRIM(email) <> ''
GROUP BY email_key
HAVING COUNT(DISTINCT email) > 1;

-- 26. Standardize all city names to proper case (first letter uppercase, rest lowercase).
-- NOTE: MySQL doesn't have INITCAP built-in; simulate with LOWER and UPPER(SUBSTRING).
UPDATE customer_data_issues
SET city = CONCAT(UPPER(LEFT(LOWER(TRIM(city)),1)), SUBSTRING(LOWER(TRIM(city)),2))
WHERE city IS NOT NULL AND TRIM(city) <> '';

-- 27. Convert all email addresses to lowercase.
UPDATE customer_data_issues
SET email = LOWER(TRIM(email))
WHERE email IS NOT NULL;

-- 28. Standardize membership names to title case (Regular/Gold/Platinum).
UPDATE customer_data_issues
SET membership = CASE
    WHEN LOWER(TRIM(membership)) = 'regular' THEN 'Regular'
    WHEN LOWER(TRIM(membership)) = 'gold' THEN 'Gold'
    WHEN LOWER(TRIM(membership)) = 'platinum' THEN 'Platinum'
    ELSE TRIM(membership)
END
WHERE membership IS NOT NULL;

-- 29. Find duplicate phone numbers with different names (possible inconsistency).
SELECT phone, GROUP_CONCAT(DISTINCT full_name SEPARATOR ', ') AS names, COUNT(DISTINCT full_name) AS name_count
FROM customer_data_issues
WHERE phone IS NOT NULL AND TRIM(phone) <> '' AND phone <> 'Unknown'
GROUP BY REGEXP_REPLACE(phone,'[^0-9]','')
HAVING name_count > 1;

-- 30. Detect inconsistent join_date formats (NULL or year anomalies already covered). Show non-NULL join_date rows by format.
SELECT record_id, join_date, DATE_FORMAT(join_date, '%Y-%m-%d') AS iso_date
FROM customer_data_issues
WHERE join_date IS NOT NULL
ORDER BY join_date;

-- Category 4: Detect and Handle Outdated Data (Q31–Q35)

-- 31. Identify records where join_date is older than 5 years.
SELECT * FROM customer_data_issues WHERE join_date < DATE_SUB(CURDATE(), INTERVAL 5 YEAR);

-- 32. Count outdated records (join_date < '2020-01-01').
SELECT COUNT(*) AS outdated_count FROM customer_data_issues WHERE join_date < '2020-01-01';

-- 33. List outdated records with 'Old join date' in notes.
SELECT * FROM customer_data_issues WHERE notes LIKE '%Old join date%' OR notes LIKE '%old join%';

-- 34. Mark outdated customers as 'Inactive' by creating/updating a notes tag (example).
UPDATE customer_data_issues
SET notes = CONCAT(IFNULL(notes,''), ' | Marked Inactive (old join_date)')
WHERE join_date < DATE_SUB(CURDATE(), INTERVAL 5 YEAR);

-- 35. Calculate average age (in years) of data based on join_date.
SELECT AVG(TIMESTAMPDIFF(YEAR, join_date, CURDATE())) AS avg_years_since_join
FROM customer_data_issues
WHERE join_date IS NOT NULL;

-- Category 5: Identify & Handle Duplicates (Q36–Q45)

-- 36. Find exact duplicate records (all fields identical except record_id).
SELECT c1.*
FROM customer_data_issues c1
JOIN (
  SELECT full_name, email, phone, city, join_date, membership, notes, COUNT(*) AS cnt
  FROM customer_data_issues
  GROUP BY full_name, email, phone, city, join_date, membership, notes
  HAVING cnt > 1
) dup ON (COALESCE(c1.full_name,'') = COALESCE(dup.full_name,'')
        AND COALESCE(c1.email,'') = COALESCE(dup.email,'')
        AND COALESCE(c1.phone,'') = COALESCE(dup.phone,'')
        AND COALESCE(DATE_FORMAT(c1.join_date,'%Y-%m-%d'),'') = COALESCE(DATE_FORMAT(dup.join_date,'%Y-%m-%d'),'')
        AND COALESCE(c1.city,'') = COALESCE(dup.city,'')
        AND COALESCE(c1.membership,'') = COALESCE(dup.membership,'')
        AND COALESCE(c1.notes,'') = COALESCE(dup.notes,''))

-- 37. Find duplicate customers by full_name and email.

-- 37. Find duplicate customers by full_name and email.
SELECT 
    full_name, 
    email, 
    COUNT(*) AS duplicate_count
FROM customer_data_issues
GROUP BY full_name, email
HAVING COUNT(*) > 1;

-- 38. Find duplicate emails with different phone numbers.
SELECT email, GROUP_CONCAT(DISTINCT phone SEPARATOR ', ') AS phones, COUNT(DISTINCT phone) AS phone_variants
FROM customer_data_issues
WHERE email IS NOT NULL AND TRIM(email) <> ''
GROUP BY email
HAVING phone_variants > 1;

-- 39. Count total number of duplicates (by full set of columns).
SELECT SUM(cnt-1) AS duplicate_rows
FROM (
  SELECT COUNT(*) AS cnt
  FROM customer_data_issues
  GROUP BY full_name, email, phone, city, join_date, membership, notes
  HAVING cnt > 1
) t;

-- 40. Delete duplicate records keeping only the row with the smallest record_id for each duplicate group.
DELETE c
FROM customer_data_issues c
JOIN (
  SELECT MIN(record_id) AS keep_id, full_name, email, phone, city, join_date, membership, notes
  FROM customer_data_issues
  GROUP BY full_name, email, phone, city, join_date, membership, notes
  HAVING COUNT(*) > 1
) keep ON (COALESCE(c.full_name,'') = COALESCE(keep.full_name,'')
         AND COALESCE(c.email,'') = COALESCE(keep.email,'')
         AND COALESCE(c.phone,'') = COALESCE(keep.phone,'')
         AND COALESCE(DATE_FORMAT(c.join_date,'%Y-%m-%d'),'') = COALESCE(DATE_FORMAT(keep.join_date,'%Y-%m-%d'),'')
         AND COALESCE(c.city,'') = COALESCE(keep.city,'')
         AND COALESCE(c.membership,'') = COALESCE(keep.membership,'')
         AND COALESCE(c.notes,'') = COALESCE(keep.notes,''))
WHERE c.record_id <> keep.keep_id;

-- 41. Find potential duplicates using phone number only (same phone different names).
SELECT REGEXP_REPLACE(phone,'[^0-9]','') AS phone_digits, GROUP_CONCAT(DISTINCT full_name SEPARATOR ', ') AS names, COUNT(*) AS cnt
FROM customer_data_issues
WHERE phone IS NOT NULL AND phone <> '' AND phone <> 'Unknown'
GROUP BY phone_digits
HAVING cnt > 1;

-- 42. Find customers with same email but different names.
SELECT email, GROUP_CONCAT(DISTINCT full_name SEPARATOR ', ') AS names, COUNT(DISTINCT full_name) AS name_count
FROM customer_data_issues
WHERE email IS NOT NULL AND TRIM(email) <> ''
GROUP BY email
HAVING name_count > 1;

-- 43. Identify duplicate full_name but different cities.
SELECT full_name, GROUP_CONCAT(DISTINCT city SEPARATOR ', ') AS cities, COUNT(DISTINCT city) AS city_count
FROM customer_data_issues
WHERE full_name IS NOT NULL
GROUP BY full_name
HAVING city_count > 1;

-- 44. Flag all duplicate records with a duplicate_flag (add column then update).
ALTER TABLE customer_data_issues ADD COLUMN duplicate_flag TINYINT(1) DEFAULT 0;
UPDATE customer_data_issues c
JOIN (
  SELECT full_name, email, phone, city, join_date, membership, notes, COUNT(*) AS cnt
  FROM customer_data_issues
  GROUP BY full_name, email, phone, city, join_date, membership, notes
  HAVING cnt > 1
) dup ON (COALESCE(c.full_name,'') = COALESCE(dup.full_name,'')
        AND COALESCE(c.email,'') = COALESCE(dup.email,'')
        AND COALESCE(c.phone,'') = COALESCE(dup.phone,'')
        AND COALESCE(DATE_FORMAT(c.join_date,'%Y-%m-%d'),'') = COALESCE(DATE_FORMAT(dup.join_date,'%Y-%m-%d'),'')
        AND COALESCE(c.city,'') = COALESCE(dup.city,'')
        AND COALESCE(c.membership,'') = COALESCE(dup.membership,'')
        AND COALESCE(c.notes,'') = COALESCE(dup.notes,''))
SET c.duplicate_flag = 1;

-- 45. Retrieve only unique (non-duplicate) records.
SELECT * FROM customer_data_issues WHERE duplicate_flag = 0 OR duplicate_flag IS NULL;

-- Category 6: Detect Incorrectly Formatted Data (Q46–Q50)

-- 46. Find email addresses using '[at]' instead of '@'.
SELECT * FROM customer_data_issues WHERE email LIKE '%[at]%' OR email LIKE '%(at)%';

-- 47. Detect records with invalid date formats (non-YYYY-MM-DD) is not applicable for DATE typed column,
--     but find rows where join_date IS NULL or suspicious (year < 1900 or > current year).
SELECT * FROM customer_data_issues WHERE join_date IS NULL OR YEAR(join_date) < 1900 OR YEAR(join_date) > YEAR(CURDATE());

-- 48. Identify phone numbers with spaces or punctuation (non-digit characters).
SELECT *, REGEXP_REPLACE(COALESCE(phone,''),'[^0-9]','') AS phone_digits
FROM customer_data_issues
WHERE phone REGEXP '[^0-9]';

-- 49. Format all phone numbers to standard 10-12 digit numeric format (strip non-digits).
--     Update phone = only digits version; keep 'Unknown' untouched.
UPDATE customer_data_issues
SET phone = CASE 
  WHEN TRIM(COALESCE(phone,'')) = 'Unknown' THEN 'Unknown'
  ELSE REGEXP_REPLACE(phone,'[^0-9]','')
END;

-- 50. Standardize date format for join_date using DATE_FORMAT() in SELECT (display).
SELECT record_id, full_name, DATE_FORMAT(join_date, '%Y-%m-%d') AS join_date_iso FROM customer_data_issues;

-- Category 7: Validate Business Logic (Q51–Q55)

-- 51. Find customers with negative or zero phone numbers (invalid logic after digits strip).
SELECT * FROM customer_data_issues WHERE CAST(REGEXP_REPLACE(COALESCE(phone,'0'),'[^0-9]','') AS UNSIGNED) = 0;

-- 52. Detect records with future join_date.
SELECT * FROM customer_data_issues WHERE join_date > CURDATE();

-- 53. Validate membership must be one of the predefined tiers and list invalid ones.
SELECT DISTINCT membership FROM customer_data_issues
WHERE membership IS NOT NULL
  AND LOWER(TRIM(membership)) NOT IN ('regular','gold','platinum');

-- 54. Find emails that are duplicated across different memberships.
SELECT email, GROUP_CONCAT(DISTINCT membership SEPARATOR ', ') AS memberships, COUNT(DISTINCT membership) AS mcount
FROM customer_data_issues
WHERE email IS NOT NULL AND TRIM(email) <> ''
GROUP BY email
HAVING mcount > 1;

-- 55. Detect customers with empty city but non-null notes (business logic anomaly).
SELECT * FROM customer_data_issues WHERE (city IS NULL OR TRIM(city) = '') AND (notes IS NOT NULL AND TRIM(notes) <> '');

-- Category 8: Identify Non-Standardized Data (Q56–Q60)

-- 56. Find emails that mix uppercase and lowercase letters (normalized check).
SELECT email FROM customer_data_issues
WHERE email IS NOT NULL AND BINARY email <> BINARY LOWER(email);

-- 57. Detect cities written in all caps.
SELECT * FROM customer_data_issues WHERE city IS NOT NULL AND TRIM(city) <> '' AND BINARY city = UPPER(city);

-- 58. Identify memberships written in all lowercase.
SELECT * FROM customer_data_issues WHERE membership IS NOT NULL AND BINARY membership = LOWER(membership);

-- 59. List names with mixed capitalization (e.g. 'aMiT sInGh').
SELECT * FROM customer_data_issues
WHERE full_name IS NOT NULL
  AND full_name <> CONCAT(UPPER(LEFT(full_name,1)), LOWER(SUBSTRING(full_name,2)));

-- 60. Normalize all text fields to title case for full_name and city (approximation).
-- Note: This is a simple approach; for multi-word names you may need more complex logic or UDF.
UPDATE customer_data_issues
SET full_name = CONCAT(UPPER(LEFT(TRIM(full_name),1)), LOWER(SUBSTRING(TRIM(full_name),2)))
WHERE full_name IS NOT NULL AND TRIM(full_name) <> '';

UPDATE customer_data_issues
SET city = CONCAT(UPPER(LEFT(TRIM(city),1)), LOWER(SUBSTRING(TRIM(city),2)))
WHERE city IS NOT NULL AND TRIM(city) <> '';

-- Category 9: Detect Spelling or Typographical Errors (Q61–Q65)

-- 61. Find common misspellings in city names ('Kolkatta', 'Bangaluru', etc.).
SELECT * FROM customer_data_issues WHERE LOWER(city) IN ('kolkatta','bangaluru','bengaluru','bangalore','kolkata');

-- 62. Detect names with extra spaces or double letters (example: double space).
SELECT * FROM customer_data_issues WHERE full_name LIKE '%  %' OR full_name REGEXP '(.)\\1{2,}';

-- 63. Identify potential typos in email domains (e.g. 'gamil.com', 'yahho.com').
SELECT * FROM customer_data_issues
WHERE email IS NOT NULL AND TRIM(email) <> ''
  AND (email LIKE '%@gamil.%' OR email LIKE '%@yahho.%' OR email LIKE '%@hotnail.%' OR email LIKE '%@gnail.%');

-- 64. Trim leading/trailing spaces in full_name and city fields.
UPDATE customer_data_issues
SET full_name = TRIM(full_name), city = TRIM(city)
WHERE full_name IS NOT NULL OR city IS NOT NULL;

-- 65. Count records with spelling-like mistakes using simple LIKE patterns for common wrong variants.
SELECT COUNT(*) AS suspect_spelling
FROM customer_data_issues
WHERE LOWER(city) IN ('kolkatta','bangaluru','bengaluru','bangalore','delhi ' , 'mumbai');

-- Category 10: Detect Human & Mixed Case Errors (Q66–Q76)

-- 66. Find names containing both uppercase and lowercase randomly (mixed case detection).
SELECT * FROM customer_data_issues
WHERE full_name REGEXP '[A-Z]' AND full_name REGEXP '[a-z]' AND full_name <> CONCAT(UPPER(LEFT(full_name,1)), LOWER(SUBSTRING(full_name,2)));

-- 67. Detect mixed case emails (not all-lowercase).
SELECT * FROM customer_data_issues WHERE email IS NOT NULL AND BINARY email <> BINARY LOWER(email);

-- 68. Identify records where city, email, or membership mix cases inconsistently.
SELECT record_id, full_name, email, city, membership
FROM customer_data_issues
WHERE (email IS NOT NULL AND BINARY email <> BINARY LOWER(email))
   OR (city IS NOT NULL AND BINARY city <> BINARY CONCAT(UPPER(LEFT(city,1)), LOWER(SUBSTRING(city,2))))
   OR (membership IS NOT NULL AND BINARY membership <> BINARY CONCAT(UPPER(LEFT(membership,1)), LOWER(SUBSTRING(membership,2))));

-- 69. Convert all full_name to proper case (first letter uppercase, rest lowercase).
UPDATE customer_data_issues
SET full_name = CONCAT(UPPER(LEFT(TRIM(full_name),1)), LOWER(SUBSTRING(TRIM(full_name),2)))
WHERE full_name IS NOT NULL AND TRIM(full_name) <> '';

-- 70. Fix all city names to title case (already performed above as Q26/Q60).
-- (Repeat safe update to ensure consistency)
UPDATE customer_data_issues
SET city = CONCAT(UPPER(LEFT(TRIM(city),1)), LOWER(SUBSTRING(TRIM(city),2)))
WHERE city IS NOT NULL AND TRIM(city) <> '';

-- 71. Lowercase all email addresses (already did at Q27, repeat for safety).
UPDATE customer_data_issues
SET email = LOWER(TRIM(email))
WHERE email IS NOT NULL;

-- 72. Standardize membership names to consistent format (Regular/Gold/Platinum).
UPDATE customer_data_issues
SET membership = CASE 
    WHEN LOWER(TRIM(membership)) = 'regular' THEN 'Regular'
    WHEN LOWER(TRIM(membership)) = 'gold' THEN 'Gold'
    WHEN LOWER(TRIM(membership)) = 'platinum' THEN 'Platinum'
    ELSE TRIM(membership)
END
WHERE membership IS NOT NULL;

-- 73. Flag records manually edited by humans (notes containing keywords 'error', 'duplicate', 'typo', 'missing').
ALTER TABLE customer_data_issues ADD COLUMN human_flag TINYINT(1) DEFAULT 0;
UPDATE customer_data_issues
SET human_flag = 1
WHERE notes REGEXP '(?i)(error|duplicate|typo|missing|human error|spell)';

-- 74. Count number of records impacted by human errors (human_flag = 1).
SELECT COUNT(*) AS human_error_count FROM customer_data_issues WHERE human_flag = 1;

-- 75. Generate a summary report of data quality issues by type (Missing, Invalid, Duplicate, etc.).
SELECT 
  (SELECT COUNT(*) FROM customer_data_issues WHERE full_name IS NULL OR TRIM(full_name) = '') AS missing_name,
  (SELECT COUNT(*) FROM customer_data_issues WHERE email IS NULL OR TRIM(email) = '' OR email NOT LIKE '%@%.%') AS invalid_or_missing_email,
  (SELECT COUNT(*) FROM customer_data_issues WHERE phone IS NULL OR TRIM(phone) = '' OR REGEXP_REPLACE(COALESCE(phone,''),'[^0-9]','') NOT REGEXP '^[0-9]{10,12}$') AS invalid_or_missing_phone,
  (SELECT COUNT(*) FROM customer_data_issues WHERE membership IS NULL OR LOWER(TRIM(membership)) NOT IN ('regular','gold','platinum')) AS invalid_membership,
  (SELECT COUNT(*) FROM customer_data_issues WHERE join_date IS NULL OR YEAR(join_date) < 1900 OR YEAR(join_date) > YEAR(CURDATE())) AS invalid_or_missing_join_date,
  (SELECT COUNT(*) FROM customer_data_issues WHERE duplicate_flag = 1) AS duplicate_records,
  (SELECT COUNT(*) FROM customer_data_issues WHERE human_flag = 1) AS human_flagged_records;

-- 76. Total number of bad records by category.
SELECT 
    SUM(CASE WHEN full_name IS NULL THEN 1 ELSE 0 END) AS missing_name,
    SUM(CASE WHEN email IS NULL OR email NOT LIKE '%@%' THEN 1 ELSE 0 END) AS invalid_email,
    SUM(CASE WHEN phone NOT REGEXP '^[0-9]{10}$' THEN 1 ELSE 0 END) AS invalid_phone,
    SUM(CASE WHEN LOWER(city) != 'delhi' AND UPPER(city) = 'DELHI' THEN 1 ELSE 0 END) AS inconsistent_city
FROM customer_data_issues;

