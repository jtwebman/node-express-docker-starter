'use strict';

const express = require('express');
const app = express();

const indexRouter = require('./routers/index');

app.disable('x-powered-by');

app.use('/', indexRouter);

module.exports = app;
