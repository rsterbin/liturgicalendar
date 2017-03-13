/**
 * pg-promise wants one connection only
 */
if (!global.GLOBAL_OVERRIDE_LOAD_DATABASE_CONNECTION) {
    var config = require('./config');
    var pgp = require('pg-promise')();
    var db = pgp(config.database);
    global.GLOBAL_OVERRIDE_LOAD_DATABASE_CONNECTION = true;
}

module.exports = db;

