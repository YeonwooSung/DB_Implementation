'use strict';

const express = require('express');
const router = express.Router();

/* GET index.css */
router.get('/stylesheets/index.css', function (req, res) {
    res.sendFile(__dirname + '/../public/stylesheets/index.css');
});

module.exports = router;