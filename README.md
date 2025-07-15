# Retail_Sales_Analysis_SQL_Project

# Project Overview

This project is a **comprehensive SQL-based analysis of a retail sales dataset** using **MySQL Workbench**. It focuses on extracting business insights through structured queries, data cleaning, and aggregation techniques. The goal is to simulate real-world retail data analysis scenarios and answer specific business questions using SQL.

---

## 📁 Project Structure

```sql
Retail_Sales_Analysis_SQL_Project/
│
├── 📄 Retail Sales Analysis.csv
│   └─ The raw retail transaction dataset containing sales details like date, time, customer demographics, product category, quantity sold, price, and revenue.
│
├── 🗂️ project1_sql_queries.sql
│   └─ A complete SQL script containing:
│       • Database and table creation
│       • Data cleaning steps
│       • Descriptive analytics queries
│       • Business problem-solving queries using joins, aggregations, and window functions
│
├── 📝 README.md
│   └─ This documentation file describing the project's objective, dataset, methodology, SQL logic, and business insights.
```

---

## 📊 Dataset Overview

The dataset (`Retail Sales Analysis.csv`) consists of **transaction-level retail data** with the following columns:

| Column Name       | Description                                      |
|-------------------|--------------------------------------------------|
| transactions_id   | Unique ID for each transaction                   |
| sale_date         | Date of the transaction                          |
| sale_time         | Time of the transaction                          |
| customer_id       | Unique customer ID                               |
| gender            | Gender of the customer                           |
| age               | Age of the customer                              |
| category          | Product category (e.g., Clothing, Beauty, etc.)  |
| quantiy           | Number of units sold                             |
| price_per_unit    | Price per unit of the item                       |
| cogs              | Cost of goods sold                               |
| total_sale        | Total sale value (Revenue)                       |

---

## 🛠️ Tools & Technologies

- **Database:** MySQL (Workbench)
- **Language:** SQL
- **Environment:** Local setup using MySQL Workbench

---

## 🧹 Data Cleaning

The SQL script checks for and removes null values to ensure data quality. This is crucial before performing any analysis:

```sql
SELECT * FROM retail_sales
WHERE 
    transaction_id IS NULL OR sale_date IS NULL OR 
    sale_time IS NULL OR gender IS NULL OR category IS NULL OR
    quantity IS NULL OR cogs IS NULL OR total_sale IS NULL;
```

📌 **Business Questions Answered**
Below are the key business problems addressed through SQL queries in the project:

**Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'**

```sql
select * from retail_sales
where sale_date='2022-11-05';
```

**Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022**

```sql
select * from retail_sales
where category='Clothing' and quantity>=4 and date_format(sale_date,'%Y-%m')='2022-11'
order by sale_date;
```

**Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.**

```sql
select category, sum(quantiy) total_sale, count(*) total_order from retail_sales
group by category;
```

**Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**

```sql
select category, round(avg(age),2) avg_age from retail_sales
where category='Beauty';
```

**Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.**

```sql
select * from retail_sales
where total_sale>1000;
```

**Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**

```sql
select category,gender, count(transactions_id) total_txn from retail_sales
group by 1,2
order by 1;
```

**Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.**

```sql
select year,month,avg_sales from (
select year(sale_date) as year,month(sale_date) as month, avg(total_sale) as avg_sales,
rank() over(partition by year(sale_date) order by avg(total_sale) desc) as rnk
from retail_sales
group by 1,2
order by 1) as a
where rnk=1;
```


**Q.8 Write a SQL query to find the top 5 customers based on the highest total sales.**

```sql
select customer_id, sum(total_sale) total_sales from retail_sales
group by 1
order by 2 desc
limit 5;
```

**Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.**

```sql
select category, count(distinct customer_id) as Count_unique_cx from retail_sales
group by 1;
```

**Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)**

```sql
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
```

✅ **How to Use**
1. Clone this repository:
2. Import Retail Sales Analysis.csv into MySQL Workbench.
3. Run the SQL script ```sqlproject1_sql_queries.sql``` step-by-step to perform cleaning and analysis.
4. Export result sets if required for visualization or reporting.

📌 **Notes**

1. This project assumes a basic understanding of SQL and MySQL Workbench.
2. All business questions and solutions are written using standard SQL syntax.

**📬 Contact**

Kaushik Roy
Email: 1998kaushik.roy@gmail.com
LinkedIn: [[kaushikroy98](https://www.linkedin.com/in/kaushikroy98/)]

Project created for learning and demonstration purposes.







