/*
* File: ex12.sql Comp 2521, Fall 2021, Tutorial 12
* Matt Smith
* Dec 06, 2021
*/

\! rm -f ex12.log
tee ex12.log

use msmit474;

DROP TABLE IF EXISTS ex12_keyword;

CREATE TABLE ex12_keyword (
book_id int(11),
keyword VARCHAR(20)
);

DROP PROCEDURE keywords;

delimiter $$
CREATE PROCEDURE keywords()
BEGIN
      DECLARE bid int(11);
      DECLARE k1 VARCHAR(20);
      DECLARE k2 VARCHAR(20);
      DECLARE k3 VARCHAR(20);
      DECLARE k4 VARCHAR(20);
      DECLARE done INT DEFAULT 0;
      DECLARE curs CURSOR FOR
                  SELECT book_id, kw1, kw2, kw3, kw4
		  FROM ex12_book
		  GROUP BY book_id;
      DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
      OPEN curs;
      read_loop: LOOP
                 FETCH curs INTO bid, k1, k2, k3, k4;
		 IF done THEN
		         LEAVE read_loop;
                 END IF;
		 IF k1 IS NOT NULL THEN
		 INSERT INTO ex12_keyword(book_id, keyword) VALUES(bid,k1);
		 END IF;
		 IF k2 IS NOT NULL THEN
		 INSERT INTO ex12_keyword(book_id, keyword) VALUES(bid,k2);
		 END IF;
		 IF k3 IS NOT NULL THEN
		 INSERT INTO ex12_keyword(book_id, keyword) VALUES(bid,k3);
		 END IF;
		 IF k4 IS NOT NULL THEN
		 INSERT INTO ex12_keyword(book_id, keyword) VALUES(bid,k4);
		 END IF;
      END LOOP;		 
		 

SELECT book_id, keyword
FROM ex12_keyword;


END $$
delimiter ;



notee
