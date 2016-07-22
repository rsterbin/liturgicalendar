
-- rambler up

--
-- Define types of service schedules
--

CREATE TABLE schedules (
    schedule_id serial,
    name text NOT NULL,
    code text,
    valid_start timestamp with time zone NULL,
    valid_end timestamp with time zone NULL,
    is_default boolean NOT NULL DEFAULT false,
    CONSTRAINT schedules_pk PRIMARY KEY schedule_id
);

CREATE INDEX schedules_code_idx ON schedules (code);
CREATE INDEX schedules_valid_idx ON schedules (valid_start, valid_end, is_default);

INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Weekday Basic', 'weekday', true); -- 1
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Thursday Basic', 'thursday', true); -- 2
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Saturday Basic', 'saturday', true); -- 3
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Saturday Vigil Basic', 'vigil', true); -- 4
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Sunday Basic', 'sunday', true); -- 5
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Summer Sunday Basic', 'summer-sunday', true); -- 6
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('E&B Only', 'eb-only', true); -- 7
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Evensong Only', 'es-only', true); -- 8
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Evening Prayer Only', 'ep-only', true); -- 9
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Weekday Feast', 'weekday-feast', true); -- 10
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Solemn Weekday Feast', 'solemn-weekday-feast', true); -- 11
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Candlemas', 'candlemas', false); -- 12
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Saint Blase', 'blase', false); -- 13
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Eve of Candalmas on Friday', 'candelmas-eve', false); -- 14
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('"Eve of" Solemn Mass on Friday', 'solemn-friday-eve', false); -- 15
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('"Eve of" Mass on Friday', 'friday-eve', false); -- 16
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Weekday Basic With Vigil', 'weekday-vigil', true); -- 17
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Thursday Basic With Vigil', 'thursday-vigil', true); -- 18
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Lenten Friday', 'lent-friday', true); -- 19
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Saturday Without Confessions', 'saturday-no-confessions', true); -- 20
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Requiem Weekday', 'requiem-weekday', false); -- 21

CREATE TABLE services (
    service_id serial,
    name text NOT NULL,
    start_time time with time zone NOT NULL,
    is_default boolean NOT NULL DEFAULT false,
    CONSTRAINT services_pk PRIMARY KEY service_id
);

CREATE INDEX services_start_time_idx ON services (start_time);

INSERT INTO services (name, start_time, is_default) VALUES ('Morning Prayer', '08:30:00', true); -- 1
INSERT INTO services (name, start_time, is_default) VALUES ('Noonday Prayer', '12:00:00', true); -- 2
INSERT INTO services (name, start_time, is_default) VALUES ('Mass', '12:10:00', true); -- 3
INSERT INTO services (name, start_time, is_default) VALUES ('Mass with Healing Service', '12:10:00', true); -- 4
INSERT INTO services (name, start_time, is_default) VALUES ('Evening Prayer', '18:00:00', true); -- 5
INSERT INTO services (name, start_time, is_default) VALUES ('Confessions', '11:30:00', true); -- 6
INSERT INTO services (name, start_time, is_default) VALUES ('Confessions', '16:00:00', true); -- 7
INSERT INTO services (name, start_time, is_default) VALUES ('Evening Prayer', '17:00:00', true); -- 8
INSERT INTO services (name, start_time, is_default) VALUES ('Saturday Vigil Mass', '17:20:00', true); -- 9
INSERT INTO services (name, start_time, is_default) VALUES ('Sung Matins', '08:30:00', true); -- 10
INSERT INTO services (name, start_time, is_default) VALUES ('Mass', '09:00:00', true); -- 11
INSERT INTO services (name, start_time, is_default) VALUES ('Mass', '10:00:00', true); -- 12
INSERT INTO services (name, start_time, is_default) VALUES ('Solemn Mass', '11:00:00', true); -- 13
INSERT INTO services (name, start_time, is_default) VALUES ('Organ Recital', '16:40:00', true); -- 14
INSERT INTO services (name, start_time, is_default) VALUES ('Solemn Evensong & Benediction', '17:00:00', true); -- 15
INSERT INTO services (name, start_time, is_default) VALUES ('Solemn Evensong & Benediction', '18:00:00', false); -- 16
INSERT INTO services (name, start_time, is_default) VALUES ('Solemn Evensong', '18:00:00', false); -- 17
INSERT INTO services (name, start_time, is_default) VALUES ('Sung Mass', '12:10:00', true); -- 18
INSERT INTO services (name, start_time, is_default) VALUES ('Organ Recital', '17:30:00', true); -- 19
INSERT INTO services (name, start_time, is_default) VALUES ('Mass', '18:20:00', true); -- 20
INSERT INTO services (name, start_time, is_default) VALUES ('Solemn Mass', '18:00:00', true); -- 21
INSERT INTO services (name, start_time, is_default) VALUES ('Blessing of Candles & Sung Mass', '12:10:00', false); -- 22
INSERT INTO services (name, start_time, is_default) VALUES ('Blessing of Candles, Procession & Solemn Mass', '18:00:00', false); -- 23
INSERT INTO services (name, start_time, is_default) VALUES ('Sung Mass with Blessing of Throats', '12:10:00', false); -- 24
INSERT INTO services (name, start_time, is_default) VALUES ('Evening Prayer with Blessing of Throats', '18:00:00', false); -- 25
INSERT INTO services (name, start_time, is_default) VALUES ('Stations of the Cross', '18:30:00', true); -- 26
INSERT INTO services (name, start_time, is_default) VALUES ('Sung Requiem Mass', '12:10:00', true); -- 27
INSERT INTO services (name, start_time, is_default) VALUES ('Requiem Mass', '18:20:00', true); -- 28

