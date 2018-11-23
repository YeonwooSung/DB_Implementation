const express = require('express');
const router = express.Router();

//use the sql queries to check if the user is registered.
const conn = require('../utils/dbConnection');

const util = require('../utils/util');

/* GET users listing. */
router.get('/', function (req, res) {
    res.render('register', { title: 'Register', alert: undefined });
});

router.post('/', function (req, res) {
    console.log(req.body);
    let { userName, id, password, confirmedP, email, confirmedE } = req.body;

    password = util.encodePassword(password);

    //TODO sql connection -> register
});

module.exports = router;