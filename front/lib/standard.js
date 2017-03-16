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


module.exports = {
    BasicFailure: BasicFailure,
    BasicError: BasicError,
};
