'use strict';

//import required libraries
let createError = require('http-errors');
let express = require('express');
let path = require('path');
let cookieParser = require('cookie-parser');
let logger = require('morgan');

let app = express()

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());


//TODO use favicon
const favicon = require('express-favicon');
app.use(favicon(path.resolve(__dirname + '/../public/images/book.ico')));


//The routers objects.
let indexRouter = require('../routes/index');
let publicRouter = require('../routes/publicRouter');
let loginRouter = require('../routes/login');
let registerRouter = require('../routes/register');
let bookRouter= require('../routes/books');
let logoutRouter = require('../routes/logout');
let reviewsRouter = require('../routes/reviews');
let authorsRouter = require('../routes/authors');
let ratingsRouter = require('../routes/ratings');


//Add router objects
app.use('/', indexRouter);
app.use('/public', publicRouter);
app.use('/login', loginRouter);
app.use('/register', registerRouter);
app.use('/books', bookRouter);
app.use('/logout', logoutRouter);
app.use('/reviews', reviewsRouter);
app.use('/authors', authorsRouter);
app.use('/ratings', ratingsRouter);


//Set the view engine
app.engine('pug', require('pug').__express)
app.set('views', path.join(__dirname, '../views'));
app.set('view engine', 'pug'); //use the pug as a template engine


// catch 404 and forward to error handler
app.use(function (req, res, next) {
    next(createError(404));
});

module.exports = app