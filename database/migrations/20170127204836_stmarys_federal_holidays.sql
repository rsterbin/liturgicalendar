
-- rambler up

INSERT INTO federal_holidays (name, code,
        calculate_from, algorithm, distance, placement_index,
        open_time, close_time,
        note, skip_name
    ) VALUES (E'New Year\'s Day', 'new-years',
        '1/1', 'closest_weekday', 0, 1,
        '10:00:00', '14:00:00',
        'The church is open today from 10:00 AM to 2:00 PM.', true
    );

INSERT INTO federal_holidays (name, code,
        calculate_from, algorithm, distance, placement_index,
        open_time, close_time,
        note
    ) VALUES ('Martin Luther King', 'mlk',
        '1/1', 'nth_monday', 3, 2,
        '10:00:00', '14:00:00',
        'Federal holiday schedule: The Church opens today at 10:00 AM and closes at 2:00 PM.'
    );

INSERT INTO federal_holidays (name, code,
        calculate_from, algorithm, distance, placement_index,
        open_time, close_time,
        note
    ) VALUES (E'President\'s Day', 'presidents',
        '2/1', 'nth_monday', 3, 3,
        '10:00:00', '14:00:00',
        'Federal holiday schedule: The Church opens today at 10:00 AM and closes at 2:00 PM.'
    );

INSERT INTO federal_holidays (name, code,
        calculate_from, algorithm, distance, placement_index,
        open_time, close_time,
        note
    ) VALUES ('Memorial Day', 'memorial',
        '5/1', 'last_monday', 0, 4,
        '10:00:00', '14:00:00',
        'Federal holiday schedule: The Church opens today at 10:00 AM and closes at 2:00 PM.'
    );

INSERT INTO federal_holidays (name, code,
        calculate_from, algorithm, distance, placement_index,
        open_time, close_time,
        note, skip_name
    ) VALUES ('Independence Day', 'independence',
        '7/4', 'not_sunday', 0, 5,
        '10:00:00', '14:00:00',
        'Federal holiday schedule: The Church opens today at 10:00 AM and closes at 2:00 PM.', true
    );

INSERT INTO federal_holidays (name, code,
        calculate_from, algorithm, distance, placement_index,
        open_time, close_time,
        note
    ) VALUES ('Labor Day', 'labor',
        '9/1', 'nth_monday', 1, 6,
        '10:00:00', '14:00:00',
        'Federal holiday schedule: The Church opens today at 10:00 AM and closes at 2:00 PM.'
    );

INSERT INTO federal_holidays (name, code,
        calculate_from, algorithm, distance, placement_index,
        open_time, close_time,
        note, skip_name
    ) VALUES ('Thanksgiving Day', 'thanksgiving',
        '11/1', 'nth_thursday', 4, 7,
        '10:00:00', '14:00:00',
        'Federal holiday schedule: The Church opens today at 10:00 AM and closes at 2:00 PM.', true
    );

INSERT INTO federal_holidays (name, code,
        calculate_from, algorithm, distance, placement_index,
        close_time,
        note, skip_name
    ) VALUES (E'New Year\'s Eve', 'new-years-eve',
        '12/31', 'exact', 0, 8,
        '14:00:00',
        'The church closes today at 2:00 PM because of the New Year celebrations in Times Square.', true
    );

-- rambler down

DELETE FROM federal_holidays;
ALTER SEQUENCE federal_holidays_holiday_id_seq RESTART;

