/*
This lab exercise analyses the availability of drinking water 
and sanitation services in Sub Saharan region and see if they 
correlate with the countries gdp
*/
-- first lets get our result set using the SELECT WHERE statement

SELECT 
	Country_name
    ,Region
    ,Time_period
    ,Pct_managed_drinking_water_services
	,Pct_managed_sanitation_services
    ,Est_gdp_in_billions
FROM 
	access_to_basic_services
WHERE 
	Region = 'Sub-Saharan Africa'
AND
	Time_period = 2020
AND 
	Est_gdp_in_billions IS NOT NULL
-- running the above query will give us South Africa, Ethiopia, Kenya and Ghana are top gdps
-- and to display only these countries.
AND 
-- Country_name IN ('Nigeria', 'South Africa', 'Ethiopia', 'Kenya', 'Ghana');
-- the result tells us that Nigeria has a lower percentage of drinking water
-- and sanitation than South Africa. Therefore there is no much correlation
-- and we want to check to the other countries as well by excluding the top countries
-- by modifying the above last AND condition.
	Country_name NOT IN ('Nigeria', 'South Africa', 'Ethiopia', 'Kenya', 'Ghana');
-- Burundi with nearly similar drinking water 
-- and sanitation as Nigeria has really low gdp. 
-- therefore we can conclude that there is no any noticeable correlction
-- between drinking water and sanitation to gdp.alter

