
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
    CONSTRAINT schedules_pk PRIMARY KEY (schedule_id)
);

CREATE INDEX schedules_code_idx ON schedules (code, valid_start, valid_end);
CREATE INDEX schedules_default_idx ON schedules (is_default, valid_start, valid_end);

INSERT INTO schedules (name, code, is_default) VALUES ('Weekday Basic', 'weekday', true); -- 1
INSERT INTO schedules (name, code, is_default) VALUES ('Thursday Basic', 'thursday', true); -- 2
INSERT INTO schedules (name, code, is_default) VALUES ('Saturday Basic', 'saturday', true); -- 3
INSERT INTO schedules (name, code, is_default) VALUES ('Saturday Vigil Basic', 'vigil', true); -- 4
INSERT INTO schedules (name, code, is_default) VALUES ('Sunday Basic', 'sunday', true); -- 5
INSERT INTO schedules (name, code, is_default) VALUES ('Summer Sunday Basic', 'summer-sunday', true); -- 6
INSERT INTO schedules (name, code, is_default) VALUES ('E&B Only', 'eb-only', true); -- 7
INSERT INTO schedules (name, code, is_default) VALUES ('Evensong Only', 'es-only', true); -- 8
INSERT INTO schedules (name, code, is_default) VALUES ('Evening Prayer Only', 'ep-only', true); -- 9
INSERT INTO schedules (name, code, is_default) VALUES ('Weekday Feast', 'weekday-feast', true); -- 10
INSERT INTO schedules (name, code, is_default) VALUES ('Solemn Weekday Feast', 'solemn-weekday-feast', true); -- 11
INSERT INTO schedules (name, code, is_default) VALUES ('Candlemas', 'candlemas', false); -- 12
INSERT INTO schedules (name, code, is_default) VALUES ('Saint Blase', 'blase', false); -- 13
INSERT INTO schedules (name, code, is_default) VALUES ('Eve of Candlemas on Friday', 'candelmas-eve', false); -- 14
INSERT INTO schedules (name, code, is_default) VALUES ('"Eve of" Solemn Mass on Friday', 'solemn-friday-eve', false); -- 15
INSERT INTO schedules (name, code, is_default) VALUES ('"Eve of" Mass on Friday', 'friday-eve', false); -- 16
INSERT INTO schedules (name, code, is_default) VALUES ('Weekday Basic With Vigil', 'weekday-vigil', true); -- 17
INSERT INTO schedules (name, code, is_default) VALUES ('Thursday Basic With Vigil', 'thursday-vigil', true); -- 18
INSERT INTO schedules (name, code, is_default) VALUES ('Lenten Friday', 'lent-friday', true); -- 19
INSERT INTO schedules (name, code, is_default) VALUES ('Saturday Without Confessions', 'saturday-no-confessions', true); -- 20
INSERT INTO schedules (name, code, is_default) VALUES ('Requiem Weekday', 'requiem-weekday', false); -- 21
INSERT INTO schedules (name, code, is_default) VALUES ('Thursday Feast', 'thursday-feast', true); -- 22
INSERT INTO schedules (name, code, is_default) VALUES ('Saturday Vigil Mass', 'saturday-vigil-mass', true); -- 23
INSERT INTO schedules (name, code, is_default) VALUES ('Evening Prayer and Vigil Mass', 'ep-vigil-mass', false); -- 24
INSERT INTO schedules (name, code, is_default) VALUES ('Summer Sunday With Procession', 'summer-sunday-procession', true); -- 25
INSERT INTO schedules (name, code, is_default) VALUES ('Candlemas Saturday', 'candlemas-saturday', true); -- 26
INSERT INTO schedules (name, code, is_default) VALUES ('Candlemas Sunday', 'candlemas-sunday', true); -- 27
INSERT INTO schedules (name, code, is_default) VALUES ('E&B with Recital', 'eb-recital', true); -- 28
INSERT INTO schedules (name, code, is_default) VALUES ('Saint Blase With Vigil', 'blase-vigil', false); -- 29
INSERT INTO schedules (name, code, is_default) VALUES ('Saint Blase Saturday', 'blase-saturday', false); -- 30
INSERT INTO schedules (name, code, is_default) VALUES ('Requiem Weekday With Vigil', 'requiem-vigil', false); -- 31
INSERT INTO schedules (name, code, is_default) VALUES ('Requiem Saturday', 'requiem-saturday', false); -- 32
INSERT INTO schedules (name, code, is_default) VALUES ('All Souls', 'all-souls', true); -- 33
INSERT INTO schedules (name, code, is_default) VALUES ('All Souls Saturday', 'all-souls-saturday', true); -- 34
INSERT INTO schedules (name, code, is_default) VALUES ('Christmas Day', 'christmas', true); -- 35
INSERT INTO schedules (name, code, is_default, valid_start) VALUES ('Christmas Eve', 'christmas-eve', true, '2013-01-01 00:00:00' AT TIME ZONE 'America/New_York'); -- 36
INSERT INTO schedules (name, code, is_default, valid_start, valid_end) VALUES ('Christmas Eve', 'christmas-eve', true, '2011-01-01 00:00:00' AT TIME ZONE 'America/New_York', '2012-12-31 23:59:59' AT TIME ZONE 'America/New_York'); -- 37
INSERT INTO schedules (name, code, is_default, valid_end) VALUES ('Christmas Eve', 'christmas-eve', true, '2010-12-31 23:59:59' AT TIME ZONE 'America/New_York'); -- 38
INSERT INTO schedules (name, code, is_default) VALUES ('Wednesday Basic', 'wednesday', true); -- 39
INSERT INTO schedules (name, code, is_default) VALUES ('Wednesday Basic With Vigil', 'wednesday-vigil', true); -- 40
INSERT INTO schedules (name, code, is_default) VALUES ('Wednesday Feast', 'wednesday-feast', true); -- 41
INSERT INTO schedules (name, code, is_default) VALUES ('Weekday Basic Without Prayers', 'weekday-no-prayers', true); -- 42
INSERT INTO schedules (name, code, is_default) VALUES ('Thursday Basic Without Prayers', 'thursday-no-prayers', true); -- 43
INSERT INTO schedules (name, code, is_default) VALUES ('Easter Vigil', 'easter-vigil', true); -- 44
INSERT INTO schedules (name, code, is_default, valid_start) VALUES ('Easter Day', 'easter-day', true, '2014-01-01 00:00:00' AT TIME ZONE 'America/New_York'); -- 45
INSERT INTO schedules (name, code, is_default, valid_start, valid_end) VALUES ('Easter Day', 'easter-day', true, '2008-01-01 00:00:00' AT TIME ZONE 'America/New_York', '2013-12-31 23:59:59' AT TIME ZONE 'America/New_York'); -- 46
INSERT INTO schedules (name, code, is_default, valid_end) VALUES ('Easter Day', 'easter-day', true, '2007-12-31 23:59:59' AT TIME ZONE 'America/New_York'); -- 47

-- TODO: old summer sunday schedule
-- TODO: old weekday schedule (with 6:20 Mass after evening prayer)
-- TODO: Blase with old weekday schedule

CREATE TABLE services (
    service_id serial,
    name text NOT NULL,
    start_time time with time zone NOT NULL,
    is_default boolean NOT NULL DEFAULT false,
    CONSTRAINT services_pk PRIMARY KEY (service_id)
);

