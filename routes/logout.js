const express = require('express');
const router = express.Router();

/* process the log out request */
router.get('/', function (req, res) {
    res.clearCookie('ID');
    res.redirect('/login');
});

module.exports = router;