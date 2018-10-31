const mysql = require('mysql');

/**
 * This variable creates the db pool to control the db connection objects.
 *
 * @type {Pool} the database pool.
 */
let pool = mysql.createPool({
    connectionLimit: 1000,
    host: 'localhost',
    user: '',
    password: '',
    database: ''
});
