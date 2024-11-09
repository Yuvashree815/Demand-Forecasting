Demand Forecasting for E-Commerce
This repository contains implementations of various demand forecasting models that are designed for an e-commerce environment. The models used include ARIMA time series forecasting and Regression using Digital Marketing KPIs. All implementations are written in R.

Models
1. ARIMA Time Series Forecasting
The ARIMA time series forecasting model is implemented in the ProductA_timeseries.R file, using R packages for data manipulation, time series analysis, and forecasting.

Required Packages
tidyverse: Data manipulation
forecast: Time series analysis and modeling
evobiR: Sliding window calculation
tseries: Time series analysis
urca: Unit root testing
TSstudio: Residual diagnostics
Metrics: Evaluation metrics (MAPE, RMSE, etc.)
Dataset
The data, stored in ProductA.csv, contains the sales quantities of Product A and can be sourced from the Google Analytics dashboard of the respective e-commerce website.

Data Preprocessing
Split dataset into training and testing sets (80:20 ratio).
Clean the training data using a sliding window method.
Plot ACF and PACF of the time series to check for stationarity.
If needed, difference the series to achieve stationarity.
Perform stationarity tests (ADF, PP, KPSS) on both original and differenced data.
Decompose the time series to understand trend, seasonality, and residuals.
Model Training and Evaluation
Fit an ARIMA model to the training data.
Forecast sales for the testing set.
Calculate MAPE to evaluate forecast accuracy.
Generate a line plot to visualize actual vs. forecasted sales.
Results
After running the code, the console will display:

Model summary
Evaluation metrics (MAPE, etc.)
Forecasted values and plot
2. Multivariate Regression in R
This model, implemented in ProductA_Multivariate_Regression.R, performs multivariate regression to predict Product A sales based on Google clicks and Facebook impressions (digital marketing KPIs).

Required Packages
tidyverse
evobiR
MLmetrics
Metrics
Dataset
This model requires three datasets:

ProductA.csv: Sales data for Product A
ProductA_google_clicks.csv: Google Ads clicks data
ProductA_fb_impressions.csv: Facebook Ads impressions data
Execution
Load and clean the datasets using moving averages and normalization.
Merge datasets and split into training and testing sets.
Fit a multivariate regression model using lm() with sales as the dependent variable and Google clicks and Facebook impressions as predictors.
Evaluate model performance with MAPE, MSE, and RMSE.
3. Dynamic Regression Time Series Analysis
Dynamic regression, implemented in ProductA_Dynamic_Regression.R, models the sales of Product A using Google clicks and Facebook impressions as external regressors.

Required Packages
tidyverse
forecast
evobiR
tseries
urca
TSstudio
Data Preprocessing
Load sales, Google clicks, and Facebook impressions data.
Apply a sliding window to compute the mean over 3-time steps for each variable.
Split into training (80%) and testing (20%) sets.
Test each time series for stationarity with the kpss.test() function.
Model Fitting and Evaluation
Fit an ARIMA model with external regressors (Google clicks and Facebook impressions) using auto.arima() with seasonal adjustments.
Evaluate the model by summarizing it with summary() and checking residuals using checkresiduals().
Results
The results, including model summary, residual diagnostics, and other relevant information, are displayed in the console after running the code.

Contributing
Contributions and suggestions for improvement are welcome! Please feel free to open a pull request.
