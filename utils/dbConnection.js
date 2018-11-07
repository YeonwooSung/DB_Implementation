'use strict';

const mysql = require('mysql');

const Q1 = `SELECT id, name, email, numOfBooks, totalSpentMoney FROM User`;

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

exports.listAllCostomers = () => {
    const queryString = Q1;

    pool.getConnection(function(err, conn) {
        if (err) {
            //TODO on error
        } else {
            conn.query(queryString, function(err, result, fields) {
                if (err) {
                    //TODO on error
                } else {
                    //TODO on success
                }
            });

            conn.release(); //release the connection
        }
    });
}
