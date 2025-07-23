-- To view the entire data
SELECT *
FROM appointments;

-- Familiarizing with the type of data
SHOW COLUMNS FROM appointments;

-- Familiarizing with the type of data
SELECT MIN(Age), MAX(Age)
FROM appointments;

-- Familiarizing with the type of data
SELECT DISTINCT Gender
FROM appointments;

-- Familiarizing with the type of data
SELECT DISTINCT No_show
FROM appointments;

-- Familiarizing with the type of data
SELECT DISTINCT Neighbourhood
FROM appointments;

-- Familiarizing with the type of data
SELECT DISTINCT SMS_received
FROM appointments;

-- Familiarizing with the type of data
SELECT DISTINCT Scholarship
FROM appointments;

-- Familiarizing with the type of data
SELECT DISTINCT Hypertension
FROM appointments;

-- Familiarizing with the type of data
SELECT DISTINCT Diabetes
FROM appointments;

-- Familiarizing with the type of data
SELECT DISTINCT Alcoholism
FROM appointments;

-- Familiarizing with the type of data
SELECT DISTINCT Handcap
FROM appointments;

-- Familiarizing with the type of data
SELECT DISTINCT SMS_received
FROM appointments;

-- Checking for NULL values
SELECT
SUM(CASE WHEN PatientID IS NULL 
	OR TRIM(PatientID) = '' THEN 1 ELSE 0 END) AS Missing_PatientID,
SUM(CASE WHEN Gender IS NULL 
	OR TRIM(Gender) = '' THEN 1 ELSE 0 END) AS Missing_Gender,
SUM(CASE WHEN ScheduledDay IS NULL 
	OR TRIM(ScheduledDay) = ' ' THEN 1 ELSE 0 END) AS Missing_ScheduledDay,
SUM(CASE WHEN AppointmentDay IS NULL 
	OR TRIM(AppointmentDay) = ' ' THEN 1 ELSE 0 END) AS Missing_AppointmentDay,
SUM(CASE WHEN Age IS NULL OR Age < 0
	OR TRIM(Age) = ' ' THEN 1 ELSE 0 END) AS Missing_Age,
SUM(CASE WHEN Neighbourhood IS NULL 
	OR TRIM(Neighbourhood) = '' THEN 1 ELSE 0 END) AS Missing_Neighbourhood,
SUM(CASE WHEN Scholarship IS NULL 
	OR TRIM(Scholarship) = '' THEN 1 ELSE 0 END) AS Missing_Scholarship,
SUM(CASE WHEN Hypertension IS NULL 
	OR TRIM(Hypertension) = '' THEN 1 ELSE 0 END) AS Missing_Hypertension,
SUM(CASE WHEN Diabetes IS NULL 
	OR TRIM(Diabetes) = '' THEN 1 ELSE 0 END) AS Missing_Diabetes,
SUM(CASE WHEN Alcoholism IS NULL 
	OR TRIM(Alcoholism) = '' THEN 1 ELSE 0 END) AS Missing_Alcoholism,
SUM(CASE WHEN Handcap IS NULL 
	OR TRIM(Handcap) = '' THEN 1 ELSE 0 END) AS Missing_Handcap,
SUM(CASE WHEN SMS_received IS NULL 
	OR TRIM(SMS_received) = '' THEN 1 ELSE 0 END) AS Missing_SMS_received,
SUM(CASE WHEN No_show IS NULL
	OR TRIM(No_show) = '' THEN 1 ELSE 0 END) AS Missing_No_Show
FROM appointments;

-- removing outlier
DELETE FROM appointments
WHERE Age < 0;

-- Total appointments
SELECT COUNT(*) AS total_appointments
FROM appointments;

-- Total No-show ups and show ups 
CREATE OR REPLACE VIEW TotalShows AS
SELECT 
	SUM(CASE WHEN No_show LIKE '%Yes%' THEN 1 ELSE 0 END) AS "TotalNo_Show",
    SUM(CASE WHEN No_show LIKE '%No%' THEN 1 ELSE 0 END) AS "TotalShow"
FROM appointments;

SELECT *
FROM TotalShows;

-- No Show Rate
SELECT ROUND(
	SUM(CASE WHEN No_show LIKE '%Yes%' THEN 1 ELSE 0 END) / COUNT(*), 2) * 100 AS NoShowRate
FROM appointments;

-- Avg Wait Time
SELECT ROUND(AVG(wait_time), 2) AS AverageWaitTime
FROM 
	(
    SELECT AppointmentDay, ScheduledDay, No_show, 
	TIMESTAMPDIFF(DAY, ScheduledDay, AppointmentDay) AS wait_time
	FROM appointments
    ) AS wait_time_table;


-- Average wait time for no_shows
SELECT ROUND(AVG(wait_time), 2) AS WaitTimeNoShow 
FROM 
	(
    SELECT AppointmentDay, ScheduledDay, No_show, 
	TIMESTAMPDIFF(DAY, ScheduledDay, AppointmentDay) AS wait_time
	FROM appointments
    WHERE No_show LIKE '%Yes%'
    ) AS wait_time_table;
    