CREATE TABLE schedule_services (
    schedule_id integer NOT NULL,
    service_id integer NOT NULL,
    CONSTRAINT schedule_services_pk PRIMARY KEY (schedule_id, service_id),
    CONSTRAINT schedule_services_schedule_fk FOREIGN KEY (schedule_id)
        REFERENCES schedules (schedule_id)
        ON DELETE CASCADE ON UPDATE NO ACTION,
    CONSTRAINT schedule_services_service_fk FOREIGN KEY (service_id)
        REFERENCES services (service_id)
        ON DELETE CASCADE ON UPDATE NO ACTION
);

INSERT INTO schedule_services (schedule_id, service_id) VALUES (1, 1); -- weekday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (1, 2); -- weekday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (1, 3); -- weekday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (1, 5); -- weekday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (2, 1); -- thursday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (2, 2); -- thursday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (2, 4); -- thursday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (2, 5); -- thursday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (3, 6); -- saturday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (3, 2); -- saturday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (3, 3); -- saturday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (3, 7); -- saturday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (4, 8); -- vigil
INSERT INTO schedule_services (schedule_id, service_id) VALUES (4, 9); -- vigil
INSERT INTO schedule_services (schedule_id, service_id) VALUES (5, 10); -- sunday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (5, 11); -- sunday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (5, 12); -- sunday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (5, 13); -- sunday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (5, 14); -- sunday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (5, 15); -- sunday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (6, 1); -- summer-sunday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (6, 11); -- summer-sunday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (6, 12); -- summer-sunday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (6, 13); -- summer-sunday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (6, 8); -- summer-sunday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (7, 16); -- eb-only
INSERT INTO schedule_services (schedule_id, service_id) VALUES (8, 17); -- es-only
INSERT INTO schedule_services (schedule_id, service_id) VALUES (9, 5); -- ep-only
INSERT INTO schedule_services (schedule_id, service_id) VALUES (10, 1); -- weekday-feast
INSERT INTO schedule_services (schedule_id, service_id) VALUES (10, 2); -- weekday-feast
INSERT INTO schedule_services (schedule_id, service_id) VALUES (10, 18); -- weekday-feast
INSERT INTO schedule_services (schedule_id, service_id) VALUES (10, 5); -- weekday-feast
INSERT INTO schedule_services (schedule_id, service_id) VALUES (10, 20); -- weekday-feast
INSERT INTO schedule_services (schedule_id, service_id) VALUES (11, 10); -- solemn-weekday-feast
INSERT INTO schedule_services (schedule_id, service_id) VALUES (11, 2); -- solemn-weekday-feast
INSERT INTO schedule_services (schedule_id, service_id) VALUES (11, 18); -- solemn-weekday-feast
INSERT INTO schedule_services (schedule_id, service_id) VALUES (11, 19); -- solemn-weekday-feast
INSERT INTO schedule_services (schedule_id, service_id) VALUES (11, 21); -- solemn-weekday-feast
INSERT INTO schedule_services (schedule_id, service_id) VALUES (12, 10); -- candlemas
INSERT INTO schedule_services (schedule_id, service_id) VALUES (12, 2); -- candlemas
INSERT INTO schedule_services (schedule_id, service_id) VALUES (12, 22); -- candlemas
INSERT INTO schedule_services (schedule_id, service_id) VALUES (12, 19); -- candlemas
INSERT INTO schedule_services (schedule_id, service_id) VALUES (12, 23); -- candlemas
INSERT INTO schedule_services (schedule_id, service_id) VALUES (13, 1); -- blase
INSERT INTO schedule_services (schedule_id, service_id) VALUES (13, 2); -- blase
INSERT INTO schedule_services (schedule_id, service_id) VALUES (13, 24); -- blase
INSERT INTO schedule_services (schedule_id, service_id) VALUES (13, 25); -- blase
INSERT INTO schedule_services (schedule_id, service_id) VALUES (14, 19); -- candlemas-eve
INSERT INTO schedule_services (schedule_id, service_id) VALUES (14, 23); -- candlemas-eve
INSERT INTO schedule_services (schedule_id, service_id) VALUES (15, 19); -- solemn-friday-eve
INSERT INTO schedule_services (schedule_id, service_id) VALUES (15, 21); -- solemn-friday-eve
INSERT INTO schedule_services (schedule_id, service_id) VALUES (16, 5); -- friday-eve
INSERT INTO schedule_services (schedule_id, service_id) VALUES (16, 20); -- friday-eve
INSERT INTO schedule_services (schedule_id, service_id) VALUES (17, 1); -- weekday-vigil
INSERT INTO schedule_services (schedule_id, service_id) VALUES (17, 2); -- weekday-vigil
INSERT INTO schedule_services (schedule_id, service_id) VALUES (17, 3); -- weekday-vigil
INSERT INTO schedule_services (schedule_id, service_id) VALUES (18, 1); -- thursday-vigil
INSERT INTO schedule_services (schedule_id, service_id) VALUES (18, 2); -- thursday-vigil
INSERT INTO schedule_services (schedule_id, service_id) VALUES (18, 4); -- thursday-vigil
INSERT INTO schedule_services (schedule_id, service_id) VALUES (19, 1); -- lent-friday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (19, 2); -- lent-friday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (19, 3); -- lent-friday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (19, 5); -- lent-friday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (19, 26); -- lent-friday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (20, 2); -- saturday-no-confessions
INSERT INTO schedule_services (schedule_id, service_id) VALUES (20, 3); -- saturday-no-confessions
INSERT INTO schedule_services (schedule_id, service_id) VALUES (21, 1); -- requiem-weekday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (21, 2); -- requiem-weekday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (21, 27); -- requiem-weekday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (21, 5); -- requiem-weekday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (21, 28); -- requiem-weekday

