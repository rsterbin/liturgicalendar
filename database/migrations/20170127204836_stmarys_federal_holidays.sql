
-- rambler up

INSERT INTO federal_holidays (name, code,
        calculate_from, algorithm, distance, placement_index,
        open_time, close_time
    ) VALUES (E'New Year\'s Day', 'new-years',
        '1/1', 'closest_weekday', 0, 1,
        '10:00:00', '14:00:00'
    );

INSERT INTO federal_holidays (name, code,
        calculate_from, algorithm, distance, placement_index,
        open_time, close_time,
        note
    ) VALUES ('Martin Luther King', 'mlk',
        '1/1', 'nth_monday', 3, 2,
        '10:00:00', '14:00:00',
        'Federal holiday schedule'
    );

INSERT INTO federal_holidays (name, code,
        calculate_from, algorithm, distance, placement_index,
        open_time, close_time,
        note
    ) VALUES (E'President\'s Day', 'presidents',
        '2/1', 'nth_monday', 3, 3,
        '10:00:00', '14:00:00',
        'Federal holiday schedule'
    );

INSERT INTO federal_holidays (name, code,
        calculate_from, algorithm, distance, placement_index,
        open_time, close_time,
        note
    ) VALUES ('Memorial Day', 'memorial',
        '5/1', 'last_monday', 0, 4,
        '10:00:00', '14:00:00',
        'Federal holiday schedule'
    );

INSERT INTO federal_holidays (name, code,
        calculate_from, algorithm, distance, placement_index,
        open_time, close_time,
        note, skip_name
    ) VALUES ('Independence Day', 'independence',
        '7/4', 'not_sunday', 0, 5,
        '10:00:00', '14:00:00',
        'Federal holiday schedule', true
    );

INSERT INTO federal_holidays (name, code,
        calculate_from, algorithm, distance, placement_index,
        open_time, close_time,
        note
    ) VALUES ('Labor Day', 'labor',
        '9/1', 'nth_monday', 1, 6,
        '10:00:00', '14:00:00',
        'Federal holiday schedule'
    );

INSERT INTO federal_holidays (name, code,
        calculate_from, algorithm, distance, placement_index,
        open_time, close_time,
        note, skip_name
    ) VALUES ('Thanksgiving Day', 'thanksgiving',
        '11/1', 'nth_thursday', 4, 7,
        '10:00:00', '14:00:00',
        'Federal holiday schedule', true
    );

-- rambler down

DELETE FROM federal_holidays;
ALTER SEQUENCE federal_holidays_holiday_id_seq RESTART;

