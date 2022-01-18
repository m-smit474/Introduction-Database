/*
* File: ex9.sql Comp 2521, Fall 2021, Tutorial 9
* Matt Smith
* Nov 16, 2021
*/

\! rm -f ex9.log
tee ex9.log

use msmit474;

DROP TABLE IF EXISTS book;

CREATE TABLE IF NOT EXISTS book (
ISBN CHAR(11),
title VARCHAR(100) NOT NULL,
year INT NOT NULL,
type ENUM('HC', 'PB', 'TP', 'OT'),
CONSTRAINT book_pk PRIMARY KEY (ISBN)
)
ENGINE=InnoDB;


DROP TABLE IF EXISTS author;

CREATE TABLE IF NOT EXISTS author (
ID INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
birthday DATE)
ENGINE=InnoDB;


DROP TABLE IF EXISTS book_author;

CREATE TABLE IF NOT EXISTS book_author (
ISBN CHAR(11),
ID INT)
ENGINE=InnoDB;

ALTER TABLE book_author
ADD CONSTRAINT book_author_fk1 FOREIGN KEY (ISBN)
REFERENCES book(ISBN);

ALTER TABLE book_author
ADD CONSTRAINT book_author_fk2 FOREIGN KEY (ID)
REFERENCES author(ID);


DROP TABLE IF EXISTS publisher;

CREATE TABLE IF NOT EXISTS publisher (
ID INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) UNIQUE,
address VARCHAR(100))
ENGINE=InnoDB;

-- Insertions


INSERT IGNORE INTO book (ISBN, title, year, type)
VALUES
       (01234567890, 'the book', 2021-02-02, 'PB'),
       (01234567893, 'other book', 2031-02-02, 'PB'),
       (01234567892, 'the nice book', 2001-02-02, 'PB'),
       (01234567891, 'book', 2011-02-02, 'PB');


INSERT IGNORE INTO author (name, birthday)
VALUES
       ('John Clancy', 2021-02-02),
       ('Plato', 2021-02-02),
       ('Steve Jobs', 2021-02-02),
       ('Phil Philips', 2021-02-02);


INSERT IGNORE INTO book_author (ISBN, ID)
VALUES
       (01234567890, 1),
       (01234567891, 2);


CREATE OR REPLACE VIEW book_view AS
       SELECT title, name
       FROM book, author;


SELECT * FROM book_view;

notee
