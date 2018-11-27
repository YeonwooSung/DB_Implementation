const express = require('express');
const router = express.Router();

//use the sql queries to check if the user is registered.
const conn = require('../utils/dbConnection');

let path = require('path');

/* GET review (ordered by rating) list */
router.get('/', function (req, res) {
    conn.listAllReviewsByRatings(res);
});

/* GET ratings.css */
router.get('/stylesheets/ratings.css', function (req, res) {
    res.sendFile(path.resolve(__dirname + '/../public/stylesheets/ratings.css'));
});

module.exports = router;