SELECT * FROM category;
SELECT * FROM products;
SELECT * FROM stores;
SELECT * FROM sales;

--EDA--

SELECT DISTINCT repair_status FROM warranty;
---improving query peforance---
---et - 84ms
---pt- 0.10ms
---et- 9.44ms

EXPLAIN ANALYZE
SELECT * FROM sales
WHERE product_id ='P-44'

CREATE INDEX sales_product_id ON sales(product_id);
CREATE INDEX sales_store_id ON sales(store_id);
CREATE INDEX sales_sale_id ON sales(sale_id);

---improving query peforance---
---et - 86ms
---pt- 0.09ms
---et- 9.39ms

EXPLAIN ANALYZE
SELECT * FROM sales
WHERE store_id ='ST-31'

--problems

-- Q1: Find the number of stores in each country.

SELECT
country,
COUNT(store_id) AS total_stores
FROM stores
GROUP BY 1
ORDER BY 2 DESC;

--- Q2: Find the total no of unit soled by the sales stores.

SELECT
s.store_id,
st.store_name,
SUM(quantity) AS total_units_sold
FROM sales as s
JOIN
stores AS st
ON st.store_id = s.store_id
GROUP BY 1,2
ORDER BY 3 DESC


---Q3 identify how many sales occured in december 2023.


SELECT COUNT(sale_id) AS total_sales
FROM sales
WHERE TO_CHAR(sale_date, 'MM-YYYY') = '12-2023';

---Q4 how many stores never had a warranty claim filled.

SELECT * FROM stores
WHERE store_id NOT IN(
SELECT  DISTINCT store_id
FROM sales AS s
RIGHT JOIN warranty as w
ON s.sale_id = w.sale_id);

---Q5 calcule the percentage of warrnty claims marked as warrenty void

SELECT
ROUND(
COUNT(claim_id)/(SELECT COUNT(*) FROM warranty)::numeric * 100,2)
FROM warranty 
WHERE repair_status = 'Rejected'

---Q6 store with most sales last year 

SELECT 
s.store_id,
st.store_name,
SUM(s.quantity) 
FROM sales as s
JOIN stores as st
ON s.store_id = st.store_id
WHERE sale_date >=(CURRENT_DATE - INTERVAL '1 year')
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 1

--- Q:7 Count the number of unique products sold in the last year.

SELECT 
DISTINCT
COUNT(product_id)
FROM sales s
WHERE sale_date >= CURRENT_DATE - INTERVAL '1 YEAR' 


-- Q:8 Find the average price of products in each category.

SELECT 
p.category_id,
c.category_name,
ROUND(AVG(p.price)::numeric, 2) AS avg_price
FROM products p
JOIN category c
ON p.category_id = c.category_id
GROUP BY 1,2
ORDER BY 1,3 DESC;


-- Q:9 How many warranty claims were filed in 2020?

SELECT 
COUNT(*) AS total_warranty
FROM warranty
WHERE EXTRACT(YEAR FROM claim_date) = 2020;

-- Q:10 For each store, identify the best-selling day based on highest quantity sold.

SELECT *
FROM (
SELECT
store_id,
sale_date,
SUM(quantity) AS total_sale,
RANK() OVER (
PARTITION BY store_id
ORDER BY SUM(quantity) DESC
) AS ranking
FROM sales
GROUP BY store_id, sale_date) t
WHERE ranking = 1
ORDER BY store_id, total_sale DESC;

--- Q:11 Identify the least selling product in each country for each year based on total units sold.


SELECT
t1.country,
t1.product_id,
p.product_name,
t1.yearly,
t1.total_sale
FROM(
SELECT
st.country,
s.product_id,
EXTRACT(YEAR FROM sale_date) AS yearly,
SUM(quantity) AS total_sale,
RANK() OVER(PARTITION BY st.country, EXTRACT(YEAR FROM sale_date) ORDER BY SUM(quantity) ASC) AS ranking
FROM sales s
JOIN stores st
ON s.store_id = st.store_id
GROUP BY 1,2,3
) AS t1
JOIN products p
ON t1.product_id = p.product_id
WHERE ranking = 1;


--- Q:12: Calculate how many warranty claims were filed within 180 days of a product sale.

SELECT
COUNT(*) as total_claim
FROM(SELECT
s.sale_date,
w.claim_date,
s.product_id,
(w.claim_date - s.sale_date) AS duration
FROM warranty w
JOIN sales s
ON s.sale_id = w.sale_id
) AS t1
WHERE duration BETWEEN 0 AND 180;

--- Q:13 Determine how many warranty claims were filed for products launched in the last two years.


SELECT
COUNT(w.claim_id) AS total_claims
FROM warranty w
JOIN sales s
ON w.sale_id = s.sale_id
JOIN products p
ON p.product_id = s.product_id
WHERE p.launch_date >= CURRENT_DATE - INTERVAL '2 years';

--- Q:14 List the months in the last three years where sales exceeded 5,000 units in the USA.


SELECT
EXTRACT(YEAR FROM s.sale_date) AS year,
EXTRACT(MONTH FROM s.sale_date) AS month,
SUM(s.quantity) AS total_sales
FROM sales s
JOIN stores st
ON s.store_id = st.store_id
WHERE st.country = 'United States'
AND s.sale_date >= CURRENT_DATE - INTERVAL '3 years'
GROUP BY
EXTRACT(YEAR FROM s.sale_date),
EXTRACT(MONTH FROM s.sale_date)
HAVING SUM(s.quantity) > 5000
ORDER BY year, month;


---Q:15 Identify the product category with the most warranty claims filed in the last two years.

SELECT
p.category_id,
c.category_name,
COUNT(claim_id) AS total_claim
FROM warranty w
LEFT JOIN sales s
ON s.sale_id = w.sale_id
JOIN products p
ON p.product_id = s.product_id
JOIN category c
ON c.category_id = p.category_id
WHERE w.claim_date >= CURRENT_DATE - INTERVAL '2 YEAR'
GROUP BY 1,2
ORDER BY total_claim  DESC;
LIMIT 1;

---Q16. Which country has the highest revenue per store

SELECT
st.country,
ROUND(SUM(s.quantity * p.price)::numeric / COUNT(DISTINCT st.store_id),2)
AS revenue_per_store
FROM sales s
JOIN products p
ON s.product_id = p.product_id
JOIN stores st
ON s.store_id = st.store_id
GROUP BY st.country
ORDER BY revenue_per_store DESC;

---Q17 Which products have high sales but also high warranty claims

SELECT
p.product_name,
COUNT(DISTINCT s.sale_id) AS sales_count,
COUNT(w.claim_id) AS claim_count,
ROUND(COUNT(w.claim_id)::numeric * 100 /COUNT(DISTINCT s.sale_id),2) AS claim_rate_percentage
FROM products p
JOIN sales s
ON p.product_id = s.product_id
LEFT JOIN warranty w
ON s.sale_id = w.sale_id
GROUP BY p.product_name
ORDER BY claim_rate_percentage DESC;

--Q18 Which store performs above the company average revenue

WITH store_revenue AS (
SELECT
s.store_id,
SUM(s.quantity * p.price) AS revenue
FROM sales s
JOIN products p
ON s.product_id = p.product_id
GROUP BY s.store_id)
SELECT *
FROM store_revenue
WHERE revenue >(SELECT AVG(revenue)
FROM store_revenue)
ORDER BY revenue DESC;