--
-- Define service patterns for seasons, fixed feasts, and moveable feasts that vary by day of the week
--
CREATE TABLE service_patterns (
    pattern_id serial,
    name text NOT NULL,
    code text NOT NULL,
    schedule_code_mon text,
    schedule_code_mon_with_vigil text,
    schedule_code_mon_vigil text,
    schedule_code_tue text,
    schedule_code_tue_with_vigil text,
    schedule_code_tue_vigil text,
    schedule_code_wed text,
    schedule_code_wed_with_vigil text,
    schedule_code_wed_vigil text,
    schedule_code_thu text,
    schedule_code_thu_with_vigil text,
    schedule_code_thu_vigil text,
    schedule_code_fri text,
    schedule_code_fri_with_vigil text,
    schedule_code_fri_vigil text,
    schedule_code_sat text,
    schedule_code_sat_with_vigil text,
    schedule_code_sat_vigil text,
    schedule_code_sun text,
    schedule_code_sun_with_vigil text,
    schedule_code_sun_vigil text,
    valid_start timestamp with time zone,
    valid_end timestamp with time zone,
    CONSTRAINT service_patterns_pk PRIMARY KEY (pattern_id)
);


INSERT INTO service_patterns (name, code,
        schedule_code_mon, schedule_code_mon_with_vigil, schedule_code_mon_vigil,
        schedule_code_tue, schedule_code_tue_with_vigil, schedule_code_tue_vigil,
        schedule_code_wed, schedule_code_wed_with_vigil, schedule_code_wed_vigil,
        schedule_code_thu, schedule_code_thu_with_vigil, schedule_code_thu_vigil,
        schedule_code_fri, schedule_code_fri_with_vigil, schedule_code_fri_vigil,
        schedule_code_sat, schedule_code_sat_with_vigil, schedule_code_sat_vigil,
        schedule_code_sun, schedule_code_sun_with_vigil, schedule_code_sun_vigil
    ) VALUES ('Standard', 'standard'
        'weekday', 'weekday-vigil', null,
        'weekday', 'weekday-vigil', null,
        'weekday', 'weekday-vigil', null,
        'thursday', 'thursday-vigil', null,
        'weekday', 'weekday-vigil', null,
        'saturday', 'saturday', 'vigil',
        'sunday', null, null
    );

INSERT INTO service_patterns (name, code,
        schedule_code_mon, schedule_code_mon_with_vigil, schedule_code_mon_vigil,
        schedule_code_tue, schedule_code_tue_with_vigil, schedule_code_tue_vigil,
        schedule_code_wed, schedule_code_wed_with_vigil, schedule_code_wed_vigil,
        schedule_code_thu, schedule_code_thu_with_vigil, schedule_code_thu_vigil,
        schedule_code_fri, schedule_code_fri_with_vigil, schedule_code_fri_vigil,
        schedule_code_sat, schedule_code_sat_with_vigil, schedule_code_sat_vigil,
        schedule_code_sun, schedule_code_sun_with_vigil, schedule_code_sun_vigil
    ) VALUES ('Standard Without Confessions', 'standard-no-confessions'
        'weekday', 'weekday-vigil', null,
        'weekday', 'weekday-vigil', null,
        'weekday', 'weekday-vigil', null,
        'thursday', 'thursday-vigil', null,
        'weekday', 'weekday-vigil', null,
        'saturday-no-confessions', 'saturday-no-confessions', 'vigil',
        'sunday', null, null
    );

INSERT INTO service_patterns (name, code,
        schedule_code_mon, schedule_code_mon_with_vigil, schedule_code_mon_vigil,
        schedule_code_tue, schedule_code_tue_with_vigil, schedule_code_tue_vigil,
        schedule_code_wed, schedule_code_wed_with_vigil, schedule_code_wed_vigil,
        schedule_code_thu, schedule_code_thu_with_vigil, schedule_code_thu_vigil,
        schedule_code_fri, schedule_code_fri_with_vigil, schedule_code_fri_vigil,
        schedule_code_sat, schedule_code_sat_with_vigil, schedule_code_sat_vigil,
        schedule_code_sun, schedule_code_sun_with_vigil, schedule_code_sun_vigil
    ) VALUES ('Standard With Stations', 'standard-stations'
        'weekday', 'weekday-vigil', null,
        'weekday', 'weekday-vigil', null,
        'weekday', 'weekday-vigil', null,
        'thursday', 'thursday-vigil', null,
        'lent-friday', 'weekday-vigil', null,
        'saturday', 'saturday', 'vigil',
        'sunday', null, null
    );

--
-- Define precedence
--

CREATE TABLE observance_types (
    otype_id serial,
    name text NOT NULL,
    precedence integer NOT NULL,
    CONSTRAINT observance_types_pk PRIMARY KEY (otype_id)
);
INSERT INTO observance_types (name, precedence) VALUES ('Principal Feast or Holy Day', 10); -- 1
INSERT INTO observance_types (name, precedence) VALUES ('Major Feast (can be celebrated on Sunday)', 20); -- 2
INSERT INTO observance_types (name, precedence) VALUES ('Feast (transfers from Sunday)', 40); -- 3
INSERT INTO observance_types (name, precedence) VALUES ('Commemoration', 50); -- 4
INSERT INTO observance_types (name, precedence) VALUES ('Major Feast (celebrated on the nearest Sunday)', 30); -- 5

--
-- Define liturigal_seasons
--

