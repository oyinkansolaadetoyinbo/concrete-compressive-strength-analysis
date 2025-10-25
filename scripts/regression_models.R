# Regression Models
# Author: Oyinkansola Adetoyinbo

library(dplyr)

data <- read.csv("data/concrete_strength.csv")

# Simple Linear Regression: Strength ~ Cement
model1 <- lm(Compressive.Strength ~ Cement, data = data)
summary(model1)

# Multiple Linear Regression
model2 <- lm(Compressive.Strength ~ Cement + Slag + Fly.Ash + Water + 
               Superplasticizer + Coarse.Aggregate + Fine.Aggregate + Age,
             data = data)
summary(model2)

# Export model summaries
capture.output(summary(model1), file = "results/simple_regression_summary.txt")
capture.output(summary(model2), file = "results/multiple_regression_summary.txt")
