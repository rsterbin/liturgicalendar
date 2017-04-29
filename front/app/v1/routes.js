var express = require('express');
var Promise = require('bluebird');
var moment = require('moment');

var DatabaseStorage = require('../../lib/storage/database.js');
var DateRange = require('../../lib/DateRange.js');
var InputError = require('../../lib/errors/InputError.js');

function checkRange(start, end) {
    return new Promise((resolve, reject) => {
        if (!start || !end) {
            return reject(new InputError('Start and end dates are required', 110));
        }
        var dts = moment(start, 'YYYY-MM-DD');
        var dte = moment(end, 'YYYY-MM-DD');
        if (!dts.isValid()) {
            return reject(new InputError('Start is not a valid date (use format YYYY-MM-DD)', 120));
        }
        if (!dte.isValid()) {
            return reject(new InputError('End is not a valid date (use format YYYY-MM-DD)', 121));
        }
        var range = new DateRange(dts, dte);
        if (!range.isValid()) {
            return reject(new InputError('Date range ' + range + ' is invalid: Start is before end', 122));
        }
        if (range.days() > 365) {
            return reject(new InputError('Date range ' + range + ' is invalid: Range is more than a year long', 141));
        }
        return resolve(range);
    });
}

function findForRange(range, db) {
    var storage = new DatabaseStorage(db);
    return storage.getForDateRange(range.startYmd(), range.endYmd())
        .then(calendar => {
            if (calendar.days() < range.days()) {
                return new Error('Not as many days returned (' + calendar.days() + ') as we need (' + range.days() + ')');
            }
            return calendar.getSchedule();
        });
}

function doOkay(message) {
    return new Promise((resolve, reject) => {
        if (message instanceof InputError) {
            resolve({ status: 'failure', message: message.message, code: message.code });
        } else if (message instanceof Error) {
            resolve({ status: 'error', message: message.message });
        } else {
            resolve({ status: 'success', data: message });
        }
    });
}

function setupRoutes(registry) {

    var router = express.Router();

    router.get('/', (req, res, next) => {
        checkRange(req.query.start, req.query.end)
            .then(range => findForRange(range, registry.getDatabase()), error => error)
            .then(message => doOkay(message))
            .then(json => { res.json(json); })
            .catch(next);
    });

    return router;
}

module.exports = setupRoutes;
