# Advanced SQL Analytics on Apple Retail Sales Dataset

## About This Project

As part of my journey in learning Data Analytics and SQL, I worked on this project to analyze an Apple Retail Sales dataset using PostgreSQL.

The objective of this project was to solve real-world business problems related to sales performance, store operations, product reliability, and warranty claims. Through this project, I explored how SQL can be used to transform raw transactional data into meaningful business insights.

I also practiced advanced SQL concepts such as joins, aggregations, window functions, Common Table Expressions (CTEs), date functions, and query optimization techniques.

---

## Project Objectives

* Analyze sales performance across stores and countries.
* Understand product demand and customer purchasing trends.
* Evaluate product reliability using warranty claim data.
* Generate actionable business insights using SQL.
* Improve query performance through indexing and optimization.
* Strengthen practical SQL skills using real-world business scenarios.

---

## Database Schema

The project uses five tables:

### Stores

Contains information about Apple retail stores.

### Products

Contains product details such as product name, category, launch date, and price.

### Sales

Contains transaction-level sales records including quantity sold and sale date.

### Warranty

Contains warranty claim records and repair status information.

### Category

Contains product category information.

---

## SQL Concepts Used

Throughout this project, I worked with:

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
* Business KPI Analysis

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

To improve query performance, indexes were created on frequently used columns:

```sql
CREATE INDEX sales_product_id ON sales(product_id);
CREATE INDEX sales_store_id ON sales(store_id);
```

Query execution plans were analyzed using:

```sql
EXPLAIN ANALYZE
```

The execution time of frequently used queries was significantly reduced after indexing.

---

## Key Insights

* Store performance varies significantly across countries.
* Some products generate high sales but also experience high warranty claim rates.
* Warranty analysis helps identify potential product quality issues.
* Revenue per store provides a better measure of operational efficiency than total revenue.
* A small number of stores contribute a disproportionately high share of total sales.
* Data-driven analysis can help businesses improve inventory planning and customer satisfaction.

---

## What I Learned

This project helped me strengthen my SQL skills by solving practical business problems using real-world datasets. I gained hands-on experience with advanced SQL concepts, query optimization, data exploration, KPI calculations, and business-focused analytics.

It also improved my ability to translate business requirements into SQL queries and extract meaningful insights from data.

---

## Tools Used

* PostgreSQL
* pgAdmin 4
* SQL
* Git & GitHub
