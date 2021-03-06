/* A. Fedoruk 
 * Lab 11 W13
 */

\! rm ex12_cursors.log
tee ex12_cursors.log

use msmit474

DROP TABLE IF EXISTS ex12_book_author;
DROP TABLE IF EXISTS ex12_book;
DROP TABLE IF EXISTS ex12_author;

CREATE TABLE ex12_book (
   book_id INT AUTO_INCREMENT PRIMARY KEY,
   ISBN CHAR(13) UNIQUE,
   title VARCHAR(100) NOT NULL,
   year INT NOT NULL,
   type ENUM( 'PB', 'HC', 'TP', 'OT') NOT NULL DEFAULT 'TP',
   kw1 VARCHAR(20),
   kw2 VARCHAR(20),
   kw3 VARCHAR(20),
   kw4 VARCHAR(20)
) ENGINE InnoDB;
ALTER TABLE ex12_book AUTO_INCREMENT = 10000;

CREATE TABLE ex12_author (
   ID INT PRIMARY KEY AUTO_INCREMENT,
   last VARCHAR(100) NOT NULL,
   middle VARCHAR(100),
   first VARCHAR(100),
   birthdate DATE
) ENGINE InnoDB;
ALTER TABLE ex12_author AUTO_INCREMENT = 20000;

CREATE TABLE ex12_book_author (
   author_id INT,
   book_id INT,
   PRIMARY KEY (author_id, book_id)
) ENGINE InnoDB;

ALTER TABLE ex12_book_author ADD CONSTRAINT 
   FOREIGN KEY (author_id) REFERENCES ex12_author(ID);

ALTER TABLE ex12_book_author ADD CONSTRAINT 
   FOREIGN KEY (book_id) REFERENCES ex12_book(book_id);

SHOW INDEXES FROM ex12_book;
SHOW INDEXES FROM ex12_author;
SHOW INDEXES FROM ex12_book_author;

CREATE INDEX ex12_book_title_idx ON ex12_book(title);
CREATE INDEX ex12_book_ISBN_idx ON ex12_book(ISBN);
CREATE INDEX ex12_author_first_idx ON ex12_author(first);
CREATE INDEX ex12_author_last_idx ON ex12_author(last);
CREATE INDEX ex12_author_middle_idx ON ex12_author(middle);

/* Add ex12_authors */
INSERT INTO ex12_author (last, middle, first, birthdate) VALUES 
  ('Hoffer', 'A.', 'Jeffrey', NULL),
  ('Ramesh', NULL, 'V.', NULL),
  ('Topi', NULL, 'Heikki', NULL),
  ('Vanderbilt', NULL, 'Tom', NULL),
  ('Chomsky', NULL, 'Noam', NULL),
  ('Meyer', NULL, 'Stephanie', NULL), 
  ('Martin', NULL, 'Lawrence', NULL),
  ('King', NULL, 'Thomas', NULL);
INSERT INTO ex12_author (last, first) VALUES 
  ('Zinn', 'Howard');

/* Add ex12_books */
INSERT INTO ex12_book ( ISBN, title, year, type, kw1, kw2, kw3, kw4) VALUES 
  ('9780136088394','Modern Database Management', 2011, 'HC', 'Computer', 'Database', NULL, NULL);
INSERT INTO ex12_book ( ISBN, title, year, kw1, kw2, kw3, kw4) VALUES 
  ('9780307397737','Traffic', 2008, 'Cars', NULL, NULL, NULL);
INSERT INTO ex12_book ( ISBN, title, year, kw1, kw2, kw3, kw4) VALUES 
  ('0805076883','Hegemony or Survival', 2003, 'Politics', 'World', 'Chomsky', NULL);
INSERT INTO ex12_book ( ISBN, title, year, type, kw1, kw2, kw3, kw4) VALUES 
  (NULL,'Twilight', 2005, 'HC', 'Teen', 'Fiction', NULL, NULL);
INSERT INTO ex12_book ( ISBN, title, year, type, kw1, kw2, kw3, kw4) VALUES 
  (NULL,'Harperland', 2010, 'TP', 'Politics', 'Canada', NULL, NULL);
INSERT INTO ex12_book ( ISBN, title, year, type, kw1, kw2, kw3, kw4) VALUES 
  (NULL,'The Inconvenient Indian', 2012, 'HC', 'Politics', 'Canada', 'History','Aboriginal');
INSERT INTO ex12_book (title, ISBN, year, kw1) VALUES 
  ('Zinn & the Art of Road Bike Maintenance', '1931382697', 2005, 'Bikes');

/* Link Books to Authors */
INSERT INTO ex12_book_author VALUES 
(   (SELECT ID from ex12_author WHERE last = 'Martin'),
    (SELECT book_id FROM ex12_book WHERE title LIKE 'Harper%') ),
(   (SELECT ID from ex12_author WHERE last = 'King'),
    (SELECT book_id FROM ex12_book WHERE title LIKE '%Indian%') ),
(   (SELECT ID from ex12_author WHERE last = 'Hoffer'),
    (SELECT book_id FROM ex12_book WHERE title LIKE 'Modern%') ),
(   (SELECT ID from ex12_author WHERE last = 'Ramesh'),
    (SELECT book_id FROM ex12_book WHERE title LIKE 'Modern%') ),
(   (SELECT ID from ex12_author WHERE last = 'Topi'),
    (SELECT book_id FROM ex12_book WHERE title LIKE 'Modern%') ),
(   (SELECT ID from ex12_author WHERE last = 'Vanderbilt'),
    (SELECT book_id FROM ex12_book WHERE title = 'Traffic') ),
(   (SELECT ID from ex12_author WHERE last = 'Chomsky'),
    (SELECT book_id FROM ex12_book WHERE title = 'Hegemony or Survival') ),
(   (SELECT ID from ex12_author WHERE last = 'Meyer'),
    (SELECT book_id FROM ex12_book WHERE title = 'Twilight') ),
(   (SELECT ID FROM ex12_author WHERE last = 'Zinn'), 
    (SELECT book_id FROM ex12_book WHERE title LIKE '%Bike%'));

UPDATE ex12_author 
  SET birthdate = '1928-12-7'
  WHERE last = 'Chomsky';

UPDATE ex12_book 
  SET title = CONCAT(title, ': Why We Drive the Way We Do')
  WHERE title = 'Traffic';

CREATE OR REPLACE VIEW ex12_all_books AS
SELECT b.title, b.year, b.ISBN, a.last, a.first 
FROM ex12_book b JOIN ex12_book_author ba ON (b.book_id = ba.book_id) 
     JOIN ex12_author a ON (ba.author_id = a.ID);

notee
