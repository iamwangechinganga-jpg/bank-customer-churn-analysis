-- checking if all the rows were imported successfully

SELECT COUNT(*), COUNT(DISTINCT CustomerId) 
FROM customer_info;

SELECT COUNT(*), COUNT(DISTINCT CustomerId) 
FROM account_info;

SELECT *
FROM customer_info;

SELECT *
FROM account_info;
-- checking for duplicates in both tables

SELECT CustomerId, COUNT(*)
FROM customer_info
GROUP BY CustomerId
HAVING COUNT(*) > 1;

SELECT CustomerId, COUNT(*)
FROM account_info
GROUP BY CustomerId
HAVING COUNT(*) > 1;


SELECT * 
FROM customer_info 
WHERE CustomerId = 15628319;

SELECT * 
FROM account_info 
WHERE CustomerId IN (15634602, 15628319);

SELECT COUNT(*)
FROM (
    SELECT CustomerId
    FROM customer_info
    GROUP BY CustomerId
    HAVING COUNT(*) > 1
) AS duplicates;

SELECT COUNT(*) 
FROM (
    SELECT CustomerId
    FROM account_info
    GROUP BY CustomerId
    HAVING COUNT(*) > 1
) AS duplicates;


SELECT COUNT(*) AS total_rows,
       COUNT(DISTINCT CustomerId)
FROM customer_info;

SELECT COUNT(*) AS total_rows,
       COUNT(DISTINCT CustomerId)
FROM account_info;

-- Both tables contain duplicate records. After investigation, the duplicated records identified so far contain identical information.

-- Checking for missing values

SELECT
    SUM(CustomerId IS NULL OR CustomerId = ''),
    SUM(Surname IS NULL OR Surname = ''),
    SUM(CreditScore IS NULL),
    SUM(Geography IS NULL OR Geography = ''),
    SUM(Gender IS NULL OR Gender = ''),
    SUM(Age IS NULL),
    SUM(Tenure IS NULL) ,
    SUM(EstimatedSalary IS NULL OR EstimatedSalary = '')
FROM customer_info;

SELECT *
FROM customer_info
WHERE Surname IS NULL
   OR Surname = '';
   
SELECT COUNT(*)
FROM customer_info
WHERE Age IS NULL
   OR Age = '';
   
SELECT *
FROM customer_info
WHERE Age IS NULL
   OR Age = '';
   
SELECT CustomerId, EstimatedSalary
FROM customer_info
WHERE EstimatedSalary IS NULL
   OR EstimatedSalary = ''
   OR EstimatedSalary LIKE '%999999%';
   
SELECT
    SUM(CustomerId IS NULL OR CustomerId = ''),
    SUM(Balance IS NULL OR Balance = ''),
    SUM(NumOfProducts IS NULL OR NumOfProducts = ''),
    SUM(HasCrCard IS NULL OR HasCrCard = ''),
    SUM(Tenure IS NULL OR Tenure = ''),
    SUM(IsActiveMember IS NULL OR IsActiveMember = ''),
    SUM(Exited IS NULL OR Exited = '')
FROM account_info;

SELECT DISTINCT Exited
FROM account_info;

SELECT *
FROM account_info
WHERE Tenure IS NULL
   OR Tenure = '';
   
SELECT
    SUM(CustomerId IS NULL OR CustomerId = ''),
    SUM(Balance IS NULL) ,
    SUM(NumOfProducts IS NULL),
    SUM(HasCrCard IS NULL OR HasCrCard = ''),
    SUM(Tenure IS NULL),
    SUM(IsActiveMember IS NULL OR IsActiveMember = ''),
    SUM(Exited IS NULL) 
FROM account_info;

SELECT COUNT(*) 
FROM customer_info
WHERE EstimatedSalary LIKE '%999999%';

SELECT DISTINCT EstimatedSalary
FROM customer_info
ORDER BY EstimatedSalary
LIMIT 20;

SELECT
    MIN(EstimatedSalary) AS min_salary,
    MAX(EstimatedSalary) AS max_salary
FROM customer_info;

SELECT Geography, COUNT(*) AS customer_count
FROM customer_info
GROUP BY Geography
ORDER BY customer_count DESC;

SELECT Gender, COUNT(*) AS customer_count
FROM customer_info
GROUP BY Gender
ORDER BY customer_count DESC;

SELECT
    MIN(Age) AS min_age,
    MAX(Age) AS max_age,
    AVG(Age) AS avg_age
FROM customer_info
WHERE Age IS NOT NULL
  AND Age != '';
  
  SELECT
    MIN(CreditScore) AS min_credit_score,
    MAX(CreditScore) AS max_credit_score,
    AVG(CreditScore) AS avg_credit_score
FROM customer_info;
  
  SELECT
    MIN(Tenure) AS min_tenure,
    MAX(Tenure) AS max_tenure,
    AVG(Tenure) AS avg_tenure
FROM customer_info;


SELECT
    MIN(Balance) AS min_balance,
    MAX(Balance) AS max_balance,
    AVG(Balance) AS avg_balance
FROM account_info;

DESCRIBE account_info;

SELECT Balance
FROM account_info
LIMIT 10;

SELECT HasCrCard, COUNT(*) AS customer_count
FROM account_info
GROUP BY HasCrCard
ORDER BY customer_count DESC;

SELECT IsActiveMember, COUNT(*) AS customer_count
FROM account_info
GROUP BY IsActiveMember
ORDER BY customer_count DESC;

SELECT
    MIN(NumOfProducts) AS min_products,
    MAX(NumOfProducts) AS max_products,
    AVG(NumOfProducts) AS avg_products
FROM account_info;

SELECT
    MIN(Exited) AS min_exited,
    MAX(Exited) AS max_exited,
    SUM(Exited) AS churned_customers
FROM account_info;