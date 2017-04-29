/**
 * Database storage of the calendar
 */

var winston = require('winston');

var Calendar = require('../Calendar.js');

var logDbError = function (error) {
    var logger = winston.loggers.get('error');
    logger.log('error', 'Database Error #' + error.code + ': ' + error.message, { full: error });
};

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
                var calendar = new Calendar();
                calendar.loadFromRows(rows, 'cached_id');
                return calendar;
            }, error => {
                logDbError(error);
                return new Error('Could not get the calendar by date range');
            });
    }

});

module.exports = DatabaseStorage;
