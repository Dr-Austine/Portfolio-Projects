

# 🌦️ Kenya Live Weather Dashboard

A real-time weather analytics dashboard built using **Power BI** and integrated with **WeatherAPI**.  
The dashboard provides live weather updates, 7-day forecasts, and air quality insights for major Kenyan cities with automatic data refresh.

![Dashboard Preview](images/dashboard-preview.png)

---

## 📌 Overview

This project demonstrates end-to-end data integration, transformation, and visualization using real-time API data in Power BI.

It focuses on:
- API integration and automation in Power BI
- JSON data extraction and transformation using Power Query
- Data modeling and relationship design
- Dynamic dashboards with DAX-based logic
- Scheduled refresh and cloud publishing via Power BI Service

---

## 📊 Key Features

- 🌍 Real-time weather updates for 5 Kenyan cities  
- 📅 7-day weather forecast visualization  
- 🌬️ Air quality monitoring (CO, PM10, O3, NO2)  
- 🌡️ Current conditions (temperature, humidity, wind speed, visibility)  
- 🌅 Sunrise and sunset tracking  
- ⚠️ Dynamic status indicators (Good / Moderate / Unhealthy)  
- 🎛️ Interactive city-based filtering  

---

## 🗺️ Cities Covered

| City     | County   |
|----------|----------|
| Nairobi  | Nairobi  |
| Mombasa  | Mombasa  |
| Machakos | Machakos |
| Kiambu   | Kiambu   |
| Kajiado  | Kajiado  |

---

## 🧰 Tech Stack

| Tool | Purpose |
|------|--------|
| Power BI Desktop | Dashboard development |
| Power Query | API integration & data transformation |
| DAX | Calculations & conditional logic |
| WeatherAPI | Live weather data source |
| Power BI Service | Publishing & scheduled refresh |

---

## 🔌 Data Source

**WeatherAPI.com** (Free Tier)

- Current weather data  
- 3-day to 7-day forecasts  
- Air quality metrics  
- Sunrise & sunset information  

### API Endpoints Used

```text
Current Weather:
https://api.weatherapi.com/v1/current.json?key={API_KEY}&q={city}

Forecast Weather:
https://api.weatherapi.com/v1/forecast.json?key={API_KEY}&q={city}&days=3
````

---

## ⚙️ How It Works

1. Connect Power BI to WeatherAPI using Web connector
2. Parse and transform JSON responses in Power Query
3. Create separate tables for current weather, forecast, and location data
4. Build relationships between tables for modeling
5. Develop interactive visuals and KPIs using DAX
6. Publish to Power BI Service and enable scheduled refresh

---

## 📐 Data Model

| Table    | Relationship | Key Field |
| -------- | ------------ | --------- |
| Location | Current      | city_name |
| Location | Forecast     | city_name |

---

## 📊 DAX Measures (Examples)

```dax
Current Temperature = SUM(current[temp_c])

PM10 Status Color =
SWITCH(TRUE(),
    SUM(forecast[pm10]) > 300, "Red",
    SUM(forecast[pm10]) > 100, "Orange",
    "Green"
)

Air Quality Status =
SWITCH(TRUE(),
    SUM(forecast[pm10]) > 300, "Unhealthy",
    SUM(forecast[pm10]) > 100, "Moderate",
    "Good"
)
```

---

## 📁 Project Structure

```text
kenya-weather-dashboard/
│
├── kenya_weather_dashboard.pbix
├── README.md
│
├── images/
│   └── dashboard-preview.png
│
└── assets/
    └── background.png
```

---

## 🚀 Future Improvements

* Expand to more Kenyan cities (Kisumu, Nakuru, Eldoret)
* Add historical weather trend analysis
* Integrate map-based visualizations
* Include weather alerts and notifications
* Enhance forecasting analytics with time series models

---

## 📄 License

This project is for educational and portfolio purposes only.
Weather data is provided under WeatherAPI terms of service.

---

## 👨‍💻 Author

Built by **Austine Njoroge Njuga**
Data Analyst | Business Intelligence | Actuarial Science Student

```

