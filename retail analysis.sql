-- Retail Sales Analysis--

-- Overall Revenue

SELECT ROUND(SUM(total_amt),2)
AS total_revenue
FROM Transactions;

-- Total Customers
SELECT COUNT(DISTINCT cust_id) FROM Transactions As total_customers;

-- Total Quantity Sold

SELECT SUM(Qty) FROM Transactions AS total_qunatity_sold
WHERE Qty>0;

-- Total Quantity Returned

SELECT SUM(ABS(Qty)) FROM Transactions AS total_returns 
WHERE Qty<0;


-- Total Revenue by Product Category

SELECT 
    pc.prod_cat,
    SUM(t.total_amt) AS total_revenue
FROM 
    transactions t
JOIN 
    prod_cat_info pc 
    ON t.prod_cat_code = pc.prod_cat_code 
    AND t.prod_subcat_code = pc.prod_sub_cat_code
GROUP BY 
    pc.prod_cat
ORDER BY 
    total_revenue DESC;


-- Top 5 cities by number of customers

SELECT Top 5
    city_code,
    COUNT(DISTINCT customer_Id) AS customer_count
FROM 
    Customer
GROUP BY 
    city_code
ORDER BY 
    customer_count DESC

-- Monthly Sales Trend (Revenue per Month)

SELECT 
    FORMAT(CAST(tran_date AS DATE), 'yyyy-MM') AS month,
    ROUND(SUM(total_amt), 2) AS monthly_revenue
FROM 
    Transactions
GROUP BY 
    FORMAT(CAST(tran_date AS DATE), 'yyyy-MM')
ORDER BY 
    month;

-- Gender wise purchase behaviour

SELECT 
    c.Gender,
    COUNT(t.transaction_id) AS num_transactions,
    ROUND(SUM(t.total_amt), 2) AS total_spent
FROM 
    Customer c
JOIN 
    Transactions t ON c.customer_Id = t.cust_id
WHERE Gender IS NOT NULL
GROUP BY 
    c.Gender;

-- Most popular sub category by Quantity sold

SELECT 
    pc.prod_subcat,
    SUM(t.Qty) AS total_quantity_sold
FROM 
    Transactions t
JOIN 
    prod_cat_info pc 
    ON t.prod_cat_code = pc.prod_cat_code 
    AND t.prod_subcat_code = pc.prod_sub_cat_code
WHERE 
    t.Qty > 0
GROUP BY 
    pc.prod_subcat
ORDER BY 
    total_quantity_sold DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

-- Total and Average Transaction value by store type

SELECT 
    Store_type,
    ROUND(AVG(total_amt), 2) AS avg_transaction_value,
    ROUND(Sum(total_amt), 2) AS total_transaction_value
FROM 
    Transactions
GROUP BY 
    Store_type
ORDER BY 
    total_transaction_value DESC;


--Customer Lifetime Value

SELECT 
    cust_id,
    ROUND(SUM(total_amt), 2) AS lifetime_value
FROM 
    Transactions
GROUP BY 
    cust_id
ORDER BY 
    lifetime_value DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;


-- Age distribution of customers

SELECT 
    CASE 
        WHEN DATEDIFF(YEAR, TRY_CAST(DOB AS DATE), GETDATE()) BETWEEN 18 AND 25 THEN '18-25'
        WHEN DATEDIFF(YEAR, TRY_CAST(DOB AS DATE), GETDATE()) BETWEEN 26 AND 35 THEN '26-35'
        WHEN DATEDIFF(YEAR, TRY_CAST(DOB AS DATE), GETDATE()) BETWEEN 36 AND 50 THEN '36-50'
        ELSE '50+'
    END AS age_group,
    COUNT(*) AS customer_count
FROM 
    Customer
GROUP BY 
    CASE 
        WHEN DATEDIFF(YEAR, TRY_CAST(DOB AS DATE), GETDATE()) BETWEEN 18 AND 25 THEN '18-25'
        WHEN DATEDIFF(YEAR, TRY_CAST(DOB AS DATE), GETDATE()) BETWEEN 26 AND 35 THEN '26-35'
        WHEN DATEDIFF(YEAR, TRY_CAST(DOB AS DATE), GETDATE()) BETWEEN 36 AND 50 THEN '36-50'
        ELSE '50+'
    END
ORDER BY customer_count DESC;


-- RFM - Rcency, Frequency, Monetary Analysis

WITH transaction_summary AS (
    SELECT
        cust_id,
        MAX(CAST(tran_date AS DATE)) AS last_purchase_date,
        COUNT(transaction_id) AS frequency,
        SUM(total_amt) AS monetary
    FROM 
        Transactions
    GROUP BY 
        cust_id
),
rfm AS (
    SELECT
        cust_id,
        DATEDIFF(DAY, last_purchase_date, GETDATE()) AS recency,
        frequency,
        ROUND(monetary, 2) AS monetary
    FROM 
        transaction_summary
)
SELECT * FROM rfm
ORDER BY monetary DESC;


