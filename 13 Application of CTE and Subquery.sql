/*
Determine countries in the Sub-Saharan African region with struggling economies that 
have low access to drinking water and sanitation services in 2020, based on the averaged GDP on the region.
*/
-- 
SELECT 
	Country_name
    ,Pct_managed_drinking_water_services
    ,Pct_managed_sanitation_services
    ,Est_gdp_in_billions
    ,AVG(Est_gdp_in_billions) OVER(
			PARTITION BY Region
        ) AS Avg_gdp_for_region
FROM 
	access_to_basic_services
WHERE 
	Region = 'Sub-Saharan Africa'
    AND 
    Time_period = 2020
    AND 
	Pct_managed_drinking_water_services <60
    AND 
	Est_gdp_in_billions < Avg_gdp_for_region;
-- this will generate error bc Avg_gdp_for_region is not known in the where clause
-- To solve this, 1) use Subquery
SELECT 
	* 
FROM (SELECT 
	Country_name
    ,Pct_managed_drinking_water_services
    ,Pct_managed_sanitation_services
    ,Est_gdp_in_billions
    ,AVG(Est_gdp_in_billions) OVER(
			PARTITION BY Region
        ) AS Avg_gdp_for_region
	FROM 
		access_to_basic_services
	WHERE 
		Region = 'Sub-Saharan Africa'
		AND 
		Time_period = 2020
		AND 
		Pct_managed_drinking_water_services <60
	) AS Regional_comparison
WHERE 
	Est_gdp_in_billions < Avg_gdp_for_region;
-- 2) also try using CTE query
-- first create the base query
WITH Regional_avg_GDP AS(
	 SELECT 
	Country_name
    ,Pct_managed_drinking_water_services
    ,Pct_managed_sanitation_services
    ,Est_gdp_in_billions
    ,AVG(Est_gdp_in_billions) OVER(
			PARTITION BY Region
        ) AS Avg_gdp_for_region
	FROM 
		access_to_basic_services
	WHERE 
		Region = 'Sub-Saharan Africa'
		AND 
		Time_period = 2020
		AND 
		Pct_managed_drinking_water_services <60
	)
-- outer query 
SELECT 
	*
FROM 
	Regional_avg_GDP 
WHERE 
	Est_gdp_in_billions < Avg_gdp_for_region;
-- End!