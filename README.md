# Bank Customer Churn Analysis

**SQL | Tableau Prep | Tableau | Data Cleaning | Business Analysis**

## Project Overview

This project analyzes customer churn across a dataset of 10,000 bank customers.

The goal was to identify customer segments associated with higher observed churn, investigate patterns in customer and account characteristics, and communicate the findings through interactive Tableau dashboards.

This project follows an end-to-end analytics workflow:

**Data Audit → Data Cleaning → Exploratory Analysis → Business Analysis → Visualization → Insights**

---

## Business Questions

The analysis investigates questions such as:

- What is the overall customer churn rate?
- How does churn vary across geography and gender?
- Does churn vary across age groups?
- Is customer activity status associated with observed churn?
- How does churn vary by account balance?
- Does the number of products held relate to observed churn?
- Does activity status change the observed churn pattern across age, balance, and product segments?
- Are salary differences meaningfully associated with churn?

---

## Data Quality & Preparation

The dataset was audited and cleaned using SQL before analysis.

Key data-quality issues identified included:

- Missing Age values
- Missing EstimatedSalary values
- Invalid/sentinel Balance values
- Duplicate Customer IDs
- Inconsistent data types
- Geography standardization requirements

The cleaned customer and account tables were then validated and joined using Tableau Prep.

The final Tableau-ready dataset contained **10,000 customer records**.

---

## Analysis Approach

SQL was used throughout the project to:

- Audit data quality
- Clean and standardize fields
- Investigate missing and invalid values
- Perform exploratory analysis
- Calculate churn rates
- Compare customer segments
- Analyze activity status across multiple segments
- Answer business-focused analytical questions

The analysis was organized into four SQL scripts:

1. `01_data_audit.sql`
2. `02_data_cleaning.sql`
3. `03_eda.sql`
4. `04_business_analysis_questions.sql`

---

## Key Findings

### Overall Churn

- **10,000** customers were analyzed.
- **2,037** customers had churned.
- The overall observed churn rate was **20.37%**.

### Geography

Observed churn varied substantially by geography:

- Germany: **32.44%**
- Spain: **16.67%**
- France: **16.15%**

### Gender

Observed churn was:

- Female: **25.07%**
- Male: **16.46%**

### Age

Churn varied considerably across age groups:

- 18–29: **7.56%**
- 30–39: **10.89%**
- 40–49: **30.80%**
- 50–59: **56.04%**
- 60+: **27.95%**

### Activity Status

Non-active customers consistently showed higher observed churn than active customers across the age, balance, and product segments tested.

For example, among customers aged 50–59:

- Active: **37.10%**
- Non-active: **81.23%**

Among customers aged 60+:

- Active: **12.53%**
- Non-active: **85.59%**

### Number of Products

Observed churn varied strongly by number of products:

- 1 product: **27.71%**
- 2 products: **7.58%**
- 3 products: **82.71%**
- 4 products: **100.00%**

The 4-product group contained **60 customers**, of whom 29 were active and 31 were non-active. All 60 had churned.

Because the 3- and 4-product segments are considerably smaller than the 1- and 2-product groups, these results should be interpreted with appropriate caution.

### Balance

Observed churn increased across several balance bands:

- 0–50k: **14.25%**
- 50–100k: **19.88%**
- 100–150k: **25.77%**
- 150k+: **23.12%**

Non-active customers had higher observed churn within every balance segment tested.

---

## Tableau Dashboards

### Dashboard 1: Churn Overview & Key Drivers

The first dashboard provides an overview of customer churn across demographic and account segments, including:

- Total customers
- Churned customers
- Overall churn rate
- Geography
- Gender
- Age
- Number of products

![Bank Customer Churn Dashboard](Bank%20Customer%20Churn%20Dashboard.png)

### Dashboard 2: Active Member Status & Observed Churn

The second dashboard examines observed churn by activity status across:

- Age
- Balance
- Number of products

![Active Member Status & Observed Churn](Active%20Member%20Status%20%26%20Observed%20Churn.png)

The dashboards were built in Tableau using a Tableau Prep output dataset.

**[View the interactive Tableau Public dashboard](https://public.tableau.com/app/profile/wangechi.ng.ang.a5145/viz/Bank_customer_churn/BankCustomerChurnDashboard)**

---

## Tools Used

- **MySQL** – data auditing, cleaning, exploratory analysis, and business analysis
- **Tableau Prep** – data preparation and table joining
- **Tableau** – dashboard development and visualization
- **GitHub** – project documentation and version control

---

## Project Structure

```text
bank-customer-churn-analysis/
│
├── README.md
│
├── business_analysis_questions.sql
├── churn_data_EDA.sql
├── churn_data_cleaning.sql
├── data_audit.sql
│
├── Bank Customer Churn Dashboard.png
└── Active Member Status & Observed Churn.png
│

