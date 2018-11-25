'use strict';

const mysql = require('mysql');

const CONNECTION_ERROR = 'Connection error: Cannot connect to the DB';
const QUERY_ERROR = 'Query error: query failed';
const ALL_AUDIO_BOOKS = `SELECT ISBN, title, narrator_id, running_time, age_rating, purchase_price, publisher_name, published_date FROM audiobook`;

/**
 * This variable creates the db pool to control the db connection objects.
 *
 * @type {Pool} the database pool.
 */
let pool = mysql.createPool({
    connectionLimit: 100,
    host: 'localhost',
    user: '',
    password: '',
    database: ''
});

exports.listAllAudiobooks = (res) => {
    const queryString = ALL_AUDIO_BOOKS;

    pool.getConnection(function(err, conn) {
        if (err) {
            res.send(CONNECTION_ERROR);
        } else {
            conn.query(queryString, function(err, result, fields) {
                if (err) {
                    res.send(`${QUERY_ERROR}:\nquery: ${queryString}`);
                } else {
                    //TODO on success
                }
            });

            conn.release(); //release the connection
        }
    });
}

exports.listAllReviewsOfGivenBook = (res) => {
    //
}
