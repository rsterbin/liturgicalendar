var express = require('express');
var Promise = require('bluebird');

var DatabaseStorage = require('../../lib/storage/database.js');

function checkForCached(db) {
    var storage = new DatabaseStorage(db);
    return storage.getForDateRange('2012-01-01', '2012-01-31');
}

function doOkay(message) {
    return new Promise((resolve, reject) => {
        resolve({ status: 'success', data: message });
    });
}

function setupRoutes(registry) {

    var router = express.Router();

    router.get('/', (req, res, next) => {
        checkForCached(registry.getDatabase())
            .then(message => doOkay(message))
            .then(json => { res.json(json); })
            .catch(next);
    });

    return router;
}

module.exports = setupRoutes;
