
-- rambler up

INSERT INTO floating_feasts (name, code, otype_id, placement_index,
        algorithm, color,
        valid_start)
    VALUES ('Of Our Lady', 'of-our-lady', 4, 1,
        'of_our_lady', 'white',
        '2013-01-01 00:00:00' AT TIME ZONE 'America/New_York');

INSERT INTO floating_feasts (name, code, otype_id, placement_index,
        algorithm, color,
        valid_end)
    VALUES ('Of Our Lady', 'of-our-lady', 4, 1,
        'of_our_lady_old', 'white',
        '2012-12-31 23:59:59' AT TIME ZONE 'America/New_York');

INSERT INTO floating_feasts (name, code, otype_id, placement_index, algorithm, color)
    VALUES ('The First Book of Common Prayer, 1549', 'first-bcp', 4, 1, 'first_bcp', 'white');

-- rambler down

TRUNCATE TABLE floating_feasts RESTART IDENTITY;

