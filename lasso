# Load required library
library(glmnet)

# Handling missing values (replace `data` with your actual dataset name)
data <- na.omit(data)

# Prepare the data matrix and target vector
X <- as.matrix(data[, -which(names(data) == "target")])
Y <- data$target

# Fit Lasso regression with cross-validation
cv_model <- cv.glmnet(X, Y, alpha = 1)

# Get the optimal lambda value with the best cross-validated performance
optimal_lambda <- cv_model$lambda.min

# Fit the Lasso model with the optimal lambda and obtain the coefficients
lasso_model <- glmnet(X, Y, alpha = 1, lambda = optimal_lambda)
coefficients <- coef(lasso_model)

# Extract the non-zero coefficient predictors
selected_predictors_lasso <- names(coefficients)[-1][coefficients[-1] != 0]
