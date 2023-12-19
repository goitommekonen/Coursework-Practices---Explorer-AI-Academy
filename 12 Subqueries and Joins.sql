/*Imagine we want to calculate the perccentage of land of a specific country in a sub region
occupies as a percentage of the total land area in that region.
We implement this with subquery 
*/
SELECT 
	Country_name
    ,ROUND(land_area/(total_area_for_mid_africa)) AS Pct_regional_land
FROM 
	geographic_location
WHERE 
	Sub_region = 'Middle Africa'; -- only for middle africa but we don't know the total area for middle africa
-- Subquery to calculate total area for middle africa
/*SELECT
	AVG(land_area) AS Regional_land_area
FROM 
	geographic_location
GROUP BY 
	Sub_region;
    */
-- Middle Africa countries 
SELECT 
	Country_name
    ,ROUND(land_area/(SELECT
							SUM(land_area)
						FROM 
							geographic_location
						WHERE
							Sub_region = 'Middle Africa')*100) AS Pct_regional_land
FROM 
	geographic_location
WHERE 
	Sub_region = 'Middle Africa';
-- We substitute for each sub region and retrieve the data 

-- Use correlation
SELECT 
	Country_name
    ,ROUND(land_area/(SELECT
							SUM(land_area)
						FROM 
							geographic_location
						WHERE
							Sub_region = g.Sub_region)*100) AS Pct_regional_land
FROM 
	geographic_location AS g;
    
-- it works well but the calculation is inefficient!
-- Now Join and Subquery
SELECT 
	geoloc.Country_name
    ,geoloc.Land_area
    ,geoloc.Sub_region
    ,ROUND(geoloc.land_area/land_per_region.TotalLandArea*100) AS PctOfRegionalLand
FROM 
	geographic_location AS geoloc 
JOIN 
	( SELECT 
		Sub_region
        ,SUM(Land_area) as TotalLandArea
	FROM 
		geographic_location
	GROUP BY
		Sub_region
    ) AS land_per_region
ON 
	geoloc.Sub_region = land_per_region.Sub_region;
    
/*
	What is the average GDP and population for countries with unemployment rate above 5% in 2020?
*/
-- two tasks:
-- 1) Create one subquery that filters countries with unemployment rate greater than 5%
-- 2) Compute the average values 
SELECT 
	Country_name
    ,Est_gdp_in_billions
    , Est_population_in_millions
FROM 
	economic_indicators
WHERE 
	Pct_unemployment >5
AND 
	Time_period = 2020;

-- Main Query 
SELECT 
	Country_name
    ,AVG(Est_gdp_in_billions) AS AVG_GDP
    ,AVG(Est_population_in_millions) AS AVG_Population
FROM 
	(SELECT 
		Country_name
		,Est_gdp_in_billions
		, Est_population_in_millions
	FROM 
		economic_indicators
	WHERE 
		Pct_unemployment >5
	AND 
		Time_period = 2020) AS FilteredCountries -- insert the above subquery here 
GROUP BY 
	Country_name;
    
/*
	For the year 2020, which countries have a GDP above the global average
    but still have less than 90% of their population with access to drinking water?
*/
-- Subquery 
SELECT 
	AVG(Est_gdp_in_billions)
FROM 
	economic_indicators
WHERE 
	Time_period = 2020;
-- Main query
SELECT 
	eco.Country_name
    ,eco.Time_period
    ,eco.Est_gdp_in_billions
    ,service.Pct_managed_drinking_water_services
FROM 
	economic_indicators AS eco
INNER JOIN 
	Basic_Services as service 
ON 
	eco.Country_name = service.Country_name
	AND eco.Time_period = service.Time_period
WHERE 
	eco.Time_period = 2020
    AND service.Pct_managed_drinking_water_services < 90
    AND eco.Est_gdp_in_billions > (SELECT 
										AVG(Est_gdp_in_billions)
									FROM 
										economic_indicators
									WHERE 
										Time_period = 2020);
