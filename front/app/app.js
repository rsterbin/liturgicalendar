/**
 * Sets up the app
 */

var express = require('express');
var winston = require('winston');
var expressWinston = require('express-winston');

var setupV1Routes = require('./v1/routes.js');
var errorHandler = require('../lib/errorHandler.js');
var StartupError = require('../lib/errors/StartupError.js');
var Registry = require('../lib/Registry.js');

var CalendarApp = function (config) {
    this.config = config;
};

Object.assign(CalendarApp.prototype, {

    startup: function () {
        this.config = this.confirmConfig(this.config);
        this.getExpressApp();
    },

    listen: function () {
        var port = this.config.apiPort;
        this.getExpressApp().listen(port, function () {
            console.log('Listening on port ' + port)
        })
    },

    confirmConfig: function (config) {
        if (typeof config === 'undefined') {
            config = {};
        }
        if (typeof config !== 'object') {
            throw new StartupError('Configuration is invalid');
        }
        if (typeof config.database === 'undefined') {
            throw new StartupError('Must specify database configuration');
        }
        ['host', 'port', 'database', 'user', 'password'].forEach(function (key) {
            if (typeof config.database[key] !== 'string') {
                console.log(key);
                throw new StartupError('Must specify database ' + key);
            }
        });
        if (typeof config.apiPort !== 'string') {
            throw new StartupError('Must specify port to listen on');
        }
        if (typeof config.logDirectory !== 'string') {
            throw new StartupError('Must specify log directory');
        }
        return config;
    },

    getExpressApp: function () {
        if (typeof this.app == 'undefined') {
            var app = express();
            this.applyEarlyMiddleware(app);
            this.applyRoutes(app, this.getRegistry());
            this.applyLateMiddleware(app);
            this.app = app;
        }
        return this.app;
    },

    getRegistry: function () {
        if (!Registry.initialized()) {
            Registry.startup(this.config);
        }
        return Registry;
    },

    applyEarlyMiddleware: function (app) {
        // Access log
        app.use(expressWinston.logger({
            transports: [
                new (require('winston-daily-rotate-file'))({ filename: this.config.logDirectory + '/access.log' })
            ],
            expressFormat: true
        }));
    },

    applyRoutes: function (app, registry) {
        app.use('/v1', setupV1Routes(registry))
    },

    applyLateMiddleware: function (app) {
        // Error log
        winston.loggers.add('error', {
            transports: [
                new (require('winston-daily-rotate-file'))({ filename: this.config.logDirectory + '/error.log', level: 'warn' })
            ]
        });

        // Query log
        winston.loggers.add('query', {
            transports: [
                new (require('winston-daily-rotate-file'))({ filename: this.config.logDirectory + '/query.log', level: 'warn' })
            ]
        });

        // Failure log
        winston.loggers.add('failure', {
            transports: [
                new (require('winston-daily-rotate-file'))({ filename: this.config.logDirectory + '/failure.log', level: 'info' })
            ]
        });

        // Error handler
        app.use(errorHandler);
    }

});

module.exports = CalendarApp;
