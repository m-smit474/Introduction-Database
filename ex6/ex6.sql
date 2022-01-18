/*
* File: ex6.sql Comp 2521, Fall 2021, Tutorial 6
* Matt Smith
* Oct 25, 2021
*/

\! rm -f ex6.log
tee ex6.log

use world

/* Queries */
/* 1 */
SELECT Country.Name AS country, City.Name AS city
FROM Country JOIN City ON(Code = CountryCode);

/* 2 */
SELECT Country.Name AS country, COUNT(*) AS num_cities
FROM Country JOIN City ON(Code = CountryCode)
GROUP BY country;

/* 3 */
SELECT Country.Name AS country, COUNT(*) AS num_cities
FROM Country JOIN City ON(Code = CountryCode)
GROUP BY country
HAVING num_cities = 1;

/* 4 */
SELECT Country.Name AS country, COUNT(*) AS num_cities
FROM Country JOIN City ON(Code = CountryCode)
GROUP BY country
HAVING country = "Canada";

/* 5 */
SELECT Country.Name as country, COUNT(*) AS num_languages
FROM Country JOIN CountryLanguage ON(Code = CountryCode)
GROUP BY country
HAVING num_languages >= 3;

/* 6 */
/* (a) = "CAN" */
SELECT  f.Percentage AS French, e.Percentage AS English
FROM  CountryLanguage AS e
JOIN  CountryLanguage AS f USING(CountryCode)
JOIN  Country ON (Code=CountryCode)
WHERE Code = 'CAN'
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
FROM Country
JOIN City ON (Code = CountryCode)
JOIN CountryLanguage USING(CountryCode)
GROUP BY country;

notee