CREATE TABLE liturigal_seasons (
    season_id serial,
    name text NOT NULL,
    code text NOT NULL,
    color text NOT NULL,
    sort_order integer NOT NULL,
    weekday_precedence integer NOT NULL,
    has_rose_sunday boolean NOT NULL,
    continue_counting boolean NOT NULL,
    schedule_pattern text NOT NULL,
    name_pattern_mon text NOT NULL,
    name_pattern_tue text NOT NULL,
    name_pattern_wed text NOT NULL,
    name_pattern_thu text NOT NULL,
    name_pattern_fri text NOT NULL,
    name_pattern_sat text NOT NULL,
    name_pattern_sat_vigil text NOT NULL,
    name_pattern_sun text NOT NULL,
    default_note_mon text,
    default_note_tue text,
    default_note_wed text,
    default_note_thu text,
    default_note_fri text,
    default_note_sat text,
    default_note_sun text,
    CONSTRAINT liturigal_seasons_pk PRIMARY KEY (season_id)
);

INSERT INTO liturigal_seasons (name, code, color, sort_order, weekday_precedence, has_rose_sunday, continue_counting, schedule_pattern,
        name_pattern_mon, name_pattern_tue, name_pattern_wed, name_pattern_thu,
        name_pattern_fri, name_pattern_sat, name_pattern_sat_vigil, name_pattern_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu,
        default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Advent', 'advent', 'purple', 0, 60, true, false, 'standard',
        'Weekday of Advent', 'Weekday of Advent', 'Weekday of Advent', 'Weekday of Advent',
        'Weekday of Advent', 'Weekday of Advent', 'Eve of the %s Sunday of Advent', 'The %s Sunday of Advent',
        NULL, NULL, NULL, NULL,
        'Friday Abstinence', NULL, NULL
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order, weekday_precedence, has_rose_sunday, continue_counting, schedule_pattern,
        name_pattern_mon, name_pattern_tue, name_pattern_wed, name_pattern_thu,
        name_pattern_fri, name_pattern_sat, name_pattern_sat_vigil, name_pattern_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu,
        default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Christmas', 'christmas', 'white', 1, 45, false, false, 'standard-no-confessions',
        'Weekday of Christmas', 'Weekday of Christmas', 'Weekday of Christmas', 'Weekday of Christmas',
        'Weekday of Christmas', 'Weekday of Christmas', 'Eve of the %s Sunday after Christmas Day', 'The %s Sunday after Christmas Day',
        NULL, NULL, NULL, NULL,
        'Friday Abstinence is not observed during the Christmas Season.', 'Confessions are not heard, except by appointment, on the Saturdays of the Christmas Season.', NULL
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order, weekday_precedence, has_rose_sunday, continue_counting, schedule_pattern,
        name_pattern_mon, name_pattern_tue, name_pattern_wed, name_pattern_thu,
        name_pattern_fri, name_pattern_sat, name_pattern_sat_vigil, name_pattern_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu,
        default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Ordinary Time After Epiphany', 'after-epiphany', 'green', 2, 60, false, false, 'standard',
        'Weekday', 'Weekday', 'Weekday', 'Weekday',
        'Weekday', 'Weekday', 'Eve of the %s Sunday after the Epiphany', 'The %s Sunday after the Epiphany',
        NULL, NULL, NULL, NULL,
        'Friday Abstinence', NULL, NULL
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order, weekday_precedence, has_rose_sunday, continue_counting, schedule_pattern,
        name_pattern_mon, name_pattern_tue, name_pattern_wed, name_pattern_thu,
        name_pattern_fri, name_pattern_sat, name_pattern_sat_vigil, name_pattern_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu,
        default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Lent', 'lent', 'purple', 3, 45, true, false, 'standard-stations',
        'Weekday of Lent', 'Weekday of Lent', 'Weekday of Lent', 'Weekday of Lent',
        'Weekday of Lent', 'Weekday of Lent', 'Eve of the %s Sunday in Lent', 'The %s Sunday in Lent',
        'Abstinence', 'Abstinence', 'Abstinence', 'Abstinence',
        'Lenten Friday Abstinence', 'Abstinence', 'Abstinence is not observed on Sundays in Lent.'
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order, weekday_precedence, has_rose_sunday, continue_counting, schedule_pattern,
        name_pattern_mon, name_pattern_tue, name_pattern_wed, name_pattern_thu,
        name_pattern_fri, name_pattern_sat, name_pattern_sat_vigil, name_pattern_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu,
        default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Holy Week', 'holy-week', 'red', 4, 15, false, false, 'standard',
        'Monday of Holy Week', 'Tuesday of Holy Week', 'Wednesday of Holy Week', 'Thursday of Holy Week',
        'Good Friday', 'Holy Saturday', 'Eve of the Sunday of the Passion: Palm Sunday', 'The Sunday of the Passion: Palm Sunday',
        'Abstinence', 'Abstinence', 'Abstinence', 'Abstinence',
        'Fast & Abstinence', 'Abstinence', 'Abstinence is not observed on Palm Sunday.'
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order, weekday_precedence, has_rose_sunday, continue_counting, schedule_pattern,
        name_pattern_mon, name_pattern_tue, name_pattern_wed, name_pattern_thu,
        name_pattern_fri, name_pattern_sat, name_pattern_sat_vigil, name_pattern_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu,
        default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Easter Week', 'easter-week', 'gold', 5, 15, false, false, 'standard-no-confessions',
        'Monday in Easter Week', 'Tuesday in Easter Week', 'Wednesday in Easter Week', 'Thursday in Easter Week',
        'Friday in Easter Week', 'Saturday in Easter Week', 'Eve of the %s Sunday of Easter', 'The %s Sunday of Easter',
        NULL, NULL, NULL, NULL,
        'Friday abstinence is not observed in Eastertide.', 'Confessions are heard only by appointment during Easter Week.', NULL
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order, weekday_precedence, has_rose_sunday, continue_counting, schedule_pattern,
        name_pattern_mon, name_pattern_tue, name_pattern_wed, name_pattern_thu,
        name_pattern_fri, name_pattern_sat, name_pattern_sat_vigil, name_pattern_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu,
        default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Easter', 'easter', 'white', 6, 60, false, true, 'standard',
        'Weekday of Easter', 'Weekday of Easter', 'Weekday of Easter', 'Weekday of Easter',
        'Weekday of Easter', 'Weekday of Easter', 'Eve of the %s Sunday of Easter', 'The %s Sunday of Easter',
        NULL, NULL, NULL, NULL,
        'Friday abstinence is not observed in Eastertide.', NULL, NULL
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order, weekday_precedence, has_rose_sunday, continue_counting, schedule_pattern,
        name_pattern_mon, name_pattern_tue, name_pattern_wed, name_pattern_thu,
        name_pattern_fri, name_pattern_sat, name_pattern_sat_vigil, name_pattern_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu,
        default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Ordinary Time After Pentecost (Spring)', 'pentecost-spring', 'green', 7, 60, false, false, 'standard',
        'Weekday', 'Weekday', 'Weekday', 'Weekday',
        'Weekday', 'Weekday', 'Eve of the %s Sunday after Pentecost', 'The %s Sunday after Pentecost',
        NULL, NULL, NULL, NULL,
        'Friday Abstinence', NULL, NULL
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order, weekday_precedence, has_rose_sunday, continue_counting, schedule_pattern,
        name_pattern_mon, name_pattern_tue, name_pattern_wed, name_pattern_thu,
        name_pattern_fri, name_pattern_sat, name_pattern_sat_vigil, name_pattern_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu,
        default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Ordinary Time After Pentecost (Summer)', 'pentecost-summer', 'green', 8, 60, false, true, 'standard-summer',
        'Weekday', 'Weekday', 'Weekday', 'Weekday',
        'Weekday', 'Weekday', 'Eve of the %s Sunday after Pentecost', 'The %s Sunday after Pentecost',
        NULL, NULL, NULL, NULL,
        'Friday Abstinence', NULL, NULL
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order, weekday_precedence, has_rose_sunday, continue_counting, schedule_pattern,
        name_pattern_mon, name_pattern_tue, name_pattern_wed, name_pattern_thu,
        name_pattern_fri, name_pattern_sat, name_pattern_sat_vigil, name_pattern_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu,
        default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Ordinary Time After Pentecost (Fall)', 'pentecost-fall', 'green', 9, 60, false, true, 'standard',
        'Weekday', 'Weekday', 'Weekday', 'Weekday',
        'Weekday', 'Weekday', 'Eve of the %s Sunday after Pentecost', 'The %s Sunday after Pentecost',
        NULL, NULL, NULL, NULL,
        'Friday Abstinence', NULL, NULL
    );

