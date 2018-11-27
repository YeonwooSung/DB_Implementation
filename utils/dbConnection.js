'use strict';

const mysql = require('mysql');

/**
 * This variable creates the connection pool to control the database connections.
 *
 * @type {Pool} the connection pool.
 */
let pool = mysql.createPool({
    connectionLimit: 100, //set the limit number of connection to 100
    host: '', //the host server
    user: '', //your user name
    password: '', //your password
    database: '' //the name of the database
});


/* SQL query strings - constants */
const ALL_AUDIO_BOOKS = `SELECT ISBN, title, running_time, purchase_price, publisher_name, published_date FROM audiobook`;
const ALL_BOOKS_BY_AUTHORS = `SELECT person.forename, person.middle_initials, person.surname, audiobook.title, audiobook.published_date , audiobook.ISBN 
FROM audiobook LEFT JOIN audiobook_authors ON audiobook.ISBN = audiobook_authors.ISBN LEFT JOIN person ON audiobook_authors.contributor_ID = person.ID
ORDER BY person.forename`;
const ORDER_BY_RATINGS = `SELECT audiobook.title, CASE WHEN person.middle_initials IS NULL THEN CONCAT(person.forename, ' ', person.surname)
ELSE CONCAT(person.forename, ' ', person.middle_initials, ' ', person.surname) END as FullName, audiobook_reviews.rating, audiobook_reviews.comment 
FROM audiobook INNER JOIN audiobook_reviews ON audiobook.ISBN = audiobook_reviews.ISBN LEFT JOIN person ON audiobook_reviews.customer_ID = person.ID 
ORDER BY audiobook_reviews.rating DESC`;


/**
 * This function gets all audio books from the database, and send the book.pug to the client.
 */
exports.listAllAudiobooks = (res) => {
    const queryString = ALL_AUDIO_BOOKS;

    pool.getConnection(function(err, conn) {
        if (err) {
            res.send(err);
        } else {
            conn.query(queryString, function(err, result, fields) {
                if (err) {
                    res.send(err);
                } else {
                    res.render('books', {data: result});
                }
            });

            conn.release(); //release the connection
        }
    });
}

/**
 * This function does the log in process.
 */
exports.doTheLogInProcess = function (email, pw, res) {
    let queryString = `SELECT personalID, email_address FROM customer WHERE pwd = SHA2("${pw}", 512)`;

    pool.getConnection(function (err, conn) {
        if (err) {
            throw err;
        } else {
            conn.query(queryString, function (err, result, fields) {
                if (err) {
                    throw err;
                } else {
                    if (result[0]) {
                        if (result[0].email_address.toString() === email.toString()) {
                            res.cookie("ID", result[0].personalID, {
                                expires: new Date(Date.now() + 7200000)
                            });
                            res.render('index');
                        } else {
                            console.log('wrong email!');
                            let val = { message: 'wrong email address!' };
                            res.render('login', { title: 'Log In', val: val });
                        }
                    } else {
                        console.log('wrong password!');
                        let val = { message: 'wrong password!' };
                        res.render('login', { title: 'Log In', val: val });
                    }
                }
            });
            conn.release();
        }
    });
};

/**
 * This function registers the new customer.
 * @param {*} foreName 
 * @param {*} middle_initial 
 * @param {*} surName 
 * @param {*} email 
 * @param {*} password 
 * @param {*} birthday 
 * @param {*} res 
 */
function registerNewUser(foreName, middle_initial, surName, email, password, birthday, res) {
    let queryString;
    if (middle_initial == '') {
        queryString = `call insertCustomer('${email}', '${password}', '${foreName}', null, '${surName}', '${birthday}')`;
    } else {
        queryString = `call insertCustomer('${email}', '${password}', '${foreName}', '${middle_initial}', '${surName}', '${birthday}')`;
    }

    pool.getConnection(function (err, conn) {
        if (err) {
            throw err;
        } else {
            conn.query(queryString, function (err, result, fields) {
                if (err) {
                    throw err;
                } else {
                    res.render('login', {title: 'Bookstream :: login'});
                }
            });
            conn.release();
        }
    });
}

/**
 * This function checks if the given email address is already registered.
 */
exports.checkIfRegisteredAlready = (foreName, middle_initial, surName, email, password, birthday, res) => {
    let queryString = `SELECT personalID from customer WHERE email_address = "${email}"`;

    pool.getConnection(function (err, conn) {
        if (err) {
            throw err;
        } else {
            conn.query(queryString, function (err, result, fields) {
                if (err) {
                    throw err;
                } else {
                    if (result[0]) {
                        const alertID = { email: email };
                        res.render('register', { title: 'Register', alert: alertID });
                    } else {
                        registerNewUser(foreName, middle_initial, surName, email, password, birthday, res);
                    }
                }
            });
            conn.release();
        }
    });
};

/**
 * This function returns the list of all reviews of given name of book.
 */
exports.listAllReviewsOfGivenBook = (ISBN, res) => {
    const queryString = `SELECT audiobook_reviews.title, audiobook_reviews.comment, person.forename, person.middle_initials, person.surname FROM audiobook_reviews LEFT JOIN person ON person.ID = audiobook_reviews.customer_ID WHERE audiobook_reviews.ISBN = '${ISBN}'`;

    pool.getConnection(function(err, conn) {
        if (err) {
            res.send(err);
        } else {
            conn.query(queryString, function(err, result, fields) {
                if (err) {
                    res.send(err);
                } else {
                    res.render('reviews', {isbn: ISBN, data: result});
                }
            });

            conn.release();
        }
    });
}

/**
 * This function returns all audiobooks ordered by authors.
 */
exports.listAllAudioBooksByAuthors = (res) => {
    pool.getConnection((err, conn) => {
        if (err) {
            throw err;
        } else {
            conn.query(ALL_BOOKS_BY_AUTHORS, (err, result, fields) => {
                if (err) {
                    throw err;
                } else {
                    res.render('authors', {data: result});
                }
            });
        }
    });
}

exports.listAllReviewsByRatings = (res) => {
    pool.getConnection((err, conn) => {
        if (err) {
            throw err;
        } else {
            conn.query(ORDER_BY_RATINGS, (err, result, fields) => {
                if (err) {
                    throw err;
                } else {
                    res.render('ratings', {data: result});
                }
            });
        }
    });
}
