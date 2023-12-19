/*
	Initial Data Analysis with Numeric Functions: Walk through
    
    1. What is the total number of data entry in the dataset?
    2. What are the earliest and latest years for which we have data?
    3. What is the average percentage of people who have access to manage drinking water services across 
    all the years and the countries included in our dataset?
    4. How many countries are included in this dataset?
*/

USE united_nations;
SELECT 
	COUNT(*) as Number_of_observations
    , MIN(Time_period) AS Min_time_period
    ,MAX(Time_period) AS Max_time_period 
    ,COUNT(DISTINCT Country_name) as Number_of_countries
    ,AVG(Pct_managed_drinking_water_services) as Average_managed_drinking_water_Services
FROM access_to_basic_services;

/*Tranform Columns using numeric functions 
	
*/
SELECT 
	Country_name
    ,Time_period
    ,ROUND(Est_gdp_in_billions) AS Rounded_est_gdp_in_billions
FROM 
	access_to_basic_services
LIMIT 10;

-- now we want to analyse the gdp growth rate over the time periods 
-- we can use logarithm functions because it more digestible for easier analysis of growth rate
-- more digestible representation of those large numbers. 
-- log function capture proportional changes rather than absolute changes
-- and often meaningful when analysing growth rates
-- Or, alternatively we can use SQRT function as well for a smaller rep of the values

SELECT 
	Country_name
    ,Time_period
    ,ROUND(Est_gdp_in_billions) AS Rounded_est_gdp_in_billions
    , ROUND(LOG(Est_gdp_in_billions), 2) AS Log_est_gdp_in_billions
    , ROUND(SQRT(Est_gdp_in_billions), 2) AS Sqrt_est_gdp_in_billions
FROM 
	access_to_basic_services;
    
/*We want a summary report that shows data on the pct of people that have access to manage drinking water services
at the regional level. 
We want to see the maximum, minimum, and average percentage to access managed drinking water services, 
the number of countries in the region, and the total gdp for the region.*/
-- look at the data using only Region and pct_managed_drinking_water_services columns 
SELECT 
	Region
    , Pct_managed_drinking_water_services
FROM 
	access_to_basic_services;
    
SELECT 
	Region
    , AVG(Pct_managed_drinking_water_services) AS AVG_pct_managed_drinking_water_services
    ,SUM(Pct_managed_drinking_water_services) AS SUM_pct_managed_drinking_water_services
    ,MIN(Pct_managed_drinking_water_services) AS Min_pct_managed_drinking_water_services
    ,MAX(Pct_managed_drinking_water_services) AS Max_pct_managed_drinking_water_services
    ,COUNT(DISTINCT Country_name) AS Number_of_countries
    , SUM(Est_gdp_in_billions) AS Total_gdp_in_billions
FROM 
	access_to_basic_services;
-- the above query generates error, because we didn't specify the group by clause 

-- The correct query as follows
SELECT 
	Region
    , AVG(Pct_managed_drinking_water_services) AS AVG_pct_managed_drinking_water_services
    ,SUM(Pct_managed_drinking_water_services) AS SUM_pct_managed_drinking_water_services
    ,MIN(Pct_managed_drinking_water_services) AS Min_pct_managed_drinking_water_services
    ,MAX(Pct_managed_drinking_water_services) AS Max_pct_managed_drinking_water_services
    ,COUNT(DISTINCT Country_name) AS Number_of_countries
    , SUM(Est_gdp_in_billions) AS Total_gdp_in_billions
FROM 
	access_to_basic_services
GROUP BY 
	Region; 
    
-- but we can group the data by region as well as sub region

SELECT 
	Region
    ,Sub_region
    , AVG(Pct_managed_drinking_water_services) AS AVG_pct_managed_drinking_water_services
    ,SUM(Pct_managed_drinking_water_services) AS SUM_pct_managed_drinking_water_services
    ,MIN(Pct_managed_drinking_water_services) AS Min_pct_managed_drinking_water_services
    ,MAX(Pct_managed_drinking_water_services) AS Max_pct_managed_drinking_water_services
    ,COUNT(DISTINCT Country_name) AS Number_of_countries
    , SUM(Est_gdp_in_billions) AS Total_gdp_in_billions