CREATE INDEX services_start_time_idx ON services (start_time);
CREATE INDEX services_default_idx ON services (is_default);

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
INSERT INTO services (name, start_time, is_default) VALUES ('Mass', '17:20:00', true); -- 29
INSERT INTO services (name, start_time, is_default) VALUES ('Procession through Times Square & Solemn Mass', '11:00:00', true); -- 30
INSERT INTO services (name, start_time, is_default) VALUES ('Blessing of Candles & Sung Mass', '09:00:00', false); -- 31
INSERT INTO services (name, start_time, is_default) VALUES ('Blessing of Candles, Procession & Solemn Mass', '11:00:00', false); -- 32
INSERT INTO services (name, start_time, is_default) VALUES ('Solemn Mass and the Blessing of the Vault', '18:00:00', false); -- 33
INSERT INTO services (name, start_time, is_default) VALUES ('Sung Mass & Blessing of the Vault', '11:00:00', false); -- 34
INSERT INTO services (name, start_time, is_default) VALUES ('Solemn Mass & Procession to the Crèche', '11:00:00', false); -- 35
INSERT INTO services (name, start_time, is_default) VALUES ('Christmas Music', '16:30:00', false); -- 36
INSERT INTO services (name, start_time, is_default) VALUES ('Sung Mass of the Nativity', '17:00:00', false); -- 37
INSERT INTO services (name, start_time, is_default) VALUES ('Christmas Music', '22:30:00', false); -- 38
INSERT INTO services (name, start_time, is_default) VALUES ('Procession & Solemn Mass of the Nativity', '23:00:00', false); -- 39
INSERT INTO services (name, start_time, is_default) VALUES ('Evensong', '15:30:00', false); -- 40
INSERT INTO services (name, start_time, is_default) VALUES ('Choral Music & Carols', '16:30:00', false); -- 41
INSERT INTO services (name, start_time, is_default) VALUES ('Choral Music & Carols', '22:30:00', false); -- 42
INSERT INTO services (name, start_time, is_default) VALUES ('Carols for Choir & Congregation', '16:30:00', false); -- 43
INSERT INTO services (name, start_time, is_default) VALUES ('Sung Mass with Hymns and Carols', '17:00:00', false); -- 44
INSERT INTO services (name, start_time, is_default) VALUES ('Carols for Choir & Congregation', '22:30:00', false); -- 45
INSERT INTO services (name, start_time, is_default) VALUES ('The Great Vigil of Easter', '19:00:00', false); -- 46
INSERT INTO services (name, start_time, is_default) VALUES ('Mass with Hymns', '09:00:00', false); -- 47
INSERT INTO services (name, start_time, is_default) VALUES ('Mass with Hymns', '10:00:00', false); -- 48
INSERT INTO services (name, start_time, is_default) VALUES ('Said Mass with Hymns', '09:00:00', false); -- 49
INSERT INTO services (name, start_time, is_default) VALUES ('Sung Mass', '10:00:00', false); -- 50
INSERT INTO services (name, start_time, is_default) VALUES ('Organ Recital', '16:30:00', true); -- 51
INSERT INTO services (name, start_time, is_default) VALUES ('Solemn Paschal Evensong & Benediction', '17:00:00', true); -- 52

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
INSERT INTO schedule_services (schedule_id, service_id) VALUES (10, 3); -- weekday-feast
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
INSERT INTO schedule_services (schedule_id, service_id) VALUES (22, 1); -- thursday-feast
INSERT INTO schedule_services (schedule_id, service_id) VALUES (22, 2); -- thursday-feast
INSERT INTO schedule_services (schedule_id, service_id) VALUES (22, 5); -- thursday-feast
INSERT INTO schedule_services (schedule_id, service_id) VALUES (22, 20); -- thursday-feast
INSERT INTO schedule_services (schedule_id, service_id) VALUES (23, 8); -- saturday-vigil-mass
INSERT INTO schedule_services (schedule_id, service_id) VALUES (23, 29); -- saturday-vigil-mass
INSERT INTO schedule_services (schedule_id, service_id) VALUES (24, 5); -- ep-vigil-mass
INSERT INTO schedule_services (schedule_id, service_id) VALUES (24, 20); -- ep-vigil-mass
INSERT INTO schedule_services (schedule_id, service_id) VALUES (25, 1); -- summer-sunday-procession
INSERT INTO schedule_services (schedule_id, service_id) VALUES (25, 11); -- summer-sunday-procession
INSERT INTO schedule_services (schedule_id, service_id) VALUES (25, 12); -- summer-sunday-procession
INSERT INTO schedule_services (schedule_id, service_id) VALUES (25, 30); -- summer-sunday-procession
INSERT INTO schedule_services (schedule_id, service_id) VALUES (25, 8); -- summer-sunday-procession
INSERT INTO schedule_services (schedule_id, service_id) VALUES (26, 6); -- candlemas-saturday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (26, 2); -- candlemas-saturday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (26, 22); -- candlemas-saturday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (26, 7); -- candlemas-saturday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (27, 10); -- candlemas-sunday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (27, 31); -- candlemas-sunday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (27, 32); -- candlemas-sunday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (27, 15); -- candlemas-sunday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (28, 14); -- eb-recital
INSERT INTO schedule_services (schedule_id, service_id) VALUES (28, 15); -- eb-recital
INSERT INTO schedule_services (schedule_id, service_id) VALUES (29, 1); -- blase-vigil
INSERT INTO schedule_services (schedule_id, service_id) VALUES (29, 2); -- blase-vigil
INSERT INTO schedule_services (schedule_id, service_id) VALUES (29, 24); -- blase-vigil
INSERT INTO schedule_services (schedule_id, service_id) VALUES (30, 6); -- blase-saturday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (30, 2); -- blase-saturday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (30, 22); -- blase-saturday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (30, 7); -- blase-saturday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (31, 1); -- requiem-vigil
INSERT INTO schedule_services (schedule_id, service_id) VALUES (31, 2); -- requiem-vigil
INSERT INTO schedule_services (schedule_id, service_id) VALUES (31, 27); -- requiem-vigil
INSERT INTO schedule_services (schedule_id, service_id) VALUES (32, 6); -- requiem-saturday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (32, 2); -- requiem-saturday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (32, 27); -- requiem-saturday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (32, 7); -- requiem-saturday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (33, 10); -- all-souls
INSERT INTO schedule_services (schedule_id, service_id) VALUES (33, 2); -- all-souls
INSERT INTO schedule_services (schedule_id, service_id) VALUES (33, 18); -- all-souls
INSERT INTO schedule_services (schedule_id, service_id) VALUES (33, 33); -- all-souls
INSERT INTO schedule_services (schedule_id, service_id) VALUES (34, 34); -- all-souls-saturday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (34, 7); -- all-souls-saturday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (35, 35); -- christmas
INSERT INTO schedule_services (schedule_id, service_id) VALUES (36, 36); -- christmas-eve
INSERT INTO schedule_services (schedule_id, service_id) VALUES (36, 37); -- christmas-eve
INSERT INTO schedule_services (schedule_id, service_id) VALUES (36, 38); -- christmas-eve
INSERT INTO schedule_services (schedule_id, service_id) VALUES (36, 39); -- christmas-eve
INSERT INTO schedule_services (schedule_id, service_id) VALUES (37, 40); -- christmas-eve (older)
INSERT INTO schedule_services (schedule_id, service_id) VALUES (37, 41); -- christmas-eve (older)
INSERT INTO schedule_services (schedule_id, service_id) VALUES (37, 37); -- christmas-eve (older)
INSERT INTO schedule_services (schedule_id, service_id) VALUES (37, 42); -- christmas-eve (older)
INSERT INTO schedule_services (schedule_id, service_id) VALUES (37, 39); -- christmas-eve (older)
INSERT INTO schedule_services (schedule_id, service_id) VALUES (38, 43); -- christmas-eve (oldest)
INSERT INTO schedule_services (schedule_id, service_id) VALUES (38, 44); -- christmas-eve (oldest)
INSERT INTO schedule_services (schedule_id, service_id) VALUES (38, 45); -- christmas-eve (oldest)
INSERT INTO schedule_services (schedule_id, service_id) VALUES (38, 39); -- christmas-eve (oldest)
INSERT INTO schedule_services (schedule_id, service_id) VALUES (39, 1); -- wednesday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (39, 2); -- wednesday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (39, 18); -- wednesday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (39, 5); -- wednesday
INSERT INTO schedule_services (schedule_id, service_id) VALUES (40, 1); -- wednesday-vigil
INSERT INTO schedule_services (schedule_id, service_id) VALUES (40, 2); -- wednesday-vigil
INSERT INTO schedule_services (schedule_id, service_id) VALUES (40, 18); -- wednesday-vigil
INSERT INTO schedule_services (schedule_id, service_id) VALUES (41, 1); -- wednesday-feast
INSERT INTO schedule_services (schedule_id, service_id) VALUES (41, 2); -- wednesday-feast
INSERT INTO schedule_services (schedule_id, service_id) VALUES (41, 18); -- wednesday-feast
INSERT INTO schedule_services (schedule_id, service_id) VALUES (41, 5); -- wednesday-feast
INSERT INTO schedule_services (schedule_id, service_id) VALUES (41, 20); -- wednesday-feast
INSERT INTO schedule_services (schedule_id, service_id) VALUES (42, 2); -- weekday-no-prayers
INSERT INTO schedule_services (schedule_id, service_id) VALUES (42, 3); -- weekday-no-prayers
INSERT INTO schedule_services (schedule_id, service_id) VALUES (43, 2); -- thursday-no-prayers
INSERT INTO schedule_services (schedule_id, service_id) VALUES (43, 4); -- thursday-no-prayers
INSERT INTO schedule_services (schedule_id, service_id) VALUES (44, 46); -- easter-vigil
INSERT INTO schedule_services (schedule_id, service_id) VALUES (45, 10); -- easter-day
INSERT INTO schedule_services (schedule_id, service_id) VALUES (45, 47); -- easter-day
INSERT INTO schedule_services (schedule_id, service_id) VALUES (45, 48); -- easter-day
INSERT INTO schedule_services (schedule_id, service_id) VALUES (45, 13); -- easter-day
INSERT INTO schedule_services (schedule_id, service_id) VALUES (45, 51); -- easter-day
INSERT INTO schedule_services (schedule_id, service_id) VALUES (45, 52); -- easter-day
INSERT INTO schedule_services (schedule_id, service_id) VALUES (46, 10); -- easter-day (older)
INSERT INTO schedule_services (schedule_id, service_id) VALUES (46, 11); -- easter-day (older)
INSERT INTO schedule_services (schedule_id, service_id) VALUES (46, 12); -- easter-day (older)
INSERT INTO schedule_services (schedule_id, service_id) VALUES (46, 13); -- easter-day (older)
INSERT INTO schedule_services (schedule_id, service_id) VALUES (46, 51); -- easter-day (older)
INSERT INTO schedule_services (schedule_id, service_id) VALUES (46, 52); -- easter-day (older)
INSERT INTO schedule_services (schedule_id, service_id) VALUES (47, 10); -- easter-day (oldest)
INSERT INTO schedule_services (schedule_id, service_id) VALUES (47, 49); -- easter-day (oldest)
INSERT INTO schedule_services (schedule_id, service_id) VALUES (47, 50); -- easter-day (oldest)
INSERT INTO schedule_services (schedule_id, service_id) VALUES (47, 13); -- easter-day (oldest)
INSERT INTO schedule_services (schedule_id, service_id) VALUES (47, 52); -- easter-day (oldest)

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

