/*
* File: BookClubData.sql COMP 2521, Fall 2021, Assignment 4
* Matt Smith
* Dec 8, 2021
*/

tee a4.log

/**********************************************************
                        QUERY 1
**********************************************************/

-- Invalid emails
INSERT IGNORE INTO user (email, date_added, nick_name, profile)
VALUES
       ('notAnEmail', 12-22-1234, 'Fake Person', 'Super Fake');
       

INSERT IGNORE INTO user (email)
VALUES
       ('almost@email');



-- Valid emails
INSERT IGNORE INTO user (email, date_added)
VALUES
       ('something@email.com', 00-00-0000);


INSERT IGNORE INTO user (email, nick_name)
VALUES
       ('other@hotmail.ca', 'OG email service');

-- Check results of inserts into user
SELECT * FROM user;


/**********************************************************
                        QUERY 2
**********************************************************/

--Create Authors

INSERT IGNORE INTO author (first_name)
VALUES
       ('Author 1'),
       ('Author 2');

-- Show created rows
SELECT * FROM author;


--Create Book
INSERT IGNORE INTO book(title, year)
VALUES
       ('The Book', 1999);


-- Show results
SELECT * FROM book;

-- Attach created authors to created book
INSERT IGNORE INTO book_author(author_id, book_id)
VALUES
       (1,1),
       (2,1);


-- View for book author
CREATE OR REPLACE VIEW author_view AS
       SELECT *
       FROM book_author;


SELECT * FROM author_view;


/**********************************************************
                        QUERY 3
**********************************************************/
--Read books
INSERT IGNORE INTO read_book(book_id, email, date_read, rating)
VALUES
       (1,'something@email.com', CURDATE(), 10),
       (1, 'other@hotmail.ca', CURDATE(), 7);

-- Show Results
SELECT * FROM read_book;
SELECT * FROM book;



/**********************************************************
                        QUERY 4
**********************************************************/
-- Delete single row
DELETE FROM read_book WHERE read_book.email = 'other@hotmail.ca';


-- Show Results
SELECT * FROM read_book;
SELECT * FROM book;


notee
