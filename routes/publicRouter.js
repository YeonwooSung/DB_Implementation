'use strict';

const express = require('express');
const router = express.Router();

/* GET index.css */
router.get('/stylesheets/index.css', function (req, res) {
    res.sendFile(__dirname + '/../public/stylesheets/index.css');
});

/* GET index_page.js */
router.get('/javascripts/index_page.js', function (req, res) {
    res.sendFile(__dirname + '/../public/javascripts/index_page.js');
});

module.exports = router;