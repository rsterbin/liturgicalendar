/**
 * A lot of the database stuff can only be created once per run, so manage it centrally
 *
 * NB: Turn on logging by setting up winston loggers called "query" and "error"
 */

if (!global.Database) {
    var fs = require('fs');
    var path = require('path');
    var winston = require('winston');

    var StateError = require('../lib/errors/StateError.js');

    global.Database = {

        /**
         * Start up the database handler
         */
        startup: function (config) {
            this.config = config

            // set up the pgp database library
            this.pgp = require('pg-promise')({
                error: (err, cxt) => {
                    if (cxt.query) {
                        var logger = winston.loggers.get('query');
                        logger.error('Query error: ' + err.message, { sql: cxt.query, binds: cxt.params, error: err });
                    } else if (cxt.cn) {
                        var logger = winston.loggers.get('error');
                        logger.error('Database connection error: ' + err.message, { error: err });
                    }
                },
                query: (cxt) => {
                    if (cxt.query) {
                        var logger = winston.loggers.get('query');
                        if (logger) {
                            logger.debug('Running query', { sql: cxt.query, binds: cxt.params });
                        }
                    }
                },
                receive: (data, result, cxt) => {
                    if (cxt.query) {
                        var logger = winston.loggers.get('query');
                        logger.info('Query success', { sql: cxt.query, binds: cxt.params });
                    }
                }
            });

            // ensure the query file directory exists
            this.qfileDirectory = path.join(__dirname, 'queries');
            fs.existsSync(this.qfileDirectory) || fs.mkdirSync(this.qfileDirectory);

            this.queryFiles = {};
            this.initialized = true;
        },

        /**
         * Requires that the database handler be initialized
         *
         * @throws StateError if it isn't
         */
        requireInitialized: function () {
            if (!this.initialized) {
                throw new StateError('Database is not initialized');
            }
        },

        /**
         * Gets the primary database connection
         *
         * @return pgp.DatabaseConnection the db connection
         * @throws StateError if the handler isn't initialized
         */
        getConnection: function () {
            if (typeof this.db === 'undefined') {
                this.db = this.newConnection();
            }
            return this.db;
        },

        /**
         * Gets a new connection
         *
         * @return pgp.DatabaseConnection the db connection
         * @throws StateError if the handler isn't initialized
         */
        newConnection: function () {
            this.requireInitialized();
            return this.pgp(this.config);
        },

        /**
         * Gets a QueryFile object
         *
         * @param  string        filename the query's filename
         * @return pgp.QueryFile the query file object, or null if the query file doesn't exist
         * @throws StateError if the registry isn't initialized
         */
        getQueryFile: function (filename) {
            this.requireInitialized();
            if (!(filename in this.queryFiles)) {
                var fullpath = path.join(this.qfileDirectory, filename);
                if (!fs.existsSync(fullpath)) {
                    this.queryFiles[filename] = null;
                } else {
                    this.queryFiles[filename] = new this.pgp.QueryFile(fullpath, {minify: true});
                }
            }
            return this.queryFiles[filename];
        }

    };
}

module.exports = global.Database;
