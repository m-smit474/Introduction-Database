/*
* File: BookClub.sql COMP 2521, Fall 2021, Assignment 4
* Matt Smith
* Dec 8, 2021
*/

\! rm -f a4.log
tee a4.log

use msmit474;

-- Drop tables in reverse order of creation
DROP TABLE IF EXISTS read_book;
DROP TABLE IF EXISTS book_author;
DROP TABLE IF EXISTS author;
DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS user;

CREATE TABLE IF NOT EXISTS user(
email VARCHAR(100),
date_added DATE,
nick_name VARCHAR(20),
profile VARCHAR(100),
CONSTRAINT user_pk PRIMARY KEY (email)
)
ENGINE=InnoDB;

-- Name 'user_pk' ignored for PRIMARY key.
show warnings;


CREATE TABLE IF NOT EXISTS book(
book_id INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(20) NOT NULL,
year INT(4) NOT NULL,
num_raters INT DEFAULT 0,
rating DECIMAL(3,1)
)
ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS author(
author_id INT PRIMARY KEY AUTO_INCREMENT,
last_name VARCHAR(20),
first_name VARCHAR(20) NOT NULL,
middle_name VARCHAR(20)
)
ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS book_author(
author_id INT,
book_id INT,
PRIMARY KEY(author_id, book_id),
FOREIGN KEY(author_id) REFERENCES author(author_id),
FOREIGN KEY(book_id) REFERENCES book(book_id)
)
ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS read_book(
book_id INT,
email VARCHAR(100),
date_read DATE NOT NULL,
rating INT NOT NULL,
PRIMARY KEY(book_id, email),
FOREIGN KEY(email) REFERENCES user(email),
FOREIGN KEY(book_id) REFERENCES book(book_id)
)
ENGINE=InnoDB;


-- Triggers


-- Records the current date when a user is inserted
DROP TRIGGER IF EXISTS date_added_trig;

delimiter $$
CREATE TRIGGER date_added_trig
BEFORE INSERT ON user
FOR EACH ROW
BEGIN
    SET new.date_added = CURDATE();

END $$
delimiter ;



-- This trigger will validate emails that are being inserted
-- Must have something before a '@' followed by something before and after
-- a '.'
DROP TRIGGER IF EXISTS invalid_email_trig;

delimiter $$
CREATE TRIGGER invalid_email_trig
BEFORE INSERT ON user
FOR EACH ROW
BEGIN
    IF NEW.email NOT LIKE '%_@_%._%' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid Email';
    END IF;

END $$
delimiter ;



-- This trigger will display an error message for invalid updates
-- Cannot update: Email, Date_added
DROP TRIGGER IF EXISTS user_non_updateable_trig;

delimiter $$
CREATE TRIGGER user_non_updateable_trig
BEFORE UPDATE ON user
FOR EACH ROW
BEGIN
    IF (NEW.date_added != OLD.date_added OR NEW.email != OLD.email) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot change that!';
    END IF;
    

END $$
delimiter ;



-- Cannot remove books from database
DROP TRIGGER IF EXISTS book_non_removeable_trig;

delimiter $$
CREATE TRIGGER book_non_removeable_trig
BEFORE DELETE ON book
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete books';
    

END $$
delimiter ;


-- Updates derived rows when updated read book
DROP TRIGGER IF EXISTS modified_read_book_trig;

delimiter $$
CREATE TRIGGER modified_read_book_trig
AFTER UPDATE ON read_book
FOR EACH ROW
BEGIN
    UPDATE book
    SET num_raters = (SELECT COUNT(*) FROM read_book),
        book.rating = (SELECT AVG(read_book.rating) FROM read_book)
    WHERE book.book_id = NEW.book_id;
    

END $$
delimiter ;


-- Updates derived rows when inserting into read book
DROP TRIGGER IF EXISTS insert_read_book_trig;

delimiter $$
CREATE TRIGGER insert_read_book_trig
AFTER INSERT ON read_book
FOR EACH ROW
BEGIN
    UPDATE book
    SET num_raters = (SELECT COUNT(*) FROM read_book),
        book.rating = (SELECT AVG(read_book.rating) FROM read_book)
    WHERE book.book_id = NEW.book_id;
    

END $$
delimiter ;



-- Updates derived rows when deleting from read book
DROP TRIGGER IF EXISTS delete_read_book_trig;

delimiter $$
CREATE TRIGGER delete_read_book_trig
AFTER DELETE ON read_book
FOR EACH ROW
BEGIN
    UPDATE book
    SET num_raters = (SELECT COUNT(*) FROM read_book),
        book.rating = (SELECT AVG(read_book.rating) FROM read_book);
    

END $$
delimiter ;



notee
