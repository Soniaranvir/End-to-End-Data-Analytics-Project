'''sql

SELECT * FROM walmart

--
SELECT COUNT(*) FROM walmart

-- Count payment methods and number of transactions by payment method
SELECT 
    payment_method,
    COUNT(*) AS no_payments
FROM walmart
GROUP BY payment_method;

-- Count distinct branches
SELECT COUNT(DISTINCT branch) FROM walmart;

-- Find the minimum quantity sold
SELECT MIN(quantity) FROM walmart;

-- Business Problem Q1: Find different payment methods, number of transactions, and quantity sold by payment method
SELECT 
    payment_method,
    COUNT(*) AS no_payments,
    SUM(quantity) AS no_qty_sold
FROM walmart
GROUP BY payment_method;

-- Project Question #2: Identify the highest-rated category in each branch
-- Display the branch, category, and avg rating
SELECT branch, category, avg_rating
FROM (
    SELECT 
        branch,
        category,
        AVG(rating) AS avg_rating,
        RANK() OVER(PARTITION BY branch ORDER BY AVG(rating) DESC) AS rank
    FROM walmart
    GROUP BY branch, category
) AS ranked
WHERE rank = 1;

-- Q3: Identify the busiest day for each branch based on the number of transactions
SELECT branch, day_name, no_transactions
FROM (
    SELECT 
        branch,
        TO_CHAR(TO_DATE(date, 'DD/MM/YYYY'), 'Day') AS day_name,
        COUNT(*) AS no_transactions,
        RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) AS rank
    FROM walmart
    GROUP BY branch, day_name
) AS ranked
WHERE rank = 1;

-- Q4: Calculate the total quantity of items sold per payment method
SELECT 
    payment_method,
    SUM(quantity) AS no_qty_sold
FROM walmart
GROUP BY payment_method;

-- Q5: Determine the average, minimum, and maximum rating of categories for each city
SELECT 
    city,
    category,
    MIN(rating) AS min_rating,
    MAX(rating) AS max_rating,
    AVG(rating) AS avg_rating
FROM walmart
GROUP BY city, category;

-- Q6: Calculate the total profit for each category
SELECT 
    category,
    SUM(
        CAST(REPLACE(unit_price, '$', '') AS DOUBLE PRECISION) * 
        CAST(quantity AS DOUBLE PRECISION) * 
        CAST(profit_margin AS DOUBLE PRECISION)
    ) AS total_profit
FROM walmart
GROUP BY category
ORDER BY total_profit DESC;

-- Q7: Determine the most common payment method for each branch
WITH cte AS (
    SELECT 
        branch,
        payment_method,
        COUNT(*) AS total_trans,
        RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) AS rank
    FROM walmart
    GROUP BY branch, payment_method
)
SELECT branch, payment_method AS preferred_payment_method
FROM cte
WHERE rank = 1;

-- Q8: Categorize sales into Morning, Afternoon, and Evening shifts
SELECT
	branch,
CASE 
		WHEN EXTRACT(HOUR FROM(time::time)) < 12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM(time::time)) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END day_time,
	COUNT(*)
FROM walmart
GROUP BY 1, 2
ORDER BY 1, 3 DESC

-- Q9: Identify the 5 branches with the highest revenue decrease ratio from last year to current year (e.g., 2022 to 2023)
-- rdr == last_rev-cr_rev/ls_rev*100
WITH revenue_2022 AS (
    SELECT 
        branch,
        SUM(
            CAST(REPLACE(unit_price, '$', '') AS NUMERIC) * 
            CAST(quantity AS NUMERIC)
        ) AS revenue
    FROM walmart
    WHERE EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) = 2022
    GROUP BY branch
),
revenue_2023 AS (
    SELECT 
        branch,
        SUM(
            CAST(REPLACE(unit_price, '$', '') AS NUMERIC) * 
            CAST(quantity AS NUMERIC)
        ) AS revenue
    FROM walmart
    WHERE EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) = 2023
    GROUP BY branch
)
SELECT 
    ls.branch,
    ls.revenue AS last_year_revenue,
    cs.revenue AS cr_year_revenue,
    ROUND(
        (ls.revenue - cs.revenue) / ls.revenue * 100, 
        2
    ) AS rev_dec_ratio
FROM revenue_2022 AS ls
JOIN revenue_2023 AS cs
ON ls.branch = cs.branch
WHERE 
    ls.revenue > cs.revenue
ORDER BY rev_dec_ratio DESC
LIMIT 5;

--Q10: Identify the Top 3 Categories with the Highest Revenue in Each Branch
--This query helps analyze which categories perform best in terms of revenue across different branches.
WITH category_revenue AS (
    SELECT 
        branch,
        category,
        SUM(
            CAST(REPLACE(unit_price, '$', '') AS NUMERIC) * 
            CAST(quantity AS NUMERIC)
        ) AS total_revenue
    FROM walmart
    GROUP BY branch, category
),
ranked_categories AS (
    SELECT 
        branch,
        category,
        total_revenue,
        RANK() OVER (PARTITION BY branch ORDER BY total_revenue DESC) AS revenue_rank
    FROM category_revenue
)
SELECT 
    branch,
    category,
    total_revenue
FROM ranked_categories
WHERE revenue_rank <= 3
ORDER BY branch, revenue_rank;

--Q11: Calculate the Average Quantity Sold for Each Product per City
--This gives insights into product demand by city.

SELECT 
    city,
    category,
    AVG(quantity) AS avg_quantity_sold
FROM walmart
GROUP BY city, category
ORDER BY city, avg_quantity_sold DESC;

--Q12: Analyze Seasonal Trends by Quarter
--Break down total sales revenue by quarters to understand seasonal patterns.

SELECT 
    QUARTER(STR_TO_DATE(date, '%d/%m/%Y')) AS quarter,
    branch,
    SUM(unit_price * quantity) AS total_revenue
FROM walmart
GROUP BY QUARTER(STR_TO_DATE(date, '%d/%m/%Y')), branch
ORDER BY quarter, total_revenue DESC;

--Q13: Determine the Most Profitable Day of the Week Across All Branches
--This query identifies which day generates the highest overall profit.

SELECT 
    TO_CHAR(TO_DATE(date, 'DD/MM/YYYY'), 'Day') AS day_name,
    SUM(
        CAST(REPLACE(unit_price, '$', '') AS NUMERIC) * 
        CAST(quantity AS NUMERIC) * 
        CAST(profit_margin AS NUMERIC)
    ) AS total_profit
FROM walmart
GROUP BY TO_CHAR(TO_DATE(date, 'DD/MM/YYYY'), 'Day')
ORDER BY total_profit DESC
LIMIT 1;


--Q14: Find the Least Sold Products Across All Branches
--Helps identify underperforming products that may need attention.

SELECT 
    category,
    SUM(quantity) AS total_quantity_sold
FROM walmart
GROUP BY category
ORDER BY total_quantity_sold ASC
LIMIT 10;
'
