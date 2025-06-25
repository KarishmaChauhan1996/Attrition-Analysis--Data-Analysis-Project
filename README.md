# Overview

This project is a comprehensive Sales Analytics & Forecasting solution designed to help businesses understand Sales using SQL-based data analysis, and interactive dashboarding and predict product demand using machine learning.

It includes:

- Exploratory data analysis and transformation using SQL
- Power BI Dashboard with actionable KPIs and DAX-driven insights.
- Product Demand Forecasting model using Python (Regression)


# Objective

- Analyze the sales and segement customers/products based on purchasing behavior.
- Predict future product demand (sales quantity) using historical data.
- Build a Power BI dashboard for real-time insights on sales performance.
- Enable data-driven pricing, stocking, and marketing decisions.

## Data

#### Table: customers
  - customer_ID
  - DOB
  - Gneder
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

### SQL Data Analysis

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

### Power BI Dashboard
An advanced Power BI dashboard was created to visualize key business metrics using dynamic DAX measures and visuals.

Key Features:
- Monthly Trends: Net sales & total transactions (line chart)
- Customer Segmentation: RFM, cohort analysis
- Pareto- Top Products Contributors
- Product Insights: Sales by category/subcategory, top contributors
- MoM Growth: Trend indicators for quantity/sales changes
- Conversion Analysis: Store-type level conversion efficiency
- Cohort Analysis: Customer retention trends over time

### Machine Learning – Product Demand Forecasting
Model: Supervised Regression (Random Forest)

### Model Development Workflow:
 
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
- Optionally used TimeSeriesSplit or GroupKFold to respect temporal structure.
- Modeling Techniques- RandomForest
#### Model Evaluation
- Measured using industry-standard metrics:
   - RMSE (Root Mean Square Error): 0.014
   - R² Score: 0.9999 (indicating excellent fit)

#### Business Impact:
- Enables accurate forecasting of demand at the product and store level.
- Assists teams in stock planning, reducing overstock and stockouts.
- Informs pricing decisions and promotion targeting.
- Supports month-on-month sales planning and seasonality adjustment
  
## Key Results

- Highly accurate regression model (R² > 0.9999) for demand prediction
- Business-ready dashboard highlighting sales drivers and trends

## Data




### Tools & Technologies

Python (Pandas, Matplotlib, Seaborn, Scikit-learn,Numpy) for data cleaning, EDA, and modeling

SQL (MS SQL Server / PostgreSQL) for data aggregation, joins, and advanced filtering

Power BI for dynamic dashboards and executive-level visual insights


### Steps Involved

- Data Preparation
- Features selection.
- A target variable attack_class was created in two different ways:
   - a. Binomial:

     0 → Normal

     1 → Attack
     
  - b. Multinomial:
  
     Normal

     Back

     Buffer Overflow

     FTP Write

     Guess Password

    Neptune

    Nmap

    Port Sweep

    Rootkit

    Satan

    Smurf

Python Analysis Highlights
Performed EDA to detect missing values, outliers, and class imbalance

Visualized attrition trends across variables using bar plots, box plots, and heatmaps

Built logistic regression and decision tree models to identify top predictors of attrition

🛢️ SQL Analysis Highlights
Used complex JOIN, CASE, and GROUP BY queries to:

Calculate attrition rate by department, role, education field, and satisfaction level

Identify performance patterns of employees who left vs stayed

Analyze travel frequency, overtime, and promotions in relation to attrition

📈 Power BI Dashboard
Interactive visuals to track:

Attrition by department, gender, job role

Comparison of satisfaction levels and attrition

Demographics and compensation breakdown

Filters by department, marital status, and age group

Executive summary cards showing KPIs like:

Total Employees, Attrition Rate, High-Risk Segments

🔍 Key Insights
Employees with low job satisfaction, frequent overtime, or few years since promotion are more likely to leave.

Sales and Human Resources departments have relatively higher attrition rates.

Younger employees and those with 1–2 years tenure are at higher risk.

Work-life balance and manager relationship scores are strong retention indicators.
#### Future Work
- Try advanced ensemble methods like XGBoost or LightGBM.

- Handle class imbalance (if needed) using SMOTE or class_weight.

- Tune hyperparameters using GridSearchCV for further optimization.
    
