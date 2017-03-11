var Promise = require('bluebird');
var winston = require('winston');

/**
 * Class for returning failures
 *
 * @param string  message the message
 * @param integer code    the code
 * @param bool    doLog   [optional] whether to record this in the failure log
 * @param string  context [optional] when logging, this is the context
 */
const BasicFailure = function (message, code, doLog, context) {
    this.message = message;
    this.code = code;
    this.doLog = doLog;
    this.context = context;
};

/**
 * Class for returning errors
 *
 * @param string  message the message
 * @param integer code    the code
 * @param string  context [optional] when logging, this is the context
 */
const BasicError = function (message, code, context) {
    this.message = message;
    this.code = code;
    this.context = context;
};

/**
 * Handles errors the default way
 *
 * To create a failure response, reject with a BasicFailure or a string
 * To create an error response, reject with a BasicError or any object with
 *   a `message` element (or throw a javascript error)
 * If you reject with anything else, you'll get an error with a message
 *   "Unknown error"
 *
 * @param mixed err the error
 * @param expressRequest req the request
 * @param expressResponse res the response
 * @param callback next the next callback
 */
const errorHandler = function (err, req, res, next) {
    var json = { status: 'error', message: 'Unknown error' };
    var status = 500;
    var logto = null;
    var logmeta = null;

    if (err instanceof BasicFailure || err instanceof BasicError) {
        json['message'] = err.message;
        if (err.code) {
            json['code'] = err.code;
        }
    }

    if (err instanceof BasicFailure) {
        status = 200;
        json['status'] = 'fail';
        if (err.doLog) {
            logto = 'failure';
            logmeta = { code: err.code, context: err.context };
        }

    } else if (err instanceof BasicError) {
        status = 501;
        logto = 'error';
        logmeta = { code: err.code, context: err.context };

    } else if (typeof err == 'object' && 'message' in err) {
        json['message'] = err.message
        logto = 'error';
        logmeta = {};

    } else if (typeof err == 'string') {
        status = 200;
        json['status'] = 'fail';
        json['message'] = err;

    } else {
        logto = 'error';
        logmeta = { 'raw': err };
    }

    if ('stack' in err) {
        console.error(err.stack);
        if (logto) {
            logmeta['stack'] = err.stack;
        }
    }

    if (logto) {
        var logger = winston.loggers.get(logto);
        logger.log('error', json['message'], logmeta);
    }

    res.status(status).json(json);
}

module.exports = {
    BasicFailure: BasicFailure,
    BasicError: BasicError,
    errorHandler: errorHandler
};
