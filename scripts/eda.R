# Exploratory Data Analysis (EDA)
# Author: Oyinkansola Adetoyinbo

library(ggplot2)
library(dplyr)

# Load dataset
data <- read.csv("data/concrete_strength.csv")

# Summary statistics
summary(data)

# Histogram of Compressive Strength
ggplot(data, aes(x = Compressive.Strength)) +
  geom_histogram(bins = 30, fill = "steelblue", color = "black") +
  theme_minimal() +
  labs(title = "Distribution of Concrete Compressive Strength",
       x = "Compressive Strength (MPa)",
       y = "Frequency")
