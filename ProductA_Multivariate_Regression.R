# Load necessary libraries
library(tidyverse)
library(evobiR)
library(MLmetrics)
library(Metrics)

# Read sales and predictor data from CSV files
productA_sales <- read.csv("ProductA.csv")  # Sales quantity
productA_google_clicks <- read.csv("ProductA_google_clicks.csv")  # Clicks data
productA_fb_impressions <- read.csv("ProductA_fb_impressions.csv")  # Impressions data

# Clean and normalize predictor variables using moving average
productA_google_clicks <- SlidingWindow("mean", productA_google_clicks$Clicks, 3, 1)
productA_google_clicks <- productA_google_clicks / (max(productA_google_clicks) - min(productA_google_clicks))

productA_fb_impressions <- SlidingWindow("mean", productA_fb_impressions$Impressions, 3, 1)
productA_fb_impressions <- productA_fb_impressions / (max(productA_fb_impressions) - min(productA_fb_impressions))

productA_sales <- SlidingWindow("mean", productA_sales$Quantity, 3, 1)

# Combine the cleaned variables into a data frame
regression_productA_sales <- data.frame(productA_sales, productA_google_clicks, productA_fb_impressions)
colnames(regression_productA_sales) <- c('sales', 'google_clicks', 'fb_impressions')

# Split data into training and testing sets (90% training, 10% testing)
split_point <- floor(0.9 * nrow(regression_productA_sales))
productA_training <- regression_productA_sales[1:split_point, ]
productA_testing <- regression_productA_sales[(split_point + 1):nrow(regression_productA_sales), ]

# Build the Multivariate Regression model
fit_productA_sales <- lm(sales ~ google_clicks + fb_impressions, data = productA_training)

# Display the model summary
print(summary(fit_productA_sales))


# Generate predictions on the testing set
forecast <- predict(fit_productA_sales, productA_testing)

# Calculate performance metrics
mape_result <- Metrics::mape(productA_testing$sales, forecast)  # Mean Absolute Percentage Error
mse_result <- Metrics::mse(productA_testing$sales, forecast)      # Mean Squared Error
rmse_result <- Metrics::rmse(productA_testing$sales, forecast)    # Root Mean Squared Error

# Print performance metrics
cat("MAPE: ", mape_result, "\n")
cat("MSE: ", mse_result, "\n")
cat("RMSE: ", rmse_result, "\n")

# Plot Actual vs Predicted Values
actual_vs_predicted_plot <-ggplot(productA_testing, aes(x = sales, y = forecast)) +
  geom_point() +
  geom_abline(slope = 1, intercept = 0, color = 'red') +  # Diagonal line for perfect predictions
  labs(title = "Actual vs Predicted Sales", x = "Actual Sales", y = "Predicted Sales") +
  theme_minimal()
print(actual_vs_predicted_plot)  # Explicitly print the plot

# Residuals Plot
residuals <- productA_testing$sales - forecast
residuals_plot <-ggplot(data.frame(residuals), aes(x = residuals)) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Residuals Histogram", x = "Residuals", y = "Frequency") +
  theme_minimal()
print(residuals_plot)  # Explicitly print the plot

