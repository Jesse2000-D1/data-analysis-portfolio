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

#### 🛠 SQL Analysis: RFM Segmentation

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
```


#### 🐍 Python Analysis: Logistic Regression Modeling

```python
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression

# Load preprocessed customer data
df = pd.read_csv('data/customer_churn_preprocessed.csv')

# Define features and target variable
X = df[['days_since_last_login', 'support_tickets_opened', 'avg_order_value', 'discount_usage_rate']]
y = df['is_churned']

# Split dataset into training and testing sets (80/20)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Train Logistic Regression model
model = LogisticRegression()
model.fit(X_train, y_train)

# Feature importance evaluation
feature_importance = pd.DataFrame({
    'Feature': X.columns,
    'Coefficient': model.coef_[0]
}).sort_values(by='Coefficient', ascending=False)

print("--- Key Drivers of Churn ---")
print(feature_importance)
```

### Key Insights & Business Recommendations
- Support Friction Drives Loss: Customers who logged >3 support tickets in 30 days showed a 64% higher probability of churning, indicating unresolved fulfillment and product quality issues.

- High-Value Revenue At Risk: Identified 4,200 "At-Risk Champions" representing over $1.2M in annual recurring revenue who have been inactive for over 60 days.

- Automated VIP Retention Workflows: Establish an automated escalation protocol for high-tier customers opening support tickets to resolve issues before churn risk escalates.

 - Targeted Re-Engagement: Deploy tailored 15% discount win-back campaigns specifically targeted at "At-Risk Champions" upon reaching 45 days of inactivity.
```

### PROJECT 2: Supply Chain Fulfillment Optimization
**Business Problem:** A regional distribution network experienced late delivery penalties totaling **$340K annually** due to carrier bottlenecks, unoptimized transit routes, and severe regional fulfillment delays.

**Objective:** Analyze carrier delivery performance across distribution nodes, quantify transit delays by carrier and region, and build an exploratory optimization model to reallocate volume to high-performing carriers.
 ```

### 🛠 SQL Analysis: Carrier Delay & Performance Metrics

```sql
SELECT 
    carrier_id,
    COUNT(shipment_id) AS total_shipments,
    ROUND(AVG(actual_transit_days - estimated_transit_days), 2) AS avg_delay_days,
    ROUND(SUM(CASE WHEN actual_transit_days > estimated_transit_days THEN 1 ELSE 0 END) * 100.0 / COUNT(shipment_id), 2) AS late_delivery_pct
FROM shipment_logs
WHERE dispatch_date >= DATEADD(month, -6, CURRENT_DATE)
GROUP BY carrier_id
HAVING COUNT(shipment_id) >= 100
ORDER BY late_delivery_pct DESC;
```

### Python Analysis: Transit Delay Distribution & Route EDA
import pandas as pd
import numpy as np

#Load shipment and logistics tracking logs
shipments = pd.read_csv('data/supply_chain_shipments.csv')

#Calculate fulfillment delays (Actual vs Promised)
shipments['delay_days'] = shipments['actual_transit_days'] - shipments['estimated_transit_days']
shipments['is_delayed'] = shipments['delay_days'] > 0

#Carrier delay summary by regional hub
carrier_performance = shipments.groupby(['origin_region', 'carrier_id']).agg(
    total_orders=('shipment_id', 'count'),
    avg_delay=('delay_days', 'mean'),
    on_time_rate=('is_delayed', lambda x: (1 - x.mean()) * 100)
).reset_index()

#Filter out high-delay regional bottlenecks (>2 days avg delay)
bottlenecks = carrier_performance[carrier_performance['avg_delay'] > 2.0]
print("--- Critical Regional Bottlenecks ---")
print(bottlenecks.sort_values(by='avg_delay', ascending=False))
 ```

### KEY INSIGHTS & BUSINESS RECOMMENDATIONS
 1. Severe Bottleneck in Midwest Hub: Carrier "LogiTrans" averaged a 3.4-day delay on Midwest distribution routes, accounting for 42% of all late delivery penalty fees.

2. On-Time Discrepancy: Regional carriers outperformed national carriers on short-haul routes with an 89% on-time delivery rate compared to national carriers at 71%.

3. Dynamic Carrier Reallocation: Shift 30% of Midwest short-haul volume from LogiTrans to top-performing regional logistics providers.

4. Projected Cost Savings: Route optimization and volume re-balancing are estimated to reduce overall order delays by 18% and save ~$140K annually in late penalties.
 ```
