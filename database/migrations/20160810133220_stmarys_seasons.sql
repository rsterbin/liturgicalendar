
-- rambler up

--
-- Define the liturigal seasons of the year
--

INSERT INTO liturigal_seasons (name, code, color, sort_order,
        calculate_from, algorithm, distance, weekday_precedence, continue_counting, schedule_pattern,
        name_pattern_mon, name_pattern_tue, name_pattern_wed, name_pattern_thu,
        name_pattern_fri, name_pattern_sat, name_pattern_sat_vigil, name_pattern_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu,
        default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Advent', 'advent', 'purple', 0,
        'christmas', 'days_before', 1, 60, false, 'standard',
        'Weekday of Advent', 'Weekday of Advent', 'Weekday of Advent', 'Weekday of Advent',
        'Weekday of Advent', 'Weekday of Advent', 'Eve of the %s Sunday of Advent', 'The %s Sunday of Advent',
        NULL, NULL, NULL, NULL,
        'Friday Abstinence', NULL, NULL
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order,
        calculate_from, algorithm, distance, weekday_precedence, continue_counting, schedule_pattern,
        name_pattern_mon, name_pattern_tue, name_pattern_wed, name_pattern_thu,
        name_pattern_fri, name_pattern_sat, name_pattern_sat_vigil, name_pattern_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu,
        default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Christmas', 'christmas', 'white', 1,
        'christmas', 'days_after', 12, 45, false, 'standard-no-confessions',
        'Weekday of Christmas', 'Weekday of Christmas', 'Weekday of Christmas', 'Weekday of Christmas',
        'Weekday of Christmas', 'Weekday of Christmas', 'Eve of the %s Sunday after Christmas Day', 'The %s Sunday after Christmas Day',
        NULL, NULL, NULL, NULL,
        'Friday Abstinence is not observed during the Christmas Season.', 'Confessions are not heard, except by appointment, on the Saturdays of the Christmas Season.', NULL
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order,
        calculate_from, algorithm, distance, weekday_precedence, has_last_sunday, continue_counting, schedule_pattern,
        name_pattern_mon, name_pattern_tue, name_pattern_wed, name_pattern_thu,
        name_pattern_fri, name_pattern_sat, name_pattern_sat_vigil, name_pattern_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu,
        default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Ordinary Time After Epiphany', 'after-epiphany', 'green', 2,
        'easter', 'tuesdays_before', 7, 60, true, false, 'standard',
        'Weekday', 'Weekday', 'Weekday', 'Weekday',
        'Weekday', 'Weekday', 'Eve of the %s Sunday after the Epiphany', 'The %s Sunday after the Epiphany',
        NULL, NULL, NULL, NULL,
        'Friday Abstinence', NULL, NULL
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order,
        calculate_from, algorithm, distance, weekday_precedence, continue_counting, schedule_pattern,
        name_pattern_mon, name_pattern_tue, name_pattern_wed, name_pattern_thu,
        name_pattern_fri, name_pattern_sat, name_pattern_sat_vigil, name_pattern_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu,
        default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Lent', 'lent', 'purple', 3,
        'easter', 'days_before', 7, 45, false, 'standard-stations',
        'Weekday of Lent', 'Weekday of Lent', 'Weekday of Lent', 'Weekday of Lent',
        'Weekday of Lent', 'Weekday of Lent', 'Eve of the %s Sunday in Lent', 'The %s Sunday in Lent',
        'Abstinence', 'Abstinence', 'Abstinence', 'Abstinence',
        'Lenten Friday Abstinence', 'Abstinence', 'Abstinence is not observed on Sundays in Lent.'
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order,
        calculate_from, algorithm, distance, weekday_precedence, continue_counting, schedule_pattern,
        name_pattern_mon, name_pattern_tue, name_pattern_wed, name_pattern_thu,
        name_pattern_fri, name_pattern_sat, name_pattern_sat_vigil, name_pattern_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu,
        default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Holy Week', 'holy-week', 'red', 4,
        'easter', 'days_before', 1, 15, false, 'standard',
        'Monday of Holy Week', 'Tuesday of Holy Week', 'Wednesday of Holy Week', 'Thursday of Holy Week',
        'Good Friday', 'Holy Saturday', 'Eve of the Sunday of the Passion: Palm Sunday', 'The Sunday of the Passion: Palm Sunday',
        'Abstinence', 'Abstinence', 'Abstinence', 'Abstinence',
        'Fast & Abstinence', 'Abstinence', 'Abstinence is not observed on Palm Sunday.'
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order,
        calculate_from, algorithm, distance, weekday_precedence, continue_counting, schedule_pattern,
        name_pattern_mon, name_pattern_tue, name_pattern_wed, name_pattern_thu,
        name_pattern_fri, name_pattern_sat, name_pattern_sat_vigil, name_pattern_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu,
        default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Easter Week', 'easter-week', 'gold', 5,
        'easter', 'days_after', 7, 15, false, 'standard-no-confessions',
        'Monday in Easter Week', 'Tuesday in Easter Week', 'Wednesday in Easter Week', 'Thursday in Easter Week',
        'Friday in Easter Week', 'Saturday in Easter Week', 'Eve of the %s Sunday of Easter', 'The %s Sunday of Easter',
        NULL, NULL, NULL, NULL,
        'Friday abstinence is not observed in Eastertide.', 'Confessions are heard only by appointment during Easter Week.', NULL
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order,
        calculate_from, algorithm, distance, weekday_precedence, continue_counting, schedule_pattern,
        name_pattern_mon, name_pattern_tue, name_pattern_wed, name_pattern_thu,
        name_pattern_fri, name_pattern_sat, name_pattern_sat_vigil, name_pattern_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu,
        default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Easter', 'easter', 'white', 6,
        'easter', 'days_after', 50, 60, true, 'standard',
        'Weekday of Easter', 'Weekday of Easter', 'Weekday of Easter', 'Weekday of Easter',
        'Weekday of Easter', 'Weekday of Easter', 'Eve of the %s Sunday of Easter', 'The %s Sunday of Easter',
        NULL, NULL, NULL, NULL,
        'Friday abstinence is not observed in Eastertide.', NULL, NULL
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order,
        calculate_from, algorithm, distance, weekday_precedence, continue_counting, schedule_pattern,
        name_pattern_mon, name_pattern_tue, name_pattern_wed, name_pattern_thu,
        name_pattern_fri, name_pattern_sat, name_pattern_sat_vigil, name_pattern_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu,
        default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Ordinary Time After Pentecost (Spring)', 'pentecost-spring', 'green', 7,
        'easter', 'days_after', 61, 60, false, 'standard',
        'Weekday', 'Weekday', 'Weekday', 'Weekday',
        'Weekday', 'Weekday', 'Eve of the %s Sunday after Pentecost', 'The %s Sunday after Pentecost',
        NULL, NULL, NULL, NULL,
        'Friday Abstinence', NULL, NULL
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order,
        calculate_from, algorithm, distance, weekday_precedence, continue_counting, schedule_pattern,
        name_pattern_mon, name_pattern_tue, name_pattern_wed, name_pattern_thu,
        name_pattern_fri, name_pattern_sat, name_pattern_sat_vigil, name_pattern_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu,
        default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Ordinary Time After Pentecost (Summer)', 'pentecost-summer', 'green', 8,
        'christmas', 'weeks_before', 12, 60, true, 'standard-summer',
        'Weekday', 'Weekday', 'Weekday', 'Weekday',
        'Weekday', 'Weekday', 'Eve of the %s Sunday after Pentecost', 'The %s Sunday after Pentecost',
        NULL, NULL, NULL, NULL,
        'Friday Abstinence', NULL, NULL
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order,
        calculate_from, algorithm, distance, weekday_precedence, has_last_sunday, continue_counting, schedule_pattern,
        name_pattern_mon, name_pattern_tue, name_pattern_wed, name_pattern_thu,
        name_pattern_fri, name_pattern_sat, name_pattern_sat_vigil, name_pattern_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu,
        default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Ordinary Time After Pentecost (Fall)', 'pentecost-fall', 'green', 9,
        'christmas', 'weeks_before', 4, 60, true, true, 'standard',
        'Weekday', 'Weekday', 'Weekday', 'Weekday',
        'Weekday', 'Weekday', 'Eve of the %s Sunday after Pentecost', 'The %s Sunday after Pentecost',
        NULL, NULL, NULL, NULL,
        'Friday Abstinence', NULL, NULL
    );

-- rambler down

TRUNCATE TABLE liturigal_seasons RESTART IDENTITY;

