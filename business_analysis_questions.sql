-- ============================================
-- Business Analysis questions
-- =============================================

-- ============================================
-- Does churn differ by geography?
-- =============================================

SELECT c.Geography, COUNT(*)AS total_customers,
(SUM(a.Exited) * 100.0) / COUNT(*) AS churn_rate
FROM customer_info_clean c
JOIN account_info_clean a ON c.CustomerId = a.CustomerId
GROUP BY Geography;

-- Finding:
-- Churn varies across geographies.
-- Germany has a churn rate of 32.44%, compared with
-- 16.15% in France and 16.67% in Spain.


-- ============================================
-- Does churn differ by gender?
-- =============================================

SELECT 
    c.Gender,
    COUNT(*) AS total_customers,
    SUM(a.Exited) AS churned_customers,
    (SUM(a.Exited) * 100.0) / COUNT(*) AS churn_rate
FROM customer_info_clean c
JOIN account_info_clean a 
    ON c.CustomerId = a.CustomerId
GROUP BY c.Gender;

-- Finding:
-- Churn differs by gender.
-- Female customers have a churn rate of 25.07%,
-- compared with 16.46% among male customers.


-- ============================================
-- Does customer tenure appear to be related to churn?
-- =============================================

SELECT c.Tenure, COUNT(*) AS total_customers,
(SUM(a.Exited) * 100.0) / COUNT(*) AS churn_rate
FROM customer_info_clean c
JOIN account_info_clean a ON c.CustomerId = a.CustomerId
GROUP BY Tenure
ORDER BY c.Tenure;

-- Finding:
-- Churn rates vary across tenure levels but do not show
-- a clear or consistent relationship with customer tenure.
-- Churn ranges from approximately 17.22% to 23.00% across
-- the 0-10 year tenure levels.


-- ============================================
-- Does the number of bank products a customer has appear to be related to churn?
-- =============================================

SELECT NumOfProducts, COUNT(*)AS total_customers, 
(SUM(Exited) * 100.0) / COUNT(*) AS churn_rate
FROM account_info_clean
GROUP BY NumOfProducts
ORDER BY NumOfProducts;

-- Finding:
-- Churn varies substantially by the number of products held.
-- Customers with 2 products have the lowest observed churn rate
-- at 7.58%, while customers with 3 and 4 products have much
-- higher observed churn rates of 82.71% and 100%, respectively.
-- The 3- and 4-product groups are relatively small and should
-- therefore be interpreted with caution.


-- ============================================
-- Among customers with 3 or 4 products, does churn vary by whether they are active members?
-- =============================================

SELECT NumOfProducts, COUNT(*)AS total_customers, IsActiveMember,
(SUM(Exited) * 100.0) / COUNT(*) AS churn_rate
FROM account_info_clean
WHERE NumOfProducts IN (3, 4)
GROUP BY NumOfProducts, IsActiveMember
ORDER BY churn_rate ASC;

-- Finding:
-- Among customers with 3 products, churn was higher among
-- non-active members (88.24%) than active members (75.22%).
-- Among customers with 4 products, churn was 100% for both
-- active and non-active members.
-- These results should be interpreted cautiously because the
-- 3- and 4-product groups are relatively small.


-- ============================================
-- Does churn vary by customer age?
-- =============================================

SELECT 
    CASE
        WHEN Age BETWEEN 18 AND 29 THEN '18-29'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59'
        WHEN Age >= 60 THEN '60+'
    END AS age_group,
    COUNT(*) AS total_customers, (SUM(a.Exited) * 100.0) / COUNT(*) AS churn_rate
FROM customer_info_clean c
JOIN account_info_clean a ON c.CustomerId = a.CustomerId
WHERE c.Age IS NOT NULL
GROUP BY age_group
ORDER BY churn_rate DESC;

-- Finding:
-- Churn varies substantially across age groups.
-- Customers aged 50-59 have the highest observed churn rate,
-- while customers aged 18-29 have the lowest.


-- ============================================
-- Within each age group, does churn differ between active and non-active customers?
-- =============================================

