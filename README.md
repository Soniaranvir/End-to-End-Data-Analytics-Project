Walmart Data Analysis Project

✨ Overview

Walmart is one of the world’s largest retailers, handling vast amounts of transactional data across multiple branches. This project focuses on analyzing Walmart’s sales data to uncover insights about customer behavior, sales trends, and business performance. By leveraging SQL, Python, and Tableau, we explored the dataset and created visualizations to drive actionable decisions.

🔍 Problem Statement

Retail businesses like Walmart often struggle with:

Understanding customer preferences and payment patterns.

Identifying high-performing and low-performing branches or products.

Spotting revenue trends and seasonal changes.

Optimizing inventory and marketing strategies based on demand.

This project aims to address these challenges by extracting meaningful insights from Walmart’s sales data.

⚙️ Tools and Technologies Used

Database Management: PostgreSQL (pgAdmin)

Programming Language: Python (Data cleaning and preparation)

Visualization: Tableau (Interactive charts and graphs)

🔎 Key Questions and Insights

1. What are the different payment methods, and how do they perform?

Query: Count payment methods and calculate the total quantity sold by each method.

Insight: Ewallet emerged as the most preferred payment method, followed by credit cards.

2. Which category receives the highest average rating in each branch?

Query: Rank categories within branches based on average customer ratings.

Insight: Categories like Health and Beauty consistently scored higher in customer satisfaction.

3. What is the busiest day of the week for each branch?

Query: Identify the busiest day based on the number of transactions.

Insight: Saturdays were identified as the peak shopping day.

4. Which shifts drive the most sales?

Query: Categorize sales into morning, afternoon, and evening shifts.

Insight: The Afternoon shift accounted for the highest sales volume.

5. What are the top-performing categories in each branch?

Query: Determine the top 3 categories contributing the highest revenue in each branch.

Insight: Categories like Electronics and Home & Lifestyle dominated revenue generation.

6. How do revenue trends vary seasonally?

Query: Analyze revenue distribution across quarters.

Insight: Q4 (Holiday season) showed a significant increase in sales compared to other quarters.

7. What’s the revenue decline trend?

Query: Compare revenue between 2022 and 2023 to identify branches with the highest decline ratio.

Insight: Certain branches in smaller cities faced revenue challenges.

🔢 Data Cleaning and Preparation

Using Python, we:

Removed duplicates and missing values.

Standardized data types, such as converting prices to float.

Added new fields like total revenue and customer IDs for enhanced analysis.

🌄 Tableau Visualizations

Key Dashboards and Visualizations:

Payment Methods Distribution

A pie chart showcasing the proportion of transactions by payment method.

Category Ratings by Branch

A bar chart comparing average ratings of categories across branches.

Top Categories by Revenue

A stacked bar chart displaying the revenue contribution of top-performing categories.

Seasonal Revenue Trends

A line graph depicting quarterly revenue patterns to identify peak sales seasons.

Branch-Level Performance

A map visualization highlighting branches based on revenue and customer satisfaction.

🌐 Lessons Learned

SQL is powerful for deriving detailed insights with precise queries like RANK and WINDOW functions.

Python excels in handling messy datasets, making it easier to clean and prepare data for visualization.

Tableau’s visual storytelling capabilities are unparalleled for communicating complex data in a user-friendly way.

🎨 Future Scope

Automate ETL Pipelines: Using Python or other tools to automate data extraction and analysis.

Advanced Predictive Modeling: Leveraging machine learning for customer segmentation and sales forecasting.

Enhanced Visualizations: Creating interactive dashboards for real-time business insights.

⚡ Quick Links

Dataset: 

SQL Queries: 

Python Code: 

Tableau Visualizations: 

