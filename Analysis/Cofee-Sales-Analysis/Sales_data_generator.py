# ---------------------------------------------
# ☕ Complete Coffee Sales Data Generator & Starter Analysis
# ---------------------------------------------

# 1️⃣ Import libraries
import pandas as pd
import numpy as np
from faker import Faker
from datetime import datetime, timedelta
import random
from IPython.display import display

# 2️⃣ Initialize Faker and random seeds
fake = Faker()
Faker.seed(42)
random.seed(42)
np.random.seed(42)

# ----------------------------
# 3️⃣ Generate Cities table
# ----------------------------
num_cities = 25
cities = pd.DataFrame({
    'city_id': range(1,num_cities+1),
    'city_name': [fake.city() for _ in range(num_cities)],
    'population': np.random.randint(100_000, 1_500_000, size=num_cities)
})

# ----------------------------
# 4️⃣ Generate Stores table
# ----------------------------
stores_list = []
store_id = 1
for idx, row in cities.iterrows():
    num_stores_city = random.randint(3,8)  # Multiple stores per city
    for _ in range(num_stores_city):
        stores_list.append({
            'store_id': store_id,
            'city_id': row['city_id'],
            'store_name': f"{row['city_name']} Cafe {store_id}",
            'store_size_sqft': random.randint(800,1500),
            'monthly_rent_usd': random.randint(2500,7000),
            'opening_date': fake.date_between(start_date='-3y', end_date='today')
        })
        store_id += 1
stores = pd.DataFrame(stores_list)

# ----------------------------
# 5️⃣ Generate Products table
# ----------------------------
products = pd.DataFrame({
    'product_id': range(1,11),
    'product_name':['Espresso','Drip Coffee','Americano','Cappuccino','Latte','Mocha','Cold Brew','Croissant','Blueberry Muffin','Banana Bread'],
    'category':['Coffee','Coffee','Coffee','Coffee','Coffee','Coffee','Coffee','Pastry','Pastry','Pastry'],
    'price_usd':[3.0,3.0,3.5,5.0,5.5,5.75,5.25,4.0,3.75,3.5],
    'cost_usd':[0.8,0.7,0.9,1.6,1.8,2.0,1.7,1.2,1.1,1.0]
})

# ----------------------------
# 6️⃣ Generate Customers table
# ----------------------------
num_customers = 10000
customers = pd.DataFrame({
    'customer_id': range(10001,10001+num_customers),
    'first_name': [fake.first_name() for _ in range(num_customers)],
    'last_name': [fake.last_name() for _ in range(num_customers)],
    'email': [fake.email() for _ in range(num_customers)],
    'gender': np.random.choice(['Male','Female','Other'], size=num_customers, p=[0.48,0.48,0.04]),
    'age': np.random.randint(18,70,size=num_customers),
    'city_id': np.random.choice(cities['city_id'], size=num_customers),
    'signup_date': [fake.date_between(start_date='-3y', end_date='today') for _ in range(num_customers)]
})

# ----------------------------
# 7️⃣ Generate Sales table
# ----------------------------
num_sales = 100000
sales_rows = []

store_ids = stores['store_id'].tolist()
product_ids = products['product_id'].tolist()
customer_ids = customers['customer_id'].tolist()

start_date = datetime(2024,1,1)
end_date = datetime(2024,12,31)
days_range = (end_date - start_date).days

for i in range(num_sales):
    order_id = 1000000 + i
    order_date = start_date + timedelta(days=random.randint(0,days_range))
    
    # FIXED: Realistic order times with probabilities that sum to 1
    hour = np.random.choice([7,8,9,10,11,12,13,14,15,16,17,18],
                            p=[0.06, 0.10, 0.12, 0.08, 0.06, 0.10, 0.10, 0.08, 0.06, 0.06, 0.10, 0.08])
    minute = random.randint(0,59)
    order_time = f"{hour:02d}:{minute:02d}"
    
    customer_id = random.choice(customer_ids)
    store_id = random.choice(store_ids)
    product_id = random.choice(product_ids)
    product = products.loc[products['product_id']==product_id].iloc[0]
    unit_price = product['price_usd']
    quantity = np.random.choice([1,2,3], p=[0.75,0.2,0.05])
    discount = 0
    if random.random() < 0.05:  # 5% chance of discount
        discount = round(unit_price * 0.1, 2)
    total_amount = round((unit_price * quantity) - discount, 2)
    
    sales_rows.append([order_id, order_date.date(), order_time, customer_id, store_id, product_id, quantity, unit_price, discount, total_amount])

sales = pd.DataFrame(sales_rows, columns=['order_id','order_date','order_time','customer_id','store_id','product_id','quantity','unit_price','discount','total_amount'])
# ----------------------------
# 8️⃣ Save tables to CSV (optional)
# ----------------------------
cities.to_csv('coffee_cities_realistic.csv', index=False)
stores.to_csv('coffee_stores_realistic.csv', index=False)
products.to_csv('coffee_products_realistic.csv', index=False)
customers.to_csv('coffee_customers_realistic.csv', index=False)
sales.to_csv('coffee_sales_realistic_100k.csv', index=False)

# ----------------------------
# 9️⃣ Quick Insights / Starter Analysis
# ----------------------------

print("Table Shapes (rows x columns):")
print("Cities:", cities.shape)
print("Stores:", stores.shape)
print("Products:", products.shape)
print("Customers:", customers.shape)
print("Sales:", sales.shape)
print("\n")

print("Preview Cities:")
display(cities.head())

print("Preview Stores:")
display(stores.head())

print("Preview Products:")
display(products.head())

print("Preview Customers:")
display(customers.head())

print("Preview Sales:")
display(sales.head())

# ----------------------------
# 10️⃣ Basic summaries
# ----------------------------
print("City populations (sorted):")
display(cities[['city_name','population']].sort_values(by='population', ascending=False))

print("Number of stores per city:")
stores_count = stores.groupby('city_id').size().reset_index(name='num_stores')
stores_count = stores_count.merge(cities[['city_id','city_name']], on='city_id')
display(stores_count.sort_values(by='num_stores', ascending=False))

print("Top 10 products by price:")
display(products.sort_values(by='price_usd', ascending=False).head(10))

print("Customer age distribution:")
display(customers['age'].describe())

print("Customer gender distribution:")
display(customers['gender'].value_counts())

# ----------------------------
# 11️⃣ Top 10 cities by total sales
# ----------------------------
sales_with_stores = sales.merge(stores[['store_id','city_id']], on='store_id')
sales_with_cities = sales_with_stores.merge(cities[['city_id','city_name']], on='city_id')
city_sales = sales_with_cities.groupby('city_name')['total_amount'].sum().reset_index()
city_sales = city_sales.sort_values(by='total_amount', ascending=False)
print("Top 10 cities by total sales:")
display(city_sales.head(10))

# ----------------------------
# 12️⃣ Top 10 products by quantity sold
# ----------------------------
sales_with_products = sales.merge(products[['product_id','product_name']], on='product_id')
product_sales = sales_with_products.groupby('product_name')['quantity'].sum().reset_index()
product_sales = product_sales.sort_values(by='quantity', ascending=False)
print("Top 10 products by quantity sold:")
display(product_sales.head(10))
