
-- rambler up

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

INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Weekday Basic', 'weekday', NOW(), true); -- 1
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Thursday Basic', 'thursday', NOW(), true); -- 2
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Saturday Basic', 'saturday', NOW(), true); -- 3
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Saturday Vigil Basic', 'vigil', NOW(), true); -- 4
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Sunday Basic', 'sunday', NOW(), true); -- 5
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Summer Sunday Basic', 'summer-sunday', NOW(), true); -- 6
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('E&B Only', 'eb-only', NOW(), true); -- 7
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Evensong Only', 'es-only', NOW(), true); -- 8
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Evening Prayer Only', 'ep-only', NOW(), true); -- 9
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Weekday Feast', 'weekday-feast', NOW(), true); -- 10
INSERT INTO schedules (name, code, valid_start, is_default) VALUES ('Solumn Weekday Feast', 'solumn-weekday-feast', NOW(), true); -- 10

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
INSERT INTO services (name, start_time, is_default) VALUES ('Solumn Mass', '11:00:00', true); -- 13
INSERT INTO services (name, start_time, is_default) VALUES ('Organ Recital', '16:40:00', true); -- 14
INSERT INTO services (name, start_time, is_default) VALUES ('Solumn Evensong & Benediction', '17:00:00', true); -- 15
INSERT INTO services (name, start_time, is_default) VALUES ('Solumn Evensong & Benediction', '18:00:00', false); -- 16
INSERT INTO services (name, start_time, is_default) VALUES ('Solumn Evensong', '18:00:00', false); -- 17
INSERT INTO services (name, start_time, is_default) VALUES ('Sung Mass', '12:10:00', true); -- 18
INSERT INTO services (name, start_time, is_default) VALUES ('Organ Recital', '17:30:00', true); -- 19
INSERT INTO services (name, start_time, is_default) VALUES ('Mass', '18:20:00', true); -- 20
INSERT INTO services (name, start_time, is_default) VALUES ('Solumn Mass', '18:00:00', true); -- 21

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
INSERT INTO schedule_services (schedule_id, service_id) VALUES (11, 10); -- solumn-weekday-feast
INSERT INTO schedule_services (schedule_id, service_id) VALUES (11, 2); -- solumn-weekday-feast
INSERT INTO schedule_services (schedule_id, service_id) VALUES (11, 18); -- solumn-weekday-feast
INSERT INTO schedule_services (schedule_id, service_id) VALUES (11, 19); -- solumn-weekday-feast
INSERT INTO schedule_services (schedule_id, service_id) VALUES (11, 21); -- solumn-weekday-feast

CREATE TABLE fixed_feasts (
    fixed_id serial,
    name text NOT NULL,
    month integer NOT NULL,
    day integer NOT NULL,
    is_vigil boolean NOT NULL DEFAULT FALSE,
    schedule_code text,
    color text,
    note text,
    CONSTRAINT fixed_feasts_pk PRIMARY KEY (fixed_id)
);

CREATE INDEX fixed_feasts_month_idx ON fixed_feasts (month);
CREATE INDEX fixed_feasts_date_idx ON fixed_feasts (month, day);

-- January
INSERT INTO fixed_feasts (name, month, day, color) VALUES ('The Holy Name of Our Lord Jesus Christ', 1, 1, 'gold');
INSERT INTO fixed_feasts (name, month, day, is_vigil, schedule_code, color) VALUES ('Eve of the Epiphany of Our Lord Jesus Christ', 1, 5, true, 'es-only', 'gold');
INSERT INTO fixed_feasts (name, month, day, schedule_code, color) VALUES ('The Epiphany of Our Lord Jesus Christ', 1, 6, 'solumn-weekday-feast', 'gold');
INSERT INTO fixed_feasts (name, month, day) VALUES ('Harriet Bedell, Deaconess and Misisonary, 1969', 1, 8);
INSERT INTO fixed_feasts (name, month, day) VALUES ('Julia Chester Emery, 1922', 1, 9);
INSERT INTO fixed_feasts (name, month, day, color) VALUES ('William Laud, Archbishop of Canterbury, 1645', 1, 10, 'red');
INSERT INTO fixed_feasts (name, month, day, color) VALUES ('Aelred, Abbot of Rievaulx, 1167', 1, 12, 'white');
INSERT INTO fixed_feasts (name, month, day, color) VALUES ('Hilary, Bishop of Poitiers, 367', 1, 13, 'white');
INSERT INTO fixed_feasts (name, month, day, color) VALUES ('Antony, Abbot in Egypt, 356', 1, 17, 'white');
INSERT INTO fixed_feasts (name, month, day, is_vigil, color) VALUES ('Eve of the Confession of Saint Peter the Apostle', 1, 17, true, 'ep-only', 'white');
INSERT INTO fixed_feasts (name, month, day, schedule_code, color) VALUES ('The Confession of Saint Peter the Apostle', 1, 18, 'weekday-feast', 'white');
INSERT INTO fixed_feasts (name, month, day, color) VALUES ('Wulfstan, Bishop of Worcester, 1095', 1, 19, 'white');
INSERT INTO fixed_feasts (name, month, day, color) VALUES ('Fabian, Bishop and Martyr of Rome, 250', 1, 20, 'red');
INSERT INTO fixed_feasts (name, month, day, color) VALUES ('Agnes, Martyr at Rome, 304', 1, 21, 'red');
INSERT INTO fixed_feasts (name, month, day, color) VALUES ('Vincent, Deacon of Saragossa, and Martyr, 304', 1, 22, 'red');
INSERT INTO fixed_feasts (name, month, day, is_vigil, schedule_code, color) VALUES ('Eve of the Conversion of Saint Paul the Apostle', 1, 24, 'ep-only', 'white');
INSERT INTO fixed_feasts (name, month, day, schedule_code, color) VALUES ('The Conversion of Saint Paul the Apostle', 1, 25, 'weekday-feast', 'white');
INSERT INTO fixed_feasts (name, month, day, color) VALUES ('Timothy and Titus, Companions of Saint Paul', 1, 26, 'white');
INSERT INTO fixed_feasts (name, month, day, color) VALUES ('Thomas Aquinas, Priest and Friar, 1274', 1, 28, 'white');
INSERT INTO fixed_feasts (name, month, day, color) VALUES ('Charles, King and Martyr, 1649', 1, 30, 'red');

