-- Total Revenue generated
SELECT ROUND(SUM(total_price),2) AS Total_Revenue FROM pizza_sales_excel_file

-- Average Amount Spent per order
SELECT ROUND(SUM(total_price)/COUNT(DISTINCT order_id),2) FROM pizza_sales_excel_file

-- Total Pizza Sold
SELECT SUM(quantity) AS Total_Pizza_Sold FROM pizza_sales_excel_file

-- Total Orders placed
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales_excel_file

-- Average Pizzas per Order
SELECT CAST(
CAST(SUM(quantity) AS DECIMAL(10,2))/
CAST(COUNT(DISTINCT order_id)AS DECIMAL(10,2))  AS DECIMAL(10,2)) as Avg_Pizzas_Ordered
FROM pizza_sales_excel_file

-- Daily Trend for Total Orders
SELECT 
	DATENAME( DW, order_date) as order_day,
	COUNT ( DISTINCT order_id) as Total_orders
FROM pizza_sales_excel_file
GROUP BY  DATENAME( DW, order_date)

-- Monthly Trend for Total Orders
SELECT 
	DATENAME(MONTH, order_date) AS Monthly_Name, 
	COUNT(DISTINCT order_id) as Total_orders
FROM pizza_sales_excel_file
GROUP BY  DATENAME(MONTH, order_date)
ORDER BY Total_orders DESC

-- Percentage of Sales by Pizza Category
SELECT
    pizza_category,
	ROUND(SUM(total_price),2) as Total_Sales,
    ROUND(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales_excel_file), 2) AS Per_Sales
FROM
  pizza_sales_excel_file
GROUP BY
    pizza_category;

-- Percentage of Sales by Pizza Category in January
SELECT
    pizza_category,
    ROUND(SUM(total_price), 2) AS Total_Sales,
    ROUND(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales_excel_file WHERE MONTH(order_date) = 1), 2) AS Per_Sales
FROM
    pizza_sales_excel_file
WHERE
    MONTH(order_date) = 1
GROUP BY
    pizza_category;



-- Percentage of Sales by Pizza Size
SELECT
    pizza_size,
	ROUND(SUM(total_price),2) as Total_Sales,
    ROUND(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales_excel_file), 2) AS Per_Sales
FROM pizza_sales_excel_file
GROUP BY pizza_size
ORDER BY Per_Sales DESC

-- Percentage of Sales by Pizza Size in January
SELECT
    pizza_size,
    ROUND(SUM(total_price), 2) AS Total_Sales,
    ROUND(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales_excel_file WHERE  DATEPART(QUARTER,order_date) = 1), 2) AS Per_Sales
FROM  pizza_sales_excel_file
WHERE   DATEPART(QUARTER,order_date) = 1
GROUP BY  pizza_size
ORDER BY Per_Sales desc


-- Total Pizza Sold by Pizza Category
SELECT
pizza_category, SUM (quantity) AS Total_Quantity_Sold FROM pizza_sales_excel_file
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC

-- Top 5 Pizzas by Revenue
SELECT Top 5
pizza_name, ROUND(SUM(total_price),2) AS Total_Revenue
FROM pizza_sales_excel_file
GROUP BY pizza_name
ORDER BY Total_Revenue DESC

-- Bottom 5 Pizzas by Revenue
SELECT Top 5
pizza_name, ROUND(SUM(total_price),2) AS Total_Revenue
FROM pizza_sales_excel_file
GROUP BY pizza_name
ORDER BY Total_Revenue ASC

-- Top 5 Pizzas by Quantity
SELECT Top 5
pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales_excel_file
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC

-- Bottom 5 Pizzas by Quantity
SELECT TOP 5 
pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales_excel_file
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC

-- Top 5 Pizzas by Total Orders
SELECT Top 5 
pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales_excel_file
GROUP BY pizza_name
ORDER BY Total_Orders DESC

--Bottom 5 Pizzas by Total Orders
SELECT Top 5 
pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales_excel_file
GROUP BY pizza_name
ORDER BY Total_Orders ASC
