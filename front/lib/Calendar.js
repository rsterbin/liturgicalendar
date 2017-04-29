/**
 * Calendar schedule handling
 */

var moment = require('moment');

/**
 * Turns a row set into a schedule
 *
 * The ID field is passed in, as this can cover both cached and calculated
 * schedules.  The expected field names for everything else are:
 *  - target_date
 *  - target_block
 *  - name
 *  - color
 *  - note
 *  - service_name
 *  - service_start_time
 *
 * @param  Array  rows    the rows
 * @param  string idField the field with the ID in it
 * @return object the resulting calendar
 */
var buildFromRows = function (rows, idField) {
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
        if (cid != row[idField]) {
            cid = row[idField];
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
};

module.exports = { buildFromRows: buildFromRows };
