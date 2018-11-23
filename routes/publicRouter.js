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

/* GET login.css */
router.get('/stylesheets/login.css', function (req, res) {
    res.sendFile(__dirname + '/../public/stylesheets/login.css');
});

/* GET register.css */
router.get('/stylesheets/register.css', function (req, res) {
    res.sendFile(__dirname + '/../public/stylesheets/register.css');
});

/* GET index_page.js */
router.get('/javascripts/register.js', function (req, res) {
    res.sendFile(__dirname + '/../public/javascripts/register.js');
});

/* GET home.svg */
router.get('/stylesheets/login.css', function (req, res) {
    res.sendFile(__dirname + '/../public/images/home.svg');
});

module.exports = router;