-- TODO: February
INSERT INTO fixed_feasts (name, month, day) VALUES ('Brigid, Abbess at Kildare, 523', 2, 1);
INSERT INTO fixed_feasts (name, month, day) VALUES ('The Presentation of Our Lord Jesus Christ in the Temple', 2, 2);
INSERT INTO fixed_feasts (name, month, day) VALUES ('[The Dorchester Chaplains: Lieutenant George Fox, Lieutenant Alexander D.  Goode, Lieutenant Clark V. Poling and Lieutenant John P. Washington, 1943]', 2, 3);
INSERT INTO fixed_feasts (name, month, day) VALUES ('Anskar, Archbishop of Hamburg, Missionary to Denmark and Sweden, 865 (new date)', 2, 4);
INSERT INTO fixed_feasts (name, month, day) VALUES ('[Roger Williams, 1683, and Anne Hutchinson, 1643, Prophetic Witnesses]', 2, 5);
INSERT INTO fixed_feasts (name, month, day) VALUES ('The Martyrs of Japan, 1597 (new date)', 2, 6);
INSERT INTO fixed_feasts (name, month, day) VALUES ('Cornelius the Centurion (new date)', 2, 7);
INSERT INTO fixed_feasts (name, month, day) VALUES ('[Frances Jane (Fanny) Van Alstyne Crosby, Hymnwriter, 1915]', 2, 11);
INSERT INTO fixed_feasts (name, month, day) VALUES ('[Charles Freer Andrews, Priest and “Friend of the Poor” in India, 1940]', 2, 12);
INSERT INTO fixed_feasts (name, month, day) VALUES ('Absalom Jones, Priest, 1818', 2, 13);
INSERT INTO fixed_feasts (name, month, day) VALUES ('Cyril, Monk, and Methodius, Bishop, Missionaries to the Slavs, 869, 885', 2, 14);
INSERT INTO fixed_feasts (name, month, day) VALUES ('Thomas Bray, Priest and Missionary, 1730', 2, 15);
INSERT INTO fixed_feasts (name, month, day) VALUES ('[Charles Todd Quintard, Bishop of Tennessee, 1898]', 2, 16);
INSERT INTO fixed_feasts (name, month, day) VALUES ('Janani Luwum, Archbishop of Uganda & Martyr, 1977', 2, 17);
INSERT INTO fixed_feasts (name, month, day) VALUES ('Martin Luther, 1546', 2, 18);
INSERT INTO fixed_feasts (name, month, day) VALUES ('[Frederick Douglass, Prophetic Witness, 1895]', 2, 20);
INSERT INTO fixed_feasts (name, month, day) VALUES ('[John Henry Newman, Priest and Theologian, 1890]', 2, 21);
INSERT INTO fixed_feasts (name, month, day) VALUES ('[Eric Liddell, Missionary to China, 1945]', 2, 22);
INSERT INTO fixed_feasts (name, month, day) VALUES ('Polycarp, Bishop and Martyr of Smyrna, 156', 2, 23);
INSERT INTO fixed_feasts (name, month, day) VALUES ('Saint Matthias the Apostle', 2, 24);
INSERT INTO fixed_feasts (name, month, day) VALUES ('[John Roberts, Priest, 1949]', 2, 25);
INSERT INTO fixed_feasts (name, month, day) VALUES ('[Emily Malbone Morgan, Prophetic Witness, 1937]', 2, 26);
INSERT INTO fixed_feasts (name, month, day) VALUES ('George Herbert, Priest, 1633', 2, 27);
INSERT INTO fixed_feasts (name, month, day) VALUES ('[Anna Julia Haywood Cooper, 1964, and Elizabeth Evelyn Wright, 1904, Educators]', 2, 28);


-- rambler down

DROP TABLE fixed_feasts;
DROP TABLE schedule_services;
DROP TABLE services;
DROP TABLE schedules;

