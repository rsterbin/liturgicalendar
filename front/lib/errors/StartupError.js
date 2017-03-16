/**
 * Error on server startup
 */

var StartupError = function (message) {
    this.message = message;
    this.stack = (new Error()).stack;
};
StartupError.prototype = Object.create(Error.prototype);
StartupError.prototype.constructor = StartupError;
StartupError.prototype.name = 'StartupError';

module.exports = StartupError;
