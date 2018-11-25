const express = require('express');
const router = express.Router();

//use the sql queries to check if the user is registered.
const conn = require('../utils/dbConnection');

const util = require('../utils/util');

let path = require('path');

/* GET users listing. */
router.get('/', function (req, res) {
    res.render('register', { title: 'Register', alert: undefined });
});

router.post('/', function (req, res) {
    console.log(req.body);
    let { forename, middle_initial, surname, password, confirmedP, email } = req.body;

    password = util.encodePassword(password);
    confirmedP = util.encodePassword(confirmedP);

    if (password === confirmedP) {
        //TODO sql connection -> register
    }
});

/* GET login.css */
router.get('/stylesheets/register.css', function (req, res) {
    res.sendFile(path.resolve(__dirname + '/../public/stylesheets/register.css'));
});

module.exports = router;