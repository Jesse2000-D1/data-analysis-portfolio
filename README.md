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
