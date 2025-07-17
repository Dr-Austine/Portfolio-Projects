use e_commerce;
CREATE TABLE Retail_Db (
    Transactions_id INT PRIMARY KEY,
    Sale_date DATE,
    Sale_time TIME,
    Customer_id INT,
    Gender VARCHAR(10),
    Age INT,
    Category VARCHAR(35),
    Quantity INT,
    Price_per_unit FLOAT,
    Cogs FLOAT,
    Total_sale FLOAT
);

# Data Exploration & Cleaning
## Query to view the first 10 records in the Retail_Db table
SELECT * FROM Retail_Db LIMIT 10;


# Query to count the number of records in the Retail_Db table
SELECT COUNT(*) FROM Retail_Db;

# Query to count the number of unique Customer_id in the database
SELECT COUNT(DISTINCT Customer_id) FROM Retail_Db;

# Query to list all unique categories in the Retail_Db table
SELECT DISTINCT category FROM Retail_Db;

# Query to find the total number of transactions for each category
SELECT category, COUNT(*) AS Total_transactions
FROM Retail_Db
GROUP BY category
ORDER BY Total_transactions DESC;


# Query to find the total sales amount for each category
SELECT category, SUM(Total_sale) AS Total_sales
FROM Retail_Db
GROUP BY category
ORDER BY Total_sales DESC;



# Query to find the average age of customers in each category
SELECT category, ROUND(AVG(Age), 2) AS Average_age
FROM Retail_Db
GROUP BY category
ORDER BY Average_age DESC;


# Query to find the total quantity and Total_sales_amount made for each category
SELECT category, SUM(Quantity) AS Total_quantity_sold,
       ROUND(SUM(Total_sale), 2) AS Total_sales_amount
FROM Retail_Db
GROUP BY category
ORDER BY Total_sales_amount DESC;


# Query to find the total sales amount for the top 5 customers and categories
SELECT Customer_id, category, ROUND(SUM(Total_sale), 2) AS Total_sales
FROM Retail_Db
GROUP BY Customer_id, category
ORDER BY Total_sales DESC
LIMIT 5;

# Query to find Gender distribution in the Retail_Db table
SELECT Gender, COUNT(*) AS Total
FROM Retail_Db
GROUP BY Gender; 

# Query to find the average price per unit for each category
SELECT category, ROUND(AVG(Price_per_unit), 2) AS Average_price_per_unit
FROM Retail_Db
GROUP BY category
ORDER BY Average_price_per_unit DESC;


# Query to find the total sales amount for each category
SELECT category, ROUND(SUM(Total_sale), 2) AS Total_sales
FROM Retail_Db
GROUP BY category
ORDER BY Total_sales DESC;

# Query to find total sales and category selected by each Gender
SELECT Gender, category, ROUND(SUM(Total_sale), 2) AS Total_sales
FROM Retail_Db
GROUP BY Gender, category
ORDER BY Total_sales DESC;

# Query to find the total sales amount for each Gender
SELECT Gender, ROUND(SUM(Total_sale), 2) AS Total_sales
FROM Retail_Db
GROUP BY Gender
ORDER BY Total_sales DESC;


# Query to find the monthly total sales group by category made
SELECT DATE_FORMAT(Sale_date, '%Y-%m') AS Sale_month, category, ROUND(SUM(Total_sale), 2) AS Total_sales
FROM Retail_Db
GROUP BY Sale_month, category
ORDER BY Sale_month DESC;


# Query to find yearly total sales group by category made
SELECT DATE_FORMAT(Sale_date, '%Y') AS Sale_year, category, ROUND(SUM(Total_sale), 2) AS Total_sales
FROM Retail_Db
GROUP BY Sale_year, category
ORDER BY Sale_year DESC;

# Query to find the most sold category by year
SELECT Sale_year, category, ROUND(SUM(Total_sales), 2) AS Total_sales
FROM (
    SELECT DATE_FORMAT(Sale_date, '%Y') AS Sale_year, category, ROUND(SUM(Total_sale), 2) AS Total_sales
    FROM Retail_Db
    GROUP BY Sale_year, category
) AS Yearly_Sales
GROUP BY Sale_year
ORDER BY Total_sales DESC;

# Query to find the total sold category by both genders for all yearly sales
SELECT Sale_year, Gender, category, ROUND(SUM(Total_sales), 2) AS Total_sales
FROM (
    SELECT DATE_FORMAT(Sale_date, '%Y') AS Sale_year, Gender, category, ROUND(SUM(Total_sale), 2) AS Total_sales
    FROM Retail_Db
    GROUP BY Sale_year, Gender, category
) AS Yearly_Sales
GROUP BY Sale_year, Gender
ORDER BY Total_sales DESC;

# Query to find the total number of transactions made by each gender for each category
SELECT Gender, category, COUNT(*) AS Total_transactions
FROM Retail_Db
GROUP BY Gender, category;

# Query to find the total number of transactions made by each gender for each category monthly
SELECT Gender, category, COUNT(*) AS Total_transactions
FROM Retail_Db
GROUP BY Gender, category, MONTH(Sale_date);


# SQL query to find the number of unique customers who purchased items from each category
SELECT category, COUNT(DISTINCT Customer_id) AS Unique_customers
FROM Retail_Db
GROUP BY category;


#  SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
SELECT
    CASE
        WHEN HOUR(Sale_time) < 12 THEN 'Morning'
        WHEN HOUR(Sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS Shift,
    COUNT(*) AS Total_orders
FROM Retail_Db
GROUP BY Shift;

# Sql query to find which monthly sales are the highest
SELECT 
    DATE_FORMAT(Sale_date, '%b %Y') AS Sale_month, 
    ROUND(SUM(Total_sale), 2) AS Total_sales
FROM Retail_Db
GROUP BY Sale_month
ORDER BY Total_sales DESC
LIMIT 10;

# Sql query to find which monthly sales are the Lowest performing
SELECT 
    DATE_FORMAT(Sale_date, '%b %Y') AS Sale_month, 
    ROUND(SUM(Total_sale), 2) AS Total_sales
FROM Retail_Db
GROUP BY Sale_month
ORDER BY Total_sales 
LIMIT 10;

# SQL Query to find which age group has the highest sales
SELECT 
    CASE
        WHEN Age < 20 THEN 'Under 20'
        WHEN Age BETWEEN 20 AND 29 THEN '20-29'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60 and above'
    END AS Age_Group,
    ROUND(SUM(Total_sale), 2) AS Total_sales
FROM Retail_Db
GROUP BY Age_Group
ORDER BY Total_sales DESC;

# SQL to find which which month do each age group have the highest sales
SELECT 
    DATE_FORMAT(Sale_date, '%b %Y') AS Sale_month, 
    CASE
        WHEN Age < 20 THEN 'Under 20'
        WHEN Age BETWEEN 20 AND 29 THEN '20-29'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60 and above'
    END AS Age_Group,
    ROUND(SUM(Total_sale), 2) AS Total_sales
FROM Retail_Db
GROUP BY Sale_month, Age_Group
ORDER BY Sale_month, Total_sales DESC;

# SQl to find which age group has the highest sales in each category
SELECT 
    category,
    CASE            
        WHEN Age < 20 THEN 'Under 20'
        WHEN Age BETWEEN 20 AND 29 THEN '20-29'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60 and above'
    END AS Age_Group,
    ROUND(SUM(Total_sale), 2) AS Total_sales
FROM Retail_Db
GROUP BY category, Age_Group
ORDER BY category, Total_sales DESC;

