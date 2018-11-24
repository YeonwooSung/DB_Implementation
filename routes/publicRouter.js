'use strict';

const express = require('express');
const router = express.Router();

let path = require('path')

/* GET index.css */
router.get('/stylesheets/index.css', function (req, res) {
    res.sendFile(path.resolve(__dirname + '/../public/stylesheets/index.css'));
});

/* GET index_page.js */
router.get('/javascripts/index_page.js', function (req, res) {
    res.sendFile(path.resolve(__dirname + '/../public/javascripts/index_page.js'));
});

/* GET index_page.js */
router.get('/javascripts/register.js', function (req, res) {
    res.sendFile(path.resolve(__dirname + '/../public/javascripts/register.js'));
});

/* GET logo */
router.get('/images/logo.png', function (req, res) {
    res.sendFile(path.resolve(__dirname + '/../public/images/logo.png'));
});

module.exports = router;