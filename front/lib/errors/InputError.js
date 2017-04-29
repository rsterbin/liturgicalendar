/**
 * Error due to incorrect input
 */

var InputError = function (message, code) {
    this.message = message;
    this.code = code;
    this.stack = (new Error()).stack;
};
InputError.prototype = Object.create(Error.prototype);
InputError.prototype.constructor = InputError;
InputError.prototype.name = 'InputError';

module.exports = InputError;
