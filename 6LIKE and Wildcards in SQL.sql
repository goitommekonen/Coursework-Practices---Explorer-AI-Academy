/*It is common to find impoverished conditions in politically unstable countries
We will check for two countires, assuming that they are politically instable
and check their drinking water and sanitation services. 
*/
SELECT
	* 
FROM 
	access_to_basic_services
WHERE 
	Country_name = 'Iran'
OR 
	Country_name = 'North Korea';
    
-- we got empty records. Wrong countries names 
-- so we need to use LIKE and wildcards to get the correct result 
-- as the countries names are written something else
SELECT
	Country_name -- including the columns we are only interested
    ,Time_period
    ,Pct_managed_drinking_water_services
    ,Pct_managed_sanitation_services
FROM 
	access_to_basic_services
WHERE 
	Country_name LIKE 'Iran%'
OR 
	Country_name LIKE '%_Republic of Korea';
    
-- From the data we learn that Iran's and North Korea's basic services 
-- is in a good condition, also, North Korea has shown a decline in water services 
-- in the years to come
-- so, we can say that political instability has no
-- link with impverishment conditions just like what 
-- saw in African countries.