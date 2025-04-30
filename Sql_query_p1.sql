
--SQL Retail Sales analysis - P1
CREATE DATABASE sql_Project_p2

--create TABLE

DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales(
			transactions_id INT PRIMARY KEY,
			 sale_date DATE,
			 sale_time TIME,
			 customer_id INT,
			 gender VARCHAR(15),
			 age INT,
			 category VARCHAR(50),
			 quantity INT,
			 price_per_unit FLOAT,
			cogs FLOAT,
			 total_sale FLOAT

);

SELECT * FROM retail_sales
LIMIT 10;

SELECT
COUNT(*)
FROM retail_sales;


SELECT DISTINCT category
FROM retail_sales;

SELECT * 
FROM retail_sales
WHERE transactions_id is null;

SELECT * 
FROM retail_sales
WHERE sale_date is null;

SELECT * 
FROM retail_sales
WHERE sale_time is null;

--Data Cleaning
SELECT * 
FROM retail_sales
WHERE 
    transactions_id is nulL
	OR sale_date is null
	OR sale_time is null
	OR customer_id is null
	OR gender is null
	OR category is null
	OR quantity is null
	OR cogs is null
	OR total_sale is null;
	
	DELETE FROM retail_sales
	WHERE 
	   transactions_id is nulL
	OR sale_date is null
	OR sale_time is null
	OR customer_id is null
	OR gender is null
	OR category is null
	OR quantity is null
	OR cogs is null
	OR total_sale is null;
	
SELECT
  COUNT(*) FROM retail_sales;
  
  
SELECT * FROM retail_sales; 

---Data Exploration
--How many sales we have
SELECT COUNT(*) as total_sales FROM retail_sales

-- How many unique customers we have? 155
SELECT count(DISTINCT customer_id) as total_unique_customers FROM retail_sales;

--How many unique categories? 3
SELECT 
	DISTINCT category as total_categories 
	FROM retail_sales;
	
	
--Data Analysis & Business problems

--retrive all columns for sales made on '2022-11-05' -98rows

SELECT 
  *
FROM retail_sales
WHERE sale_date = '2022-11-05'

--retrive all transactions where the category is 'clothing' and the quanity sold is more than 10
--in the month of nov-2022

SELECT *
	FROM retail_sales
	WHERE category = 'Clothing' and TO_CHAR(sale_date, 'YYYY-MM') = '2022-11' AND quantity>=4;
	
--calculate the total sales for each category	

SELECT
  category,
  SUM(total_sale) total_sales,
  count(*) total_orders
  FROM retail_sales
  GROUP BY category;
  
 --avg age of customers who purchased items from the beauty category 
  
 SELECT
   category,
   ROUND(AVG(age),2) avg_age
   FROM retail_sales
   WHERE category = 'Beauty'
   GROUP BY category
 --Write a SQL query to find all transactions where the total sale is greater than 1000
 
 SELECT
   *
 FROM retail_sales
 WHERE total_sale >1000
 
-- write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category

SELECT
  gender,
  category,
  count(*) total_transactions
  FROM retail_sales
  group by gender,category
  
 --write a query to calculate the average sale for each month find out the best selling month in each year.
 
 SELECT 
   *
   FROM 
 (SELECT
    EXTRACT(YEAR FROM sale_date) as Year,
	EXTRACT(MONTH FROM sale_date)as Month,
	 ROUND(CAST(AVG(total_sale) AS INT),2) avg_sales,
	 RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY ROUND(CAST(AVG(total_sale) AS INT),2)DESC)RNK
	FROM retail_sales
	GROUP BY 1,2)T
	WHERE rnk = 1

 -- Write a SQL query to find the top 5 customers based on the highest total sales
 
 SELECT
    customer_id,
	sum(total_sale) as total_sales
FROM retail_sales
GROUP BY customer_id 
ORDER BY sum(total_sale) desc
LIMIT 5


--Write a sql query to find the number of unique customers who purchased items from each category


SELECT 
	category,
	COUNT(DISTINCT customer_id) Unique_Num_of_customers
FROM retail_sales
GROUP BY Category

--write a sql query to create each shift and number of orders (Example Morning <=12, afternoon between 12 717, evening >17)

SELECT
  CASE
     WHEN Extract(hour from sale_time)<12 THEN 'Morning'
	 WHEN Extract(hour from sale_time)between 12 and 17 THEN 'Afternoon'
	 WHEN Extract(hour from sale_time)>17 THEN 'Evenening'
	 END AS shift,
	count(transactions_id) as num_of_orders 
 FROM retail_sales
GROUP BY 1
 
 End of project

