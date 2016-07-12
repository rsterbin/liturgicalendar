
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
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('"Eve of" Solemn Mass on Friday', 'friday-solemn-eve', false); -- 15
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('"Eve of" Mass on Friday', 'friday-eve', false); -- 16
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Weekday Basic With Vigil', 'weekday-vigil', true); -- 17
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Thursday Basic With Vigil', 'thursday-vigil', true); -- 18
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Lenten Friday', 'lent-friday', true); -- 19
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Saturday Without Confessions', 'saturday-no-confessions', true); -- 20

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
INSERT INTO schedule_services (schedule_id, service_id) VALUES (15, 21); -- friday-solemn-eve
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

--
-- Define precedence and seasons
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

CREATE TABLE liturigal_seasons (
    season_id serial,
    name text NOT NULL,
    code text NOT NULL,
    color text NOT NULL,
    sort_order integer NOT NULL,
    weekday_precedence integer NOT NULL,
    has_rose_sunday boolean NOT NULL,
    continue_counting boolean NOT NULL,
    schedule_code_mon text NOT NULL,
    schedule_code_mon_with_vigil text NOT NULL,
    schedule_code_tue text NOT NULL,
    schedule_code_tue_with_vigil text NOT NULL,
    schedule_code_wed text NOT NULL,
    schedule_code_wed_with_vigil text NOT NULL,
    schedule_code_thu text NOT NULL,
    schedule_code_thu_with_vigil text NOT NULL,
    schedule_code_fri text NOT NULL,
    schedule_code_fri_with_vigil text NOT NULL,
    schedule_code_sat text NOT NULL,
    schedule_code_sat_vigil text NOT NULL,
    schedule_code_sun text NOT NULL,
    default_note_mon text,
    default_note_tue text,
    default_note_wed text,
    default_note_thu text,
    default_note_fri text,
    default_note_sat text,
    default_note_sun text,
    CONSTRAINT liturigal_seasons_pk PRIMARY KEY (season_id)
);

