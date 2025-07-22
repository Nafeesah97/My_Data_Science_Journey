DROP DATABASE IF EXISTS `appointment_db`;
CREATE DATABASE `appointment_db`;
USE `Parks_and_Recreation`;

DROP TABLE IF EXISTS `appointments`;

CREATE TABLE appointments (
  PatientID BIGINT,
  AppointmentID INT,
  Gender VARCHAR(1),
  ScheduledDay DATETIME,
  AppointmentDay DATETIME,
  Age INT,
  Neighbourhood VARCHAR(50),
  Scholarship TINYINT,
  Hypertension TINYINT,
  Diabetes TINYINT,
  Alcoholism TINYINT,
  Handcap TINYINT,
  SMS_received TINYINT,
  No_show VARCHAR(3)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/KaggleV2-May-2016.csv'
INTO TABLE appointments
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT *
FROM appointments;