--
-- Define observances
--

CREATE TABLE fixed_feasts (
    fixed_id serial,
    name text NOT NULL,
    otype_id integer NOT NULL,
    month integer NOT NULL,
    day integer NOT NULL,
    schedule_code text,
    has_vigil boolean NOT NULL DEFAULT FALSE,
    vigil_schedule_code text,
    fri_vigil_schedule_code text,
    color text,
    note text,
    valid_start timestamp with time zone NULL,
    valid_end timestamp with time zone NULL,
    CONSTRAINT fixed_feasts_pk PRIMARY KEY (fixed_id),
    CONSTRAINT fixed_feasts_otype_fk PRIMARY KEY (otype_id)
        REFERENCES observance_types (otype_id)
        ON DELETE RESTRICT ON UPDATE NO ACTION
);

CREATE INDEX fixed_feasts_month_idx ON fixed_feasts (month);
CREATE INDEX fixed_feasts_date_idx ON fixed_feasts (month, day);

-- January
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('The Holy Name of Our Lord Jesus Christ', 3, 1, 1, 'gold');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color) VALUES ('The Epiphany of Our Lord Jesus Christ', 1, 1, 6, 'solemn-weekday-feast', true, 'es-only', 'solemn-friday-eve', 'gold');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, color) VALUES ('William Laud, Archbishop of Canterbury, 1645', 4, 1, 10, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Aelred, Abbot of Rievaulx, 1167', 4, 1, 12, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Hilary, Bishop of Poitiers, 367', 4, 1, 13, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Antony, Abbot in Egypt, 356', 4, 1, 17, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color) VALUES ('The Confession of Saint Peter the Apostle', 3, 1, 18, 'weekday-feast', true, 'ep-only', 'friday-eve', 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Wulfstan, Bishop of Worcester, 1095', 4, 1, 19, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Fabian, Bishop and Martyr of Rome, 250', 4, 1, 20, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Agnes, Martyr at Rome, 304', 4, 1, 21, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Vincent, Deacon of Saragossa, and Martyr, 304', 4, 1, 22, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color) VALUES ('The Conversion of Saint Paul the Apostle', 3, 1, 25, 'weekday-feast', true, 'ep-only', 'friday-eve', 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Timothy and Titus, Companions of Saint Paul', 4, 1, 26, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Thomas Aquinas, Priest and Friar, 1274', 4, 1, 28, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Charles, King and Martyr, 1649', 4, 1, 30, 'red');

