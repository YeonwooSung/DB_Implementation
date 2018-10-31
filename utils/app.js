//import required libraries
let createError = require('http-errors');
let express = require('express');
let path = require('path');

let app = express()

// catch 404 and forward to error handler
app.use(function (req, res, next) {
    next(createError(404));
});

module.exports = app