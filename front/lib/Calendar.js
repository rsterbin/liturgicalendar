/**
 * Calendar schedule handling
 */

var moment = require('moment');

var Calendar = function() {
    this.schedule = {};
};

Object.assign(Calendar.prototype, {

    /**
     * Loads up the calendar from the rows given
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
     */
    loadFromRows: function (rows, idField) {
        this.schedule = {};
        var cdate = null;
        var cid = null;
        var cblock = null;
        for (var i = 0; i < rows.length; i++) {
            var row = rows[i];
            if (cdate != moment(row['target_date']).format('YYYY-MM-DD')) {
                cdate = moment(row['target_date']).format('YYYY-MM-DD');
                this.schedule[cdate] = {
                    date: cdate,
                    blocks: {}
                };
            }
            if (cid != row[idField]) {
                cid = row[idField];
                cblock = row['target_block'];
                this.schedule[cdate]['blocks'][cblock] = {
                    name: row['name'],
                    color: row['color'],
                    note: row['note'],
                    services: []
                };
            }
            this.schedule[cdate]['blocks'][cblock]['services'].push({
                service_name: row['service_name'],
                service_start_time: row['service_start_time']
            });
        }
    },

    /**
     * Gets the schedule
     *
     * The schedule format is:
     *   [YYYY-MM-DD]: {
     *     blocks: {
     *       base: {
     *         name: 'Weekday',
     *         color: 'green',
     *         note: 'Today is a day',
     *         services: [
     *           { service_name: 'Morning Prayer', service_time: {8:30am} },
     *           ...etc
     *         ]
     *       }
     *     }
     *   }
     *
     * @return object the schedule
     */
    getSchedule: function () {
        return this.schedule;
    },

    /**
     * Returns the number of days accounted for in this calendar
     *
     * @return integer the number of days
     */
    days: function() {
        return Object.keys(this.schedule).length;
    }

});

module.exports = Calendar;