CREATE INDEX service_patterns_code_idx ON service_patterns (code, valid_start, valid_end);

INSERT INTO service_patterns (name, code,
        schedule_code_mon, schedule_code_mon_with_vigil, schedule_code_mon_vigil,
        schedule_code_tue, schedule_code_tue_with_vigil, schedule_code_tue_vigil,
        schedule_code_wed, schedule_code_wed_with_vigil, schedule_code_wed_vigil,
        schedule_code_thu, schedule_code_thu_with_vigil, schedule_code_thu_vigil,
        schedule_code_fri, schedule_code_fri_with_vigil, schedule_code_fri_vigil,
        schedule_code_sat, schedule_code_sat_with_vigil, schedule_code_sat_vigil,
        schedule_code_sun, schedule_code_sun_with_vigil, schedule_code_sun_vigil
    ) VALUES ('Standard', 'standard',
        'weekday', 'weekday-vigil', null,
        'weekday', 'weekday-vigil', null,
        'wednesday', 'wednesday-vigil', null,
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
    ) VALUES ('Standard Without Confessions', 'standard-no-confessions',
        'weekday', 'weekday-vigil', null,
        'weekday', 'weekday-vigil', null,
        'wednesday', 'wednesday-vigil', null,
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
    ) VALUES ('Standard With Stations', 'standard-stations',
        'weekday', 'weekday-vigil', null,
        'weekday', 'weekday-vigil', null,
        'wednesday', 'wednesday-vigil', null,
        'thursday', 'thursday-vigil', null,
        'lent-friday', 'weekday-vigil', null,
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
    ) VALUES ('Major Fixed Feast', 'major-fixed-feast',
        'weekday-feast', 'weekday-feast', null,
        'weekday-feast', 'weekday-feast', null,
        'wednesday-feast', 'wednesday-feast', null,
        'thursday-feast', 'thursday-feast', null,
        'weekday-feast', 'weekday-feast', null,
        'saturday', 'saturday', null,
        null, null, null
    );

INSERT INTO service_patterns (name, code,
        schedule_code_mon, schedule_code_mon_with_vigil, schedule_code_mon_vigil,
        schedule_code_tue, schedule_code_tue_with_vigil, schedule_code_tue_vigil,
        schedule_code_wed, schedule_code_wed_with_vigil, schedule_code_wed_vigil,
        schedule_code_thu, schedule_code_thu_with_vigil, schedule_code_thu_vigil,
        schedule_code_fri, schedule_code_fri_with_vigil, schedule_code_fri_vigil,
        schedule_code_sat, schedule_code_sat_with_vigil, schedule_code_sat_vigil,
        schedule_code_sun, schedule_code_sun_with_vigil, schedule_code_sun_vigil
    ) VALUES ('Major Fixed Feast Eve', 'major-fixed-feast-eve',
        null, null, 'ep-only',
        null, null, 'ep-only',
        null, null, 'ep-only',
        null, null, 'ep-only',
        null, null, 'friday-eve',
        null, null, null,
        null, null, null
    );

INSERT INTO service_patterns (name, code,
        schedule_code_mon, schedule_code_mon_with_vigil, schedule_code_mon_vigil,
        schedule_code_tue, schedule_code_tue_with_vigil, schedule_code_tue_vigil,
        schedule_code_wed, schedule_code_wed_with_vigil, schedule_code_wed_vigil,
        schedule_code_thu, schedule_code_thu_with_vigil, schedule_code_thu_vigil,
        schedule_code_fri, schedule_code_fri_with_vigil, schedule_code_fri_vigil,
        schedule_code_sat, schedule_code_sat_with_vigil, schedule_code_sat_vigil,
        schedule_code_sun, schedule_code_sun_with_vigil, schedule_code_sun_vigil
    ) VALUES ('Solemn Fixed Feast', 'solemn-fixed-feast',
        'solemn-weekday-feast', 'solemn-weekday-feast', null,
        'solemn-weekday-feast', 'solemn-weekday-feast', null,
        'solemn-weekday-feast', 'solemn-weekday-feast', null,
        'solemn-weekday-feast', 'solemn-weekday-feast', null,
        'solemn-weekday-feast', 'solemn-weekday-feast', null,
        'saturday', 'saturday', null,
        null, null, null
    );

INSERT INTO service_patterns (name, code,
        schedule_code_mon, schedule_code_mon_with_vigil, schedule_code_mon_vigil,
        schedule_code_tue, schedule_code_tue_with_vigil, schedule_code_tue_vigil,
        schedule_code_wed, schedule_code_wed_with_vigil, schedule_code_wed_vigil,
        schedule_code_thu, schedule_code_thu_with_vigil, schedule_code_thu_vigil,
        schedule_code_fri, schedule_code_fri_with_vigil, schedule_code_fri_vigil,
        schedule_code_sat, schedule_code_sat_with_vigil, schedule_code_sat_vigil,
        schedule_code_sun, schedule_code_sun_with_vigil, schedule_code_sun_vigil
    ) VALUES ('Solemn Fixed Feast Eve', 'solemn-fixed-feast-eve',
        null, null, 'es-only',
        null, null, 'es-only',
        null, null, 'es-only',
        null, null, 'es-only',
        null, null, 'solemn-friday-eve',
        null, null, null,
        null, null, null
    );

INSERT INTO service_patterns (name, code,
        schedule_code_mon, schedule_code_mon_with_vigil, schedule_code_mon_vigil,
        schedule_code_tue, schedule_code_tue_with_vigil, schedule_code_tue_vigil,
        schedule_code_wed, schedule_code_wed_with_vigil, schedule_code_wed_vigil,
        schedule_code_thu, schedule_code_thu_with_vigil, schedule_code_thu_vigil,
        schedule_code_fri, schedule_code_fri_with_vigil, schedule_code_fri_vigil,
        schedule_code_sat, schedule_code_sat_with_vigil, schedule_code_sat_vigil,
        schedule_code_sun, schedule_code_sun_with_vigil, schedule_code_sun_vigil
    ) VALUES ('Candlemas', 'candlemas',
        'candlemas', 'candlemas', null,
        'candlemas', 'candlemas', null,
        'candlemas', 'candlemas', null,
        'candlemas', 'candlemas', null,
        'candlemas', 'candlemas', null,
        'candlemas-saturday', 'candlemas-saturday', null,
        'candlemas-sunday', 'candlemas-sunday', null
    );

