-- Create tables

CREATE TABLE person (
    ID INT NOT NULL,
    forename VARCHAR(20) NOT NULL,
    middle_initials VARCHAR(20),
    surname VARCHAR(20) NOT NULL,
    date_of_birth DATE NOT NULL,
    PRIMARY KEY(ID)
);

CREATE TABLE contributor (
    person_ID INT,
    biography VARCHAR(1024),
    primary key(person_ID),
    foreign key(person_ID) references person(ID)
);

CREATE TABLE customer (
    person_ID INT,
    email_address VARCHAR(1024),
    primary key(person_ID),
    foreign key(person_ID) references person(ID)
);

CREATE TABLE phone_number (
    customer_ID INT,
    phone_number VARCHAR(20),
    primary key(customer_ID,phone_number),
    foreign key(customer_ID) references customer(person_ID)
);

CREATE TABLE publisher (
    name VARCHAR(1024),
    building VARCHAR(20),
    street VARCHAR(20),
    city VARCHAR(20),
    country VARCHAR(20),
    postcode VARCHAR(20),
    phone_number VARCHAR(20),
    established_date DATE,
    primary key(name)
);

CREATE TABLE audiobook (
    ISBN VARCHAR(20),
    title VARCHAR(1024) NOT NULL,
    narrator_id INT,
    running_time TIME,
    age_rating INT,
    purchase_price decimal(8,2),
    publisher_name VARCHAR(1024),
    published_date DATE,
    audiofile BLOB,
    primary key(ISBN),
    foreign key(narrator_id) references person(ID),
    foreign key(publisher_name) references publisher(name)
);

CREATE TABLE chapter (
    ISBN VARCHAR(20),
    number INT,
    title VARCHAR(1024),
    start TIME,
    primary key(ISBN, number),
    foreign key(ISBN) references audiobook(ISBN)
);

CREATE TABLE audiobook_authors (
    contributor_ID INT,
    ISBN VARCHAR(20),
    primary key(contributor_ID,ISBN),
    foreign key(contributor_ID) references contributor(person_ID),
    foreign key(ISBN) references audiobook(ISBN)
);

CREATE TABLE audiobook_purchases (
    customer_ID INT,
    ISBN VARCHAR(20),
    purchase_date DATETIME NOT NULL,
    primary key(customer_ID,ISBN),
    foreign key(customer_ID) references customer(person_ID),
    foreign key(ISBN) references audiobook(ISBN)
);

CREATE TABLE audiobook_reviews (
    customer_ID INT,
    ISBN VARCHAR(20),
    rating INT,
    title VARCHAR(1024),
    comment VARCHAR(1024),
    verified BOOLEAN not null default 0,
    primary key(customer_ID,ISBN),
    foreign key(customer_ID) references customer(person_ID),
    foreign key(ISBN) references audiobook(ISBN)
);


-- Drop all created tables

DROP Table audiobook_reviews;
DROP Table audiobook_purchases;
DROP Table audiobook_authors;
DROP Table chapter;
DROP Table audiobook;
DROP table publisher;
DROP table phone_number;
DROP table customer;
DROP table contributor;
DROP table person;