INSERT INTO liturigal_seasons (name, code, color, sort_order, weekday_precedence, has_rose_sunday, continue_counting,
        schedule_code_mon, schedule_code_mon_with_vigil, schedule_code_tue, schedule_code_tue_with_vigil,
        schedule_code_wed, schedule_code_wed_with_vigil, schedule_code_thu, schedule_code_thu_with_vigil,
        schedule_code_fri, schedule_code_fri_with_vigil, schedule_code_sat, schedule_code_sat_vigil, schedule_code_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu, default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Advent', 'advent', 'purple', 0, 60, true, false,
        'weekday', 'weekday-vigil', 'weekday', 'weekday-vigil',
        'weekday', 'weekday-vigil', 'thursday', 'thursday-vigil',
        'weekday', 'weekday-vigil', 'saturday', 'saturday', 'sunday',
        NULL, NULL, NULL, NULL, 'Friday Abstinence', NULL, NULL
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order, weekday_precedence, has_rose_sunday, continue_counting,
        schedule_code_mon, schedule_code_mon_with_vigil, schedule_code_tue, schedule_code_tue_with_vigil,
        schedule_code_wed, schedule_code_wed_with_vigil, schedule_code_thu, schedule_code_thu_with_vigil,
        schedule_code_fri, schedule_code_fri_with_vigil, schedule_code_sat, schedule_code_sat_vigil, schedule_code_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu, default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Christmas', 'christmas', 'white', 1, 45, false, false,
        'weekday', 'weekday-vigil', 'weekday', 'weekday-vigil',
        'weekday', 'weekday-vigil', 'thursday', 'thursday-vigil',
        'weekday', 'weekday-vigil', 'saturday-no-confessions', 'saturday-no-confessions', 'sunday',
        NULL, NULL, NULL, NULL, 'Friday Abstinence is not observed during the Christmas Season.', 'Confessions are not heard, except by appointment, on the Saturdays of the Christmas Season.', NULL
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order, weekday_precedence, has_rose_sunday, continue_counting,
        schedule_code_mon, schedule_code_mon_with_vigil, schedule_code_tue, schedule_code_tue_with_vigil,
        schedule_code_wed, schedule_code_wed_with_vigil, schedule_code_thu, schedule_code_thu_with_vigil,
        schedule_code_fri, schedule_code_fri_with_vigil, schedule_code_sat, schedule_code_sat_vigil, schedule_code_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu, default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Ordinary Time After Epiphany', 'after-epiphany', 'green', 2, 60, false, false,
        'weekday', 'weekday-vigil', 'weekday', 'weekday-vigil',
        'weekday', 'weekday-vigil', 'thursday', 'thursday-vigil',
        'weekday', 'weekday-vigil', 'saturday', 'saturday', 'sunday',
        NULL, NULL, NULL, NULL, 'Friday Abstinence', NULL, NULL
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order, weekday_precedence, has_rose_sunday, continue_counting,
        schedule_code_mon, schedule_code_mon_with_vigil, schedule_code_tue, schedule_code_tue_with_vigil,
        schedule_code_wed, schedule_code_wed_with_vigil, schedule_code_thu, schedule_code_thu_with_vigil,
        schedule_code_fri, schedule_code_fri_with_vigil, schedule_code_sat, schedule_code_sat_vigil, schedule_code_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu, default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Lent', 'lent', 'purple', 3, 45, true, false,
        'weekday', 'weekday-vigil', 'weekday', 'weekday-vigil',
        'weekday', 'weekday-vigil', 'thursday', 'thursday-vigil',
        'lent-friday', 'weekday-vigil', 'saturday', 'saturday', 'sunday',
        'Abstinence', 'Abstinence', 'Abstinence', 'Abstinence', 'Lenten Friday Abstinence', 'Abstinence', 'Abstinence is not observed on Sundays in Lent.'
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order, weekday_precedence, has_rose_sunday, continue_counting,
        schedule_code_mon, schedule_code_mon_with_vigil, schedule_code_tue, schedule_code_tue_with_vigil,
        schedule_code_wed, schedule_code_wed_with_vigil, schedule_code_thu, schedule_code_thu_with_vigil,
        schedule_code_fri, schedule_code_fri_with_vigil, schedule_code_sat, schedule_code_sat_vigil, schedule_code_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu, default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Holy Week', 'holy-week', 'red', 4, 15, false, false,
        'weekday', 'weekday-vigil', 'weekday', 'weekday-vigil',
        'weekday', 'weekday-vigil', 'thursday', 'thursday-vigil',
        'weekday', 'weekday-vigil', 'saturday', 'saturday', 'sunday',
        'Abstinence', 'Abstinence', 'Abstinence', 'Abstinence', 'Fast & Abstinence', 'Abstinence', 'Abstinence is not observed on Palm Sunday.'
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order, weekday_precedence, has_rose_sunday, continue_counting,
        schedule_code_mon, schedule_code_mon_with_vigil, schedule_code_tue, schedule_code_tue_with_vigil,
        schedule_code_wed, schedule_code_wed_with_vigil, schedule_code_thu, schedule_code_thu_with_vigil,
        schedule_code_fri, schedule_code_fri_with_vigil, schedule_code_sat, schedule_code_sat_vigil, schedule_code_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu, default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Easter Week', 'easter-week', 'gold', 5, 15, false, false,
        'weekday', 'weekday-vigil', 'weekday', 'weekday-vigil',
        'weekday', 'weekday-vigil', 'thursday', 'thursday-vigil',
        'weekday', 'weekday-vigil', 'saturday', 'saturday', 'sunday',
        NULL, NULL, NULL, NULL, 'Friday abstinence is not observed in Eastertide.', 'Confessions are heard only by appointment during Easter Week.', NULL
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order, weekday_precedence, has_rose_sunday, continue_counting,
        schedule_code_mon, schedule_code_mon_with_vigil, schedule_code_tue, schedule_code_tue_with_vigil,
        schedule_code_wed, schedule_code_wed_with_vigil, schedule_code_thu, schedule_code_thu_with_vigil,
        schedule_code_fri, schedule_code_fri_with_vigil, schedule_code_sat, schedule_code_sat_vigil, schedule_code_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu, default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Easter', 'easter', 'white', 6, 60, false, false,
        'weekday', 'weekday-vigil', 'weekday', 'weekday-vigil',
        'weekday', 'weekday-vigil', 'thursday', 'thursday-vigil',
        'weekday', 'weekday-vigil', 'saturday', 'saturday', 'sunday',
        NULL, NULL, NULL, NULL, 'Friday abstinence is not observed in Eastertide.', 'Confessions are heard only by appointment during Easter Week.', NULL
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order, weekday_precedence, has_rose_sunday, continue_counting,
        schedule_code_mon, schedule_code_mon_with_vigil, schedule_code_tue, schedule_code_tue_with_vigil,
        schedule_code_wed, schedule_code_wed_with_vigil, schedule_code_thu, schedule_code_thu_with_vigil,
        schedule_code_fri, schedule_code_fri_with_vigil, schedule_code_sat, schedule_code_sat_vigil, schedule_code_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu, default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Ordinary Time After Pentecost (Spring)', 'pentecost-spring', 'green', 7, 60, false, false,
        'weekday', 'weekday-vigil', 'weekday', 'weekday-vigil',
        'weekday', 'weekday-vigil', 'thursday', 'thursday-vigil',
        'weekday', 'weekday-vigil', 'saturday', 'saturday', 'sunday',
        NULL, NULL, NULL, NULL, 'Friday Abstinence', NULL, NULL
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order, weekday_precedence, has_rose_sunday, continue_counting,
        schedule_code_mon, schedule_code_mon_with_vigil, schedule_code_tue, schedule_code_tue_with_vigil,
        schedule_code_wed, schedule_code_wed_with_vigil, schedule_code_thu, schedule_code_thu_with_vigil,
        schedule_code_fri, schedule_code_fri_with_vigil, schedule_code_sat, schedule_code_sat_vigil, schedule_code_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu, default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Ordinary Time After Pentecost (Summer)', 'pentecost-summer', 'green', 8, 60, false, true,
        'weekday', 'weekday-vigil', 'weekday', 'weekday-vigil',
        'weekday', 'weekday-vigil', 'thursday', 'thursday-vigil',
        'weekday', 'weekday-vigil', 'saturday', 'saturday', 'summer-sunday',
        NULL, NULL, NULL, NULL, 'Friday Abstinence', NULL, NULL
    );