SELECT IsActiveMember, COUNT(*) AS customer_count,
CASE
        WHEN Age BETWEEN 18 AND 29 THEN '18-29'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59'
        WHEN Age >= 60 THEN '60+'
    END AS age_group,
    (SUM(a.Exited) * 100.0) / COUNT(*) AS churn_rate
FROM  customer_info_clean c
JOIN account_info_clean a ON c.CustomerId = a.CustomerId
WHERE c.Age IS NOT NULL
GROUP BY IsActiveMember, age_group
ORDER BY age_group, IsActiveMember;

-- Finding:
-- Within every age group, non-active customers have a higher
-- observed churn rate than active customers.
-- The difference is particularly large among customers aged
-- 50-59 and 60+.


-- ============================================
-- Does balance appear to be related to churn?
-- =============================================

SELECT Count(*) AS customer_count, 
CASE 	
	WHEN Balance BETWEEN  0 AND 50000 THEN '0-50000'
    WHEN Balance BETWEEN  50001 AND 100000 THEN '50001-100000'
    WHEN Balance BETWEEN  100001 AND 150000 THEN '100001-150000'
    WHEN Balance >=  150001 THEN '150001+'
END AS bal_group,
(SUM(Exited) * 100.0) / COUNT(*) AS churn_rate
FROM account_info_clean
GROUP BY bal_group
ORDER BY churn_rate;

-- Finding:
-- Churn generally increases across the lower and middle
-- balance groups, rising from 14.25% among customers with
-- balances of €0-50,000 to 25.77% among customers with
-- balances of €100,001-150,000.
-- Churn decreases slightly to 23.12% among customers with
-- balances above €150,000.


-- ============================================
-- Among customers with different balance levels, does churn differ between active and non-active members?
-- =============================================

SELECT IsActiveMember, Count(*) AS customer_count,
CASE 	
	WHEN Balance BETWEEN  0 AND 50000 THEN '0-50000'
    WHEN Balance BETWEEN  50001 AND 100000 THEN '50001-100000'
    WHEN Balance BETWEEN  100001 AND 150000 THEN '100001-150000'
    WHEN Balance >=  150001 THEN '150001+'
END AS bal_group,
(SUM(Exited) * 100.0) / COUNT(*) AS churn_rate
FROM account_info_clean
GROUP BY bal_group, IsActiveMember
ORDER BY churn_rate;

-- Finding:
-- Non-active customers have higher observed churn rates than
-- active customers across every balance group.
-- The highest observed churn rate is among non-active customers
-- with balances of €100,001-150,000 (33.49%).


-- ============================================
-- Average salary of churned vs. retained customers
-- =============================================

SELECT
    a.Exited,
    COUNT(*) AS customer_count,
    AVG(c.EstimatedSalary) AS avg_salary
FROM customer_info_clean c
JOIN account_info_clean a
    ON c.CustomerId = a.CustomerId
GROUP BY a.Exited;

-- Finding:
-- Average estimated salary was slightly higher among churned
-- customers (€101,465.68) than among customers who stayed
-- (€99,740.75).
-- The difference is relatively small, suggesting a weak
-- association between estimated salary and churn in this dataset.


-- ============================================
-- Churn rate across salary bands
-- =============================================

SELECT 
    COUNT(*) AS customer_count,
    CASE
        WHEN EstimatedSalary BETWEEN 0 AND 50000 THEN '0-50000'
        WHEN EstimatedSalary BETWEEN 50001 AND 100000 THEN '50001-100000'
        WHEN EstimatedSalary BETWEEN 100001 AND 150000 THEN '100001-150000'
        WHEN EstimatedSalary >= 150001 THEN '150001+'
    END AS EstimatedSalary_group,
    (SUM(a.Exited) * 100.0) / COUNT(*) AS churn_rate
FROM customer_info_clean c
JOIN account_info_clean a 
    ON c.CustomerId = a.CustomerId
WHERE c.EstimatedSalary IS NOT NULL
GROUP BY EstimatedSalary_group
ORDER BY churn_rate;

-- Finding:
-- Churn rates are relatively consistent across estimated salary
-- bands, ranging from 19.87% to 21.47%.
-- This suggests a weak association between estimated salary
-- and churn in this dataset.