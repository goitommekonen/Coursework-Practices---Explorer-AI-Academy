USE united_nations;
SELECT * FROM united_nations.access_to_basic_services;
-- Create Geographic location table
CREATE TABLE Geographic_Location(
	Country_name VARCHAR(37) NOT NULL PRIMARY KEY
    ,Sub_region VARCHAR(27)
    ,Region VARCHAR(32)
    ,Land_area NUMERIC(10,2)
);
-- insert data from the old table to the new one
INSERT INTO 
	geographic_location(
    Country_name
    ,Sub_region
    ,Region 
    ,Land_area)
SELECT
	Country_name
    ,Sub_region
    ,Region
    ,AVG(Land_area) AS Country_area -- use aggregate function to avoid the group by clause error
FROM 
	access_to_basic_services
GROUP BY 
	Country_name
    ,Sub_region
    ,Region;
-- Retrieve data from the new table
SELECT 
	* 
FROM 
	geographic_location;
    
-- Create Basic Services table.
CREATE TABLE Basic_Services( 
	Country_name VARCHAR(37)
    ,Time_period INTEGER
    ,Pct_managed_drinking_water_services NUMERIC(5,2)
    ,Pct_managed_sanitation_services NUMERIC(5,2)
    ,PRIMARY KEY (Country_name, Time_period)
    ,FOREIGN KEY (Country_name) REFERENCES Geographic_Location(Country_name)
);

-- Insert data from the old table to the new one
INSERT INTO Basic_Services(
	Country_name
    ,Time_period
    ,Pct_managed_drinking_water_services
    ,Pct_managed_sanitation_services
    )
SELECT 
	Country_name
    ,Time_period
    ,Pct_managed_drinking_water_services
    ,Pct_managed_sanitation_services
FROM 
	Access_to_Basic_Services;
-- Populate data from the new table to see if it works correctly
SELECT 
	* 
FROM 
	Basic_Services;
-- Now create another table called Economic Indicators 
CREATE TABLE Economic_Indicators(
	Country_name VARCHAR(37)
    ,Time_period INTEGER
    ,Est_gdp_in_billions NUmERIC(8,2)
    ,Est_population_in_millions NUMERIC(11,6)
    ,Pct_unemployment NUMERIC(5,2)
    ,PRIMARY KEY (Country_name, Time_period)
    ,FOREIGN KEY(Country_name) REFERENCES Geographic_Location(Country_name)
);
-- Insert the relavant data from the old table
INSERT INTO Economic_Indicators(
	Country_name
    ,Time_period
    ,Est_gdp_in_billions
    ,Est_population_in_millions
    ,Pct_unemployment
    )
SELECT 
	Country_name
    ,Time_period
    ,Est_gdp_in_billions
    ,Est_population_in_millions
    ,Pct_unemployment
FROM 
	access_to_basic_services;
-- Dropping tables with relations
DROP TABLE geographic_location;
-- can't drop table referenced by a FK
-- So drop child tables first or remove FK constraints
DROP TABLE economic_indicators;
DROP TABLE basic_services;
DROP TABLE geographic_location;
DROP TABLE countries_list;
-- We permanently deleted the tables,
-- but let us recreate them

DROP TABLE IF EXISTS Basic_Services;
DROP TABLE IF EXISTS Economic_Indicators;
DROP TABLE IF EXISTS Geographic_Location;

/* Create Geographic_Location Table */
CREATE TABLE Geographic_Location (
Country_name VARCHAR(37) PRIMARY KEY,
Sub_region VARCHAR(25),
Region VARCHAR(32),
Land_area NUMERIC(10,2));

/* Adding data */
INSERT INTO Geographic_Location(
	Country_name
    ,Sub_region
    ,Region
    ,Land_area)
SELECT 
	Country_name
	,Sub_region
	,Region
	,AVG(Land_area) as Country_area
FROM 
	Access_to_Basic_Services
GROUP BY 
	Country_name
	,Sub_region
	,Region;
/* Create Economic_Indicators Table */
CREATE TABLE Economic_Indicators(
	Country_name VARCHAR(37)
	,Time_period INTEGER
	,Est_gdp_in_billions NUMERIC(8,2)
	,Est_population_in_millions NUMERIC(11,6)
    ,Pct_unemployment NUMERIC(5,2)
	,PRIMARY KEY (Country_name, Time_period)
	,FOREIGN KEY (Country_name) REFERENCES Geographic_Location (Country_name)
);

/* Adding data */
INSERT INTO Economic_Indicators(
	Country_name
    ,Time_period
    ,Est_gdp_in_billions
	,Est_population_in_millions 
    ,Pct_unemployment
	)
SELECT 
	Country_name
	,Time_period
	,Est_gdp_in_billions
	,Est_population_in_millions
	,Pct_unemployment
FROM 
	Access_to_Basic_Services;
    
/* Create Basic_Services Table */
CREATE TABLE Basic_Services(
	Country_name VARCHAR(37)
	,Time_period INTEGER
	,Pct_managed_drinking_water_services NUMERIC(5,2)
	,Pct_managed_sanitation_services NUMERIC(5,2)
	,PRIMARY KEY (Country_name, Time_period)
	,FOREIGN KEY (Country_name) REFERENCES Geographic_Location (Country_name)
);

/* Adding data */
INSERT INTO Basic_Services(
	Country_name
    ,Time_period
    ,Pct_managed_drinking_water_services
	,Pct_managed_sanitation_services
	)
SELECT 
	Country_name
	,Time_period
	,Pct_managed_drinking_water_services
	,Pct_managed_sanitation_services
FROM 
	Access_to_Basic_Services;
-- End! 