-- Customers Segmentation based on RFM

SELECT
    cust_id,
    CASE 
        WHEN recency <= 30 AND frequency >= 5 AND monetary >= 5000 THEN 'Champions'
        WHEN recency <= 90 AND frequency >= 3 THEN 'Loyal Customers'
        WHEN recency <= 180 THEN 'Potential Loyalist'
        ELSE 'At Risk'
    END AS customer_segment
FROM (
    SELECT
        cust_id,
        DATEDIFF(DAY, MAX(CAST(tran_date AS DATE)), GETDATE()) AS recency,
        COUNT(transaction_id) AS frequency,
        SUM(total_amt) AS monetary
    FROM 
        Transactions
    GROUP BY 
        cust_id
) rfm_data
ORDER BY customer_segment;


--Product cross selling affinity

SELECT 
    t1.prod_subcat_code AS prod_1,
    t2.prod_subcat_code AS prod_2,
    COUNT(*) AS times_bought_together
FROM 
    Transactions t1
JOIN 
    Transactions t2 
    ON t1.cust_id = t2.cust_id 
    AND CAST(t1.tran_date AS DATE) = CAST(t2.tran_date AS DATE)
    AND t1.prod_subcat_code < t2.prod_subcat_code
GROUP BY 
    t1.prod_subcat_code, t2.prod_subcat_code
ORDER BY 
    times_bought_together DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

-- Repeat purchase rate

WITH customer_purchases AS (
    SELECT 
        cust_id, 
        COUNT(DISTINCT CAST(tran_date AS DATE)) AS purchase_days
    FROM 
        Transactions
    GROUP BY 
        cust_id
)
SELECT 
    CAST(COUNT(CASE WHEN purchase_days > 1 THEN 1 END) AS FLOAT) 
    / COUNT(*) AS repeat_purchase_rate
FROM 
    customer_purchases;

-- Pareto Analysis(80/20)- Top products contributors

WITH product_sales AS (
    SELECT 
        pc.prod_subcat,
        SUM(t.total_amt) AS total_sales
    FROM 
        Transactions t
    JOIN 
        prod_cat_info pc 
        ON t.prod_cat_code = pc.prod_cat_code 
        AND t.prod_subcat_code = pc.prod_sub_cat_code
    GROUP BY 
        pc.prod_subcat
),
ranked_sales AS (
    SELECT *,
        SUM(total_sales) OVER (ORDER BY total_sales DESC) * 1.0 / 
        SUM(total_sales) OVER () AS cumulative_share
    FROM 
        product_sales
)
SELECT * 
FROM ranked_sales
WHERE cumulative_share > 0.8
;

-- Month over Month revenue Growth

WITH monthly_sales AS (
    SELECT 
        FORMAT(CAST(tran_date AS DATE), 'yyyy-MM') AS month,
        SUM(total_amt) AS revenue
    FROM 
        Transactions
    GROUP BY 
        FORMAT(CAST(tran_date AS DATE), 'yyyy-MM')
),
growth AS (
    SELECT 
        month,
        revenue,
        LAG(revenue) OVER (ORDER BY month) AS prev_month_revenue,
        ROUND((revenue - LAG(revenue) OVER (ORDER BY month)) * 100.0 / NULLIF(LAG(revenue) OVER (ORDER BY month), 0), 2) AS mom_growth_pct
    FROM 
        monthly_sales
)
SELECT * FROM growth;

-- Revenue by Store type and Product Category

SELECT 
    t.Store_type,
    pc.prod_cat,
    ROUND(SUM(t.total_amt - t.Tax), 2) AS total_revenue
FROM 
    Transactions t
JOIN 
    prod_cat_info pc 
    ON t.prod_cat_code = pc.prod_cat_code 
    AND t.prod_subcat_code = pc.prod_sub_cat_code
GROUP BY 
    t.Store_type, pc.prod_cat
ORDER BY 
    total_revenue DESC;

-- Active customers by month

SELECT 
    FORMAT(CAST(tran_date AS DATE), 'yyyy-MM') AS month,
    COUNT(DISTINCT cust_id) AS active_customers
FROM 
    Transactions
GROUP BY 
    FORMAT(CAST(tran_date AS DATE), 'yyyy-MM')
ORDER BY 
    month;

-- High value transaction pattern

SELECT 
    cust_id,
    transaction_id,
    tran_date,
    total_amt
FROM 
    Transactions
WHERE 
    total_amt > (
        SELECT AVG(total_amt) + (2 * STDEV(total_amt)) FROM Transactions
    )
ORDER BY 
    total_amt DESC;

-- Peak shopping days

SELECT 
    DATENAME(dd, CAST(tran_date AS DATE)) AS date,
    COUNT(*) AS total_transactions,
    SUM(total_amt) AS total_revenue
FROM 
    Transactions
GROUP BY 
    DATENAME(dd, CAST(tran_date AS DATE))
