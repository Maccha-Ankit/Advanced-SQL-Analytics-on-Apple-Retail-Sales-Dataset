# Advanced SQL Analytics on Apple Retail Sales Dataset

## About This Project

This project showcases the use of SQL to analyze a large-scale Apple Retail Sales dataset and solve real-world business problems related to sales performance, store operations, product reliability, and warranty claims.

The analysis was performed using PostgreSQL on a dataset containing **over 1 million sales records**, providing hands-on experience with querying, optimizing, and extracting insights from large volumes of data.

Through this project, I applied advanced SQL concepts such as joins, aggregations, window functions, Common Table Expressions (CTEs), date functions, and query optimization techniques to generate meaningful business insights.

---

## Dataset Overview

The project uses a retail dataset consisting of the following tables:

### Stores

Contains information about retail store locations.

### Products

Contains product details such as product name, category, launch date, and price.

### Sales

Contains transaction-level sales records including quantity sold, product purchased, store information, and sale date.

### Warranty

Contains warranty claim records and repair status information.

### Category

Contains product category details.

---

## Dataset Scale

The project was performed on a large dataset containing:

* **1M+ Sales Records**
* Product Information
* Store Information
* Warranty Claim Data
* Product Category Data

Working with a large dataset helped me gain practical experience in:

* Query Optimization
* Indexing
* Large-Scale Data Analysis
* Performance Tuning using `EXPLAIN ANALYZE`
* Writing Efficient SQL Queries

---

## SQL Concepts Used

* SELECT Statements
* Filtering and Sorting
* Aggregate Functions
* GROUP BY and HAVING
* Joins (INNER, LEFT, RIGHT)
* Subqueries
* Window Functions
* Common Table Expressions (CTEs)
* Date Functions
* Query Optimization
* Indexing

---

## Business Problems Solved

### Store & Sales Analysis

1. Find the number of stores in each country.
2. Calculate the total number of units sold by each store.
3. Identify how many sales occurred in December 2023.
4. Determine how many stores have never had a warranty claim filed.
5. Identify the store with the highest total units sold in the last year.
6. Count the number of unique products sold in the last year.
7. Find the average price of products in each category.
8. For each store, identify the best-selling day based on the highest quantity sold.
9. Identify the least-selling product in each country for each year.
10. List the months in the last three years where sales exceeded 5,000 units in the USA.

### Warranty Analysis

11. Calculate the percentage of warranty claims marked as "Warranty Void".
12. Determine how many warranty claims were filed in 2020.
13. Calculate how many warranty claims were filed within 180 days of a product sale.
14. Determine warranty claim percentages for products launched in the last two years.
15. Identify the product category with the most warranty claims filed in the last two years.

### Revenue & Performance Analysis

16. Which country has the highest revenue per store?
17. Which products have high sales but also high warranty claims?
18. Which stores perform above the company average revenue?

---

## Query Performance Optimization

To improve query performance on large datasets, indexes were created on frequently used columns:

```sql
CREATE INDEX sales_product_id ON sales(product_id);
CREATE INDEX sales_store_id ON sales(store_id);
```

Query execution plans were analyzed using:

```sql
EXPLAIN ANALYZE
```

This significantly reduced query execution time compared to full table scans.

---

## Key Insights

* Store performance varies across countries and regions.
* Revenue per store provides a better measure of efficiency than total revenue.
* Some products generate high sales but also experience higher warranty claim rates.
* Warranty claim analysis helps identify potential product quality issues.
* Query optimization becomes increasingly important when working with millions of records.
* Business decisions can be improved through data-driven analysis and KPI monitoring.

---

## What I Learned

This project helped me strengthen my SQL skills by solving practical business problems using real-world retail data.

Key takeaways include:

* Writing complex SQL queries for business analysis
* Working with large datasets containing over 1 million records
* Using joins, window functions, and CTEs effectively
* Performing query optimization using indexes
* Translating business questions into analytical SQL solutions
* Extracting actionable insights from raw data

---

## Tools Used

* PostgreSQL
* pgAdmin 4
* SQL
* Git & GitHub
