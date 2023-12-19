/* I'm acting as a data professional in charge of managing the database for an organisation that 
operates a type 1 diabetes care programme. The database that I am working on focuses on 
three tables: Patient, Clinic, and Insulin; the database name is Diabetes_care.
The following SQL codes applys the DML sublanguage. */

CREATE DATABASE Diabetes_care;
USE Diabetes_care;

-- Now we create each tables in the database 
-- Create the Patient table
CREATE TABLE patient (
	patientID INT PRIMARY KEY NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR (50) NOT NULL,
    age INT, 
    gender VARCHAR(10),
    diagnosisDate DATE
    );
-- Insert data into the 'patient' table
INSERT INTO 
	patient
    (patientID, firstName, lastName, age, gender, diagnosisDate)
VALUES 
	(1, 'Yom', 'Shewit', 7, 'M', '2020-01-15'),
    (2, 'Dawit', 'Haile', 39, 'M', '2018-03-20'),
    (3, 'Azeb', 'Nigatu', 40, 'F', '2023-11-10'),
    (4, 'Goitom', 'Mekonen', 35, 'M', '2022-05-21');
    
-- Create the 'clinic' table.
CREATE TABLE clinic(
	clinicID INT PRIMARY KEY NOT NULL,
    clinicName VARCHAR(100),
    location VARCHAR(100)
    );
-- Insert data into the 'clinic' table
INSERT INTO
	clinic
    (clinicID, clinicName, location)
    VALUES 
    (1, 'HealthyCare', 'Nairobi'),
    (2, 'MediClinic', 'Mombasa'),
    (3, 'Wellness Hospital', 'Nairobi');
    
-- Create the 'insulin' table
CREATE TABLE insulin (
	insulinID INT PRIMARY KEY NOT NULL,
    brandName VARCHAR (50), 
    insulinType VARCHAR (50),
    unitsPervial INT
	);
    
-- Insert data into the 'insulin' table:
INSERT INTO 
	insulin 
    (insulinID, brandName, insulinType, unitsPervial)
    VALUES 
    (1, 'NovoRapid', 'Fast-acting', 100),
    (2, 'Lantus', 'Long-acting', 300),
    (3, 'Humalog', 'Fast-acting', 50);
    
-- Now we need to establish relationships between the tables - by utilising the concept of primary and foreign keys
-- patient and clinic relationship
ALTER TABLE patient 
ADD clinicID INT,
ADD FOREIGN KEY (clinicID) REFERENCES clinic(clinicID);

-- Insert values for the new column, i.e., clinicID
UPDATE patient 
SET clinicID = 1 
WHERE patientID = 1;

UPDATE patient 
SET clinicID = 2 
WHERE patientID = 2;

UPDATE patient 
SET clinicID = 1 
WHERE patientID = 3;

UPDATE patient 
SET clinicID = 2 
WHERE patientID = 4;

-- patient and insulin relationship
ALTER TABLE patient
ADD insulinID INT,
ADD FOREIGN KEY (insulinID) REFERENCES insulin(insulinID);

-- add values for the insluinID column in patient
UPDATE patient 
SET insulinID = 1 
WHERE patientID = 4;

UPDATE patient 
SET insulinID = 2 
WHERE patientID = 3;

UPDATE patient 
SET insulinID = 3 
WHERE patientID = 1;

UPDATE patient 
SET insulinID = 1 
WHERE patientID = 2;

-- Add a new column called 'expiryDate' to the insulin table
ALTER TABLE insulin 
ADD expiryDATE DATE;

-- Update values for expiryDate 
UPDATE insulin 
SET expiryDATE = '2025-04-14'
WHERE insulinID = 3; 

-- delete a record with expiry date on 2025 -04 - 14, although it will generate error message as the id associated with this insulin is also foreign key for another table.
DELETE FROM 
	insulin
WHERE 
	insulinID = 3
    AND expiryDate = '2025-04-14';
-- end of exercise! 