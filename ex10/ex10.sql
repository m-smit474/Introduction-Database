/*
* File: ex10.sql COMP 2521, Fall 2021, Tutorial 10
* Matt Smith
* Nov 22, 2021
*/

\! rm -f ex10.log
tee ex10.log

use ufodb


SELECT
      SUM(IF(zodiac = 'Aquarius',1,0)) AS Aquarius,
      SUM(IF(zodiac = 'Aries',1,0)) AS Aries,
      SUM(IF(zodiac = 'Pisces',1,0)) AS Pisces,
      SUM(IF(zodiac = 'Sagittarius',1,0)) AS Sagittarius,
      SUM(IF(zodiac = 'Taurus',1,0)) AS Taurus,
      SUM(IF(zodiac = 'Capricorn',1,0)) AS Capricorn,
      SUM(IF(zodiac = 'Scorpio',1,0)) AS Scorpio,
      SUM(IF(zodiac = 'Libra',1,0)) AS Libra,
      SUM(IF(zodiac = 'Gemini',1,0)) AS Gemini,
      SUM(IF(zodiac = 'Virgo',1,0)) AS Virgo,
      SUM(IF(zodiac = 'Leo',1,0)) AS Leo,
      SUM(IF(zodiac = 'Cancer',1,0)) AS Cancer,
      SUM(IF(zodiac = '',1,0)) AS Missing
FROM fact_ufo
JOIN dim_date ON(sighting_date=dim_date);


SELECT
      FORMAT(SUM(IF(dim_month = 'JANUARY', 1, 0)), 1) AS Jan,
      FORMAT(SUM(IF(dim_month = 'FEBRUARY', 1, 0)), 1) AS Feb,
      FORMAT(SUM(IF(dim_month = 'MARCH', 1, 0)), 1) AS Mar,
      FORMAT(SUM(IF(dim_month = 'APRIL', 1, 0)), 1) AS Apr,
      FORMAT(SUM(IF(dim_month = 'MAY', 1, 0)), 1) AS May,
      FORMAT(SUM(IF(dim_month = 'JUNE', 1, 0)), 1) AS Jun,
      FORMAT(SUM(IF(dim_month = 'JULY', 1, 0)), 1) AS Jul,
      FORMAT(SUM(IF(dim_month = 'AUGUST', 1, 0)), 1) AS Aug,
      FORMAT(SUM(IF(dim_month = 'SEPTEMBER', 1, 0)), 1) AS Sep,
      FORMAT(SUM(IF(dim_month = 'OCTOBER', 1, 0)), 1) AS Oct,
      FORMAT(SUM(IF(dim_month = 'NOVEMBER', 1, 0)), 1) AS Nov,
      FORMAT(SUM(IF(dim_month = 'DECEMBER', 1, 0)), 1) AS "Dec"
FROM fact_ufo
JOIN dim_date ON(sighting_date=dim_date);


notee