FROM 
	access_to_basic_services
GROUP BY 
	Region, Sub_region;
    
-- if we want to view our summary report in the order of estimated gdp 
SELECT 
	Region
    ,Sub_region
    , AVG(Pct_managed_drinking_water_services) AS AVG_pct_managed_drinking_water_services
    ,SUM(Pct_managed_drinking_water_services) AS SUM_pct_managed_drinking_water_services
    ,MIN(Pct_managed_drinking_water_services) AS Min_pct_managed_drinking_water_services
    ,MAX(Pct_managed_drinking_water_services) AS Max_pct_managed_drinking_water_services
    ,COUNT(DISTINCT Country_name) AS Number_of_countries
    , SUM(Est_gdp_in_billions) AS Total_gdp_in_billions
FROM 
	access_to_basic_services
GROUP BY 
	Region, Sub_region
ORDER BY
	Total_gdp_in_billions ASC;
    
-- Let us say the NGO require the same report but for the year 2020 and focusing on
-- the countries with pct managed drinking water services below 60%

SELECT 
	Region
    ,Sub_region
    , AVG(Pct_managed_drinking_water_services) AS AVG_pct_managed_drinking_water_services
    ,SUM(Pct_managed_drinking_water_services) AS SUM_pct_managed_drinking_water_services
    ,MIN(Pct_managed_drinking_water_services) AS Min_pct_managed_drinking_water_services
    ,MAX(Pct_managed_drinking_water_services) AS Max_pct_managed_drinking_water_services
    ,COUNT(DISTINCT Country_name) AS Number_of_countries
    , SUM(Est_gdp_in_billions) AS Total_gdp_in_billions
FROM 
	access_to_basic_services
WHERE 
	Time_period = 2020
AND 
	Pct_managed_drinking_water_services < 60
GROUP BY 
	Region, Sub_region
ORDER BY
	Total_gdp_in_billions ASC;
-- Due to the limited fund availability of funds, the NGO wants 
-- to write a summary for sub regions that have fewer than four countries
-- So we can't use the WHERE clause, because number of country is part of the aggregate function
-- and WHERE is executed before, thus we can use HAVING clause instead.
SELECT 
	Region
    ,Sub_region
    , AVG(Pct_managed_drinking_water_services) AS AVG_pct_managed_drinking_water_services
    ,SUM(Pct_managed_drinking_water_services) AS SUM_pct_managed_drinking_water_services
    ,MIN(Pct_managed_drinking_water_services) AS Min_pct_managed_drinking_water_services
    ,MAX(Pct_managed_drinking_water_services) AS Max_pct_managed_drinking_water_services
    ,COUNT(DISTINCT Country_name) AS Number_of_countries
    , SUM(Est_gdp_in_billions) AS Total_gdp_in_billions
FROM 
	access_to_basic_services
WHERE 
	Time_period = 2020
AND 
	Pct_managed_drinking_water_services < 60
GROUP BY 
	Region, Sub_region
HAVING 
	Number_of_countries < 4
ORDER BY
	Total_gdp_in_billions ASC;
    
-- Data Cleaning 
SELECT 
	DISTINCT Country_name
    ,LENGTH(Country_name) AS String_length
    ,POSITION('(' IN Country_name) As Pos_opening_bracket
    ,RTRIM(LEFT (Country_name, POSITION('(' IN Country_name)-1)) AS New_country_name
    ,LENGTH(RTRIM(LEFT (Country_name, POSITION('(' IN Country_name)-1))) AS String_new_length
FROM
	access_to_basic_services
WHERE 
	Country_name LIKE '%(%)%';
    
-- Creating a Custom ID by combing column values
SELECT 
	Country_name
    ,Time_period
    ,Est_population_in_millions
    ,CONCAT(
		SUBSTRING(IFNULL(UPPER(Country_name), 'UNKNOWN'), 1, 4)
		,SUBSTRING(IFNULL(Time_period, 'UNKNOWN'),1, 4)
		,SUBSTRING(IFNULL(Est_population_in_millions, 'UNKNOWN'),-7)
    ) AS Custom_id
FROM 
	access_to_basic_services;
    
-- Apllication of CASE statement 
/*
	
*/