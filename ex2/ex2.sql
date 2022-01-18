/*
* File:  ex2.sql Comp 2521, Fall 2021, Tutorial 2
* Matt Smith
* Sept 20, 2021
*/

SELECT first_name, last_name, nick_name FROM castaway;
SELECT COUNT(*) FROM hut;
SELECT COUNT(*) AS huts FROM hut;
SELECT * FROM hut WHERE hut_bunks > 2;
