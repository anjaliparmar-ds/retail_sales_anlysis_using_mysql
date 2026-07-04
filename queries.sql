                                                         -- My Analysis & Findings

USE retail_sals_analysis;

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
       SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and
--     the quantity sold is more than 3 in the month of Nov-2022
        SELECT * FROM retail_sales
        WHERE category = 'Clothing' AND quantity > 3 AND month(sale_date) = 11 AND year(sale_date) = 2022;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
       SELECT category , SUM(total_sale) AS total_sales FROM retail_sales group by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
      SELECT category , round(AVG(age),2)  FROM retail_sales where category='Beauty' ;

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
       SELECT * FROM retail_sales WHERE total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
	SELECT category,gender,count(transactions_id) AS transactions FROM retail_sales group by category ,gender;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
       select year,month,avg_sale
      from
	  (SELECT
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        ROUND(AVG(total_sale),2) AS avg_sale,
        RANK() OVER (
            PARTITION BY YEAR(sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS rank_no
    FROM retail_sales
    GROUP BY year, month) AS inner_query
    where rank_no = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
	   SELECT 
              customer_id,
              round(SUM(total_sale),2) AS total_sales
	   FROM retail_sales
       group by customer_id
       order by total_sales DESC
       LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
       SELECT category, COUNT(distinct customer_id) AS unique_customers FROM retail_sales group by category;
      
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
SELECT
       Case
           when hour(sale_time) <= 12 then 'Morning'
           when hour(sale_time) >12 AND hour(sale_time) <=17 then 'Afternoon'
           else 'Evening'
           END as shift,
           COUNT(transactions_id) AS total_orders
FROM retail_sales group by shift;





