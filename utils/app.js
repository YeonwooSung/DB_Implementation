'use strict';

//import required libraries
let createError = require('http-errors');
let express = require('express');
let path = require('path');
let ejs = require('ejs');
let logger = require('morgan');

let app = express()

//Add the logger
app.use(logger('dev'));

//The routers objects.
let indexRouter = require('../routes/index');
let publicRouter = require('../routes/publicRouter');

//Set the view engine
app.set('views', path.join(__dirname, '/../views'));
app.engine('html', ejs.renderFile);
app.set('view engine', 'html');

//Add router objects
app.use('/', indexRouter);
app.use('/public', publicRouter);

// catch 404 and forward to error handler
app.use(function (req, res, next) {
    next(createError(404));
});

module.exports = app