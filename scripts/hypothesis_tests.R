# Hypothesis Testing
# Author: Oyinkansola Adetoyinbo

data <- read.csv("data/concrete_strength.csv")

# Test 1: Correlation between Cement and Strength
cor_test <- cor.test(data$Cement, data$Compressive.Strength)
print(cor_test)

# Test 2: Effect of Age on Strength
age_model <- lm(Compressive.Strength ~ Age, data = data)
summary(age_model)

# Export results
capture.output(cor_test, file = "results/correlation_test_output.txt")
capture.output(summary(age_model), file = "results/age_regression_summary.txt")
