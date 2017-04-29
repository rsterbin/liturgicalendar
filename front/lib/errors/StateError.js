/**
 * Error due to incorrect state of the app
 */

var StateError = function (message) {
    this.message = message;
    this.stack = (new Error()).stack;
};
StateError.prototype = Object.create(Error.prototype);
StateError.prototype.constructor = StateError;
StateError.prototype.name = 'StateError';

module.exports = StateError;
