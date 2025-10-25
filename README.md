
# 🧱 Statistical Analysis of Concrete Compressive Strength Using R

## 📘 Project Overview

This project investigates how material composition and curing age influence **concrete compressive strength**.
Using **R** for data exploration, modeling, and diagnostics, the analysis applies statistical and visual techniques to uncover insights about optimal concrete mix design.

The study involves:

* Exploratory Data Analysis (EDA)
* Correlation Analysis
* Regression Modeling (Simple & Multiple)
* Hypothesis Testing
* Model Diagnostics

---

## 📊 Dataset Description

The dataset consists of **concrete mix components** and corresponding **compressive strength values** (MPa).

| Variable                   | Description                               |
| -------------------------- | ----------------------------------------- |
| Cement (kg/m³)             | Main binder contributing to strength      |
| Blast Furnace Slag (kg/m³) | Supplementary cementitious material       |
| Fly Ash (kg/m³)            | Pozzolanic material improving workability |
| Water (kg/m³)              | Affects hydration and porosity            |
| Superplasticizer (kg/m³)   | Improves workability and reduces water    |
| Coarse Aggregate (kg/m³)   | Adds bulk and stability                   |
| Fine Aggregate (kg/m³)     | Fills voids for smooth texture            |
| Age (days)                 | Curing duration                           |
| Compressive Strength (MPa) | Target performance measure                |

---

## 🔍 Exploratory Data Analysis (EDA)

### Code Snippet

```r
summary(concrete_compressive_strength)
ggplot(concrete_compressive_strength, aes(x = `Concrete compressive strength(MPa, megapascals)`)) +
  geom_histogram(bins = 30, fill = "blue", color = "black") +
  theme_minimal() +
  labs(title = "Distribution of Concrete Compressive Strength")
```

### Insights

* **Distribution:** Positively skewed — most samples cluster around medium strength, with few very high-strength mixes.
* **Trends:** Scatterplots revealed strong **positive relationships** between *cement content* and *compressive strength*.

---

## 🧩 Correlation Analysis

### Code Snippet

```r
cor_matrix <- cor(concrete_compressive_strength %>% select(-`Concrete Category`, -`Contains Fly Ash`))
corrplot(cor_matrix, method = "circle", type = "upper", addCoef.col = "red")
```

### Key Findings

| Variable         | r-value   | Interpretation                   |
| ---------------- | --------- | -------------------------------- |
| Cement           | **0.75**  | Strong positive correlation      |
| Age              | **0.69**  | Longer curing increases strength |
| Water            | **–0.39** | Excess water weakens concrete    |
| Superplasticizer | **0.57**  | Improves workability & strength  |
| Coarse Aggregate | 0.21      | Weak but positive                |
| Fine Aggregate   | 0.12      | Minimal effect                   |

💡 *Cement and Age are the most influential factors, while water has a detrimental effect.*

---

## 📈 Regression Modeling

### 🔹 Simple Linear Regression

**Model:**
[
\text{Strength} = β_0 + β_1 \times \text{Cement} + ε
]

```r
model1 <- lm(`Concrete compressive strength(MPa, megapascals)` ~ `Cement (component 1)(kg in a m^3 mixture)`, data = concrete_compressive_strength)
summary(model1)
```

📊 **Results:**

* Each +1 kg/m³ cement → +0.0796 MPa in strength
* R² = **0.2478** → Cement explains 25% of variation
* p < 2e-16 → Statistically significant

---

### 🔹 Multiple Linear Regression

**Model:**
[
\text{Strength} = β_0 + β_1 \text{Cement} + β_2 \text{Slag} + β_3 \text{FlyAsh} + β_4 \text{Water} + β_5 \text{Superplasticizer} + β_6 \text{Aggregates} + β_7 \text{Age} + ε
]

```r
model2 <- lm(`Concrete compressive strength(MPa, megapascals)` ~ ., data = concrete_compressive_strength %>% select(-`Concrete Category`, -`Contains Fly Ash`))
summary(model2)
```

📊 **Equation:**
[
\text{Strength} = -23.16 + 0.1198Cement + 0.1038Slag + 0.0879FlyAsh - 0.1503Water + 0.2907Superplasticizer + 0.0180Coarse + 0.0202Fine + 0.1142Age
]

* **R² = 0.6155** → Explains ~62% of total variation
* **Cement, Slag, Fly Ash, and Age** = significant positive predictors
* **Water** = negative impact
* **Aggregates** = weak but stable effect

---

## 🧪 Hypothesis Testing

### H₀₁: No correlation between Cement and Strength

```r
cor.test(concrete_compressive_strength$`Cement (component 1)(kg in a m^3 mixture)`,
         concrete_compressive_strength$`Concrete compressive strength(MPa, megapascals)`)
```

✅ Result: r = **0.4978**, p < 2.2e-16 → **Reject H₀**
→ Cement significantly affects strength.

---

### H₀₂: Age has no impact on Strength

```r
age_model <- lm(`Concrete compressive strength(MPa, megapascals)` ~ `Age (day)`, data = concrete_compressive_strength)
summary(age_model)
```

✅ Result:

* Coefficient = **0.0869 MPa/day**
* R² = **0.1082**, p < 2e-16
  → **Reject H₀** — curing age significantly increases strength.

---

## ⚙️ Model Assumptions & Diagnostics

```r
shapiro.test(resid(model2))    # Normality test
ncvTest(model2)                # Homoscedasticity test
vif(model2)                    # Multicollinearity
```

📉 **Findings**

* Residuals are **non-normal** (Shapiro–Wilk test)
* **Heteroscedasticity** detected → variance not constant
* **Multicollinearity** between Cement and Slag

🧭 *Next steps:*
Apply **data transformation**, use **robust standard errors**, or **reduce correlated predictors**.

---

## 🧠 Key Insights

* **Cement** and **Curing Age** are the dominant predictors of compressive strength.
* **Water** reduces strength due to higher porosity.
* **Superplasticizers** improve performance by optimizing W/C ratio.
* **Aggregates** have limited direct effect but influence stability.

---

## 💡 Recommendations

1. ⚖️ **Optimize Cement Content:** Avoid overuse; balance strength & cost.
2. 💧 **Control Water–Cement Ratio:** Prevent excessive porosity.
3. 🌡️ **Ensure Proper Curing:** Maintain moisture and temperature for 28 days.
4. 🔄 **Explore Nonlinear Models:** Capture long-term strength development trends.

---

## 🧰 Tools & Libraries Used

* `ggplot2` — Visualization
* `corrplot` — Correlation matrix
* `car` — Diagnostic tests (VIF, ncvTest)
* `stats` — Regression & Hypothesis testing

---

## 📚 References

* Ambroziak, A. & Ziolkowski, P. (2020). *Concrete Compressive Strength under Changing Environmental Conditions during Placement Processes.* **Materials**, 13(20), 4577.
* Šverko, Z. et al. (2022). *Complex Pearson Correlation Coefficient for EEG Connectivity Analysis.* **Sensors**, 22(4), 1477.
