 # Hi, I'm Jesse 👋
**Data Analyst | Business Intelligence & Data-Driven Problem Solver**

📍 Minneapolis, Minnesota  
📫 Contact: [jessembebuin.work@outlook.com](mailto:jessembebuin.work@outlook.com) | [LinkedIn](https://www.linkedin.com)

---

## 🛠 Tech Stack & Tools
- **Languages:** Python (Pandas, NumPy, Scikit-learn), SQL (PostgreSQL, MySQL)
- **Data Visualization:** Power BI, Tableau, Matplotlib, Seaborn
- **Analytics Methodologies:** RFM Segmentation, Cohort Analysis, Logistics Optimization, Time Series Forecasting

---

## 📈 Portfolio Overview
| Project Name | Domain | Key Tools | Business Impact |
| :--- | :--- | :--- | :--- |
| **E-Commerce Churn Analytics** | E-Commerce | SQL, Python, Tableau | Identified **$1.2M** in lost revenue & proposed dynamic retention workflows |
| **Supply Chain Fulfillment EDA** | Operations | SQL, Python, Power BI | Reduced average order delay by **18%** through carrier optimization |
| **Retail Sales Forecasting** | Retail | Python, Prophet, Statsmodels | Improved stock allocation accuracy by **12%** month-over-month |

---

## 📂 Featured Projects
 ### Project 1: E-Commerce Customer Churn & Retention Analysis
**Business Problem:** An e-commerce retailer experienced an annual customer drop-off rate of 28%, significantly impacting monthly recurring revenue. The executive team lacked visibility into which customer segments were leaving and why.

**Objective:** Analyze transaction history, quantify churn triggers, segment customers using Recency, Frequency, and Monetary (RFM) scoring, and deliver targeted retention strategies.

sql</code> and <code>
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
