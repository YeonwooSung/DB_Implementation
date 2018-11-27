const express = require('express');
const router = express.Router();

//use the sql queries to check if the user is registered.
const conn = require('../utils/dbConnection');

let path = require('path');

/* GET audiobook list */
router.get('/', function (req, res) {
    conn.listAllAudioBooksByAuthors(res);
});

/* GET books.css */
router.get('/stylesheets/authors.css', function (req, res) {
    res.sendFile(path.resolve(__dirname + '/../public/stylesheets/authors.css'));
});

module.exports = router;