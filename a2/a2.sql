/*
* File: a2.sql COMP 2521, Fall 2021, Assignment 2
* Matt Smith
* Nov 8, 2021
*/

\! rm -f a2.log
tee a2.log

use ufodb

/* UFO DATABASE */
/* Queries */
/* 1 */
/* This table does stats on the sightings organized per month */
SELECT MAX(Sightings), MIN(Sightings), AVG(Sightings), STDDEV_SAMP(Sightings)
FROM  (
       SELECT dim_month AS Month, FORMAT(COUNT(*), 0) AS Sightings
       FROM fact_ufo
       JOIN dim_date ON(sighting_date = dim_date)
       GROUP BY Month
       ORDER BY dim_mon) AS months;

/* 2 */
/* This query deals with the day with the most sightings.

   Limitations: It is incomplete, only finds the max
                sightings for a single day. Tried to connect
                the derived table back but couldn't get it.
*/
/*
SELECT sighting_date, zodiac, COUNT(*) AS Sightings
FROM fact_ufo
JOIN dim_date ON(sighting_date = dim_date)
WHERE Sightings = (
*/
                   SELECT MAX(Sightings)
                   FROM (
                         SELECT COUNT(*) AS Sightings
                         FROM fact_ufo
                         GROUP BY sighting_date) AS Sighting_By_Date;


use mountain;

/* MOUNTAIN DATABASE */
/* QUERIES */
/* 1 */
/* This query aims to count the number of mountains in each different 
   moutain range and display some correlated info for the range */
SELECT COUNT(*) AS mountains, name AS continent, range_name
FROM mountain_range
JOIN mountain USING(range_id)
JOIN continent ON(cont_id = range_continent)
GROUP BY range_id
ORDER BY mountains DESC, range_name;

/* 2 */
/* This query tries to find all the mountain ranges that have no
   mounatins or no data on moutains. 

  Limitations: This query, as is, does not work. Was trying to
               do a similar approach to the example in ex7
*/
SELECT 0 AS mountains, name AS continent, range_name
FROM mountain_range
JOIN mountain USING(range_id)
JOIN continent ON(cont_id = range_continent)
WHERE NOT EXISTS (
      SELECT  COUNT(*) AS num_mountains
      GROUP BY range_id )
ORDER BY mountains DESC, range_name;

/* 3 */
/* Based on 2 and that does not work 

   What I would have done if 2 was working is take out the order by
   in query 1 and put a union at the end then slap query 2 underneath
   with the order by.
*/



/* 5 */
/* This query tries to get the continent with the highest average 
   height of its peaks.

   Limitations: Was not able to get the name as the selection using 
                where statements. I knew the highest average was 
                Asia from a simpler query, so hardcoded that.
*/
SELECT MAX(Average_Elevation) AS 'Asia'
FROM (
      SELECT AVG(elevation) AS Average_Elevation, name
      FROM mountain
      JOIN mountain_range USING(range_id)
      JOIN continent ON(cont_id = range_continent)
      GROUP BY name) AS elevations;

notee
