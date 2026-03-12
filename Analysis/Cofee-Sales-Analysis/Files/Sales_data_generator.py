# ---------------------------------------------
# ☕ Advanced Coffee Retail Dataset Generator
# Designed for SQL / Power BI / Data Analysis
# ---------------------------------------------

# 1️⃣ Import libraries
import pandas as pd
import numpy as np
from faker import Faker
from datetime import datetime, timedelta
import random
from IPython.display import display

# 2️⃣ Initialize Faker and seeds
fake = Faker()
Faker.seed(42)
random.seed(42)
np.random.seed(42)

# ------------------------------------------------
# 3️⃣ Cities Table (Market + Demographics)
# ------------------------------------------------
num_cities = 25

cities = pd.DataFrame({
    "city_id": range(1, num_cities + 1),
    "city_name": [fake.city() for _ in range(num_cities)],
    "state": [fake.state() for _ in range(num_cities)],
    "country": ["USA"] * num_cities,
    "population": np.random.randint(120000, 1500000, num_cities),
    "avg_income_usd": np.random.randint(35000, 95000, num_cities),
    "median_age": np.random.randint(25, 45, num_cities),
    "coffee_consumption_index": np.random.uniform(70,120,num_cities).round(1),
    "num_competing_cafes": np.random.randint(30,400,num_cities),
    "latitude":[fake.latitude() for _ in range(num_cities)],
    "longitude":[fake.longitude() for _ in range(num_cities)]
})

# ------------------------------------------------
# 4️⃣ Stores Table
# ------------------------------------------------
stores_list = []
store_id = 1

for _, row in cities.iterrows():

    num_stores_city = random.randint(3,8)

    for _ in range(num_stores_city):

        manager = fake.name()

        stores_list.append({
            "store_id": store_id,
            "city_id": row["city_id"],
            "store_name": f"{row['city_name']} Cafe {store_id}",
            "store_size_sqft": random.randint(900,1600),
            "monthly_rent_usd": random.randint(3000,7500),
            "employees": random.randint(6,14),
            "opening_date": fake.date_between("-3y","today"),
            "store_manager": manager,
            "location": fake.address().replace("\n",", "),
            "contact": fake.phone_number(),
            "email": manager.lower().replace(" ",".") + "@coffeeco.com"
        })

        store_id += 1

stores = pd.DataFrame(stores_list)

# ------------------------------------------------
# 5️⃣ Products Table (Menu Analytics)
# ------------------------------------------------
import pandas as pd

# 2026 "High-Accuracy" Product Database
products = pd.DataFrame({
    "product_id": range(1, 26),
    "product_name": [
        "Espresso", "Drip Coffee", "Americano", "Cappuccino", "Latte", 
        "Mocha", "Cold Brew", "Flat White", "Nitro Cold Brew", "Caramel Macchiato",
        "Matcha Latte", "Chai Tea Latte", "Iced Green Tea", "Strawberry Refresher", "Mango Dragonfruit Refresher",
        "Pumpkin Spice Latte", "Peppermint Mocha", "Java Chip Frappuccino", "Vanilla Bean Crème",
        "Butter Croissant", "Blueberry Muffin", "Banana Bread", "Chocolate Chunk Cookie",
        "Bacon & Gouda Sandwich", "Spinach & Feta Wrap"
    ],
    "category": [
        "Coffee", "Coffee", "Coffee", "Coffee", "Coffee", 
        "Coffee", "Coffee", "Coffee", "Coffee", "Coffee",
        "Tea", "Tea", "Tea", "Refresher", "Refresher",
        "Seasonal", "Seasonal", "Blended", "Blended",
        "Pastry", "Pastry", "Pastry", "Pastry",
        "Breakfast", "Breakfast"
    ],
    # Prices reflect 2026 US National Averages
    "price_usd": [
        3.75, 3.85, 4.25, 5.45, 5.95, 
        6.25, 5.75, 5.50, 6.50, 6.45,
        5.95, 5.75, 4.25, 5.50, 5.75,
        6.95, 6.95, 6.75, 5.95,
        4.25, 4.50, 4.25, 3.75,
        7.25, 6.95
    ],
    # Costs including beans, dairy/alternatives, and packaging
    "cost_usd": [
        0.95, 0.85, 1.10, 1.95, 2.10, 
        2.40, 2.00, 2.05, 2.25, 2.45,
        1.85, 1.70, 0.95, 1.45, 1.55,
        2.75, 2.85, 2.40, 2.15,
        1.45, 1.40, 1.30, 1.15,
        3.15, 2.85
    ],
    "prep_time_seconds": [
        45, 30, 50, 90, 100, 
        110, 40, 95, 45, 120,
        105, 95, 60, 75, 75,
        130, 130, 150, 140,
        30, 30, 30, 20,
        180, 160
    ],
    "calories": [
        5, 5, 15, 140, 190, 
        360, 5, 170, 5, 250,
        240, 240, 80, 100, 130,
        390, 440, 440, 380,
        260, 410, 420, 310,
        370, 290
    ]
})

