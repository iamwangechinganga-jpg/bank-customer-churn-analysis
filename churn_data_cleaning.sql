-- ============================================
-- Customer Churn Data Cleaning
-- =============================================

-- ============================================
-- 1. CREATE CLEAN CUSTOMER TABLE
-- ============================================
CREATE TABLE customer_info_clean AS
SELECT *
FROM customer_info;

SELECT COUNT(*)
FROM customer_info_clean;

DESCRIBE customer_info_clean;

-- ============================================
-- 2. HANDLE DUPLICATE CUSTOMER RECORD
-- ============================================

SELECT *
FROM customer_info_clean
WHERE CustomerId = 15628319;

ALTER TABLE customer_info_clean
ADD COLUMN row_id INT AUTO_INCREMENT PRIMARY KEY;

SELECT row_id, CustomerId
FROM customer_info_clean
WHERE CustomerId = 15628319;

DELETE FROM customer_info_clean
WHERE row_id = 9712;

SELECT *
FROM customer_info_clean
WHERE CustomerId = 15628319;


SET SQL_SAFE_UPDATES = 0;

-- ============================================
-- 3. STANDARDIZE GEOGRAPHY
-- ============================================

UPDATE customer_info_clean
SET Geography = 'France'
WHERE Geography IN ('French', 'FRA');

SELECT Geography, COUNT(*) AS customer_count
FROM customer_info_clean
GROUP BY Geography
ORDER BY customer_count DESC;

-- ============================================
-- 4. HANDLE MISSING VALUES
-- ============================================

UPDATE customer_info_clean
SET Surname = NULL
WHERE Surname = '';

SELECT *
FROM customer_info_clean
WHERE Surname IS NULL;

UPDATE customer_info_clean
SET Age = NULL
WHERE Age = '';

SELECT *
FROM customer_info_clean
WHERE Age IS NULL;

-- ============================================
-- 5. CLEAN AND CONVERT ESTIMATED SALARY
-- ============================================

UPDATE customer_info_clean
SET EstimatedSalary = NULL
WHERE EstimatedSalary = '-€999999';

SELECT CustomerId, EstimatedSalary
FROM customer_info_clean
WHERE EstimatedSalary IS NULL;


SELECT CustomerId, EstimatedSalary, HEX(EstimatedSalary) AS salary_hex
FROM customer_info_clean
WHERE EstimatedSalary LIKE '%999999%';

UPDATE customer_info_clean
SET EstimatedSalary = NULL
WHERE EstimatedSalary LIKE '%999999%';

SELECT CustomerId, EstimatedSalary
FROM customer_info_clean
WHERE EstimatedSalary IS NULL;

SELECT EstimatedSalary
FROM customer_info_clean
WHERE EstimatedSalary IS NOT NULL
LIMIT 10;

SELECT EstimatedSalary,
       REPLACE(EstimatedSalary, '€', '') AS cleaned_salary
FROM customer_info_clean
WHERE EstimatedSalary IS NOT NULL
LIMIT 10;

UPDATE customer_info_clean
SET EstimatedSalary = REPLACE(EstimatedSalary, '€', '')
WHERE EstimatedSalary IS NOT NULL;

SELECT EstimatedSalary
FROM customer_info_clean
WHERE EstimatedSalary IS NOT NULL
LIMIT 10;

SELECT EstimatedSalary
FROM customer_info_clean
WHERE EstimatedSalary IS NOT NULL
  AND EstimatedSalary NOT REGEXP '^[0-9]+\\.?[0-9]*$';
  
  -- ============================================
-- 6. CONVERT CUSTOMER DATA TYPES
-- ============================================
  
ALTER TABLE customer_info_clean
MODIFY COLUMN EstimatedSalary DECIMAL(10,2);

DESCRIBE customer_info_clean;

SELECT CreditScore
FROM customer_info_clean
LIMIT 20;

SELECT CreditScore
FROM customer_info_clean
WHERE CreditScore IS NOT NULL
  AND CreditScore NOT REGEXP '^[0-9]+$';
  
ALTER TABLE customer_info_clean
MODIFY COLUMN CreditScore INT;

DESCRIBE customer_info_clean;

