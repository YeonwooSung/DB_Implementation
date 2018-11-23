const express = require('express');
const router = express.Router();

//use the sql queries to check if the user is registered.
let conn = require('../utils/dbConnection');

let util = require('../utils/util');

//To solve the forbidden error that is occurred by the '/..' in the res.sendFile function.
const path = require('path');

/* GET users listing. */
router.get('/', function (req, res) {
    res.render('login', { title: 'Bookstream :: login', val: undefined });
});

/* GET log in authentication */
router.post('/', function (req, res) {
    let id = req.body.id;
    let pw = req.body.password;

    pw = util.encodePassword(pw);

    //TODO sql connection -> log in
});

router.get('/stylesheets/loginStyle.css', function (req, res) {
    res.sendFile(path.resolve(__dirname + '/../public/stylesheets/loginStyle.css'));
});

module.exports = router;