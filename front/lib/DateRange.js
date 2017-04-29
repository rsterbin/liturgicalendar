/**
 * Date range handling
 */

var DateRange = function(start, end) {
    this.start = start;
    this.end = end;
};

Object.assign(DateRange.prototype, {

    /**
     * Returns the range as a string (for use in logging)
     *
     * @return string the date range as a string
     */
    toString: function () {
        return this.start.format('YYYY-MM-DD') + ' to ' + this.end.format('YYYY-MM-DD');
    },

    /**
     * Returns the start date as a ymd string
     *
     * @return string the start date in ymd format
     */
    startYmd: function () {
        return this.start.format('YYYY-MM-DD');
    },

    /**
     * Returns the end date as a ymd string
     *
     * @return string the end date in ymd format
     */
    endYmd: function () {
        return this.end.format('YYYY-MM-DD');
    },

    /**
     * Returns whether the range is valid (start before end)
     *
     * @return boolean whether the range is valid
     */
    isValid: function () {
        return this.end > this.start;
    },

    /**
     * Returns the number of days in this range, inclusive
     *
     * @return integer the number of days
     */
    days: function() {
        return this.end.diff(this.start, 'days') + 1;
    }

});

module.exports = DateRange;
