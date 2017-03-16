/**
 * Registry for the app: anything that needs to be shared to every route
 */

var fs = require('fs');

var StartupError = require('../lib/errors/StartupError.js');

var Registry = function (config) {
    this.config = config;
};

Object.assign(Registry.prototype, {

    startup: function () {
        this.pgp = require('pg-promise')();
        this.getDatabaseConnection();

        fs.existsSync(this.config.logDirectory) || fs.mkdirSync(this.config.logDirectory);

    },

    getDatabaseConnection: function () {
        if (typeof this.db === 'undefined') {
            this.db = this.newDatabaseConnection();
        }
        return this.db;
    },

    newDatabaseConnection: function () {
        if (typeof this.pgp === 'undefined') {
            throw new StartupError('PG-Promise initializer function is missing');
        }
        return this.pgp(this.config.database);
    }

});

module.exports = Registry;
