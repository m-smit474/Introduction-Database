/*
* File: ex7.sql Comp 2521, Fall 2021, Tutorial 7
* Matt Smith
* Nov 1, 2021
*/

\! rm -f ex7.log
tee ex7.log

use lunch_orders

/* Queries */
/* 1 */
SELECT empl.employee_id, empl.last_name , empl.phone_number,
       man.first_name AS Manager, man.phone_number
FROM employee AS empl JOIN employee AS man ON(man.employee_id = empl.manager_id)
ORDER BY empl.employee_id;

/* 2 */
SELECT empl.employee_id, empl.last_name , empl.phone_number, department_name,
       man.first_name AS Manager, man.phone_number
FROM employee AS empl
JOIN employee AS man ON(man.employee_id = empl.manager_id)
JOIN department ON(department.dept_code = empl.dept_code)
ORDER BY empl.employee_id;

/* 3 */
SELECT empl.employee_id, empl.last_name , empl.phone_number, department_name,
       man.first_name AS Manager, man.phone_number
FROM employee AS empl
LEFT JOIN employee AS man ON(man.employee_id = empl.manager_id)
JOIN department ON(department.dept_code = empl.dept_code)
ORDER BY empl.employee_id;

/* 4 */
SELECT empl.employee_id, empl.last_name , empl.phone_number, department_name,
       man.first_name AS Manager, man.phone_number
FROM employee AS empl
JOIN employee AS man ON(man.employee_id = empl.manager_id)
JOIN department ON(department.dept_code = empl.dept_code);
/* Doesn't work
UNION
*/
SELECT empl2.employee_id, empl2.last_name , empl2.phone_number, department_name,
       man.first_name AS Manager, man.phone_number
FROM employee AS empl2
LEFT JOIN employee AS man ON(man.employee_id = empl2.manager_id)
JOIN department ON(department.dept_code = empl2.dept_code)
WHERE man.first_name IS NULL
ORDER BY empl2.employee_id;

/* 5 */
SELECT COUNT(DISTINCT lunch_id) AS 'Lunches Attended', last_name, first_name
FROM lunch
JOIN employee USING(employee_id)
WHERE 'Lunches Attended' < 5
GROUP BY lunch.employee_id;

/* 6 */
SELECT one.employee_id, one.last_name, one.first_name,
       two.employee_id, two.last_name, two.first_name
FROM employee AS one
JOIN employee AS two USING(hire_date)
WHERE one.employee_id != two.employee_id;

SELECT one.employee_id, one.last_name, one.first_name,
       two.employee_id, two.last_name, two.first_name
FROM employee AS one, employee AS two
WHERE one.employee_id != two.employee_id
  AND one.hire_date = (
      SELECT two.hire_date);

 
/* 7 */
SELECT COUNT(DISTINCT lunch_id) AS 'Max Number of Lunches'
FROM lunch;

notee
