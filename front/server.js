var express = require('express')
var app = express()
var fs = require('fs')
var path = require('path')

var morgan = require('morgan')
var rfs = require('rotating-file-stream')

var winston = require('winston')

var v1routes = require('./app/v1/routes.js')

// Make sure we have a log directory
var logDirectory = path.join(__dirname, 'log');
fs.existsSync(logDirectory) || fs.mkdirSync(logDirectory);

// Rotating access log (daily)
var accessLogStream = rfs('access.log', {
  interval: '1d',
  path: logDirectory
});
app.use(morgan('combined', {stream: accessLogStream}));

// Logging config
winston.loggers.add('error', {
    transports: [
        new (require('winston-daily-rotate-file'))({ filename: logDirectory + '/error.log' })
    ],
});

// Add routes for API v1
app.use('/v1', v1routes)

app.listen(3000, function () {
    console.log('Example app listening on port 3000!')
})

