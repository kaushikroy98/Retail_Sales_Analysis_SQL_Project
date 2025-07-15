-- SQL Retail sales Analysis Project 1
create database project_1_sales_analysis;

-- Create table 
CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(30),
    quantiy INT,
    price_per_unit INT,
    cogs FLOAT,
    total_sale INT
);

select * from retail_sales
limit 100;

select count(*) from retail_sales;


-- Data cleaning
SELECT 
    *
FROM
    retail_sales
WHERE
    transactions_id IS NULL OR sale_date IS NULL OR sale_time IS NULL
        OR customer_id IS NULL OR gender IS NULL OR age IS NULL
        OR category IS NULL OR quantiy IS NULL OR price_per_unit IS NULL
        OR cogs IS NULL OR total_sale IS NULL;
        
DELETE
FROM
    retail_sales
WHERE
    transactions_id IS NULL OR sale_date IS NULL OR sale_time IS NULL
        OR customer_id IS NULL OR gender IS NULL OR age IS NULL
        OR category IS NULL OR quantiy IS NULL OR price_per_unit IS NULL
        OR cogs IS NULL OR total_sale IS NUL;


-- Data Exploration

-- Count of sales
select count(*) sales_count from retail_sales;

-- Count of distinct customers
select count(distinct customer_id) distinct_customer_count from retail_sales;

-- Count of categories
select count(distinct category) category_count from retail_sales;

-- Category Name
select distinct category from retail_sales;


-- Solving Business problems

-- Q1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from retail_sales
where sale_date='2022-11-05';

-- Q2 Write a SQL query to retrieve all transactions where the category is 'Clothing' 
-- and the quantity sold is more than 4 in the month of Nov-2022

select * from retail_sales
where category='Clothing' and quantiy>=4 and date_format(sale_date,'%Y-%m')='2022-11'
order by sale_date;


-- Q3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category, sum(quantiy) total_sale, count(*) total_order from retail_sales
group by category;

-- Q4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category

select category, round(avg(age),2) avg_age from retail_sales
where category='Beauty';


-- Q5 Write a SQL query to find all transactions where the total_sale is greater than 1000

select * from retail_sales
where total_sale>1000;

-- Q6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category

select category,gender, count(transactions_id) total_txn from retail_sales
group by 1,2
order by 1;

-- Q7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year 
-- Good for practising window functions and use of multiple select query

select year,month,avg_sales from (
select year(sale_date) as year,month(sale_date) as month, avg(total_sale) as avg_sales,
rank() over(partition by year(sale_date) order by avg(total_sale) desc) as rnk
from retail_sales
group by 1,2
order by 1) as a
where rnk=1;

-- Q8 Write a SQL query to find the top 5 customers based on the highest total sales

select customer_id, sum(total_sale) total_sales from retail_sales
group by 1
order by 2 desc
limit 5;

-- Q9 Write a SQL query to find the number of unique customers who purchased items from each category

select category, count(distinct customer_id) as Count_unique_cx from retail_sales
group by 1;



-- Q10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

-- Use of CTE Table

with hourly_sales as(
select *,
case 
when hour(sale_time) <12 then 'Morning'
when hour(sale_time) between 12 and 17 then 'Afternoon'
else 'Evening'
end shift
from retail_sales)

select shift, count(*) as total_orders from hourly_sales
group by 1
order by 2 ;



-- End of project
