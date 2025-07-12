# Product Demand Forecasting & Sales Intelligence Dashboard

## Project Overview

This project is a comprehensive Sales Analytics & Forecasting solution designed to help businesses understand Sales using SQL-based data analysis, and interactive dashboarding and predict product demand using machine learning.

It includes:

- Exploratory data analysis and transformation using SQL
- Power BI Dashboard with actionable KPIs and DAX-driven insights.
- Product Demand Forecasting model using Python (Regression)


## Objective

- Analyze the sales and segement customers/products based on purchasing behavior.
- Predict future product demand (sales quantity) using historical data.
- Build a Power BI dashboard for real-time insights on sales performance.
- Enable data-driven pricing, stocking, and marketing decisions.

## Data Overview

#### Table: customers
  - customer_ID
  - DOB
  - Gender
  - City_code
#### Table: product_hierarchy
  - prod_cat_code
  - prod_cat
  - prod_sub_cat_code
  - prod_subcat
#### Table: transactions
  - transaction_id
  - cust_id
  - tran_date
  - prod_subcat_code
  - prod_cat_code
  - Qty
  - Rate
  - Tax
  - total_amt
  - Store_type

## Tools & Technologies

- Python (Pandas, Matplotlib, Seaborn, Scikit-learn,Numpy) for data cleaning, EDA, and modeling.
- SQL (MS SQL Server / PostgreSQL) for data aggregation, joins, and advanced filtering.
- Power BI for dynamic dashboards and executive-level visual insights
  
## SQL Data Analysis

Robust SQL queries were used to clean, transform, and aggregate raw transactional and reference data.
Key SQL Operations:
- Data Cleaning & Normalization
- Standardized inconsistent date formats using CAST, TRY_CAST, and string manipulation.
- Filtered out invalid transactions (e.g., zero or negative quantities in sales).
- Handled nulls and missing values for product and customer attributes.
- Derived standard columns
- Table Joins
- Customer and Product Aggregation
- Cohort Analysis Preparation

## Power BI Dashboard
An advanced Power BI dashboard was created to visualize key business metrics using dynamic DAX measures and visuals.

Key Features:
- Monthly Trends: Net sales & total transactions (line chart)
- Customer Segmentation: RFM, cohort analysis
- Pareto- Top Products Contributors
- Product Insights: Sales by category/subcategory, top contributors
- MoM Growth: Trend indicators for quantity/sales changes
- Conversion Analysis: Store-type level conversion efficiency
- Cohort Analysis: Customer retention trends over time

## Machine Learning – Product Demand Forecasting
Model: Supervised Regression (Random Forest)

#### Model Development Workflow:
 
#### Exploratory Data Analysis
#### Data Preparation
- Cleaned and preprocessed transactional records using Python.
- Filtered out returns (negative quantities).
- Handled missing values and inconsistent date formats.
- Created structured features like YearMonth, Avg_Selling_Price, Product_Label.
#### Feature Encoding
- Applied one-hot or label encoding to categorical variables like Store_Type, Product_Category, etc.
#### Model Bulding
- Train-Test Split
- Split the data into 80% training and 20% testing for evaluation.
- Modeling Techniques- RandomForest
#### Model Evaluation
- Measured using industry-standard metrics:
   - RMSE (Root Mean Square Error)
   - R² Score
#### Key Results
- Highly accurate regression model (R² > 0.9999) for demand prediction
- Business-ready dashboard highlighting sales drivers and trends

## Project Structure

- data/ # Raw and processed datasets
- notebooks/ # Jupyter notebooks for EDA and modeling
- scripts/ # Python scripts for cleaning and prediction
- powerbi/ # Power BI dashboard file (.pbix)
- outputs/ # Plots, reports, and metrics
- README.md # Project documentation

## Business Impact:

- Enables accurate forecasting of demand at the product and store level.
- Assists teams in stock planning, reducing overstock and stockouts.
- Informs pricing decisions and promotion targeting.
- Supports month-on-month sales planning and seasonality adjustment

## Potential Enhancements

- Add price sensitivity analysis (elasticity modeling)
- Integrate real-time data sources (APIs)
- Extend model for multi-step forecasting
- Incorporate promotions & seasonal flags
    
