-- creating and accessing a database 

CREATE DATABASE united_nations;
USE united_nations;

-- creating new table into our united_nations db
CREATE TABLE Access_to_Basic_Services (
		Region VARCHAR (32),
        Sub_region VARCHAR (32),
        Country_name CHAR (32) NOT NULL,
        Time_period INTEGER NOT NULL, 
        Pct_managed_drinking_water_services NUMERIC (5,2),
        Pct_managed_sanitation_services NUMERIC (5,2),
        Est_population_in_millions NUMERIC (12,6),
        Est_gdp_in_billions NUMERIC (8,2),
        Land_area NUMERIC (10,2),
        Pct_umemployment NUMERIC (5,2)
    );
-- checking our new table if data exists in it. 
SELECT 
	* 
FROM 
	Access_to_Basic_Services;

-- Update Values 
UPDATE Access_to_Basic_Services
SET Pct_umemployment = 4.53
WHERE 
	Country_name = 'China'
AND Time_period = 2016;
    
-- adding new column to our Access_to_Basic_Services table 
ALTER TABLE Access_to_Basic_Services
ADD Gini_index FLOAT;

-- check the fields using the SELECT statement as an alternative
SELECT 
	* 
FROM 
	Access_to_Basic_Services;
    
-- listing the fields of table Access_to_Basic_Services     
DESCRIBE Access_to_Basic_Services; -- or
SHOW COLUMNS FROM Access_to_Basic_Services;

-- change/modify the datatype of Country_name 
ALTER TABLE Access_to_Basic_Services
MODIFY COLUMN Country_name VARCHAR(37);

-- check the status of the columns 
DESCRIBE Access_to_Basic_Services;

-- TRUNCATE data in a table 
TRUNCATE TABLE Access_to_Basic_Services;

-- DROP Tables and the entire database, united_nations
DROP TABLE Access_to_Basic_Services;
DROP DATABASE united_nations;

-- End of the programme.
