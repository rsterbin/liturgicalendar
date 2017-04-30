/**
 * Transitory error that should resolve itself shortly
 */

var TemporaryError = function (message, code) {
    this.message = message;
    this.code = code;
    this.stack = (new Error()).stack;
};
TemporaryError.prototype = Object.create(Error.prototype);
TemporaryError.prototype.constructor = TemporaryError;
TemporaryError.prototype.name = 'TemporaryError';

module.exports = TemporaryError;