-- February
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Brigid (Bride), 523', 4, 2, 1, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color) VALUES ('The Presentation of Our Lord Jesus Christ in the Temple', 2, 2, 2, 'candlemas', true, 'es-only', 'candlemas-eve', 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, color) VALUES ('Blase, Bishop and Martyr, c. 316', 4, 2, 3, 'blase', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_end) VALUES ('Cornelius the Centurion', 4, 2, 4, 'white', '2010-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Anskar, Archbishop of Hamburg, Missionary to Denmark and Sweden, 865', 4, 2, 4, 'white', '2011-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('The Martyrs of Japan, 1597', 4, 2, 5, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Cornelius the Centurion', 4, 2, 7, 'white', '2011-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Scholastica, Religious, 542', 4, 2, 10, 'white', '2007-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Absalom Jones, Priest, 1818', 4, 2, 13, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Cyril, Monk, and Methodius, Bishop, Missionaries to the Slavs, 869, 885', 4, 2, 14, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Thomas Bray, Priest and Missionary, 1730', 4, 2, 15, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Polycarp, Bishop and Martyr of Smyrna, 156', 4, 2, 23, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color) VALUES ('Saint Matthias the Apostle', 3, 2, 24, 'weekday-feast', true, 'ep-only', 'friday-eve', 'red');

-- March

INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color) VALUES ('Saint Joseph', 3, 3, 19, 'weekday-feast', true, 'ep-only', 'friday-eve', 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color, valid_end) VALUES ('The Annunciation of Our Lord Jesus Christ', 2, 3, 25, 'solemn-weekday-feast', true, 'es-only', 'solemn-friday-eve', 'blue', '2013-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color, valid_start) VALUES ('The Annunciation of Our Lord Jesus Christ', 2, 3, 25, 'solemn-weekday-feast', true, 'es-only', 'solemn-friday-eve', 'gold', '2014-01-01 00:00:00' AT TIME ZONE 'America/New_York');

-- April

INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Frederick Denison Maurice, Priest, 1872', 4, 4, 1, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('James Lloyd Breck, Priest, 1876', 4, 4, 2, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Richard, Bishop of Chichester, 1253', 4, 4, 3, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Martin Luther King, Jr., Civil Rights Leader, 1968', 4, 4, 4, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('William Augustus Muhlenberg, Priest, 1877', 4, 4, 8, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('William Law, Priest, 1761', 4, 4, 10, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('George Augustus Selwyn, Bishop of New Zealand, and of Lichfield, 1878', 4, 4, 11, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Alphege, Archbishop of Canterbury, and Martyr, 1012', 4, 4, 19, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Anselm, Archbishop of Canterbury, 1109', 4, 4, 21, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Genocide Remembrance', 4, 4, 24, 'red', '2015-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color) VALUES ('Saint Mark the Evangelist', 3, 4, 25, 'weekday-feast', true, 'ep-only', 'friday-eve', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Catherine of Siena, 1380', 4, 4, 29, 'white');

-- May

INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color) VALUES ('Saint Philip and Saint James, Apostles', 4, 5, 1, 'weekday-feast', true, 'ep-only', 'friday-eve', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Athanasius, Bishop of Alexandria, 373', 4, 5, 2, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Monnica, Mother of Augustine of Hippo, 387', 4, 5, 4, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Dame Julian of Norwich, c. 1417', 4, 5, 8, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Gregory of Nazianzus, Bishop of Constantinople, 389', 4, 5, 9, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Dunstan, Archbishop of Canterbury, 988', 4, 5, 19, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Alcuin, Deacon, and Abbot of Tours, 804', 4, 5, 20, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Jackson Kemper, First Missionary Bishop in the United States, 1870', 4, 5, 24, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Bede, the Venerable, Priest, and Monk of Jarrow, 735', 4, 5, 25, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Augustine, First Archbishop of Canterbury, 605', 4, 5, 26, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color) VALUES ('The Visitation of the Blessed Virgin Mary', 4, 5, 31, 'weekday-feast', true, 'ep-only', 'friday-eve', 'white');

-- June

INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Justin, Martyr at Rome, c. 167', 4, 6, 1, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('The Martyrs of Lyons, 177', 4, 6, 2, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('The Martyrs of Uganda, 1886', 4, 6, 3, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Boniface, Archbishop of Mainz, Missionary to Germany, and Martyr, 754', 4, 6, 5, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Columba, Abbot of Iona, 597', 4, 6, 9, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Ephrem of Edessa, Syria, Deacon, 373', 4, 6, 10, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color) VALUES ('Saint Barnabas the Apostle', 4, 6, 11, 'weekday-feast', true, 'ep-only', 'friday-eve', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Basil the Great, Bishop of Caesarea, 379', 4, 6, 14, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Joseph Butler, Bishop of Durham, 1752', 4, 6, 16, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_end) VALUES ('Bernard Mizeki, Catechist and Martyr in Rhodesia, 1896', 4, 6, 18, 'red', '2011-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Bernard Mizeki, Catechist and Martyr in Mashonaland, 1896', 4, 6, 18, 'red', '2012-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Alban, First Martyr of Britain, c. 304', 4, 6, 22, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color) VALUES ('The Nativity of Saint John the Baptist', 4, 6, 24, 'weekday-feast', true, 'ep-only', 'friday-eve', 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Cyril, Patriarch of Alexandria, 444', 4, 6, 27, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Irenaeus, Bishop of Lyons and Martyr, c. 202', 4, 6, 28, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color) VALUES ('Saint Peter and Saint Paul, Apostles', 4, 6, 29, 'weekday-feast', true, 'ep-only', 'friday-eve', 'red');

-- July

INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Independence Day', 4, 7, 4, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Jan Hus, Prophetic Witness and Martyr, 1415', 4, 7, 6, 'red', '2012-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Benedict of Nursia, Abbot of Monte Casino, c. 540', 4, 7, 11, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Bonaventure, Bishop and Friar, 1274', 4, 7, 15, 'white', '2005-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('William White, Bishop of Pennsylvania, 1836', 4, 7, 17, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Macrina, Monastic and Teacher, 379', 4, 7, 19, 'white', '2012-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color) VALUES ('Saint Mary Magdalene', 3, 7, 22, 'weekday-feast', true, 'ep-only', 'friday-eve', 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Thomas a Kempis, Priest, 1471', 4, 7, 24, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color) VALUES ('Saint James the Apostle', 4, 7, 25, 'weekday-feast', true, 'ep-only', 'friday-eve', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Parents of the Blessed Virgin Mary', 4, 7, 26, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('William Reed Huntington, Priest, 1909', 4, 7, 27, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Mary and Martha of Bethany', 4, 7, 29, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('William Wilberforce, 1833', 4, 7, 30, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_end) VALUES ('Ignatius of Loyola, Priest and Monastic, 1556', 4, 7, 31, 'white', '2011-12-31 23:59:59' AT TIME ZONE 'America/New_York');

-- August

INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Joseph of Arimathaea', 4, 8, 1, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color) VALUES ('The Transfiguration of Our Lord Jesus Christ', 3, 8, 6, 'weekday-feast', true, 'ep-only', 'friday-eve', 'gold');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('John Mason Neale, Priest, 1866', 4, 8, 7, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Dominic, Priest and Friar, 1221', 4, 8, 8, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Lawrence, Deacon, and Martyr at Rome, 258', 4, 8, 10, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Clare, Abbess at Assisi, 1253', 4, 8, 11, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Florence Nightingale, Nurse, Social Reformer, 1910', 4, 8, 12, 'white', '2012-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Jeremy Taylor, Bishop of Down, Connor, and Dromore, 1667', 4, 8, 13, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Jonathan Myrick Daniels, Seminarian and Witness for Civil Rights, 1965', 4, 8, 14, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color, valid_end) VALUES ('The Assumption of the Blessed Virgin Mary', 4, 8, 15, 'solemn-weekday-feast', true, 'es-only', 'friday-eve', 'white', '2010-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color, valid_start) VALUES ('The Assumption of the Blessed Virgin Mary', 4, 8, 15, 'solemn-weekday-feast', true, 'ep-only', 'solemn-friday-eve', 'gold', '2011-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Bernard, Abbot of Clairvaux, 1153', 4, 8, 20, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color) VALUES ('Saint Bartholomew the Apostle', 4, 8, 24, 'weekday-feast', true, 'ep-only', 'friday-eve', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Louis, King of France, 1270', 4, 8, 25, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Thomas Gallaudet, Priest, 1902, with Henry Winter Syle, Priest, 1890, Missioners to the Deaf', 4, 8, 27, 'white', '2012-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Augustine, Bishop of Hippo, 430', 4, 8, 28, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('The Beheading of Saint John the Baptist', 4, 8, 29, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Aidan, Bishop of Lindisfarne, 651', 4, 8, 31, 'white');

-- September

INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('The Martyrs of New Guinea, 1942', 4, 9, 2, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color) VALUES ('The Nativity of the Blessed Virgin Mary', 4, 9, 8, 'weekday-feast', true, 'ep-only', 'friday-eve', 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Constance, Nun, and her Companions, 1878', 4, 9, 9, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Alexander Crummel, 1898', 4, 9, 10, 'white', '2010-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Requiem for the Victims of September 11, 2011', 4, 9, 11, 'black', '2009-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, fri_vigil_schedule_code, color, valid_end) VALUES ('Parish Requiem: Victims of September 11, 2011', 4, 9, 11, 'requiem-weekday', 'purple', '2008-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('John Henry Hobart, Bishop of New York, 1830', 4, 9, 12, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('John Chrysostom, Bishop of Constantinople, 407', 4, 9, 13, 'white', '2011-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_end) VALUES ('Cyprian, Bishop and Martyr of Carthage, 258', 4, 9, 13, 'red', '2010-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color, valid_start) VALUES ('Holy Cross Day', 2, 9, 14, 'weekday-feast', true, 'ep-only', 'friday-eve', 'red', '2010-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color, valid_end) VALUES ('Holy Cross Day', 2, 9, 14, 'solemn-weekday-feast', true, 'es-only', 'solemn-friday-eve', 'red', '2009-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Cyprian, Bishop and Martyr of Carthage, 258', 4, 9, 15, 'red', '2011-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Ninian, Bishop in Galloway, c. 430', 4, 9, 16, 'white', '2005-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start, valid_end) VALUES ('Hildegard of Bingen, 1170', 4, 9, 17, 'white', '2009-01-01 00:00:00' AT TIME ZONE 'America/New_York', '2009-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Edward Bouverie Pusey, Priest, 1882', 4, 9, 18, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Theodore of Tarsus, Archbishop of Canterbury, 690', 4, 9, 19, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('John Coleridge Patteson, Bishop of Melanesia, and his Companions, Martyrs, 1871', 4, 9, 20, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color) VALUES ('Saint Matthew, Apostle and Evangelist', 3, 9, 21, 'weekday-feast', true, 'ep-only', 'friday-eve', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Sergius, Abbot of Holy Trinity, Moscow, 1392', 4, 9, 25, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Lancelot Andrewes, Bishop of Winchester, 1626', 4, 9, 26, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color) VALUES ('Saint Michael and All Angels', 2, 9, 29, 'weekday-feast', true, 'ep-only', 'friday-eve', 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Jerome, Priest, and Monk of Bethlehem, 420', 4, 9, 30, 'white');

-- October

INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Remigius, Bishop of Rheims, c. 530', 4, 10, 1, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_end) VALUES ('Dedication of the Church', 5, 10, 3, 'white', '2005-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Francis of Assisi, Friar, 1226', 4, 10, 4, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('William Tyndale, Priest, 1536', 4, 10, 6, 'red', '2010-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_end) VALUES ('William Tyndale, Priest, 1536', 4, 10, 6, 'white', '2009-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Robert Grosseteste, Bishop of Lincoln, 1253', 4, 10, 9, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Philip, Deacon and Evangelist', 4, 10, 11, 'white', '2005-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Samuel Isaac Joseph Schereschewsky, Bishop of Shanghai, 1906', 4, 10, 14, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Teresa of Avila, Nun, 1582', 4, 10, 5, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Hugh Latimer and Nicholas Ridley, Bishops, 1555', 4, 10, 16, 'red', '2012-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Ignatius, Bishop of Antioch, and Martyr, c. 115', 4, 10, 17, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color) VALUES ('Saint Luke the Evangelist', 4, 10, 18, 'weekday-feast', true, 'ep-only', 'friday-eve', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Henry Martyn, Priest and Missionary to India and Persia, 1812', 4, 10, 19, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color) VALUES ('Saint James of Jerusalem, Brother of Our Lord Jesus Christ, and Martyr, c. 62', 4, 10, 23, 'weekday-feast', true, 'ep-only', 'friday-eve', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Alfred the Great, King of the West Saxons, 899', 4, 10, 26, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color) VALUES ('Saint Simon and Saint Jude, Apostles', 4, 10, 28, 'weekday-feast', true, 'ep-only', 'friday-eve', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('James Hannington, Bishop of Eastern Equatorial Africa, and his Companions, Martyrs, 1885', 4, 10, 29, 'red');

-- TODO: November

INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color, valid_end) VALUES ('All Saints', 1, 11, 1, 'solemn-weekday-feast', true, 'es-only', 'solemn-friday-eve', 'white', '2009-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color, valid_start) VALUES ('All Saints', 1, 11, 1, 'solemn-weekday-feast', true, 'es-only', 'solemn-friday-eve', 'gold', '2010-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, color) VALUES ('All Souls Day', 3, 11, 2, 'black');

3 Richard Hooker, Priest, 1600
4 
5 
6 William Temple, Archbishop of Canterbury, 1944
7 Willibrord, Archbishop of Utrecht, Missionary to Frisia, 739
8 (alternative date for James Theodore Holly: see March 13)
9 
10 Leo the Great, Bishop of Rome, 461
11 Martin, Bishop of Tours, 397
12 Charles Simeon, Priest, 1836
13 
14 Samuel Seabury, First American Bishop, 1796
15 [Francis Asbury, 1816, and George Whitefield, 1770, Evangelists]
16 Margaret, Queen of Scotland, 1093
17 Hugh, 1200, and Robert Grosseteste, 1253, Bishops of Lincoln (new date for Robert Grosseteste)
18 Hilda, Abbess of Whitby, 680
19 Elizabeth, Princess of Hungary, 1231
20 Edmund, King of East Anglia, 870
21 [William Byrd, 1623, John Merbecke, 1585, and Thomas Tallis, 1585, Musicians]
22 C. S. Lewis, Apologist and spiritual Writer, 1963; also [Cecilia, Martyr at Rome, c. 280]
23 Clement, Bishop of Rome, c. 100
24 
25 James Otis Sargent Huntington, Priest and Monk, 1935
26 [Isaac Watts, Hymnwriter, 1748]
27 
28 Kamehameha and Emma, King and Queen of Hawaii, 1864, 1885
29 
30 Saint Andrew the Apostle


-- TODO: December


-- todo: movable notes
-- in January: 'Birthday of Martin Luther King, Jr. – Federal Holiday Schedule<br />The church opens today at 10:00 AM and closes at 2:00 PM.'
-- in February: 'Washington’s Birthday – Federal Holiday Schedule<br />The church opens today at 10:00 AM and closes at 2:00 PM.'
-- in May: 'Memorial Day – Federal Holiday Schedule<br />The church opens today at 10:00 AM and closes at 2:00 PM.'
-- in July: 'Federal Holiday Schedule<br />The church opens today at 10:00 AM and closes at 2:00 PM.' (for Independence Day or the closest weekday)
-- in September: 'Labor Day – Federal Holiday Schedule<br />The church opens today at 10:00 AM and closes at 2:00 PM.'
-- in October: 'Columbus Day – Federal Holiday Schedule<br />The church opens today at 10:00 AM and closes at 2:00 PM.'

-- todo: remember
-- There is a Last Sunday After Epiphany
-- Major Feasts in Holy Week or Easter Week transfer all the way to the following Monday (and Tuesday, if both Saint Joseph and Annunciation fall within)
-- Federal Holidays have notes and a schedule (church open 10-2)

-- todo: ask for clarification
-- How do the days marked "Of Our Lady" work? There seems to be roughly one a month, but I don't know what the pattern is.
-- Is the change from white to gold for Annunciation an intentional change or a mistake that got carried from the previous year's transfer?
-- The list of Commemorations needs confirmation, as there are some important variations from the Episcopal calendars I've found (e.g. http://satucket.com/lectionary/Calendar.htm)
-- If a major feast falls on a Saturday in Lent, what happens to Stations of the Cross?
-- How is the date of "The First Book of Common Prayer, 1549" determined?
-- Do we celebrate Sacred Heart (19 days after Pentecost) anymore?  It appears through 2008.
-- July 18 [Bartolomé de las Casas, Friar and Missionary to the Indies, 1566] - WE SHOULD DO THIS: http://theoatmeal.com/comics/columbus_day
-- Was Ignatius of Loyola dropped from the calendar intentionally?
-- Get correct services and color for Assumption (i.e., switch from white + Mass on eve to gold + evensong only)
-- Confirm that The Nativity of the Blessed Virgin Mary doesn't get transferred from Sunday, despite otherwise looking like a level 3
-- Confirm that Hildegard was meant to be a breif blip on the schedule
-- Is there a Healing Mass on a feast day (level 3) at 12:10? At 6:20?

-- rambler down

DROP TABLE fixed_feasts;
DROP TABLE schedule_services;
DROP TABLE services;
DROP TABLE schedules;

