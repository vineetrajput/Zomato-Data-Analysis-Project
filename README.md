# Zomato Data Analysis Project

## Overview
This project demonstrates **SQL-based data analysis** using a Zomato. The project is designed for learning and practicing **data cleaning, data handling, and analytical queries** in SQL. It includes multiple tables, sample data, and real-world data issues to simulate practical scenarios.

---

## Project Highlights

- **Multiple Tables**: Customers, Restaurants, Menu Items, Orders, Order Items, Delivery, Payments, Reviews, Employees  
- **Data Issues Covered**:
  - Incomplete Data
  - Inaccurate Data
  - Inconsistent Data
  - Outdated Data
  - Duplicate Data
  - Incorrectly Formatted Data
  - Violations of Business Logic
  - Non-Standardized Data
  - Spelling Errors
  - Human Errors
  - Mixed Uppercase and Lowercase
- **SQL Concepts Practiced**:
  - Data Cleaning & Validation
  - Aggregation & Grouping
  - Ranking & Top-N Analysis
  - Joins (INNER, LEFT)
  - Window Functions
  - Filtering & Sorting
  - Subqueries & CTEs

---

---

## Tables Overview

1. **customers** – Customer details including membership, city, and contact info  
2. **restaurants** – Restaurant details with cuisine type, rating, and address  
3. **menu_items** – Dishes, categories, prices, and availability  
4. **orders** – Orders placed by customers  
5. **order_items** – Items included in each order  
6. **delivery** – Delivery details, assigned delivery boy, and status  
7. **payments** – Payment method, status, and amount  
8. **reviews** – Customer reviews and ratings  
9. **employees** – Restaurant staff, roles, and hire dates  

---

## SQL Queries

### 1. Top 5 Restaurants by Total Revenue
```
SELECT r.restaurant_name, SUM(o.total_amount) AS total_revenue
FROM restaurants r
JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_name
ORDER BY total_revenue DESC
LIMIT 5;
```
2. Customers Ranked by Total Spending
```
SELECT c.customer_id, c.full_name, SUM(o.total_amount) AS total_spent,
       RANK() OVER (ORDER BY SUM(o.total_amount) DESC) AS rank
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name;
```
3. Find Duplicate Customers by Full Name and Email
```
SELECT full_name, email, COUNT(*) AS duplicate_count
FROM customer_data_issues
WHERE full_name IS NOT NULL AND email IS NOT NULL
GROUP BY full_name, email
HAVING COUNT(*) > 1;
```
4. Top 3 Dishes per Restaurant by Revenue
```
WITH dish_revenue AS (
    SELECT mi.restaurant_id, mi.item_id, SUM(oi.price) AS revenue
    FROM menu_items mi
    JOIN order_items oi ON mi.item_id = oi.item_id
    GROUP BY mi.restaurant_id, mi.item_id
)
SELECT restaurant_id, item_id, revenue
FROM (
    SELECT *, RANK() OVER (PARTITION BY restaurant_id ORDER BY revenue DESC) AS rank
    FROM dish_revenue
) t
WHERE rank <= 3;
```


## Folder Structur``
