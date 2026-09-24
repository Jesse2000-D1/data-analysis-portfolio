# Project 1: E-Commerce Customer Churn & Retention Analytics

## 📌 Executive Summary
An e-commerce retailer faced a 28% annual customer churn rate, resulting in estimated recurring revenue losses exceeding $1.2M. This project analyzed 50,000+ customer transactions and interaction logs to identify high-risk churn drivers, segment user bases using **RFM (Recency, Frequency, Monetary)** scoring, and deploy a predictive churn risk model.

---

## 🎯 Business Problem & Objectives
- **Problem Statement:** Management lacked clear visibility into why customers were stopping repeat purchases after 60–90 days.
- **Primary Goal:** Quantify customer churn behaviors, establish predictive churn indicators, and deliver actionable retention strategies to protect high-lifetime-value (LTV) segments.

---

## 🛠 Tech Stack & Methodology
- **SQL (PostgreSQL):** Transaction aggregation, window functions (`NTILE`), and RFM segmentation scoring.
- **Python (Pandas, Scikit-Learn, Seaborn):** Feature engineering, exploratory data analysis, and Logistic Regression modeling.
- **Data Visualization:** Tableau dashboard for executive KPIs and segment tracking.

---

## 📊 Analytical Process & Code Implementation

### 1. Data Processing & RFM Segmentation (SQL)
We calculated RFM metrics for all active customers to group them into actionable marketing segments:

```sql
WITH CustomerMetrics AS (
    SELECT 
        customer_id,
        MAX(order_date) AS last_order_date,
        COUNT(order_id) AS total_orders,
        SUM(order_value) AS total_spend
    FROM orders
    WHERE order_status = 'Completed'
    GROUP BY customer_id
),
RFM_Scores AS (
    SELECT 
        customer_id,
        NTILE(5) OVER (ORDER BY last_order_date ASC) AS R_Score,
        NTILE(5) OVER (ORDER BY total_orders DESC) AS F_Score,
        NTILE(5) OVER (ORDER BY total_spend DESC) AS M_Score
    FROM CustomerMetrics
)
SELECT 
    customer_id,
    R_Score, F_Score, M_Score,
    CASE 
        WHEN R_Score <= 2 AND F_Score >= 4 THEN 'At-Risk Champion'
        WHEN R_Score <= 2 AND F_Score <= 2 THEN 'Lost Customer'
        WHEN R_Score >= 4 AND F_Score >= 4 THEN 'Loyal Power User'
        ELSE 'Casual Buyer'
    END AS customer_segment
FROM RFM_Scores;
