const express = require('express');
const router = express.Router();

//use the sql queries to check if the user is registered.
const conn = require('../utils/dbConnection');

let path = require('path');

/* GET audiobook list */
router.get('/', function (req, res) {
    conn.listAllAudiobooks(res); //get all audiobooks from db and send the response to the client
});

/* GET books.css */
router.get('/stylesheets/books.css', function (req, res) {
    res.sendFile(path.resolve(__dirname + '/../public/stylesheets/books.css'));
});

module.exports = router;