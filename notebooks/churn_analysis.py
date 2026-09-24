import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression

# Load preprocessed dataset
df = pd.read_csv('../data/customer_churn_preprocessed.csv')

# Features & Target
X = df[['days_since_last_login', 'support_tickets_opened', 'avg_order_value', 'discount_usage_rate']]
y = df['is_churned']

# Train-Test Split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Train Model
model = LogisticRegression()
model.fit(X_train, y_train)

# Feature Importance Output
feature_importance = pd.DataFrame({
    'Feature': X.columns,
    'Coefficient': model.coef_[0]
}).sort_values(by='Coefficient', ascending=False)

print("--- Feature Importance ---")
print(feature_importance)