INSERT INTO service_patterns (name, code,
        schedule_code_mon, schedule_code_mon_with_vigil, schedule_code_mon_vigil,
        schedule_code_tue, schedule_code_tue_with_vigil, schedule_code_tue_vigil,
        schedule_code_wed, schedule_code_wed_with_vigil, schedule_code_wed_vigil,
        schedule_code_thu, schedule_code_thu_with_vigil, schedule_code_thu_vigil,
        schedule_code_fri, schedule_code_fri_with_vigil, schedule_code_fri_vigil,
        schedule_code_sat, schedule_code_sat_with_vigil, schedule_code_sat_vigil,
        schedule_code_sun, schedule_code_sun_with_vigil, schedule_code_sun_vigil
    ) VALUES ('Candlemas Eve', 'candlemas-eve',
        null, null, 'eb-recital',
        null, null, 'eb-recital',
        null, null, 'eb-recital',
        null, null, 'eb-recital',
        null, null, 'candlemas-eve',
        null, null, 'saturday-vigil-mass',
        null, null, 'eb-only'
    );

INSERT INTO service_patterns (name, code,
        schedule_code_mon, schedule_code_mon_with_vigil, schedule_code_mon_vigil,
        schedule_code_tue, schedule_code_tue_with_vigil, schedule_code_tue_vigil,
        schedule_code_wed, schedule_code_wed_with_vigil, schedule_code_wed_vigil,
        schedule_code_thu, schedule_code_thu_with_vigil, schedule_code_thu_vigil,
        schedule_code_fri, schedule_code_fri_with_vigil, schedule_code_fri_vigil,
        schedule_code_sat, schedule_code_sat_with_vigil, schedule_code_sat_vigil,
        schedule_code_sun, schedule_code_sun_with_vigil, schedule_code_sun_vigil,
        valid_start
    ) VALUES ('Assumption', 'assumption',
        'solemn-weekday-feast', 'solemn-weekday-feast', null,
        'solemn-weekday-feast', 'solemn-weekday-feast', null,
        'solemn-weekday-feast', 'solemn-weekday-feast', null,
        'solemn-weekday-feast', 'solemn-weekday-feast', null,
        'solemn-weekday-feast', 'solemn-weekday-feast', null,
        'saturday', 'saturday', null,
        'summer-sunday', 'summer-sunday', null,
        '2009-01-01 00:00:00' AT TIME ZONE 'America/New_York'
    );

INSERT INTO service_patterns (name, code,
        schedule_code_mon, schedule_code_mon_with_vigil, schedule_code_mon_vigil,
        schedule_code_tue, schedule_code_tue_with_vigil, schedule_code_tue_vigil,
        schedule_code_wed, schedule_code_wed_with_vigil, schedule_code_wed_vigil,
        schedule_code_thu, schedule_code_thu_with_vigil, schedule_code_thu_vigil,
        schedule_code_fri, schedule_code_fri_with_vigil, schedule_code_fri_vigil,
        schedule_code_sat, schedule_code_sat_with_vigil, schedule_code_sat_vigil,
        schedule_code_sun, schedule_code_sun_with_vigil, schedule_code_sun_vigil,
        valid_start
    ) VALUES ('Assumption Eve', 'assumption-eve',
        null, null, 'ep-only',
        null, null, 'ep-only',
        null, null, 'ep-only',
        null, null, 'ep-only',
        null, null, 'solemn-friday-eve',
        null, null, 'saturday-vigil-mass',
        null, null, 'ep-only',
        '2008-01-01 00:00:00' AT TIME ZONE 'America/New_York'
    );

INSERT INTO service_patterns (name, code,
        schedule_code_mon, schedule_code_mon_with_vigil, schedule_code_mon_vigil,
        schedule_code_tue, schedule_code_tue_with_vigil, schedule_code_tue_vigil,
        schedule_code_wed, schedule_code_wed_with_vigil, schedule_code_wed_vigil,
        schedule_code_thu, schedule_code_thu_with_vigil, schedule_code_thu_vigil,
        schedule_code_fri, schedule_code_fri_with_vigil, schedule_code_fri_vigil,
        schedule_code_sat, schedule_code_sat_with_vigil, schedule_code_sat_vigil,
        schedule_code_sun, schedule_code_sun_with_vigil, schedule_code_sun_vigil,
        valid_end
    ) VALUES ('Assumption', 'assumption',
        'solemn-weekday-feast', 'solemn-weekday-feast', null,
        'solemn-weekday-feast', 'solemn-weekday-feast', null,
        'solemn-weekday-feast', 'solemn-weekday-feast', null,
        'solemn-weekday-feast', 'solemn-weekday-feast', null,
        'solemn-weekday-feast', 'solemn-weekday-feast', null,
        'saturday', 'saturday', null,
        'summer-sunday-procession', 'summer-sunday-procession', null,
        '2009-12-31 23:59:59' AT TIME ZONE 'America/New_York'
    );

INSERT INTO service_patterns (name, code,
        schedule_code_mon, schedule_code_mon_with_vigil, schedule_code_mon_vigil,
        schedule_code_tue, schedule_code_tue_with_vigil, schedule_code_tue_vigil,
        schedule_code_wed, schedule_code_wed_with_vigil, schedule_code_wed_vigil,
        schedule_code_thu, schedule_code_thu_with_vigil, schedule_code_thu_vigil,
        schedule_code_fri, schedule_code_fri_with_vigil, schedule_code_fri_vigil,
        schedule_code_sat, schedule_code_sat_with_vigil, schedule_code_sat_vigil,
        schedule_code_sun, schedule_code_sun_with_vigil, schedule_code_sun_vigil,
        valid_end
    ) VALUES ('Assumption Eve', 'assumption-eve',
        null, null, 'ep-vigil-mass',
        null, null, 'ep-vigil-mass',
        null, null, 'ep-vigil-mass',
        null, null, 'es-only',
        null, null, 'ep-vigil-mass',
        null, null, 'ep-vigil-mass',
        null, null, 'ep-vigil-mass',
        '2008-12-31 23:59:59' AT TIME ZONE 'America/New_York'
    );

INSERT INTO service_patterns (name, code,
        schedule_code_mon, schedule_code_mon_with_vigil, schedule_code_mon_vigil,
        schedule_code_tue, schedule_code_tue_with_vigil, schedule_code_tue_vigil,
        schedule_code_wed, schedule_code_wed_with_vigil, schedule_code_wed_vigil,
        schedule_code_thu, schedule_code_thu_with_vigil, schedule_code_thu_vigil,
        schedule_code_fri, schedule_code_fri_with_vigil, schedule_code_fri_vigil,
        schedule_code_sat, schedule_code_sat_with_vigil, schedule_code_sat_vigil,
        schedule_code_sun, schedule_code_sun_with_vigil, schedule_code_sun_vigil
    ) VALUES ('St. Blase', 'blase',
        'blase', 'blase-vigil', null,
        'blase', 'blase-vigil', null,
        'blase', 'blase-vigil', null,
        'blase', 'blase-vigil', null,
        'blase', 'blase-vigil', null,
        'blase-saturday', 'blase-saturday', null,
         null, null, null
    );

INSERT INTO service_patterns (name, code,
        schedule_code_mon, schedule_code_mon_with_vigil, schedule_code_mon_vigil,
        schedule_code_tue, schedule_code_tue_with_vigil, schedule_code_tue_vigil,
        schedule_code_wed, schedule_code_wed_with_vigil, schedule_code_wed_vigil,
        schedule_code_thu, schedule_code_thu_with_vigil, schedule_code_thu_vigil,
        schedule_code_fri, schedule_code_fri_with_vigil, schedule_code_fri_vigil,
        schedule_code_sat, schedule_code_sat_with_vigil, schedule_code_sat_vigil,
        schedule_code_sun, schedule_code_sun_with_vigil, schedule_code_sun_vigil
    ) VALUES ('Parish Requiem', 'parish-requiem',
        'requiem-weekday', 'requiem-vigil', null,
        'requiem-weekday', 'requiem-vigil', null,
        'requiem-weekday', 'requiem-vigil', null,
        'requiem-weekday', 'requiem-vigil', null,
        'requiem-weekday', 'requiem-vigil', null,
        'requiem-saturday', 'requiem-saturday', null,
         null, null, null
    );