-- Average wait time for show ups
SELECT ROUND(AVG(wait_time), 2) AS WaitTimeShow
FROM 
	(
    SELECT AppointmentDay, ScheduledDay, No_show, 
	TIMESTAMPDIFF(DAY, ScheduledDay, AppointmentDay) AS wait_time
	FROM appointments
    WHERE No_show LIKE '%No%'
    ) AS wait_time_table;
    
    
-- No show rate by gender
SELECT Gender, COUNT(*) AS total_appointments, (
	ROUND(SUM(CASE WHEN No_show LIKE '%Yes%' THEN 1 ELSE 0 END) / COUNT(*), 2)
    ) * 100 AS NoShowRate
FROM appointments
GROUP BY gender;


-- No show rate by age
SELECT 
	FLOOR(age / 10) * 10 AS age_group,
    COUNT(*) AS total_patient,
    ROUND(SUM(
    CASE WHEN No_show LIKE '%Yes%' THEN 1 ELSE 0 
    END) / COUNT(*), 2) * 100 AS NoShowRate
FROM appointments
GROUP BY age_group
ORDER BY NoShowRate DESC;
    
-- No show rate by age category
SELECT 
  CASE 
    WHEN age < 13 THEN 'Child'
    WHEN age BETWEEN 13 AND 19 THEN 'Teen'
    WHEN age BETWEEN 20 AND 64 THEN 'Adult'
    ELSE 'Senior'
  END AS age_category,
  COUNT(*) AS total_patient,
  ROUND(SUM(
  CASE WHEN No_show LIKE '%Yes%' THEN 1 ELSE 0 
  END) / COUNT(*), 2) * 100 AS NoShowRate
FROM appointments
GROUP BY age_category
ORDER BY NoShowRate DESC;

-- No Show rate by underlying medical conditions
SELECT 'Hypertension' AS `CONDITION`,
	COUNT(*) AS total_patient,
    ROUND(SUM(
    CASE WHEN No_show LIKE '%Yes%' THEN 1 ELSE 0
    END) / COUNT(*), 2) * 100 AS NoShowRate
FROM appointments
WHERE Hypertension = 1

UNION ALL

SELECT 'Diabetes' AS `CONDITION`,
	COUNT(*) AS total_patient,
    ROUND(SUM(CASE WHEN No_show LIKE '%Yes%' THEN 1 ELSE 0 
    END) / COUNT(*), 2) * 100 AS NoShowRate
FROM appointments
WHERE Diabetes = 1

UNION ALL

SELECT 'Alcoholism' AS `CONDITION`,
	COUNT(*) AS total_patient,
    ROUND(SUM(CASE WHEN No_show LIKE '%Yes%' THEN 1 ELSE 0 
    END) / COUNT(*), 2) * 100 AS NoShowRate
FROM appointments
WHERE Alcoholism = 1

UNION ALL

SELECT 'Handcap' AS `CONDITION`,
	COUNT(*) AS total_patient,
    ROUND(SUM(
    CASE WHEN No_show LIKE '%Yes%' THEN 1 ELSE 0 
    END) / COUNT(*), 2) * 100 AS NoShowRate
FROM appointments
WHERE Handcap > 0
ORDER BY NoShowRate DESC;

-- No-show rate by Scholarships
SELECT Scholarship,
	COUNT(*) AS total_patient,
    ROUND(SUM(
    CASE WHEN No_show LIKE '%Yes%' THEN 1 ELSE 0 
    END) / COUNT(*), 2) * 100 AS NoShowRate
FROM appointments
GROUP BY Scholarship;

-- No-shows by SMS reminders
SELECT SMS_received,
	COUNT(*) AS total_patient,
    ROUND(SUM(
    CASE WHEN No_show LIKE '%Yes%' THEN 1 ELSE 0 
    END) / COUNT(*), 2) * 100 AS NoShowRate
FROM appointments
GROUP BY SMS_received;

-- No-shows by neighbourhood
-- Top 5 neighbourhoods with most patients
SELECT Neighbourhood,
	COUNT(*) / (
    SELECT COUNT(*) FROM appointments) * 100 AS total_patient,
    ROUND(SUM(
    CASE WHEN No_show LIKE '%Yes%' THEN 1 ELSE 0 
    END) / COUNT(*), 2) * 100 AS NoShowRate
FROM appointments
GROUP BY Neighbourhood
ORDER BY total_patient DESC LIMIT 5;

-- Top 5 neighbourhoods with highest no show rate
SELECT Neighbourhood,
	COUNT(*) / (
    SELECT COUNT(*) FROM appointments) * 100 AS total_patient,
    ROUND(SUM(
    CASE WHEN No_show LIKE '%Yes%' THEN 1 ELSE 0 
    END) / COUNT(*), 2) * 100 AS NoShowRate
FROM appointments
GROUP BY Neighbourhood
ORDER BY NoShowRate DESC LIMIT 5;

-- No Show rate by days of the week
SELECT DAYNAME(AppointmentDay) AS `Day`,
	COUNT(*) AS total_patient,
    ROUND(SUM(
    CASE WHEN No_show LIKE '%Yes%' THEN 1 ELSE 0 
    END) / COUNT(*), 2) * 100 AS NoShowRate
FROM appointments
GROUP BY  `Day`
ORDER BY NoShowRate DESC;
