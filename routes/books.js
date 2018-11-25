const express = require('express');
const router = express.Router();

//use the sql queries to check if the user is registered.
const conn = require('../utils/dbConnection');

/* GET users listing. */
router.get('/', function (req, res) {
    conn.listAllAudiobooks(res); //get all audiobooks from db and send the response to the client
});


module.exports = router;