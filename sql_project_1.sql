--SQl Retail Sales Analysis - p1

--
SELECT 
	COUNT (*)
FROM retail_sales

--Crate TABLE
CREATE TABLE retail_sales
			(
				transactions_id INT PRIMARY KEY,
				sale_date DATE,
				sale_time TIME,
				customer_id INT,
				gender VARCHAR(50),
				age INT,
				category VARCHAR(50),
				quantiy INT,
				price_per_unit FLOAT,
				cogs FLOAT,
				total_sale FlOAT

			)
SELECT * FROM retail_sales

-- Data CLeaning

SELECT * FROM retail_sales
WHERE transactions_id IS NULL

SELECT * FROM retail_sales
WHERE sale_date IS NULL

SELECT * FROM retail_sales
WHERE sale_time IS NULL

SELECT * FROM retail_sales
WHERE
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	gender IS NULL
	OR 
	category IS NULL
	OR
	quantiy IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL

--
DELETE FROM retail_sales
WHERE
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	gender IS NULL
	OR 
	category IS NULL
	OR
	quantiy IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL

-- Data Exploration

-- How many sale we have?
SELECT COUNT (*) as total_sale FROM retail_sales

--How many unique customer we have?

SELECT COUNT (DISTINCT customer_id) as total_sale FROM retail_sales

SELECT DISTINCT category  FROM retail_sales

-- Data Analysis & Businss Key Problem & Answer

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT 
	*
FROM retail_sales
WHERE category ='Clothing'
	AND
	TO_CHAR(sale_date,'YYY-MM') = '2022-11'
	AND 
	quantiy >= 4

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT 
	category,
	SUM(total_sale) as net_sales,
	COUNT(*) as total_orders
FROM retail_sales
	GROUP BY 1
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT 
    ROUND(AVG (age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * FROM retail_sales
WHERE total_sale > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT 
	category,
	gender,
COUNT (*)
as total_trans
FROM retail_sales
GROUP 
	BY
	category,
	gender
ORDER BY 1

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT * FROM
(
SELECT 
	EXTRACT (YEAR FROM sale_date) as year,
	EXTRACT (MONTH FROM sale_date) as month,
	AVG(total_sale) as avg_sale,
	RANK() OVER (PARTITION BY EXTRACT (YEAR FROM sale_date) ORDER BY  AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank =1





SELECT 
	year,
	month,
	avg_sale
FROM
(
SELECT 
	EXTRACT (YEAR FROM sale_date) as year,
	EXTRACT (MONTH FROM sale_date) as month,
	AVG(total_sale) as avg_sale,
	RANK() OVER (PARTITION BY EXTRACT (YEAR FROM sale_date) ORDER BY  AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank =1

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT
	customer_id,
	SUM(total_sale) as total_sale
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT
	category,
	COUNT ( DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category

SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;
	

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

SELECT 
  CASE 
    WHEN CAST(sale_time AS TIME) < '12:00:00' THEN 'Morning'
    WHEN CAST(sale_time AS TIME) BETWEEN '12:00:00' AND '17:00:00' THEN 'Afternoon'
    ELSE 'Evening'
  END AS shift,
  COUNT(*) AS orders
FROM retail_sales
GROUP BY shift
ORDER BY orders DESC;

--End of Project

