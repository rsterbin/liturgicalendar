
-- rambler up

--
-- Define the liturigal seasons of the year
--

INSERT INTO liturigal_seasons (name, code, color, sort_order, algorithm, arg1, arg2,
        weekday_precedence, has_rose_sunday, continue_counting, schedule_pattern,
        name_pattern_mon, name_pattern_tue, name_pattern_wed, name_pattern_thu,
        name_pattern_fri, name_pattern_sat, name_pattern_sat_vigil, name_pattern_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu,
        default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Advent', 'advent', 'purple', 0, 'sundays_before', 4, 'christmas',
        60, true, false, 'standard',
        'Weekday of Advent', 'Weekday of Advent', 'Weekday of Advent', 'Weekday of Advent',
        'Weekday of Advent', 'Weekday of Advent', 'Eve of the %s Sunday of Advent', 'The %s Sunday of Advent',
        NULL, NULL, NULL, NULL,
        'Friday Abstinence', NULL, NULL
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order, algorithm, arg1, arg2,
        weekday_precedence, has_rose_sunday, continue_counting, schedule_pattern,
        name_pattern_mon, name_pattern_tue, name_pattern_wed, name_pattern_thu,
        name_pattern_fri, name_pattern_sat, name_pattern_sat_vigil, name_pattern_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu,
        default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Christmas', 'christmas', 'white', 1, 'continue_for', 1, 'week',
        45, false, false, 'standard-no-confessions',
        'Weekday of Christmas', 'Weekday of Christmas', 'Weekday of Christmas', 'Weekday of Christmas',
        'Weekday of Christmas', 'Weekday of Christmas', 'Eve of the %s Sunday after Christmas Day', 'The %s Sunday after Christmas Day',
        NULL, NULL, NULL, NULL,
        'Friday Abstinence is not observed during the Christmas Season.', 'Confessions are not heard, except by appointment, on the Saturdays of the Christmas Season.', NULL
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order, algorithm, weekday_precedence,
        has_rose_sunday, has_last_sunday, continue_counting, schedule_pattern,
        name_pattern_mon, name_pattern_tue, name_pattern_wed, name_pattern_thu,
        name_pattern_fri, name_pattern_sat, name_pattern_sat_vigil, name_pattern_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu,
        default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Ordinary Time After Epiphany', 'after-epiphany', 'green', 2, 'continue', 60,
        false, true, false, 'standard',
        'Weekday', 'Weekday', 'Weekday', 'Weekday',
        'Weekday', 'Weekday', 'Eve of the %s Sunday after the Epiphany', 'The %s Sunday after the Epiphany',
        NULL, NULL, NULL, NULL,
        'Friday Abstinence', NULL, NULL
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order, algorithm, arg1,
        weekday_precedence, has_rose_sunday, continue_counting, schedule_pattern,
        name_pattern_mon, name_pattern_tue, name_pattern_wed, name_pattern_thu,
        name_pattern_fri, name_pattern_sat, name_pattern_sat_vigil, name_pattern_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu,
        default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Lent', 'lent', 'purple', 3, 'start_at', 'ash-wednesday',
        45, true, false, 'standard-stations',
        'Weekday of Lent', 'Weekday of Lent', 'Weekday of Lent', 'Weekday of Lent',
        'Weekday of Lent', 'Weekday of Lent', 'Eve of the %s Sunday in Lent', 'The %s Sunday in Lent',
        'Abstinence', 'Abstinence', 'Abstinence', 'Abstinence',
        'Lenten Friday Abstinence', 'Abstinence', 'Abstinence is not observed on Sundays in Lent.'
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order, algorithm, arg1, arg2,
        weekday_precedence, has_rose_sunday, continue_counting, schedule_pattern,
        name_pattern_mon, name_pattern_tue, name_pattern_wed, name_pattern_thu,
        name_pattern_fri, name_pattern_sat, name_pattern_sat_vigil, name_pattern_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu,
        default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Holy Week', 'holy-week', 'red', 4, 'days_before', 7, 'easter',
        15, false, false, 'standard',
        'Monday of Holy Week', 'Tuesday of Holy Week', 'Wednesday of Holy Week', 'Thursday of Holy Week',
        'Good Friday', 'Holy Saturday', 'Eve of the Sunday of the Passion: Palm Sunday', 'The Sunday of the Passion: Palm Sunday',
        'Abstinence', 'Abstinence', 'Abstinence', 'Abstinence',
        'Fast & Abstinence', 'Abstinence', 'Abstinence is not observed on Palm Sunday.'
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order, algorithm, arg1, arg2,
        weekday_precedence, has_rose_sunday, continue_counting, schedule_pattern,
        name_pattern_mon, name_pattern_tue, name_pattern_wed, name_pattern_thu,
        name_pattern_fri, name_pattern_sat, name_pattern_sat_vigil, name_pattern_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu,
        default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Easter Week', 'easter-week', 'gold', 5, 'days_after', 7, 'easter',
        15, false, false, 'standard-no-confessions',
        'Monday in Easter Week', 'Tuesday in Easter Week', 'Wednesday in Easter Week', 'Thursday in Easter Week',
        'Friday in Easter Week', 'Saturday in Easter Week', 'Eve of the %s Sunday of Easter', 'The %s Sunday of Easter',
        NULL, NULL, NULL, NULL,
        'Friday abstinence is not observed in Eastertide.', 'Confessions are heard only by appointment during Easter Week.', NULL
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order, algorithm, arg1, arg2,
        weekday_precedence, has_rose_sunday, continue_counting, schedule_pattern,
        name_pattern_mon, name_pattern_tue, name_pattern_wed, name_pattern_thu,
        name_pattern_fri, name_pattern_sat, name_pattern_sat_vigil, name_pattern_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu,
        default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Easter', 'easter', 'white', 6, 'days_after', 50, 'easter',
        60, false, true, 'standard',
        'Weekday of Easter', 'Weekday of Easter', 'Weekday of Easter', 'Weekday of Easter',
        'Weekday of Easter', 'Weekday of Easter', 'Eve of the %s Sunday of Easter', 'The %s Sunday of Easter',
        NULL, NULL, NULL, NULL,
        'Friday abstinence is not observed in Eastertide.', NULL, NULL
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order, algorithm, arg1, arg2,
        weekday_precedence, has_rose_sunday, continue_counting, schedule_pattern,
        name_pattern_mon, name_pattern_tue, name_pattern_wed, name_pattern_thu,
        name_pattern_fri, name_pattern_sat, name_pattern_sat_vigil, name_pattern_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu,
        default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Ordinary Time After Pentecost (Spring)', 'pentecost-spring', 'green', 7, 'continue_for', 3, 'weeks',
        60, false, false, 'standard',
        'Weekday', 'Weekday', 'Weekday', 'Weekday',
        'Weekday', 'Weekday', 'Eve of the %s Sunday after Pentecost', 'The %s Sunday after Pentecost',
        NULL, NULL, NULL, NULL,
        'Friday Abstinence', NULL, NULL
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order, algorithm,
        weekday_precedence, has_rose_sunday, continue_counting, schedule_pattern,
        name_pattern_mon, name_pattern_tue, name_pattern_wed, name_pattern_thu,
        name_pattern_fri, name_pattern_sat, name_pattern_sat_vigil, name_pattern_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu,
        default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Ordinary Time After Pentecost (Summer)', 'pentecost-summer', 'green', 8, 'continue',
        60, false, true, 'standard-summer',
        'Weekday', 'Weekday', 'Weekday', 'Weekday',
        'Weekday', 'Weekday', 'Eve of the %s Sunday after Pentecost', 'The %s Sunday after Pentecost',
        NULL, NULL, NULL, NULL,
        'Friday Abstinence', NULL, NULL
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order, algorithm, weekday_precedence,
        has_rose_sunday, has_last_sunday, continue_counting, schedule_pattern,
        name_pattern_mon, name_pattern_tue, name_pattern_wed, name_pattern_thu,
        name_pattern_fri, name_pattern_sat, name_pattern_sat_vigil, name_pattern_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu,
        default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Ordinary Time After Pentecost (Fall)', 'pentecost-fall', 'green', 9, 'continue', 60,
        false, true, true, 'standard',
        'Weekday', 'Weekday', 'Weekday', 'Weekday',
        'Weekday', 'Weekday', 'Eve of the %s Sunday after Pentecost', 'The %s Sunday after Pentecost',
        NULL, NULL, NULL, NULL,
        'Friday Abstinence', NULL, NULL
    );

-- rambler down

TRUNCATE TABLE liturigal_seasons RESTART IDENTITY;

-- todo: replace has_rose_sunday with a moveable feast each for Advent and Lent
