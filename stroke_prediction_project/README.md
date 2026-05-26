# Stroke Risk Prediction Model

## Overview
This project looks at demographic and clinical data to identify patterns in stroke occurrence and build a model that can predict stroke risk. The work covers data cleaning, exploratory analysis, feature selection, and model building and comparison.

---

## Dataset
- **Source:** Simulated health dataset (Health_data_proj1.csv)
- **Size:** ~5,000 records (after cleaning)
- **Variables (11 total):**

| Variable | Description |
|---|---|
| gender | Male / Female |
| age | Patient age |
| hypertension | 0 = No, 1 = Yes |
| heart_disease | 0 = No, 1 = Yes |
| ever_married | Yes / No |
| work_type | Private, Self-employed, Govt_job, children, Never_worked |
| Residence_type | Urban / Rural |
| avg_glucose_level | Average blood glucose level |
| bmi | Body mass index |
| smoking_status | Never smoked, formerly smoked, smokes, Unknown |
| stroke | 0 = No stroke, 1 = Stroke (target variable) |

---

## Tools and Libraries
- **Language:** Python
- **Libraries:** pandas, numpy, seaborn, matplotlib, scikit-learn (LogisticRegression, RFE, KFold, train_test_split, LabelEncoder, Normalizer)

---

## Project Steps

### 1. Data Cleaning
The raw data had several inconsistencies including typos, extra spaces, and formatting errors across multiple columns. All were corrected manually. One row with gender listed as "Other" was dropped to reduce data complexity. Duplicate rows and the ID column were also removed.

### 2. Feature Engineering
Age, average glucose level, and BMI were grouped into ranges (e.g. age 60-80, glucose 50-100, BMI 20-40) to make patterns easier to visualize and interpret.

### 3. Exploratory Data Analysis
Bar charts were created for all categorical variables, comparing distributions with and without stroke outcome. Key patterns observed:

- There was not much difference in stroke occurrence between males and females
- Non-hypertensive people had more strokes than hypertensive people
- People without heart disease had more strokes than those with it
- The ever-married population had more strokes than those who had never married
- Private sector workers had the highest stroke occurrence, followed by the self-employed
- There was not much difference between urban and rural residents
- People who had never smoked had more strokes than current or former smokers
- The 60-80 age group had the highest stroke occurrence, followed by 40-60
- Persons with average glucose levels between 50-100 had the most stroke cases
- People with BMI between 20-40 had the most stroke cases
- There was a strong positive correlation between age and marriage status

### 4. Missing Value Handling
BMI had missing values. Two approaches were used and compared:
- **df:** Missing values filled using mean (for age, glucose) and median (for BMI, heart disease)
- **df2:** Rows with missing values dropped entirely

Both datasets were carried forward to see how the approach affected model performance.

### 5. Preprocessing
- Categorical variables were converted to numerical values using Label Encoding
- Outliers were removed from work type, glucose level, and BMI using the IQR method
- Hypertension and heart disease outliers were intentionally kept as they reflected data imbalance, not true outliers
- All features were normalized using scikit-learn's Normalizer

### 6. Feature Selection
Recursive Feature Elimination (RFE) with Logistic Regression was used to rank all features. The top 4 features were consistent across both datasets. The 5th feature differed (smoking status vs hypertension), so both were included, giving 6 final features:

> **Age, BMI, Average Glucose Level, Work Type, Hypertension, Smoking Status**

### 7. Model Building and Comparison
Two models were built using Logistic Regression:

| Model | Dataset with dropped nulls (df2) | Dataset with filled nulls (df) |
|---|---|---|
| Train-Test Split | 50% | 50% |
| K-Fold Cross-Validation | 58% | **62.5%** |

Cross-validation outperformed train-test split in both cases. The higher accuracy on the filled null dataset likely reflects the larger sample size, though the filled values may also introduce some noise.

---

## Key Findings
- Cross-validation was the more stable and accurate model for this dataset
- Age was the strongest predictor of stroke risk
- The dataset had significant class imbalance (far fewer stroke cases than non-stroke), which affects model accuracy
- Missing value handling strategy had a measurable impact on model performance

---

## Public Health Relevance

- Stroke is the third leading cause of death in Canada and a major driver of long-term disability, costing the health system over $3.6 billion annually
- Identifying which population subgroups carry the highest risk supports targeted prevention programs and more efficient use of health resources
- Findings suggest that stroke prevention messaging should extend beyond traditionally recognized high-risk groups to include working-age adults in high-demand employment sectors 

---
## Limitations
- The dataset is simulated and may not fully reflect real-world health data distributions
- Class imbalance was not resampled (e.g. SMOTE was not applied), which limits model sensitivity for the minority class
- Logistic Regression was the only algorithm tested; future work could compare other classifiers

---

## Future Work
- Apply resampling techniques to handle class imbalance
- Use the trained model to predict missing BMI values and reassess accuracy
- Test additional classification models (Random Forest, XGBoost)

---

## Author
**Naffisat Salaudeen**
Public Health Data Analyst

- GitHub: [Nafeesah97](https://github.com/Nafeesah97/My_Data_Science_Journey)
- LinkedIn: [naffisat-salaudeen](https://www.linkedin.com/in/naffisat-salaudeen-74ba60240)
- Email: naffisatsalaudeen@gmail.com
