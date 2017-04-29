/**
 * Database storage of the calendar
 */

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
    }

});

module.exports = DatabaseStorage;
