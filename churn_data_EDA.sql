-- ============================================
-- Customer Churn Data EDA
-- =============================================

-- ============================================
-- How many customers churned vs. how many stayed?
-- =============================================

SELECT Exited, COUNT(*) AS customer_count
FROM account_info_clean
GROUP BY Exited;


-- ============================================
-- What percentage of customers churned?
-- =============================================

SELECT
    SUM(Exited) AS churned_customers,
    COUNT(*) AS total_customers,
    (SUM(Exited) * 100.0) / COUNT(*) AS churn_rate
FROM account_info_clean;

-- ============================================
--  Age Data Quality Checks
-- =============================================

SELECT Age
FROM customer_info_clean
WHERE Age < 18 OR Age > 92 OR Age IS NULL;

SELECT COUNT(*) AS missing_age
FROM customer_info_clean
WHERE Age IS NULL;


-- ============================================
-- CROSS-TABLE CONSISTENCY CHECKS
-- ============================================

-- Check for Tenure mismatches
SELECT 
    c.CustomerId,
    c.Tenure AS tenure_customer,
    a.Tenure AS tenure_account
FROM customer_info_clean c
JOIN account_info_clean a
    ON c.CustomerId = a.CustomerId
WHERE c.Tenure != a.Tenure;

-- Check for customers without an account record
SELECT c.CustomerId
FROM customer_info_clean c
LEFT JOIN account_info_clean a ON c.CustomerId = a.CustomerId
WHERE a.CustomerId IS NULL;

-- Check for account records without a customer record
SELECT a.CustomerId
FROM account_info_clean a
LEFT JOIN customer_info_clean c ON a.CustomerId = c.CustomerId
WHERE c.CustomerId IS NULL;


-- Finding:
-- No Tenure mismatches or orphan CustomerId records
-- were found between the two cleaned tables.


-- ============================================
-- What are the minimum and maximum CreditScore values?
-- =============================================

SELECT MAX(CreditScore) AS max_credit_score, 
	MIN(CreditScore) AS min_credit_score
FROM customer_info_clean;

-- Finding:
-- CreditScore ranges from 350 to 850.
-- No obviously invalid CreditScore values were identified.


-- ============================================
-- What are the minimum and maximum Balance values?
-- =============================================

SELECT MAX(Balance) AS max_bal, 
	MIN(Balance) AS min_bal
FROM account_info_clean;

-- Finding:
-- Balance ranges from 0.00 to 250,898.09.
-- No negative Balance values were identified in the cleaned data.


-- ============================================
-- What are the minimum and maximum EstimatedSalary values?
-- =============================================

SELECT MAX(EstimatedSalary) AS max_EstimatedSalary, 
	MIN(EstimatedSalary) AS min_EstimatedSalary
FROM customer_info_clean;

-- Check for missing EstimatedSalary values

SELECT COUNT(*) AS missing_salary
FROM customer_info_clean
WHERE EstimatedSalary IS NULL;

-- Finding:
-- EstimatedSalary ranges from 11.58 to 199,992.48.
-- 3 EstimatedSalary values are missing.
-- No obviously invalid salary values were identified.


-- ============================================
-- What are the minimum and maximum NumOfProducts?
-- =============================================

SELECT MAX(NumOfProducts) AS max_NumOfProducts, 
	MIN(NumOfProducts) AS min_NumOfProducts
FROM account_info_clean;

-- Finding:
-- NumOfProducts ranges from 1 to 4.
-- No unexpected product-count values were identified.