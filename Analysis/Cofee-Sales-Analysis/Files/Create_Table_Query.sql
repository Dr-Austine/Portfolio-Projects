
-- ----------------------------------------
-- Coffee Sales Database Setup
-- ----------------------------------------

-- Drop the database if it exists
DROP DATABASE IF EXISTS coffee_sales_db;

-- Create new database
CREATE DATABASE coffee_sales_db;

-- Use the database
USE coffee_sales_db;

-- ----------------------------------------
-- 1️⃣ Cities Table
-- ----------------------------------------
CREATE TABLE cities (
    city_id INT PRIMARY KEY,
    city_name VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    population INT NOT NULL,
    avg_income_usd DECIMAL(10,2) NOT NULL,
    median_age INT NOT NULL,
    coffee_consumption_index DECIMAL(5,1) NOT NULL,
    num_competing_cafes INT NOT NULL,
    latitude DECIMAL(9,6) NOT NULL,
    longitude DECIMAL(9,6) NOT NULL
);


-- ----------------------------------------
-- 2️⃣ Stores Table
-- ----------------------------------------
CREATE TABLE stores (
    store_id INT PRIMARY KEY,
    city_id INT NOT NULL,
    store_name VARCHAR(150) NOT NULL,
    store_size_sqft INT NOT NULL,
    monthly_rent_usd DECIMAL(10,2) NOT NULL,
    employees INT NOT NULL,
    opening_date DATE NOT NULL,
    store_manager VARCHAR(100) NOT NULL,
    location VARCHAR(255) NOT NULL,
    contact CHAR(14) NOT NULL, -- fixed length phone number e.g., (123) 456-7890
    email VARCHAR(100) NOT NULL,
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);


-- ----------------------------------------
-- 3️⃣ Products Table
-- ----------------------------------------
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category ENUM('Coffee','Pastry') NOT NULL,
    price_usd DECIMAL(6,2) NOT NULL,
    cost_usd DECIMAL(6,2) NOT NULL,
    prep_time_seconds INT NOT NULL,
    calories INT NOT NULL,
    profit_usd DECIMAL(6,2) GENERATED ALWAYS AS (price_usd - cost_usd) STORED,
    margin_pct DECIMAL(5,2) GENERATED ALWAYS AS ((profit_usd / price_usd) * 100) STORED
);


-- ----------------------------------------
-- 4️⃣ Customers Table
-- ----------------------------------------
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    gender ENUM('Male','Female','Other') NOT NULL,
    age INT NOT NULL,
    city_id INT NOT NULL,
    signup_date DATE NOT NULL,
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);



-- ----------------------------------------
-- 5️⃣ Sales Table
-- ----------------------------------------
CREATE TABLE sales (
    order_id BIGINT PRIMARY KEY,
    order_datetime DATETIME NOT NULL,
    customer_id INT NOT NULL,
    store_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(6,2) NOT NULL,
    discount DECIMAL(6,2) DEFAULT 0.00,
    total_amount DECIMAL(8,2) NOT NULL,
    total_cost DECIMAL(8,2) NOT NULL,
    profit DECIMAL(8,2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
