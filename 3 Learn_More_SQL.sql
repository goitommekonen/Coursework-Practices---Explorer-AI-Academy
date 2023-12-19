/*This is sql practice is powered by Web Dev Simplified, and is further developed on 
his tutorial to learn SQL in detail. */
CREATE DATABASE record_company;
USE record_company;
-- Create table bands 
CREATE TABLE bands (
	id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
    );
    
-- Create table albums 
CREATE TABLE albums(
	id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    release_Year INT,
    band_Id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (band_Id) REFERENCES bands(id)
    );

INSERT INTO 
	bands
		(name)
VALUES 
	('Big Star'),
    ('Arcade Fire'),
    ('Iron Maiden'),
    ('Deuce'),
    ('Avenged Sevenfold'),
    ('Ankor');
-- display all the values we inserted above.
SELECT 
	* 
FROM 
	bands;
-- display only two rows 
SELECT 
	*
FROM 
	bands 
LIMIT 2; 

-- select names only
SELECT 
	name 
FROM
	bands;
-- use aliases for column names 
SELECT 
	id
AS 'Band ID',
	name 
AS "Band Name"
FROM 
	bands;

-- use more sql statments 
SELECT 
	* 
FROM 
	bands 
ORDER BY name; -- add DESC if you want in descending order

-- Insert few values into table album
INSERT INTO 
	albums 
		(name, release_Year, band_Id)
VALUES 
	('The Number of the Beasts', 1985, 1),
    ('Power Slave', 1984, 1),
    ('Nightmare', 2018, 2),
    ('Nightmare', 2010, 3),
    ('Test Album', NULL, 3);
-- Querying the albums table
SELECT 
	* 
FROM 
	albums;

SELECT 
	name 
FROM 
	albums;

-- display distinct names
SELECT
DISTINCT 
	name 
FROM 
	albums;
UPDATE albums
SET release_Year = 1982
WHERE id = 1;
-- filtering data from albums table
SELECT 
	*
FROM 
	albums 
WHERE 
	release_Year <2000;
    
SELECT 
	*
FROM
	albums
WHERE 
	name LIKE '%er%' 
    OR band_Id = 2;
    
SELECT 
	* 
FROM 
	albums
WHERE 
	release_Year = 1984
    AND band_Id = 1;
    
SELECT 
	*
FROM 
	albums
WHERE 
	release_Year 
BETWEEN 
	2000 
AND 
	2018;
    
SELECT 
	*
FROM
	albums
WHERE 
	release_year 
IS NULL;

DELETE 
FROM 
	albums 
WHERE 
	id = 5;

SELECT 
	*
FROM
	albums;
    
-- Join statements
SELECT 
	* 
FROM 
	bands 
INNER JOIN albums 
ON bands.id = albums.band_Id;

SELECT 
	* 
FROM 
	bands 
LEFT JOIN albums 
ON bands.id = albums.band_Id;

SELECT 
	* 
FROM 
	bands 
RIGHT JOIN albums 
ON bands.id = albums.band_Id;

-- Aggregate functions 
SELECT 
	AVG(release_Year) as AVERAGE_RELEASE_YEAR 
FROM 
	albums;
    
SELECT 
	band_Id,
    COUNT(band_Id) AS TOTAL_BANDS_IN_ALBUM
FROM
	albums
GROUP BY band_Id;

SELECT 
	b.name as Band_Name, 
    COUNT(b.id) as num_Albums 
FROM 
	bands as b
LEFT JOIN albums as a 
ON b.id = a.band_Id
GROUP BY b.id
HAVING num_albums = 1
AND b.name = 'Deuce';
-- end of exercise! 