
# ☕ Coffee Retail Analytics Dataset Generator

A **realistic synthetic coffee shop dataset generator** designed for **data analytics, SQL practice, and business intelligence projects**.

This project generates a **complete retail dataset** including cities, stores, products, customers, and transactions. The dataset is structured similarly to a **real-world retail data warehouse** and is ideal for **Power BI, Tableau, SQL analysis, and data science experiments**.

---

# 📊 Project Overview

The script generates a **fully relational dataset** simulating a coffee retail chain operating across multiple cities.

The dataset includes:

* **Cities (market data)**
* **Stores (store operations)**
* **Products (menu and profitability)**
* **Customers (demographics)**
* **Sales transactions (fact table)**

The goal is to simulate a dataset that supports realistic **business analytics scenarios**, such as:

* revenue analysis
* product performance
* store profitability
* customer demographics
* operational insights

---

# 🏗 Dataset Architecture

The data follows a **star schema commonly used in analytics warehouses**.

```
Cities
   │
   │
Stores
   │
   │
Sales  ← Fact Table
   │
   │
Products

Customers
```

### Fact Table

* **Sales**

### Dimension Tables

* Cities
* Stores
* Products
* Customers

This structure is compatible with:

* SQL data warehouses
* Power BI
* Tableau
* dbt models
* machine learning pipelines

---

# 📂 Generated Tables

## Cities

Market-level information about where stores operate.

Columns include:

* `city_id`
* `city_name`
* `state`
* `country`
* `population`
* `avg_income_usd`
* `median_age`
* `coffee_consumption_index`
* `num_competing_cafes`
* `latitude`
* `longitude`

Example use cases:

* market potential analysis
* revenue vs population analysis
* sales vs income correlations

---

# 🏪 Stores

Information about individual store locations.

Columns include:

* `store_id`
* `city_id`
* `store_name`
* `store_size_sqft`
* `monthly_rent_usd`
* `employees`
* `opening_date`
* `store_manager`
* `location`
* `contact`
* `email`

Example analysis:

* revenue per store
* revenue per square foot
* rent vs store performance
* store manager performance

---

# ☕ Products

Coffee menu items and pastries.

Columns include:

* `product_id`
* `product_name`
* `category`
* `price_usd`
* `cost_usd`
* `prep_time_seconds`
* `calories`
* `profit_usd`
* `margin_pct`

Example analysis:

* product profitability
* top selling menu items
* category performance
* margin optimization

---

# 👥 Customers

Simulated customer demographic data.

Columns include:

* `customer_id`
* `first_name`
* `last_name`
* `email`
* `gender`
* `age`
* `city_id`
* `signup_date`

Example analysis:

* customer demographics
* city-based customer distribution
* signup trends

---

# 💰 Sales (Fact Table)

The central **transaction table** containing purchase records.

Columns include:

* `order_id`
* `order_datetime`
* `customer_id`
* `store_id`
* `product_id`
* `quantity`
* `unit_price`
* `discount`
* `total_amount`
* `total_cost`
* `profit`

Derived analytics fields:

* `year`
* `month`
* `month_name`
* `day_of_week`
* `hour`
* `is_weekend`

Example analysis:

* peak sales hours
* weekend vs weekday revenue
* seasonal trends
* store profitability

---

# 📈 Example Analytics Questions

This dataset supports many business questions such as:

### Sales Analysis

* What cities generate the most revenue?
* What are the top selling products?
* What is the monthly revenue trend?

### Store Performance

* Which stores generate the highest revenue?
* Which stores have the best profit margins?
* Revenue per square foot analysis

### Product Analytics

* Which products generate the highest profit?
* Which menu items sell the most?
* Coffee vs pastry revenue contribution

### Customer Insights

* Customer age distribution
* Gender distribution
* Customer signup trends

### Operational Insights

* Peak sales hours
* Weekend vs weekday traffic
* Seasonal demand patterns

---

# 📦 Dataset Size

Default configuration generates approximately:

| Table     | Rows    |
| --------- | ------- |
| Cities    | 25      |
| Stores    | 100–180 |
| Products  | 10      |
| Customers | 10,000  |
| Sales     | 100,000 |

The dataset size is **large enough for realistic analysis but small enough to run locally**.

---

# ⚙️ How to Run

Install dependencies:

```
pip install pandas numpy faker
```

Run the script:

```
python coffee_dataset_generator.py
```

Generated CSV files:

```
coffee_cities.csv
coffee_stores.csv
coffee_products.csv
coffee_customers.csv
coffee_sales_100k.csv
```

---

# 🧠 Recommended Use Cases

This dataset is useful for:

### Data Analyst Portfolios

* SQL analytics projects
* Power BI dashboards
* Tableau dashboards

### Data Engineering Practice

* ETL pipelines
* data warehouse modeling
* dbt transformations

### Data Science

* demand forecasting
* customer segmentation
* product recommendation models

---

# 📊 Example Dashboard Ideas

You can build dashboards such as:

**Executive Sales Dashboard**

* revenue by city
* revenue by store
* profit trends

**Product Performance Dashboard**

* top selling products
* product margins
* category revenue

**Store Operations Dashboard**

* peak hours
* store performance
* staffing analysis

---

# 🚀 Future Improvements

Possible extensions:

* employee table
* inventory tracking
* supplier dataset
* marketing campaigns
* promotions and discounts
* loyalty program data

These additions would further simulate a **full enterprise retail analytics environment**.

---

# 📜 License

This project is open-source and intended for **educational and portfolio use**.

---

If you'd like, I can also show you **3 extremely impressive upgrades** that would make this project look like a **senior-level analytics portfolio project** (the kind that gets attention from recruiters).