INSERT INTO liturigal_seasons (name, code, color, sort_order, weekday_precedence, has_rose_sunday, continue_counting,
        schedule_code_mon, schedule_code_mon_with_vigil, schedule_code_tue, schedule_code_tue_with_vigil,
        schedule_code_wed, schedule_code_wed_with_vigil, schedule_code_thu, schedule_code_thu_with_vigil,
        schedule_code_fri, schedule_code_fri_with_vigil, schedule_code_sat, schedule_code_sat_vigil, schedule_code_sun,
        default_note_mon, default_note_tue, default_note_wed, default_note_thu, default_note_fri, default_note_sat, default_note_sun
    ) VALUES ('Ordinary Time After Pentecost (Fall)', 'pentecost-fall', 'green', 9, 60, false, true,
        'weekday', 'weekday-vigil', 'weekday', 'weekday-vigil',
        'weekday', 'weekday-vigil', 'thursday', 'thursday-vigil',
        'weekday', 'weekday-vigil', 'saturday', 'saturday', 'sunday',
        NULL, NULL, NULL, NULL, 'Friday Abstinence', NULL, NULL
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
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color) VALUES ('The Epiphany of Our Lord Jesus Christ', 1, 1, 6, 'solemn-weekday-feast', true, 'es-only', 'friday-solemn-eve', 'gold');
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
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color, valid_end) VALUES ('The Annunciation of Our Lord Jesus Christ', 2, 3, 25, 'solemn-weekday-feast', true, 'es-only', 'friday-solemn-eve', 'blue', '2013-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_code, has_vigil, vigil_schedule_code, fri_vigil_schedule_code, color, valid_start) VALUES ('The Annunciation of Our Lord Jesus Christ', 2, 3, 25, 'solemn-weekday-feast', true, 'es-only', 'friday-solemn-eve', 'gold', '2014-01-01 00:00:00' AT TIME ZONE 'America/New_York');

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

-- TODO: July
-- TODO: August
-- TODO: September
-- TODO: October
-- TODO: November
-- TODO: December

-- todo: movable notes
-- in January: 'Birthday of Martin Luther King, Jr. – Federal Holiday Schedule<br />The church opens today at 10:00 AM and closes at 2:00 PM.'
-- in February: 'Washington’s Birthday – Federal Holiday Schedule<br />The church opens today at 10:00 AM and closes at 2:00 PM.'

-- todo: remember
-- Commemorations don't show up at all in Lent
-- There is a Last Sunday After Epiphany
-- Major Feasts in Holy Week or Easter Week transfer all the way to the following Monday (and Tuesday, if both Saint Joseph and Annunciation fall within)

-- todo: ask for clarification
-- How does the day marked "Of Our Lady" in January work?
-- Is the change from white to gold for Annunciation an intentional change or a mistake that got carried from the previous year's transfer?
-- The list of Commemorations needs confirmation, as there are some important variations from the Episcopal calendars I've found (e.g. http://satucket.com/lectionary/Calendar.htm)
-- If a major feast falls on a Saturday in Lent, what happens to Stations of the Cross?
-- How is the date of "The First Book of Common Prayer, 1549" determined?
-- Do we celebrate Sacred Heart (19 days after Pentecost) anymore?  It appears through 2008.

-- rambler down

DROP TABLE fixed_feasts;
DROP TABLE schedule_services;
DROP TABLE services;
DROP TABLE schedules;

