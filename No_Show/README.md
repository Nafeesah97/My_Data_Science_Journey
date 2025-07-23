# No-Show Appointments Analysis 📅🚫

This project analyzes over 110,000 medical appointment records in Brazil to uncover insights into patient attendance behavior. The dataset tracks whether patients showed up for their scheduled medical appointments, including variables like age, gender, neighborhood, chronic conditions, and reminders.

## 📌 Project Overview
- This project analyzes over 110,000 medical appointments from Brazil to uncover the factors influencing patient no-shows. Using SQL, the data was cleaned and explored to identify trends based on age, gender, neighborhood, chronic conditions, wait times, and SMS reminders.

## ❓ Problem Statement
- Missed appointments lead to wasted resources and reduced healthcare efficiency. This analysis aims to answer:

-- What factors contribute to patients missing their appointments?

-- Can trends be identified to help reduce future no-shows?

- The goal is to support better scheduling strategies and improve patient follow-up practices.

## 🔗 Dataset Source

- [Kaggle: No-show appointments](https://www.kaggle.com/datasets/joniarroba/noshowappointments)

---

## 🧰 Tools Used

- **MySQL** for data import, cleaning, querying, and aggregation
- **Spreadsheet (pre-processing)**: Replaced `T` with space and removed `Z` from datetime fields in the CSV

---

## 📊 Data Overview

| Field | Description |
|-------|-------------|
| `PatientId` | Unique identifier for each patient |
| `AppointmentID` | Unique identifier for each appointment |
| `Gender` | Male or Female |
| `ScheduledDay` | Day the appointment was scheduled |
| `AppointmentDay` | Day of the actual appointment |
| `Age` | Patient's age |
| `Neighbourhood` | Location of the clinic |
| `Scholarship` | Whether the patient receives a government welfare program |
| `Hypertension`, `Diabetes`, `Alcoholism`, `Handcap` | Chronic conditions or disabilities |
| `SMS_received` | Whether a reminder SMS was sent |
| `No-show` | "Yes" if patient missed the appointment, "No" otherwise |

---

## 🧹 Data Cleaning

- Removed time zone noise (`T` and `Z`) from datetime columns
- Checked for missing values and anomalies
- Verified consistency using SQL commands such as `DISTINCT`, `CASE`, and aggregate functions

---

## 📈 Key Findings

### ➤ General Stats
- **Total Appointments**: 110,526  
- **No-Shows**: 22,319  
- **Show-Ups**: 88,207  
- **Overall No-Show Rate**: ~20%  
- **Average Wait Time**:  
  - No-Shows: 15 days  
  - Show-Ups: 8 days  

---

### ➤ No-Show Rate by Neighborhoods

#### Top 5 Neighborhoods by Patient Volume:
| Neighbourhood | % of Total Patients | No-Show Rate (%) |
|---------------|---------------------|------------------|
| Jardim Camburi | 6.98% | 19% |
| Maria Ortiz | 5.25% | 21% |
| Resistência | 4.01% | 20% |
| Jardim da Penha | 3.51% | 16% |
| Itararé | 3.18% | 26% |

#### Top 5 by Highest No-Show Rates:
| Neighbourhood | % of Total Patients | No-Show Rate (%) |
|---------------|---------------------|------------------|
| Ilhas Oceânicas de Trindade | 0.0018% | 100% |
| Santos Dumont | 1.15% | 29% |
| Santa Cecília | 0.41% | 27% |
| Santa Clara | 0.46% | 26% |
| Itararé | 3.18% | 26% |

---

### ➤ No-Show by Demographics

#### By Gender:
- **Male**: 20%
- **Female**: 20%

#### By Age Group:
| Age Group | No-Show Rate (%) |
|-----------|------------------|
| 110–119 | 60% |
| 20–29 | 25% |
| 10–19 | 25% |
| 30–39 | 22% |
| 0–9 | 20% |
| 50–59 | 17% |
| 80–89 | 16% |
| 60–69 / 70–79 | 15% |
| 100–109 | 0% |

#### By Age Category:
| Category | No-Show Rate (%) |
|----------|------------------|
| Teen (10–19) | 26% |
| Adult (20–59) | 20% |
| Child (0–9) | 20% |
| Senior (60+) | 16% |

---

### ➤ No-Show by Underlying Conditions

| Condition | Total Patients | No-Show Rate (%) |
|-----------|----------------|------------------|
| Alcoholism | 3,360 | 20% |
| Diabetes | 7,943 | 18% |
| Handcap | 2,241 | 18% |
| Hypertension | 21,801 | 17% |

---

### ➤ Other Influencing Factors

- **Scholarship holders**: 20% no-show rate  
- **Non-scholarship**: 24% no-show rate  
- **With SMS reminders**: 28% no-show rate  
- **Without reminders**: 17% no-show rate  

#### By Day of the Week:
| Day | No-Show Rate (%) |
|-----|------------------|
| Saturday | 23% |
| Friday & Monday | 21% |
| Tuesday & Wednesday | 20% |
| Thursday | 19% |

---

## 📌 Conclusion

The analysis highlights important factors linked to patient no-shows:
- Younger age groups (especially teens and young adults) are more likely to miss appointments.
- SMS reminders, surprisingly, show **higher** no-show rates—likely a selection bias.
- Certain neighborhoods and chronic conditions may correlate with higher attendance issues.
- Wait time plays a major role: longer delays between scheduling and appointments increase no-shows.

---

## 🚀 Next Possible Explorations

- Explore machine learning models to predict no-shows
- Compare SMS reminder effectiveness across age or health categories
- Investigate socio-economic impacts using external demographic data

---



