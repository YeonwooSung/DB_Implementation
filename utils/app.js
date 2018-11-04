'use strict';

//import required libraries
let createError = require('http-errors');
let express = require('express');
let path = require('path');
let ejs = require('ejs');

let app = express()

//The routers objects.
let indexRouter = require('./routes/index');

//Set the view engine
app.set('views', path.join(__dirname, 'views'));
app.engine('html', ejs.renderFile);
app.set('view engine', 'html');

//Add router objects
app.use('/', indexRouter);

// catch 404 and forward to error handler
app.use(function (req, res, next) {
    next(createError(404));
});

module.exports = app