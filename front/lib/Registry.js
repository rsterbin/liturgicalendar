/**
 * Registry for the app: anything that needs to be shared to every route, and
 * things that can have only one copy for the whole app
 */

if (!global.Registry) {
    var fs = require('fs');
    var path = require('path');

    var StartupError = require('./errors/StartupError.js');
    var StateError = require('./errors/StateError.js');

    global.Registry = {

        /**
         * Start up the registry
         *
         * @param  object config the config
         * @throws StartupError if the registry couldn't be initialized
         */
        startup: function (config) {
            this.config = config;

            // ensure the log directory exists
            fs.existsSync(this.config.logDirectory) || fs.mkdirSync(this.config.logDirectory);

            this.initialized = true;
        },

        /**
         * Have we initialized?
         *
         * @return boolean whether the registry has been initialized
         */
        initialized: function () {
            return this.initialized === true;
        },

        /**
         * Requires that the registry be initialized
         *
         * @throws StartupError if it isn't
         */
        requireInitialized: function () {
            if (!this.initialized) {
                throw new StartupError('Registry is not initialized');
            }
        },

        /**
         * Gets the primary memcached connection
         *
         * @return Memcached the memcached connection
         */
        getMemcached: function () {
            this.requireInitialized();
            if (typeof this.mc === 'undefined') {
                this.mc = require('./Memcached.js');
            }
            return this.mc;
        },

        /**
         * Gets the primary database connection
         *
         * @return Database the db connection
         * @throws StartupError if the registry isn't initialized
         * @throws StateError   if the PG-Promise initializer is missing
         */
        getDatabase: function () {
            this.requireInitialized();
            if (typeof this.db === 'undefined') {
                this.db = require('./Database.js');
                this.db.startup(this.config.database);
            }
            return this.db;
        },

        /**
         * Gets the message queue handler
         *
         * @return MessageQueue the message queue handler
         * @throws StartupError if the registry isn't initialized
         */
        getMessageQueue: function () {
            this.requireInitialized();
            if (typeof this.mq === 'undefined') {
                this.mq = require('./MessageQueue.js');
                this.mq.startup(this.config.messageQueue);
            }
            return this.mq;
        }

    };
}

module.exports = global.Registry;
