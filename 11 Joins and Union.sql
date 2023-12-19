SELECT * FROM united_nations.access_to_basic_services;
/*Suppose we want a summary of estimated unemployment rates per country for each time period in each region region
*/
SELECT 
	loc.Country_name
    ,eco.Time_period
    ,IFNULL(eco.Pct_unemployment, 19.59) AS Pct_unemployment_imputed
FROM 
	geographic_location AS loc
LEFT JOIN 
	economic_indicators as eco
ON eco.Country_name = loc.Country_name
WHERE 
	Region LIKE "%Central and Southern Asia%"
UNION 
SELECT 
	loc.Country_name
    ,eco.Time_period
    ,IFNULL(eco.Pct_unemployment, 19.59) AS Pct_unemployment_imputed
FROM 
	geographic_location AS loc
LEFT JOIN 
	economic_indicators as eco
ON eco.Country_name = loc.Country_name
WHERE 
	Region LIKE "%Easter and South-Eastern Asia%"
UNION 
SELECT 
	loc.Country_name
    ,eco.Time_period
    ,IFNULL(eco.Pct_unemployment, 22.64) AS Pct_unemployment_imputed
FROM 
	geographic_location AS loc
LEFT JOIN 
	economic_indicators as eco
ON eco.Country_name = loc.Country_name
WHERE 
	Region LIKE "%Central and Southern Asia%"
UNION 
SELECT 
	loc.Country_name
    ,eco.Time_period
    ,IFNULL(eco.Pct_unemployment, 24.43) AS Pct_unemployment_imputed
FROM 
	geographic_location AS loc
LEFT JOIN 
	economic_indicators as eco
ON eco.Country_name = loc.Country_name
WHERE 
	Region LIKE "%Europe and Northern America%"
UNION 
	SELECT 
	loc.Country_name
    ,eco.Time_period
    ,IFNULL(eco.Pct_unemployment, 24.23) AS Pct_unemployment_imputed
FROM 
	geographic_location AS loc
LEFT JOIN 
	economic_indicators as eco
ON eco.Country_name = loc.Country_name
WHERE 
	Region LIKE "%Latin America and the Carribean%"
UNION 
SELECT 
	loc.Country_name
    ,eco.Time_period
    ,IFNULL(eco.Pct_unemployment, 17.84) AS Pct_unemployment_imputed
FROM 
	geographic_location AS loc
LEFT JOIN 
	economic_indicators as eco
ON eco.Country_name = loc.Country_name
WHERE 
	Region LIKE "%Northern Africa and Western Asia%"
UNION 
SELECT 
	loc.Country_name
    ,eco.Time_period
    ,IFNULL(eco.Pct_unemployment, 4.98) AS Pct_unemployment_imputed
FROM 
	geographic_location AS loc
LEFT JOIN 
	economic_indicators as eco
ON eco.Country_name = loc.Country_name
WHERE 
	Region LIKE "%Oceania%"
UNION 
SELECT 
	loc.Country_name
    ,eco.Time_period
    ,IFNULL(eco.Pct_unemployment, 33.65) AS Pct_unemployment_imputed
FROM 
	geographic_location AS loc
LEFT JOIN 
	economic_indicators as eco
ON eco.Country_name = loc.Country_name
WHERE 
	Region LIKE "%Sub-Saharan Africa%";