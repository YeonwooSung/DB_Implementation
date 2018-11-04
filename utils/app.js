'use strict';

//import required libraries
let createError = require('http-errors');
let express = require('express');
let path = require('path');
let consolidate = require('consolidate');

let app = express()

//The routers objects.
let indexRouter = require('./routes/index');

//Set the view engine
app.engine('html', consolidate.swig);
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', html);

//Add router objects
app.use('/', indexRouter);

// catch 404 and forward to error handler
app.use(function (req, res, next) {
    next(createError(404));
});

module.exports = app