INSERT INTO service_patterns (name, code,
        schedule_code_mon, schedule_code_mon_with_vigil, schedule_code_mon_vigil,
        schedule_code_tue, schedule_code_tue_with_vigil, schedule_code_tue_vigil,
        schedule_code_wed, schedule_code_wed_with_vigil, schedule_code_wed_vigil,
        schedule_code_thu, schedule_code_thu_with_vigil, schedule_code_thu_vigil,
        schedule_code_fri, schedule_code_fri_with_vigil, schedule_code_fri_vigil,
        schedule_code_sat, schedule_code_sat_with_vigil, schedule_code_sat_vigil,
        schedule_code_sun, schedule_code_sun_with_vigil, schedule_code_sun_vigil
    ) VALUES ('All Souls', 'all-souls',
        'all-souls', null, null,
        'all-souls', null, null,
        'all-souls', null, null,
        'all-souls', null, null,
        'all-souls', null, null,
        'all-souls-saturday', null, null,
         null, null, null
    );

INSERT INTO service_patterns (name, code,
        schedule_code_mon, schedule_code_mon_with_vigil, schedule_code_mon_vigil,
        schedule_code_tue, schedule_code_tue_with_vigil, schedule_code_tue_vigil,
        schedule_code_wed, schedule_code_wed_with_vigil, schedule_code_wed_vigil,
        schedule_code_thu, schedule_code_thu_with_vigil, schedule_code_thu_vigil,
        schedule_code_fri, schedule_code_fri_with_vigil, schedule_code_fri_vigil,
        schedule_code_sat, schedule_code_sat_with_vigil, schedule_code_sat_vigil,
        schedule_code_sun, schedule_code_sun_with_vigil, schedule_code_sun_vigil
    ) VALUES ('Christmas', 'christmas',
        'christmas', 'christmas', null,
        'christmas', 'christmas', null,
        'christmas', 'christmas', null,
        'christmas', 'christmas', null,
        'christmas', 'christmas', null,
        'christmas', 'christmas', null,
        'christmas', 'christmas', null
    );

INSERT INTO service_patterns (name, code,
        schedule_code_mon, schedule_code_mon_with_vigil, schedule_code_mon_vigil,
        schedule_code_tue, schedule_code_tue_with_vigil, schedule_code_tue_vigil,
        schedule_code_wed, schedule_code_wed_with_vigil, schedule_code_wed_vigil,
        schedule_code_thu, schedule_code_thu_with_vigil, schedule_code_thu_vigil,
        schedule_code_fri, schedule_code_fri_with_vigil, schedule_code_fri_vigil,
        schedule_code_sat, schedule_code_sat_with_vigil, schedule_code_sat_vigil,
        schedule_code_sun, schedule_code_sun_with_vigil, schedule_code_sun_vigil
    ) VALUES ('Christmas Eve', 'christmas-eve',
        null, null, 'christmas-eve',
        null, null, 'christmas-eve',
        null, null, 'christmas-eve',
        null, null, 'christmas-eve',
        null, null, 'christmas-eve',
        null, null, 'christmas-eve',
        null, null, 'christmas-eve'
    );

INSERT INTO service_patterns (name, code,
        schedule_code_mon, schedule_code_mon_with_vigil, schedule_code_mon_vigil,
        schedule_code_tue, schedule_code_tue_with_vigil, schedule_code_tue_vigil,
        schedule_code_wed, schedule_code_wed_with_vigil, schedule_code_wed_vigil,
        schedule_code_thu, schedule_code_thu_with_vigil, schedule_code_thu_vigil,
        schedule_code_fri, schedule_code_fri_with_vigil, schedule_code_fri_vigil,
        schedule_code_sat, schedule_code_sat_with_vigil, schedule_code_sat_vigil,
        schedule_code_sun, schedule_code_sun_with_vigil, schedule_code_sun_vigil
    ) VALUES ('Without Prayers', 'without-prayers',
        'weekday-no-prayers', null, null,
        'weekday-no-prayers', null, null,
        'weekday-no-prayers', null, null,
        'thursday-no-prayers', null, null,
        'weekday-no-prayers', null, null,
        'saturday-no-confessions', null, null,
        null, null, null
    );

INSERT INTO service_patterns (name, code,
        schedule_code_mon, schedule_code_mon_with_vigil, schedule_code_mon_vigil,
        schedule_code_tue, schedule_code_tue_with_vigil, schedule_code_tue_vigil,
        schedule_code_wed, schedule_code_wed_with_vigil, schedule_code_wed_vigil,
        schedule_code_thu, schedule_code_thu_with_vigil, schedule_code_thu_vigil,
        schedule_code_fri, schedule_code_fri_with_vigil, schedule_code_fri_vigil,
        schedule_code_sat, schedule_code_sat_with_vigil, schedule_code_sat_vigil,
        schedule_code_sun, schedule_code_sun_with_vigil, schedule_code_sun_vigil
    ) VALUES ('Easter Eve', 'easter-eve',
        null, null, null,
        null, null, null,
        null, null, null,
        null, null, null,
        null, null, null,
        null, null, 'easter-vigil',
        null, null, null
    );

INSERT INTO service_patterns (name, code,
        schedule_code_mon, schedule_code_mon_with_vigil, schedule_code_mon_vigil,
        schedule_code_tue, schedule_code_tue_with_vigil, schedule_code_tue_vigil,
        schedule_code_wed, schedule_code_wed_with_vigil, schedule_code_wed_vigil,
        schedule_code_thu, schedule_code_thu_with_vigil, schedule_code_thu_vigil,
        schedule_code_fri, schedule_code_fri_with_vigil, schedule_code_fri_vigil,
        schedule_code_sat, schedule_code_sat_with_vigil, schedule_code_sat_vigil,
        schedule_code_sun, schedule_code_sun_with_vigil, schedule_code_sun_vigil
    ) VALUES ('Easter Day', 'easter',
        null, null, null,
        null, null, null,
        null, null, null,
        null, null, null,
        null, null, null,
        null, null, null,
        'easter-day', null, null
    );

-- 2016:
-- Mass 7:00 AM
-- Mass 8:00 AM
-- Sung Mass 12:10 PM
-- Solemn Mass 6:00 PM
-- 
-- title 2008-2016:
-- Ash Wednesday
-- 
-- title 2004-2007:
-- The First Day of Lent: Ash Wednesday
-- 
-- services 2013-2015:
-- Mass 7:00 AM
-- Mass 8:00 AM
-- Sung Mass 12:10 PM
-- Solemn Mass 6:00 PM
-- 
-- services 2007-2012:
-- Mass 7:00 AM
-- Mass 8:00 AM
-- Noonday Prayer 12:00 PM
-- Sung Mass 12:10 PM
-- Solemn Mass 6:00 PM
-- 
-- services 2004-2006:
-- Said Mass 7:00 AM
-- Said Mass 8:00 AM
-- Sung Mass 12:10 PM
-- Solemn Mass 6:00 PM
-- 
-- notes 2004-2007:
-- Fast & Abstinence 
-- Ashes are offered from 7:00 AM to 8:00 PM.
-- Weekdays in Lent are observed by special acts of discipline and self-denial.
-- Fridays of Lent are observed by abstinence from flesh meats.
-- 
-- notes 2008-2009:
-- Ashes will be offered throughout the day from 7:00 AM to 8:00 PM.
-- 
-- notes 2010:
-- Imposition of Ashes will be offered throughout the day from 7:00 AM to 8:00 PM.
-- 
-- notes 2011-2012:
-- Fast and Abstinence
-- Imposition of Ashes will be offered throughout the day from 7:00 AM to 8:00 PM.
-- 
-- notes 2013-2015:
-- Fast and Abstinence
-- Imposition of Ashes will be offered throughout the day from 7:00 AM to 8:00 PM.
-- The Daily Office is not offered on this day.
-- 
-- notes 2016:
-- Fast and Abstinence
-- Imposition of Ashes will be offered throughout the day from 7:00 AM to 8:00 PM.
-- The Daily Office is not prayed publicly on this day.

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
    algorithm text NOT NULL,
    arg1 text,
    arg2 text,
    arg3 text,
    arg4 text,
    weekday_precedence integer NOT NULL,
    has_rose_sunday boolean NOT NULL,
    has_last_sunday boolean NOT NULL DEFAULT FALSE,
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

