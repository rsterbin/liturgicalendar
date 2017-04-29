/**
 * Database storage of the calendar
 */

var moment = require('moment');

var DatabaseStorage = function (db) {
    this.db = db;
};

Object.assign(DatabaseStorage.prototype, {

    /**
     * Fetches the calendar within a date range
     *
     * @param  DateTime startDate the start of the range
     * @param  DateTime endDate   the end of the range
     * @return Calendar the resulting calendar
     */
    getForDateRange: function (startDate, endDate) {
        var qf = this.db.getQueryFile('select_calendar_by_dates.sql');
        var binds = [startDate, endDate];
        return this.db.getConnection().any(qf, binds)
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
            }, error => {
                console.log(error);
                return new Error('Yeah that didnt work');
            });
    }

});

module.exports = DatabaseStorage;