SELECT Age
FROM customer_info_clean
WHERE Age IS NOT NULL
  AND Age NOT REGEXP '^[0-9]+$';
  
SELECT
    MIN(Age) AS min_age,
    MAX(Age) AS max_age
FROM customer_info_clean;

ALTER TABLE customer_info_clean
MODIFY COLUMN Age INT;

SELECT
    MIN(Age) AS min_age,
    MAX(Age) AS max_age,
    AVG(Age) AS avg_age
FROM customer_info_clean;

SELECT Tenure
FROM customer_info_clean
LIMIT 20;

SELECT DISTINCT Tenure
FROM customer_info_clean
ORDER BY Tenure;

SELECT Tenure
FROM customer_info_clean
WHERE Tenure IS NOT NULL
  AND Tenure NOT REGEXP '^[0-9]+$';
  
ALTER TABLE customer_info_clean
MODIFY COLUMN Tenure INT;

DESCRIBE customer_info_clean;

SELECT
    MIN(Tenure) AS min_tenure,
    MAX(Tenure) AS max_tenure,
    AVG(Tenure) AS avg_tenure
FROM customer_info_clean;



DESCRIBE account_info;

SELECT *
FROM account_info
LIMIT 20;

SELECT COUNT(*) AS total_rows,
       COUNT(DISTINCT CustomerId) AS customerID_count
FROM account_info;

SELECT CustomerId, COUNT(*) AS duplicate_count
FROM account_info
GROUP BY CustomerId
HAVING COUNT(*) > 1;

SELECT *
FROM account_info
WHERE CustomerId IN (15634602, 15628319);

-- ============================================
-- 7. CREATE AND CLEAN ACCOUNT TABLE
-- ============================================

CREATE TABLE account_info_clean AS
SELECT *
FROM account_info;

ALTER TABLE account_info_clean
ADD COLUMN row_id INT AUTO_INCREMENT PRIMARY KEY;

DESCRIBE account_info_clean;

SELECT row_id, CustomerId
FROM account_info_clean
WHERE CustomerId IN (15634602, 15628319);

DELETE FROM account_info_clean
WHERE row_id IN (129, 9873);

SELECT COUNT(*) AS total_rows
FROM account_info_clean;

SELECT CustomerId, COUNT(*) AS duplicate_count
FROM account_info_clean
GROUP BY CustomerId
HAVING COUNT(*) > 1;

SELECT DISTINCT Exited
FROM account_info_clean
ORDER BY Exited;

SELECT
    Exited,
    COUNT(*) AS customer_count
FROM account_info_clean
GROUP BY Exited
ORDER BY Exited;

SELECT Balance
FROM account_info_clean
LIMIT 20;

SELECT 
    Balance,
    REPLACE(Balance, 'â‚¬', '') AS cleaned_balance
FROM account_info_clean
LIMIT 20;


SET SQL_SAFE_UPDATES = 0;

UPDATE account_info_clean
SET Balance = REPLACE(Balance, 'â‚¬', '');

SELECT Balance
FROM account_info_clean
LIMIT 20;

ALTER TABLE account_info_clean
MODIFY COLUMN Balance DECIMAL(10,2);

DESCRIBE account_info_clean;

SELECT DISTINCT NumOfProducts
FROM account_info_clean
ORDER BY NumOfProducts;

SELECT DISTINCT HasCrCard
FROM account_info_clean
ORDER BY HasCrCard;

SELECT DISTINCT IsActiveMember
FROM account_info_clean
ORDER BY IsActiveMember;

-- ============================================
-- 8. FINAL DATA VALIDATION
-- ============================================

SELECT
    SUM(CustomerId IS NULL) AS missing_customer_id,
    SUM(Balance IS NULL) AS missing_balance,
    SUM(NumOfProducts IS NULL) AS missing_products,
    SUM(HasCrCard IS NULL) AS missing_credit_card,
    SUM(Tenure IS NULL) AS missing_tenure,
    SUM(IsActiveMember IS NULL) AS missing_active_member,
    SUM(Exited IS NULL) AS missing_exited
FROM account_info_clean;

SELECT COUNT(*) AS total_rows,
       COUNT(DISTINCT CustomerId) AS unique_customers
FROM account_info_clean;