ORDER BY 
    total_transactions DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

-- Revenue contribution by city and Category

SELECT 
    c.city_code,
    pc.prod_cat,
    ROUND(SUM(t.total_amt), 2) AS revenue
FROM 
    Transactions t
JOIN 
    Customer c ON t.cust_id = c.customer_Id
JOIN 
    prod_cat_info pc
    ON t.prod_cat_code = pc.prod_cat_code 
    AND t.prod_subcat_code = pc.prod_sub_cat_code
WHERE city_code IS NOT NULL
GROUP BY 
    c.city_code, pc.prod_cat
ORDER BY 
    revenue DESC;

-- Gender wise category preference

SELECT 
    c.Gender,
    pc.prod_cat,
    COUNT(*) AS purchase_count
FROM 
    Transactions t
JOIN 
    Customer c ON t.cust_id = c.customer_Id
JOIN 
    prod_cat_info pc 
    ON t.prod_cat_code = pc.prod_cat_code 
    AND t.prod_subcat_code = pc.prod_sub_cat_code
GROUP BY 
    c.Gender, pc.prod_cat
ORDER BY 
    purchase_count DESC;

-- Sales decline detection- Products with falling revenue

WITH monthly_prod_sales AS (
    SELECT 
        FORMAT(CAST(tran_date AS DATE), 'yyyy-MM') AS month,
        pc.prod_subcat,
        SUM(t.total_amt) AS revenue
    FROM 
        Transactions t
    JOIN 
        prod_cat_info pc 
        ON t.prod_cat_code = pc.prod_cat_code 
        AND t.prod_subcat_code = pc.prod_sub_cat_code
    GROUP BY 
        FORMAT(CAST(tran_date AS DATE), 'yyyy-MM'), pc.prod_subcat
),
growth AS (
    SELECT 
        prod_subcat,
        month,
        revenue,
        LAG(revenue) OVER (PARTITION BY prod_subcat ORDER BY month) AS prev_month_revenue
    FROM 
        monthly_prod_sales
)
SELECT 
    prod_subcat,
    month,
    ROUND(revenue - prev_month_revenue, 2) AS revenue_change
FROM 
    growth
WHERE 
    revenue < prev_month_revenue
ORDER BY revenue_change;

-- Store type conversion efficiency (Based on conversion rate)

SELECT 
    Store_type,
    SUM(CASE WHEN Qty < 0 THEN ABS(Qty) ELSE 0 END) AS items_returned,
    SUM(CASE WHEN Qty > 0 THEN Qty ELSE 0 END) AS items_sold,
    ROUND((100.0 * SUM(CASE WHEN Qty > 0 THEN ABS(Qty) ELSE 0 END) /
          (NULLIF(SUM(CASE WHEN Qty > 0 THEN Qty ELSE 0 END) + SUM(CASE WHEN Qty < 0 THEN ABS(Qty) ELSE 0 END), 0))), 2) AS conversion_rate
FROM 
    Transactions
GROUP BY 
    Store_type;

-- First product purchased by customer

WITH ranked_purchases AS (
    SELECT 
        t.cust_id,
        pc.prod_subcat,
        t.tran_date,
        ROW_NUMBER() OVER (PARTITION BY t.cust_id ORDER BY CAST(t.tran_date AS DATE)) AS rn
    FROM 
        Transactions t
    JOIN 
        prod_cat_info pc
        ON t.prod_cat_code = pc.prod_cat_code 
        AND t.prod_subcat_code = pc.prod_sub_cat_code
)
SELECT 
    cust_id,
    prod_subcat AS first_product,
    tran_date
FROM 
    ranked_purchases
WHERE 
    rn = 1;


-- Cohort Analysis

WITH customer_cohort AS (
    SELECT 
        cust_id,
        FORMAT(MIN(CAST(tran_date AS DATE)), 'yyyy-MM') AS cohort_month,  -- cohort based on first purchase
        MIN(CAST(tran_date AS DATE)) AS first_purchase
    FROM 
        Transactions
    GROUP BY 
        cust_id
),
transactions_with_cohort AS (
    SELECT 
        t.cust_id,
        c.cohort_month,
        FORMAT(CAST(t.tran_date AS DATE), 'yyyy-MM') AS transaction_month
    FROM 
        customer_cohort c
    JOIN 
        Transactions t ON c.cust_id = t.cust_id
)
SELECT 
    cohort_month,
    transaction_month,
    COUNT(DISTINCT cust_id) AS retained_customers
FROM 
    transactions_with_cohort
GROUP BY 
    cohort_month, transaction_month
ORDER BY 
    cohort_month, transaction_month;

-- Basket Size (Average Products per Transaction)

SELECT 
    ROUND(AVG(product_count * 1.0), 2) AS avg_basket_size
FROM (
    SELECT 
        transaction_id,
        COUNT( prod_subcat_code) AS product_count
    FROM 
        Transactions
    GROUP BY 
        transaction_id
) AS basket;

