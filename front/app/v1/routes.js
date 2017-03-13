var express = require('express');
var Promise = require('bluebird');
var router = express.Router();
var winston = require('winston');
var moment = require('moment');

var standard = require('../../lib/standard.js');
var db = require('../db');

function checkForCached() {
    var sql = ['SELECT c.cached_id, c.target_date, c.target_block, c.name, ',
        '   c.color, c.note, s.name AS service_name, ',
        '   s.start_time AS service_start_time ',
        'FROM cached c ',
        '    LEFT JOIN cached_services s ON (c.cached_id = s.cached_id) ',
        'WHERE c.target_date BETWEEN $1 AND $2 ',
        'ORDER BY c.target_date, c.target_block, s.start_time'].join("\n");
    var binds = ['2012-01-01', '2012-01-31'];
    var logger = winston.loggers.get('query');
    logger.log('info', 'Running query', { sql: sql, binds: binds });
    return db.any(sql, binds)
        .then(rows => {
            var schedule = {};
            var cdate = null;
            var cid = null;
            var cblock = null;
            for (var i = 0; i < rows.length; i++) {
                var row = rows[i];
                if (cdate != moment(row['target_date']).format('YYYY-MM-DD')) {
                    cdate = moment(row['target_date']).format('YYYY-MM-DD');
                    schedule[cdate] = {
                        date: cdate,
                        blocks: {}
                    };
                }
                if (cid != row['cached_id']) {
                    cid = row['cached_id'];
                    cblock = row['target_block'];
                    schedule[cdate]['blocks'][cblock] = {
                        name: row['name'],
                        color: row['color'],
                        note: row['note'],
                        services: []
                    };
                }
                schedule[cdate]['blocks'][cblock]['services'].push({
                    service_name: row['service_name'],
                    service_start_time: row['service_start_time']
                });
            }
            return schedule;
        })
}

function doOkay(message) {
    return new Promise((resolve, reject) => {
        resolve({ status: 'success', data: message });
    });
}

router.get('/', (req, res, next) => {
    checkForCached()
        .then(message => doOkay(message))
        .then(json => { res.json(json); })
        .catch(next);
});

module.exports = router;
