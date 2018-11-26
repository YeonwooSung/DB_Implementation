const express = require('express');
const router = express.Router();

//use the sql queries to check if the user is registered.
const conn = require('../utils/dbConnection');

let path = require('path');

/* GET users listing. */
router.get('/', function (req, res) {
    res.render('register', { title: 'Register', alert: undefined });
});

router.post('/', function (req, res) {
    console.log(req.body);
    let { forename, middle_initial, surname, email, password, confirmedP, birthday } = req.body;

    conn.checkIfRegisteredAlready(forename, middle_initial, surname, email, password, birthday, res);
});

/* GET login.css */
router.get('/stylesheets/register.css', function (req, res) {
    res.sendFile(path.resolve(__dirname + '/../public/stylesheets/register.css'));
});

module.exports = router;