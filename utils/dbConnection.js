'use strict';

const mysql = require('mysql');

//Query string
const ALL_AUDIO_BOOKS = `SELECT ISBN, title, narrator_id, running_time, age_rating, purchase_price, publisher_name, published_date FROM audiobook`;

/**
 * This variable creates the db pool to control the db connection objects.
 *
 * @type {Pool} the database pool.
 */
let pool = mysql.createPool({
    connectionLimit: 100, //set the limit number of connection to 100
    host: 'localhost',
    user: '',
    password: '',
    database: ''
});

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
                    res.render('book', {data: result});
                }
            });

            conn.release(); //release the connection
        }
    });
}

exports.listAllReviewsOfGivenBook = (res, ISBN) => {
    const queryString = `SELECT customer_ID, title, comment FROM audiobook_reviews WHERE ISBN = '${ISBN}'`;

    pool.getConnection(function(err, conn) {
        if (err) {
            res.send(err);
        } else {
            conn.query(queryString, function(err, result, fields) {
                if (err) {
                    res.send(err);
                } else {
                    //TODO send proper response to the client
                }
            })

            conn.release();
        }
    });
}
