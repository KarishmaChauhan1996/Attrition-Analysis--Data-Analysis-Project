# Overview

This project aims to analyze employee attrition patterns and uncover key drivers of turnover within an organization. We used a combination of Python, SQL, and Power BI to explore and visualize data from various dimensions such as demographics, job roles, satisfaction scores, and compensation details.


# Objective

The objective of project is to build network intrusion detection system to detect anomalies and attacks in the network. 

There are two problems: 
- Binomial classification: Detect anomalies by predicting Activity is normal or attack.
- Multinomial Classification: Detecting type of activity by predicting Activity is Normal or Back or Buffer Over flow or FTP Write or Guess Password or Neptune or N-Map or Port Sweep or Root Kit or Satan or Smurf.

## Key Questions Addressed

What are the most common attributes of employees who left the company?

Which departments and job roles experience the highest attrition?

How does job satisfaction or work-life balance influence attrition?

What is the impact of overtime, salary hike, or manager satisfaction on attrition?

How does attrition vary across different demographics like age, gender, and education?

### Table of Contents

Data

Usage

Methodology

Models Used

Evaluation Metrics

Results

Conclusion

### Data

We have following tables with columns:

### df_attrition 
EmployeeNumber
Attrition

### df_employee_info 
EmployeeNumber	
Age	
Education	
EducationField	
Gender	
MaritalStatus	
Over18

### df_job_satisfaction 
EmployeeNumber	
EnvironmentSatisfaction	
JobInvolvement	
JobSatisfaction	
Manager_RelationshipSatisfaction	
WorkLifeBalance

### df_job_details

EmployeeNumber	
Department	
BusinessTravel	
DistanceFromHome	
JobInvolvement	
JobLevel	
JobRole	
MonthlySalary	
NumCompaniesWorked	 
OverTime 
PercentSalaryHike_last_year	
PerformanceRating	
StockOptionLevel	
TrainingTimesLastYear	
YearsAtCompany	
YearsInCurrentRole	
YearsSinceLastPromotion 
YearsWithCurrManager

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
    
