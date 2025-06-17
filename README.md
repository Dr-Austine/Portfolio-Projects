# 🌍 Global Business & Risk Analytics Portfolio
**Data-driven insights for finance, insurance, and geopolitical risk analysis**  
*Leveraging Python, SQL, and BI tools to quantify business performance under global uncertainties*

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=flat&logo=linkedin)](https://www.linkedin.com/in/yourprofile)  [![Tableau](https://img.shields.io/badge/📊_Tableau-Visualize-orange?style=flat&logo=tableau)](https://public.tableau.com/app/profile/austine.njuga/vizzes)

📧 **Email**: austinenjoroge29@gmail.comm  

---

## 📌 **Key Focus Areas**
| **Domain**               | **Analysis Scope**                          | **Tools Used**              |
|--------------------------|--------------------------------------------|-----------------------------|
| **Business Analytics**   | Sales trends, Market share, ROI            | Python (Pandas, Plotly), Power BI |
| **Financial Risk**       | Portfolio stress-testing, Credit risk      | R (quantmod), SQL, Excel   |
| **Insurance Modeling**   | Claims forecasting, Mortality correlation  | Python (lifelines, scikit-learn) |
| **Global Risk Factors**  | War/death toll impact on markets           | Geopandas, Tableau         |
| **Catastrophe Modeling** | Natural disasters & business continuity    | GIS tools, Monte Carlo sim |

---

## 🗂 **Featured Projects**

### 1. [Pandemic Impact on Retail Sales](projects/retail_covid)  
**Tools**:  
- **Microsoft Access** (Data warehousing)  
- **Excel** (PivotTables, Scenario Manager)  
- **Power BI** (Dynamic dashboards)

**Code Example**:
```python
import pandas as pd
# Merge COVID deaths with retail sales
sales = pd.read_excel("retail_sales.xlsx", sheet_name="Monthly")
deaths = pd.read_sql("SELECT date, deaths FROM covid_data", access_conn)
merged = sales.merge(deaths, on="date")
merged["sales_change"] = merged["revenue"].pct_change()
print(merged.corr()[["deaths", "sales_change"]])
```

---

### 2. [Insurance Claims During Global Crises](projects/insurance_claims)  
**Tools**:  
- **PostgreSQL** (Claims data warehouse)  
- **GeoPandas** (Spatial joins & mapping)  
- **Matplotlib** (Conflict overlay maps)

**Code Example**:
```python
import geopandas as gpd
# Analyze claims spikes in conflict zones
war_zones = gpd.read_file("conflict_data.geojson")
merged_data = insurance_claims.merge(war_zones, on="country_code")
print(merged_data.groupby("conflict_intensity")["claim_amount"].mean())
```