# Financial Performance Metrics
products["profit_usd"] = products["price_usd"] - products["cost_usd"]
products["margin_pct"] = ((products["profit_usd"] / products["price_usd"]) * 100).round(2)

# Quick Analysis: Sort by most profitable item
print(products.sort_values(by="profit_usd", ascending=False).head(5))


# ------------------------------------------------
# 6️⃣ Customers Table
# ------------------------------------------------
num_customers = 44300

customers = pd.DataFrame({
    "customer_id": range(10001,10001+num_customers),
    "first_name":[fake.first_name() for _ in range(num_customers)],
    "last_name":[fake.last_name() for _ in range(num_customers)],
    "email":[fake.email() for _ in range(num_customers)],
    "gender":np.random.choice(["Male","Female","Other"], num_customers, p=[0.48,0.48,0.04]),
    "age":np.random.randint(18,70,num_customers),
    "city_id":np.random.choice(cities["city_id"], num_customers),
    "signup_date":[fake.date_between("-3y","today") for _ in range(num_customers)]
})

# ------------------------------------------------
# 7️⃣ Sales Table (Fact Table)
# ------------------------------------------------
num_sales = 869257

store_ids = stores["store_id"].tolist()
product_ids = products["product_id"].tolist()
customer_ids = customers["customer_id"].tolist()

sales_rows = []

start_date = datetime(2022,1,1)
end_date = datetime(2025,12,31)
days_range = (end_date - start_date).days

for i in range(num_sales):

    order_id = 1000000 + i
    order_datetime = start_date + timedelta(days=random.randint(0,days_range))

    hour = np.random.choice(
        [7,8,9,10,11,12,13,14,15,16,17,18],
        p=[0.05,0.12,0.15,0.08,0.07,0.10,0.10,0.08,0.06,0.06,0.08,0.05]
    )

    order_datetime = order_datetime.replace(hour=hour, minute=random.randint(0,59))

    customer_id = random.choice(customer_ids)
    store_id = random.choice(store_ids)

    product_id = random.choice(product_ids)
    product = products.loc[products.product_id==product_id].iloc[0]

    quantity = np.random.choice([1,2,3], p=[0.75,0.20,0.05])
    unit_price = product["price_usd"]
    cost = product["cost_usd"]

    discount = 0
    if random.random() < 0.05:
        discount = round(unit_price * 0.1,2)

    total_amount = round((unit_price * quantity) - discount,2)
    total_cost = round(cost * quantity,2)
    profit = round(total_amount - total_cost,2)

    sales_rows.append([
        order_id,
        order_datetime,
        customer_id,
        store_id,
        product_id,
        quantity,
        unit_price,
        discount,
        total_amount,
        total_cost,
        profit
    ])

sales = pd.DataFrame(
    sales_rows,
    columns=[
        "order_id",
        "order_datetime",
        "customer_id",
        "store_id",
        "product_id",
        "quantity",
        "unit_price",
        "discount",
        "total_amount",
        "total_cost",
        "profit"
    ]
)

# ------------------------------------------------
# 8️⃣ Time Analytics Columns
# ------------------------------------------------
sales["year"] = sales["order_datetime"].dt.year
sales["month"] = sales["order_datetime"].dt.month
sales["month_name"] = sales["order_datetime"].dt.month_name()
sales["day_of_week"] = sales["order_datetime"].dt.day_name()
sales["hour"] = sales["order_datetime"].dt.hour
sales["is_weekend"] = sales["day_of_week"].isin(["Saturday","Sunday"])

# ------------------------------------------------
# 9️⃣ Save CSV files
# ------------------------------------------------
cities.to_csv("coffee_cities.csv", index=False)
stores.to_csv("coffee_stores.csv", index=False)
products.to_csv("coffee_products.csv", index=False)
customers.to_csv("coffee_customers.csv", index=False)
sales.to_csv("coffee_sales_100k.csv", index=False)

# ------------------------------------------------
# 🔟 Starter Analysis
# ------------------------------------------------

print("Dataset Sizes")
print("Cities:",cities.shape)
print("Stores:",stores.shape)
print("Products:",products.shape)
print("Customers:",customers.shape)
print("Sales:",sales.shape)

# ------------------------------------------------
# Revenue by City
# ------------------------------------------------
city_sales = (
    sales
    .merge(stores[["store_id","city_id"]], on="store_id")
    .merge(cities[["city_id","city_name"]], on="city_id")
    .groupby("city_name")["total_amount"]
    .sum()
    .sort_values(ascending=False)
)

print("\nTop Cities by Revenue")
display(city_sales.head(10))

# ------------------------------------------------
# Top Products
# ------------------------------------------------
product_sales = (
    sales
    .merge(products[["product_id","product_name"]], on="product_id")
    .groupby("product_name")["quantity"]
    .sum()
    .sort_values(ascending=False)
)

print("\nTop Selling Products")
display(product_sales.head(10))

# ------------------------------------------------
# Store Performance
# ------------------------------------------------
store_sales = (
    sales.groupby("store_id")[["total_amount","profit"]]
    .sum()
    .sort_values("total_amount",ascending=False)
)

print("\nTop Stores by Revenue")
display(store_sales.head(10))
