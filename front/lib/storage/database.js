/**
 * Database storage of the calendar
 */

var Calendar = require('../Calendar.js');

var DatabaseStorage = function (db) {
    this.db = db;
};

Object.assign(DatabaseStorage.prototype, {

    /**
     * Fetches the calendar within a date range
     *
     * @param  DateTime startDate the start of the range
     * @param  DateTime endDate   the end of the range
     * @return object   the resulting calendar
     */
    getForDateRange: function (startDate, endDate) {
        var qf = this.db.getQueryFile('select_calendar_by_dates.sql');
        var binds = [startDate, endDate];
        return this.db.getConnection().any(qf, binds)
            .then(rows => {
                return Calendar.buildFromRows(rows, 'cached_id');
            }, error => {
                console.log(error);
                return new Error('Yeah that didnt work');
            });
    }

});

module.exports = DatabaseStorage;
