# Correlation Analysis
# Author: Oyinkansola Adetoyinbo

library(corrplot)
library(dplyr)

data <- read.csv("data/concrete_strength.csv")

# Compute correlation matrix
num_vars <- data %>% select_if(is.numeric)
cor_matrix <- cor(num_vars, use = "complete.obs")

# Display correlation matrix
print(cor_matrix)

# Visualize correlation
corrplot(cor_matrix, method = "circle", type = "upper",
         addCoef.col = "red", tl.cex = 0.7, cl.pos = "r",
         title = "Correlation Matrix for Concrete Variables")
