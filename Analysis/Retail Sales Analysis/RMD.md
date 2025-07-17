---

# **Retail Sales Data Analysis Documentation**  

## **1. Executive Summary**  
This analysis explores sales data from `Retail_Db`, covering customer demographics, transaction trends, category performance, and time-based sales patterns. Key findings include top-selling categories, gender-based purchasing behavior, and peak sales periods.

---

## **2. Data Exploration & Cleaning**  

### **2.1. Initial Data Inspection**  
```sql
-- View sample records
SELECT * FROM Retail_Db LIMIT 10;

-- Count total records
SELECT COUNT(*) FROM Retail_Db;

-- Count unique customers
SELECT COUNT(DISTINCT Customer_id) FROM Retail_Db;
```
**Findings**:  
- Total records: [X]  
- Unique customers: [Y]  

### **2.2. Unique Categories**  
```sql
SELECT DISTINCT category FROM Retail_Db;
```
**Output**:  
- List of categories (e.g., Electronics, Clothing, Grocery).  

---

## **3. Sales Performance Analysis**  

### **3.1. Category-Level Insights**  
```sql
-- Total transactions per category
SELECT category, COUNT(*) AS Total_transactions 
FROM Retail_Db 
GROUP BY category 
ORDER BY Total_transactions DESC;

-- Total sales per category
SELECT category, ROUND(SUM(Total_sale), 2) AS Total_sales 
FROM Retail_Db 
GROUP BY category 
ORDER BY Total_sales DESC;

-- Average price per unit by category
SELECT category, ROUND(AVG(Price_per_unit), 2) AS Average_price_per_unit 
FROM Retail_Db 
GROUP BY category 
ORDER BY Average_price_per_unit DESC;
```
**Key Insights**:  
- Top category by sales: **[Category]** (₹[Amount]).  
- Highest average price: **[Category]** (₹[Price]).  

### **3.2. Customer Demographics**  
```sql
-- Gender distribution
SELECT Gender, COUNT(*) AS Total 
FROM Retail_Db 
GROUP BY Gender;

-- Sales by gender
SELECT Gender, ROUND(SUM(Total_sale), 2) AS Total_sales 
FROM Retail_Db 
GROUP BY Gender 
ORDER BY Total_sales DESC;

-- Age group analysis
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
```
**Findings**:  
- **[Gender]** contributes **[X]%** of total sales.  
- Top-spending age group: **[Age_Group]**.  

---

## **4. Time-Based Trends**  

### **4.1. Monthly Sales**  
```sql
-- Highest-performing months
SELECT DATE_FORMAT(Sale_date, '%b %Y') AS Sale_month, 
       ROUND(SUM(Total_sale), 2) AS Total_sales
FROM Retail_Db
GROUP BY Sale_month
ORDER BY Total_sales DESC
LIMIT 10;

-- Lowest-performing months
SELECT DATE_FORMAT(Sale_date, '%b %Y') AS Sale_month, 
       ROUND(SUM(Total_sale), 2) AS Total_sales
FROM Retail_Db
GROUP BY Sale_month
ORDER BY Total_sales ASC
LIMIT 10;
```
**Trends**:  
- Peak month: **[Month]** (₹[Amount]).  
- Lowest month: **[Month]** (₹[Amount]).  

### **4.2. Time-of-Day Analysis**  
```sql
-- Orders by shift (Morning/Afternoon/Evening)
SELECT
    CASE
        WHEN HOUR(Sale_time) < 12 THEN 'Morning'
        WHEN HOUR(Sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS Shift,
    COUNT(*) AS Total_orders
FROM Retail_Db
GROUP BY Shift;
```
**Insight**:  
- Most orders occur during **[Shift]**.  

---

## **5. Customer Segmentation**  

### **5.1. Category Preferences by Age/Gender**  
```sql
-- Age group sales per category
SELECT 
    category,
    CASE
        WHEN Age < 20 THEN 'Under 20'
        -- ... (other age groups)
    END AS Age_Group,
    ROUND(SUM(Total_sale), 2) AS Total_sales
FROM Retail_Db
GROUP BY category, Age_Group
ORDER BY category, Total_sales DESC;

-- Gender-wise category preferences
SELECT Gender, category, ROUND(SUM(Total_sale), 2) AS Total_sales
FROM Retail_Db
GROUP BY Gender, category
ORDER BY Total_sales DESC;
```
**Findings**:  
- **[Age_Group]** prefers **[Category]**.  
- **[Gender]** spends most on **[Category]**.  

### **5.2. Top Customers**  
```sql
-- Top 5 customers by sales
SELECT Customer_id, category, ROUND(SUM(Total_sale), 2) AS Total_sales
FROM Retail_Db
GROUP BY Customer_id, category
ORDER BY Total_sales DESC
LIMIT 5;
```
**Actionable**: Target high-value customers with loyalty programs.  

---

## **6. Appendix: Full Queries**  
All SQL queries used are listed above for reproducibility.  

---

