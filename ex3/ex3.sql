/*
* File: ex3.sql Comp 2521, Fall 2021, Tutorial 3
* Matt Smith
* Sept 27, 2021
*/

\! rm -f ex3.log
tee ex3.log

use world

/* Queries */
/* 1 */
SELECT Country.Name AS country, City.Name AS city
FROM Country, City
WHERE Code = CountryCode;

/* 2 */
SELECT Country.Name AS country, COUNT(*) AS num_cities
FROM Country, City
WHERE Code = CountryCode
GROUP BY country;

/* 3 */
SELECT Country.Name AS country, COUNT(*) AS num_cities
FROM Country, City
WHERE Code = CountryCode
GROUP BY country
HAVING num_cities = 1;

/* 4 */
SELECT Country.Name AS country, COUNT(*) AS num_cities
FROM Country, City
WHERE Code = CountryCode
GROUP BY country
HAVING country = "Canada";

/* 5 */
SELECT Country.Name as country, COUNT(*) AS num_languages
FROM Country, CountryLanguage
WHERE Code = CountryCode
GROUP BY country
HAVING num_languages >= 3;

/* 6 */
/* (a) = "CAN" */
SELECT  f.Percentage AS French, e.Percentage AS English
FROM  CountryLanguage AS e, CountryLanguage AS f, Country
WHERE Code = f.CountryCode
  AND Code = e.CountryCode
  AND Code = 'CAN'
  AND f.Language = "French"
  AND e.Language = "English";

/* 7 */
SELECT Country.Name AS country, Country.Population / Country.SurfaceArea
       AS "Population Density", Country.Continent, Country.Capital
FROM Country
GROUP BY country
ORDER BY Country.Continent, country;

/* 8 */
SELECT Country.Name AS country, Country.Population,
       COUNT(DISTINCT City.Name) AS "Number of Cities",
       MAX(City.Population) AS "Largest City",
       COUNT(DISTINCT Language) AS "Number of Languages"  
FROM Country, City, CountryLanguage
WHERE Code = City.CountryCode
  AND Code = CountryLanguage.CountryCode
GROUP BY country;

notee
