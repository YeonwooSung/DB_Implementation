const express = require('express');
const router = express.Router();

//use the sql queries to check if the user is registered.
const conn = require('../utils/dbConnection');

let path = require('path');

/* GET users listing. */
router.post('/', function (req, res) {
    let isbn = req.body.isbn;
    conn.listAllReviewsOfGivenBook(isbn, res);
});

/* GET books.css */
router.get('/stylesheets/reviews.css', function (req, res) {
    res.sendFile(path.resolve(__dirname + '/../public/stylesheets/reviews.css'));
});

module.exports = router;