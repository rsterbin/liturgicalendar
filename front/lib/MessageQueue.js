/**
 * Manage access to the message queue(s)
 */

if (!global.MessageQueue) {

    var AWS = require('aws-sdk');
    var Promise = require('bluebird');

    var StateError = require('../lib/errors/StateError.js');

    global.MessageQueue = {

        /**
         * Start up the message queue handler
         */
        startup: function (config) {
            this.config = config
            this.urls = { calcRequest: this.config.calcRequestUrl };
            AWS.config.update({
                accessKeyId: this.config.accessKeyId,
                secretAccessKey: this.config.secretAccessKey
            });
            var sqs = new AWS.SQS({ region: this.config.region });
            Promise.promisifyAll(Object.getPrototypeOf(sqs));
            this.initialized = true;
        },

        /**
         * Requires that the message queue handler be initialized
         *
         * @throws StateError if it isn't
         */
        requireInitialized: function () {
            if (!this.initialized) {
                throw new StateError('Message queue is not initialized');
            }
        },

        /**
         * Gets the primary sqs connection
         *
         * @return AWS.SQS the sqs connection
         * @throws StateError if the handler isn't initialized
         */
        getConnection: function () {
            if (typeof this.sqs === 'undefined') {
                this.sqs = this.newConnection();
            }
            return this.sqs;
        },

        /**
         * Gets a new sqs connection
         *
         * @return AWS.SQS the sqs connection
         * @throws StateError if the handler isn't initialized
         */
        newConnection: function () {
            this.requireInitialized();
            return new AWS.SQS({ region: this.config.region });
        },

        /**
         * Writes a new calculation request to the queue
         *
         * @param  object  message the message to send as a payload
         * @return Promise the promise
         * @throws StateError if the registry isn't initialized
         */
        writeCalcRequest: function (message) {
            var sqsParams = {
                MessageBody: JSON.stringify(message),
                QueueUrl: this.urls.calcRequest
            };
            return this.getConnection().sendMessageAsync(sqsParams);
        }

    };
}

module.exports = global.MessageQueue;
