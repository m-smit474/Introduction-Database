/*
* File: a1.sql COMP 2521, Fall 2021, Assignment 1
* Matt Smith
* Oct 5, 2021
*/

\! rm -f a1.log
tee a1.log

use ufodb

/* Queries */
/* 1 */
SELECT NOW();

/* 2 */
SELECT FORMAT(COUNT(*), '#,#') AS "Number of Sightings",
       MIN(sighting_date) AS "Staring from", MAX(sighting_date) AS "Ending on"
FROM fact_ufo;

/* 3 */
SELECT FORMAT(COUNT(DISTINCT city), '#,#') AS "Different cities with sightings"
FROM fact_ufo;

/* 4 */
SELECT city, COUNT(*) AS sightings
FROM fact_ufo
GROUP BY city
ORDER BY sightings DESC
LIMIT 20;

/* 5 */
SELECT city, COUNT(*) AS sightings
FROM fact_ufo
GROUP BY city
HAVING sightings >= 100;

/* 6 */
SELECT IF(zodiac="", "Missing", zodiac) AS zodiac, COUNT(*) AS sightings
FROM fact_ufo, dim_date
WHERE sighting_date = dim_date
GROUP BY zodiac
ORDER BY sightings DESC;

/* 7 */
/* Orders months alphabetically not in caldenar order */
SELECT dim_month AS month, FORMAT(COUNT(*), '#,#') AS sightings
FROM fact_ufo, dim_date
WHERE sighting_date = dim_date
GROUP BY month
ORDER BY month;

/* 8 */
SELECT COUNT(DISTINCT comments) AS Total,
       MIN(LENGTH(comments)) AS "Minimum Size",
       MAX(LENGTH(comments)) AS "Maximum Size",
       AVG(LENGTH(comments)) AS "Average Size"
FROM fact_ufo
WHERE TRIM(comments)
  AND LENGTH(comments) > 0;

/* 9 */
SELECT COUNT(DISTINCT comments) AS "Number of mentions of fire balls"
FROM fact_ufo
WHERE comments LIKE "%fire ball%";

/* 10 */
SELECT time_of_day, COUNT(*) AS "Sightings in Vancouver"
FROM fact_ufo, dim_time, dim_date
WHERE city = "Vancouver"
  AND sighting_date = dim_date
  AND sighting_time = dim_time
GROUP BY time_of_day
ORDER BY time_of_day = "Morning", time_of_day = "Afternoon",
         time_of_day = "Evening", time_of_day ="Night";

/* 11 */
/* May not want to count 0 as south */
SELECT COUNT(IF(latitude > 0, 1, null)) AS "Northern Hemisphere",
       COUNT(IF(latitude <= 0, 1, null)) AS "Southern Hemisphere"
FROM fact_ufo;

/* 12 */
/**********************************************************************
For the previous query, we are counting all sighting, because each one
will have a latitude, and we making two selections to do so. The first 
selection takes the northern hemisphere count and the second takes the
south.
**********************************************************************/

/* 13 */
/* Tried using trunc to calculate DMS but was getting an error saying:
   "execute command denied to user ... for routine 'ufodb.trunc'" */
SELECT city, dim_state.state, country,
       CONCAT(SUBSTRING(comments, 1, 20), '...') AS Comments,
       CONCAT(latitude, ', ', longitude) AS "Decimal"
FROM fact_ufo, dim_state
WHERE latitude IS NOT NULL
  AND longitude IS NOT NULL
  AND latitude != 0
  AND longitude != 0
  AND fact_ufo.state = dim_state.state_id
LIMIT 100;

notee
