var express = require('express');
var app = express();
var fs = require('fs');
var path = require('path');
var winston = require('winston');
var expressWinston = require('express-winston');

var v1routes = require('./app/v1/routes.js');
var standard = require('./lib/standard.js');

// Make sure we have a log directory
var logDirectory = path.join(__dirname, 'log');
fs.existsSync(logDirectory) || fs.mkdirSync(logDirectory);

// Access log
app.use(expressWinston.logger({
    transports: [
        new (require('winston-daily-rotate-file'))({ filename: logDirectory + '/access.log' })
    ],
    expressFormat: true
}));

// Add routes for API v1
app.use('/v1', v1routes)

// Error log
winston.loggers.add('error', {
    transports: [
        new (require('winston-daily-rotate-file'))({ filename: logDirectory + '/error.log' })
    ]
});

// Failure log
winston.loggers.add('failure', {
    transports: [
        new (require('winston-daily-rotate-file'))({ filename: logDirectory + '/failure.log' })
    ]
});

app.use(standard.errorHandler);

app.listen(3000, function () {
    console.log('Listening on port 3000')
})