--
-- Define observances: fixed feasts
--

CREATE TABLE fixed_feasts (
    fixed_id serial,
    name text NOT NULL,
    code text,
    otype_id integer NOT NULL,
    month integer NOT NULL,
    day integer NOT NULL,
    schedule_pattern text,
    has_eve boolean NOT NULL DEFAULT FALSE,
    eve_schedule_pattern text,
    eve_name text,
    color text,
    note text,
    valid_start timestamp with time zone NULL,
    valid_end timestamp with time zone NULL,
    CONSTRAINT fixed_feasts_pk PRIMARY KEY (fixed_id),
    CONSTRAINT fixed_feasts_otype_fk FOREIGN KEY (otype_id)
        REFERENCES observance_types (otype_id)
        ON DELETE RESTRICT ON UPDATE NO ACTION
);

CREATE INDEX fixed_feasts_month_idx ON fixed_feasts (month);
CREATE INDEX fixed_feasts_date_idx ON fixed_feasts (month, day);

-- January
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('The Holy Name of Our Lord Jesus Christ', 3, 1, 1, 'gold');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('The Epiphany of Our Lord Jesus Christ', 1, 1, 6, 'solemn-fixed-feast', true, 'solemn-fixed-feast-eve', 'gold');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('William Laud, Archbishop of Canterbury, 1645', 4, 1, 10, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Aelred, Abbot of Rievaulx, 1167', 4, 1, 12, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Hilary, Bishop of Poitiers, 367', 4, 1, 13, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Antony, Abbot in Egypt, 356', 4, 1, 17, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('The Confession of Saint Peter the Apostle', 3, 1, 18, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Wulfstan, Bishop of Worcester, 1095', 4, 1, 19, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Fabian, Bishop and Martyr of Rome, 250', 4, 1, 20, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Agnes, Martyr at Rome, 304', 4, 1, 21, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Vincent, Deacon of Saragossa, and Martyr, 304', 4, 1, 22, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('The Conversion of Saint Paul the Apostle', 3, 1, 25, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Timothy and Titus, Companions of Saint Paul', 4, 1, 26, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Thomas Aquinas, Priest and Friar, 1274', 4, 1, 28, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Charles, King and Martyr, 1649', 4, 1, 30, 'red');

-- February
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Brigid (Bride), 523', 4, 2, 1, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('The Presentation of Our Lord Jesus Christ in the Temple', 2, 2, 2, 'candlemas', true, 'candlemas-eve', 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, color) VALUES ('Blase, Bishop and Martyr, c. 316', 4, 2, 3, 'blase', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_end) VALUES ('Cornelius the Centurion', 4, 2, 4, 'white', '2010-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Anskar, Archbishop of Hamburg, Missionary to Denmark and Sweden, 865', 4, 2, 4, 'white', '2011-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('The Martyrs of Japan, 1597', 4, 2, 5, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Cornelius the Centurion', 4, 2, 7, 'white', '2011-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Scholastica, Religious, 542', 4, 2, 10, 'white', '2007-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Absalom Jones, Priest, 1818', 4, 2, 13, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Cyril, Monk, and Methodius, Bishop, Missionaries to the Slavs, 869, 885', 4, 2, 14, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Thomas Bray, Priest and Missionary, 1730', 4, 2, 15, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Polycarp, Bishop and Martyr of Smyrna, 156', 4, 2, 23, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint Matthias the Apostle', 3, 2, 24, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'red');

-- March

INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint Joseph', 3, 3, 19, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color, valid_end) VALUES ('The Annunciation of Our Lord Jesus Christ', 2, 3, 25, 'solemn-fixed-feast', true, 'solemn-fixed-feast-eve', 'blue', '2013-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color, valid_start) VALUES ('The Annunciation of Our Lord Jesus Christ', 2, 3, 25, 'solemn-fixed-feast', true, 'solemn-fixed-feast-eve', 'gold', '2014-01-01 00:00:00' AT TIME ZONE 'America/New_York');

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
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint Mark the Evangelist', 3, 4, 25, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Catherine of Siena, 1380', 4, 4, 29, 'white');

-- May

INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint Philip and Saint James, Apostles', 3, 5, 1, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Athanasius, Bishop of Alexandria, 373', 4, 5, 2, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Monnica, Mother of Augustine of Hippo, 387', 4, 5, 4, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Dame Julian of Norwich, c. 1417', 4, 5, 8, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Gregory of Nazianzus, Bishop of Constantinople, 389', 4, 5, 9, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Dunstan, Archbishop of Canterbury, 988', 4, 5, 19, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Alcuin, Deacon, and Abbot of Tours, 804', 4, 5, 20, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Jackson Kemper, First Missionary Bishop in the United States, 1870', 4, 5, 24, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Bede, the Venerable, Priest, and Monk of Jarrow, 735', 4, 5, 25, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Augustine, First Archbishop of Canterbury, 605', 4, 5, 26, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('The Visitation of the Blessed Virgin Mary', 3, 5, 31, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'white');

-- June

INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Justin, Martyr at Rome, c. 167', 4, 6, 1, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('The Martyrs of Lyons, 177', 4, 6, 2, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('The Martyrs of Uganda, 1886', 4, 6, 3, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Boniface, Archbishop of Mainz, Missionary to Germany, and Martyr, 754', 4, 6, 5, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Columba, Abbot of Iona, 597', 4, 6, 9, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Ephrem of Edessa, Syria, Deacon, 373', 4, 6, 10, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint Barnabas the Apostle', 3, 6, 11, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Basil the Great, Bishop of Caesarea, 379', 4, 6, 14, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Joseph Butler, Bishop of Durham, 1752', 4, 6, 16, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_end) VALUES ('Bernard Mizeki, Catechist and Martyr in Rhodesia, 1896', 4, 6, 18, 'red', '2011-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Bernard Mizeki, Catechist and Martyr in Mashonaland, 1896', 4, 6, 18, 'red', '2012-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Alban, First Martyr of Britain, c. 304', 4, 6, 22, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('The Nativity of Saint John the Baptist', 3, 6, 24, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Cyril, Patriarch of Alexandria, 444', 4, 6, 27, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Irenaeus, Bishop of Lyons and Martyr, c. 202', 4, 6, 28, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint Peter and Saint Paul, Apostles', 3, 6, 29, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'red');

-- July

INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Independence Day', 4, 7, 4, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Jan Hus, Prophetic Witness and Martyr, 1415', 4, 7, 6, 'red', '2012-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Benedict of Nursia, Abbot of Monte Casino, c. 540', 4, 7, 11, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Bonaventure, Bishop and Friar, 1274', 4, 7, 15, 'white', '2005-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('William White, Bishop of Pennsylvania, 1836', 4, 7, 17, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Macrina, Monastic and Teacher, 379', 4, 7, 19, 'white', '2012-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint Mary Magdalene', 3, 7, 22, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Thomas a Kempis, Priest, 1471', 4, 7, 24, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint James the Apostle', 3, 7, 25, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Parents of the Blessed Virgin Mary', 4, 7, 26, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('William Reed Huntington, Priest, 1909', 4, 7, 27, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Mary and Martha of Bethany', 4, 7, 29, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('William Wilberforce, 1833', 4, 7, 30, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_end) VALUES ('Ignatius of Loyola, Priest and Monastic, 1556', 4, 7, 31, 'white', '2011-12-31 23:59:59' AT TIME ZONE 'America/New_York');

-- August

INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Joseph of Arimathaea', 4, 8, 1, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('The Transfiguration of Our Lord Jesus Christ', 1, 8, 6, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'gold');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('John Mason Neale, Priest, 1866', 4, 8, 7, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Dominic, Priest and Friar, 1221', 4, 8, 8, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Lawrence, Deacon, and Martyr at Rome, 258', 4, 8, 10, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Clare, Abbess at Assisi, 1253', 4, 8, 11, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Florence Nightingale, Nurse, Social Reformer, 1910', 4, 8, 12, 'white', '2012-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Jeremy Taylor, Bishop of Down, Connor, and Dromore, 1667', 4, 8, 13, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Jonathan Myrick Daniels, Seminarian and Witness for Civil Rights, 1965', 4, 8, 14, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color, valid_end) VALUES ('The Assumption of the Blessed Virgin Mary', 3, 8, 15, 'assumption', true, 'assumption-eve', 'white', '2010-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color, valid_start) VALUES ('The Assumption of the Blessed Virgin Mary', 3, 8, 15, 'assumption', true, 'assumption-eve', 'gold', '2011-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Bernard, Abbot of Clairvaux, 1153', 4, 8, 20, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint Bartholomew the Apostle', 3, 8, 24, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Louis, King of France, 1270', 4, 8, 25, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Thomas Gallaudet, Priest, 1902, with Henry Winter Syle, Priest, 1890, Missioners to the Deaf', 4, 8, 27, 'white', '2012-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Augustine, Bishop of Hippo, 430', 4, 8, 28, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('The Beheading of Saint John the Baptist', 4, 8, 29, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Aidan, Bishop of Lindisfarne, 651', 4, 8, 31, 'white');

-- September

INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('The Martyrs of New Guinea, 1942', 4, 9, 2, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('The Nativity of the Blessed Virgin Mary', 3, 9, 8, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Constance, Nun, and her Companions, 1878', 4, 9, 9, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Alexander Crummel, 1898', 4, 9, 10, 'white', '2010-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Requiem for the Victims of September 11, 2011', 4, 9, 11, 'black', '2009-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, color, valid_end) VALUES ('Parish Requiem: Victims of September 11, 2011', 4, 9, 11, 'parish-requiem', 'purple', '2008-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('John Henry Hobart, Bishop of New York, 1830', 4, 9, 12, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('John Chrysostom, Bishop of Constantinople, 407', 4, 9, 13, 'white', '2011-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_end) VALUES ('Cyprian, Bishop and Martyr of Carthage, 258', 4, 9, 13, 'red', '2010-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color, valid_start) VALUES ('Holy Cross Day', 2, 9, 14, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'red', '2010-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color, valid_end) VALUES ('Holy Cross Day', 2, 9, 14, 'solemn-fixed-feast', true, 'solemn-fixed-feast-eve', 'red', '2009-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Cyprian, Bishop and Martyr of Carthage, 258', 4, 9, 15, 'red', '2011-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Ninian, Bishop in Galloway, c. 430', 4, 9, 16, 'white', '2005-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start, valid_end) VALUES ('Hildegard of Bingen, 1170', 4, 9, 17, 'white', '2009-01-01 00:00:00' AT TIME ZONE 'America/New_York', '2009-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Edward Bouverie Pusey, Priest, 1882', 4, 9, 18, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Theodore of Tarsus, Archbishop of Canterbury, 690', 4, 9, 19, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('John Coleridge Patteson, Bishop of Melanesia, and his Companions, Martyrs, 1871', 4, 9, 20, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint Matthew, Apostle and Evangelist', 3, 9, 21, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Sergius, Abbot of Holy Trinity, Moscow, 1392', 4, 9, 25, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Lancelot Andrewes, Bishop of Winchester, 1626', 4, 9, 26, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint Michael and All Angels', 2, 9, 29, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'white');
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
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint Luke the Evangelist', 3, 10, 18, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Henry Martyn, Priest and Missionary to India and Persia, 1812', 4, 10, 19, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint James of Jerusalem, Brother of Our Lord Jesus Christ, and Martyr, c. 62', 4, 10, 23, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Alfred the Great, King of the West Saxons, 899', 4, 10, 26, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint Simon and Saint Jude, Apostles', 3, 10, 28, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('James Hannington, Bishop of Eastern Equatorial Africa, and his Companions, Martyrs, 1885', 4, 10, 29, 'red');

-- November

INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color, valid_end) VALUES ('All Saints', 1, 11, 1, 'solemn-fixed-feast', true, 'solemn-fixed-feast-eve', 'white', '2009-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color, valid_start) VALUES ('All Saints', 1, 11, 1, 'solemn-fixed-feast', true, 'solemn-fixed-feast-eve', 'gold', '2010-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, color) VALUES ('All Souls Day', 3, 11, 2, 'all-souls', 'black');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start, valid_end) VALUES ('Richard Hooker, Priest, 1600', 4, 11, 3, 'white', '2007-01-01 00:00:00' AT TIME ZONE 'America/New_York', '2012-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Willibrord, Archbishop of Utrecht, Missionary to Frisia, 739', 4, 11, 7, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Leo the Great, Bishop of Rome, 461', 4, 11, 10, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Martin, Bishop of Tours, 397', 4, 11, 11, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Charles Simeon, Priest, 1836', 4, 11, 12, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Samuel Seabury, First American Bishop, 1796', 4, 11, 14, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Margaret, Queen of Scotland, 1093', 4, 11, 16, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Hugh, Bishop of Lincoln, 1200', 4, 11, 17, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Hilda, Abbess of Whitby, 680', 4, 11, 18, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Elizabeth, Princess of Hungary, 1231', 4, 11, 19, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Edmund, King of East Anglia, Martyr, 870', 4, 11, 20, 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start, valid_end) VALUES ('Cecilia, Virgin and Martyr, c. 117', 4, 11, 22, 'red', '2005-01-01 00:00:00' AT TIME ZONE 'America/New_York', '2008-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Clement, Bishop of Rome, c. 100', 4, 11, 23, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('James Otis Sargent Huntington, Priest and Monk, 1935', 4, 11, 25, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Kamehameha and Emma, King and Queen of Hawaii, 1864, 1885', 4, 11, 28, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint Andrew the Apostle', 4, 11, 30, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'red');

-- December

INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Nicholas Ferrar, Deacon, 1637', 4, 12, 1, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('John of Damascus, Priest, c. 760', 4, 12, 4, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Clement of Alexandria, Priest, c. 210', 4, 12, 5, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Nicholas, Bishop of Myra, c. 342', 4, 12, 6, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Ambrose, Bishop of Milan, 397', 4, 12, 7, 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color, valid_start) VALUES ('The Conception of the Blessed Virgin Mary', 3, 12, 8, 'solemn-fixed-feast', true, 'solemn-fixed-feast-eve', 'gold', '2012-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color, valid_start, valid_end) VALUES ('The Conception of the Blessed Virgin Mary', 3, 12, 8, 'solemn-fixed-feast', true, 'solemn-fixed-feast-eve', 'white', '2011-01-01 00:00:00' AT TIME ZONE 'America/New_York', '2011-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color, valid_start, valid_end) VALUES ('The Immaculate Conception of the Blessed Virgin Mary', 3, 12, 8, 'solemn-fixed-feast', true, 'solemn-fixed-feast-eve', 'white', '2008-01-01 00:00:00' AT TIME ZONE 'America/New_York', '2010-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color, valid_end) VALUES ('The Immaculate Conception', 3, 12, 8, 'solemn-fixed-feast', true, 'solemn-fixed-feast-eve', 'white', '2007-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Anniversary of the Dedication of the Church, 1895', 2, 12, 12, 'gold', '2012-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, has_eve, eve_schedule_pattern, color, valid_start, valid_end) VALUES ('Anniversary of the Consecration of the Church, 1895', 2, 12, 12, true, 'fixed-feast-eve', 'white', '2009-01-01 00:00:00' AT TIME ZONE 'America/New_York', '2011-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, has_eve, eve_schedule_pattern, color, valid_end) VALUES ('Anniversary of the Dedication of the Church, 1895', 2, 12, 12, true, 'fixed-feast-eve', 'white', '2008-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start, valid_end) VALUES ('Lucy, Virgin and Martyr, c. 304', 4, 12, 13, 'red', '2005-01-01 00:00:00' AT TIME ZONE 'America/New_York', '2010-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start) VALUES ('Lucy, Martyr at Syracuse, 304', 4, 12, 13, 'red', '2011-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, color, valid_start, valid_end) VALUES ('John of the Cross, Priest, 1591', 4, 12, 14, 'white', '2007-01-01 00:00:00' AT TIME ZONE 'America/New_York', '2009-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, color) VALUES ('Saint Thomas the Apostle', 3, 12, 21, 'major-fixed-feast', true, 'major-fixed-feast-eve', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, eve_name, color, note, valid_start) VALUES ('The Nativity of Our Lord Jesus Christ: Christmas Day', 1, 12, 25, 'christmas', true, 'christmas-eve', 'Eve of the Nativity of our Lord Jesus Christ: Christmas Eve', 'gold', 'The church opens at 10:00 AM today and closes at 2:00 PM.', '2010-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, has_eve, eve_schedule_pattern, eve_name, color, note, valid_end) VALUES ('The Nativity of Our Lord Jesus Christ: Christmas Day', 1, 12, 25, 'christmas', true, 'christmas-eve', 'Eve of the Nativity of our Lord Jesus Christ: Christmas Eve', 'white', 'The church opens at 10:00 AM today and closes at 2:00 PM.', '2009-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, color, valid_start) VALUES ('Saint Stephen, Deacon and Martyr', 3, 12, 26, 'without-prayers', 'red', '2009-01-01 00:00:00' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, color, valid_end) VALUES ('Saint Stephen, Deacon and Martyr', 3, 12, 26, 'weekday-feast', 'red', '2008-12-31 23:59:59' AT TIME ZONE 'America/New_York');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, color) VALUES ('Saint John, Apostle and Evangelist', 3, 12, 27, 'weekday-feast', 'white');
INSERT INTO fixed_feasts (name, otype_id, month, day, schedule_pattern, color) VALUES ('The Holy Innocents', 3, 12, 28, 'weekday-feast', 'red');
INSERT INTO fixed_feasts (name, otype_id, month, day, color) VALUES ('Thomas Becket, 1170', 4, 12, 29, 'red');

--
-- Define observances: moveable feasts
--

CREATE TABLE moveable_feasts (
    moveable_id serial,
    name text NOT NULL,
    code text NOT NULL,
    otype_id integer NOT NULL,
    placement_index integer,
    algorithm text NOT NULL,
    arg1 text,
    arg2 text,
    arg3 text,
    arg4 text,
    schedule_pattern text,
    has_eve boolean NOT NULL DEFAULT FALSE,
    eve_schedule_pattern text,
    eve_name text,
    color text,
    note text,
    valid_start timestamp with time zone NULL,
    valid_end timestamp with time zone NULL,
    CONSTRAINT moveable_feasts_pk PRIMARY KEY (moveable_id),
    CONSTRAINT moveable_feasts_otype_fk FOREIGN KEY (otype_id)
        REFERENCES observance_types (otype_id)
        ON DELETE RESTRICT ON UPDATE NO ACTION
);

CREATE INDEX moveable_feasts_code_idx ON moveable_feasts (code);
CREATE INDEX moveable_feasts_placement_idx ON moveable_feasts (placement_index);

INSERT INTO moveable_feasts (name, code, otype_id, placement_index, algorithm,
        schedule_pattern, has_eve, eve_schedule_pattern, eve_name, color,
        valid_start)
    VALUES ('Easter Day', 'easter', 1, 1, 1, 'easter',
        'easter', true, 'easter-eve', 'Easter Eve', 'gold',
        '2011-01-01 00:00:00' AT TIME ZONE 'America/New_York');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index, algorithm,
        schedule_pattern, has_eve, eve_schedule_pattern, eve_name, color,
        valid_end)
    VALUES ('The Sunday of the Resurrection: Easter Day', 'easter', 1, 1, 1, 'easter',
        'easter', true, 'easter-eve', 'Easter Eve', 'white',
        '2010-12-31 23:59:59' AT TIME ZONE 'America/New_York');

-- TODO: Remaining moveable feasts

-- INSERT INTO moveable_feasts (name, code, otype_id, placement_index,
--         algorithm, arg1, arg2, schedule_pattern, color)
--     VALUES ('Ash Wednesday', 'ash-wednesday', 1, 1, 1,
--         'days_before', 'easter', 40, 'ash-wednesday', 'purple');

-- Ash Wednesday
-- Good Friday
-- Ascension Day
-- Day of Pentecost
-- Trinity Sunday
-- Corpus Christi
-- Thanksgiving Day
-- "Of Our Lady" Saturdays
-- The First Book of Common Prayer, 1549
-- Dedication of the Church (old timing)


-- todo: movable notes
-- in January: 'Birthday of Martin Luther King, Jr. – Federal Holiday Schedule<br />The church opens today at 10:00 AM and closes at 2:00 PM.'
-- in February: 'Washington’s Birthday – Federal Holiday Schedule<br />The church opens today at 10:00 AM and closes at 2:00 PM.'
-- in May: 'Memorial Day – Federal Holiday Schedule<br />The church opens today at 10:00 AM and closes at 2:00 PM.'
-- in July: 'Federal Holiday Schedule<br />The church opens today at 10:00 AM and closes at 2:00 PM.' (for Independence Day or the closest weekday)
-- in September: 'Labor Day – Federal Holiday Schedule<br />The church opens today at 10:00 AM and closes at 2:00 PM.'
-- in October: 'Columbus Day – Federal Holiday Schedule<br />The church opens today at 10:00 AM and closes at 2:00 PM.'

-- todo: remember
-- Major Feasts in Holy Week or Easter Week transfer all the way to the following Monday (and Tuesday, if both Saint Joseph and Annunciation fall within)
-- Federal Holidays have notes and a schedule (church open 10-2)

-- todo: answered questions:
-- How do the days marked "Of Our Lady" work? There seems to be roughly one a month, but I don't know what the pattern is.
    -- Saturdays the would otherwise be green, during a green season, become Of Our Lady
    -- This used to be true year-round
    -- Stopped in 2013 (year-round through 2012)
-- Is the change from white to gold for Annunciation an intentional change or a mistake that got carried from the previous year's transfer?
    -- YES, this is correct
-- The list of Commemorations needs confirmation, as there are some important variations from the Episcopal calendars I've found (e.g. http://satucket.com/lectionary/Calendar.htm)
    -- Will review
-- If a major feast falls on a Saturday in Lent, what happens to Stations of the Cross?
    -- Omitted for a solemn mass; mass is dropped for regular feasts
-- How is the date of "The First Book of Common Prayer, 1549" determined?
    -- First free weekday after Pentecost for which there's no other commemoration
-- Do we celebrate Sacred Heart (19 days after Pentecost) anymore?  It appears through 2008.
    -- Officially done with that
-- Was Ignatius of Loyola dropped from the calendar intentionally?
    -- Yes, but Fr. Smith sometimes does it anyway
-- Confirm that The Nativity of the Blessed Virgin Mary doesn't get transferred from Sunday, despite otherwise looking like a level 3
    -- Correctly, it would be transferred as usual

-- todo: suggestions
-- July 18 [Bartolomé de las Casas, Friar and Missionary to the Indies, 1566] - WE SHOULD DO THIS: http://theoatmeal.com/comics/columbus_day

-- todo: ask for clarification
-- Confirm that Hildegard was meant to be a breif blip on the schedule
-- Is there a Healing Mass on a feast day (level 3) at 12:10? At 6:20?
-- Confirm that Saint Michael and All Angels *and* Holy Cross are level 2s but have a level 3 service schedule
-- Ditto for Transfiguration, only that it's a level 1
-- Are there season-based schedule pattern adjustments?
-- Should I standardize the shifting names of Immaculate Conception and the Dedication of the Church? (if so, we just have one color change, not three name changes)
-- Need more info on how the Dedication of the Church works, as its description in LF&F is similar to a level 2, but we don't seem to treat it quite that way

-- todo: by-year overrides
-- Candlemas
-- Assumption
-- 9/11 Requiem
-- Willibrord, Archbishop of Utrecht, Missionary to Frisia, 739 missing in 2006
-- Anniversary of the Dedication of the Church sometimes has an eve and occasionally a nonstandard Mass

-- rambler down

DROP TABLE moveable_feasts;
DROP TABLE fixed_feasts;
DROP TABLE liturigal_seasons;
DROP TABLE observance_types;
DROP TABLE service_patterns;
DROP TABLE schedule_services;
DROP TABLE services;
DROP TABLE schedules;

