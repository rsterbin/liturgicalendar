
-- rambler up

INSERT INTO moveable_feasts (name, code, otype_id, placement_index,
        calculate_from, algorithm, distance,
        schedule_pattern, has_eve, eve_schedule_pattern, eve_name, color,
        valid_start)
    VALUES ('Easter Day', 'easter', 1, 1,
        'easter', 'exact', null,
        'easter', true, 'easter-eve', 'Easter Eve', 'gold',
        '2011-01-01 00:00:00' AT TIME ZONE 'America/New_York');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index,
        calculate_from, algorithm, distance,
        schedule_pattern, has_eve, eve_schedule_pattern, eve_name, color,
        valid_end)
    VALUES ('The Sunday of the Resurrection: Easter Day', 'easter', 1, 1,
        'easter', 'days_before', 1,
        'easter', true, 'easter-eve', 'Easter Eve', 'white',
        '2010-12-31 23:59:59' AT TIME ZONE 'America/New_York');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index,
        calculate_from, algorithm, distance,
        schedule_pattern, color, note,
        valid_start)
    VALUES ('Ash Wednesday', 'ash-wednesday', 1, 2,
        'easter', 'wednesdays_before', 6,
        'ash-wednesday', 'purple', 'Fast and Abstinence
Imposition of Ashes will be offered throughout the day from 7:00 AM to 8:00 PM.
The Daily Office is not prayed publicly on this day.',
        '2013-01-01 00:00:00' AT TIME ZONE 'America/New_York');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index,
        calculate_from, algorithm, distance,
        schedule_pattern, color, note,
        valid_start, valid_end)
    VALUES ('Ash Wednesday', 'ash-wednesday', 1, 2,
        'easter', 'wednesdays_before', 6,
        'ash-wednesday', 'purple', 'Fast and Abstinence
Imposition of Ashes will be offered throughout the day from 7:00 AM to 8:00 PM.',
        '2008-01-01 00:00:00' AT TIME ZONE 'America/New_York',
        '2012-12-31 23:59:59' AT TIME ZONE 'America/New_York');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index,
        calculate_from, algorithm, distance,
        schedule_pattern, color, note,
        valid_end)
    VALUES ('The First Day of Lent: Ash Wednesday', 'ash-wednesday', 1, 2,
        'easter', 'wednesdays_before', 6,
        'ash-wednesday', 'purple', 'Fast & Abstinence
Ashes are offered from 7:00 AM to 8:00 PM.
Weekdays in Lent are observed by special acts of discipline and self-denial.
Fridays of Lent are observed by abstinence from flesh meats.',
        '2007-12-31 23:59:59' AT TIME ZONE 'America/New_York');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index,
        calculate_from, algorithm, distance,
        schedule_pattern, has_eve, eve_schedule_pattern, color, note,
        valid_start)
    VALUES ('The Sunday of the Passion: Palm Sunday', 'palm-sunday', 1, 2,
        'easter', 'days_before', 7,
        'palm-sunday', true, 'palm-sunday-eve', 'red', 'Abstinence is not observed on Palm Sunday.
There is no celebration of Mass at 10:00 AM today.',
        '2011-01-01 00:00:00' AT TIME ZONE 'America/New_York');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index,
        calculate_from, algorithm, distance,
        schedule_pattern, has_eve, eve_schedule_pattern, color, note,
        valid_end)
    VALUES ('The Sunday of the Passion: Palm Sunday', 'palm-sunday', 1, 2,
        'easter', 'days_before', 7,
        'palm-sunday', true, 'palm-sunday-eve', 'red', 'There is no 10:00 AM liturgy today.',
        '2010-12-31 23:59:59' AT TIME ZONE 'America/New_York');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index,
        calculate_from, algorithm, distance,
        schedule_pattern, color, note,
        valid_start)
    VALUES ('Good Friday', 'good-friday', 1, 2,
        'easter', 'days_before', 2,
        'good-friday', 'red', 'Fast & Abstinence
The parish clergy hear confessions following the liturgies.',
        '2014-01-01 00:00:00' AT TIME ZONE 'America/New_York');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index,
        calculate_from, algorithm, distance,
        schedule_pattern, color, note,
        valid_start, valid_end)
    VALUES ('Good Friday', 'good-friday', 1, 2,
        'easter', 'days_before', 2,
        'good-friday', 'black', 'Fast & Friday Abstinence
Confessions are heard following the liturgies.',
        '2011-01-01 00:00:00' AT TIME ZONE 'America/New_York',
        '2013-12-31 23:59:59' AT TIME ZONE 'America/New_York');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index,
        calculate_from, algorithm, distance,
        schedule_pattern, color, note,
        valid_end)
    VALUES ('Good Friday', 'good-friday', 1, 2,
        'easter', 'days_before', 2,
        'good-friday', 'red', 'Fast & Lenten Abstinence
The Good Friday Liturgy is celebrated twice for the pastoral needs of the community.
Confessions are heard following both liturgies by the parish clergy.',
        '2010-12-31 23:59:59' AT TIME ZONE 'America/New_York');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index,
        calculate_from, algorithm, distance,
        schedule_pattern, color, note,
        valid_start)
    VALUES ('Holy Saturday', 'holy-saturday', 1, 3,
        'easter', 'days_before', 1,
        'holy-saturday', 'red', 'Abstinence',
        '2011-01-01 00:00:00' AT TIME ZONE 'America/New_York');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index,
        calculate_from, algorithm, distance,
        schedule_pattern, color, note,
        valid_end)
    VALUES ('Holy Saturday', 'holy-saturday', 1, 3,
        'easter', 'days_before', 1,
        'holy-saturday', 'red', null,
        '2010-12-31 23:59:59' AT TIME ZONE 'America/New_York');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index,
        calculate_from, algorithm, distance,
        schedule_pattern, color, note,
        valid_start)
    VALUES ('Maundy Thursday', 'maundy-thursday', 1, 3,
        'easter', 'days_before', 3,
        'maundy-thursday', 'white', 'Abstinence
There are no noonday services today.
The Watch Before the Blessed Sacrament follows the Mass.',
        '2011-01-01 00:00:00' AT TIME ZONE 'America/New_York');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index,
        calculate_from, algorithm, distance,
        schedule_pattern, color, note,
        valid_end)
    VALUES ('Maundy Thursday', 'maundy-thursday', 1, 3,
        'easter', 'days_before', 3,
        'maundy-thursday', 'white', 'There are no noonday services today.
The Watch Before the Blessed Sacrament follows the Mass.',
        '2010-12-31 23:59:59' AT TIME ZONE 'America/New_York');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index,
        calculate_from, algorithm, distance,
        schedule_pattern, has_eve, eve_schedule_pattern, color)
    VALUES ('Ascension Day', 'ascension-day', 2, 4,
        'easter', 'thursdays_after', 5,
        'solemn-fixed-feast', true, 'solemn-fixed-feast-eve', 'gold');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index,
        calculate_from, algorithm, distance, has_eve, color)
    VALUES ('The Day of Pentecost: Whitsunday', 'pentecost', 2, 4,
        'easter', 'sundays_after', 7, true, 'red');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index,
        calculate_from, algorithm, distance, has_eve, color)
    VALUES ('Trinity Sunday', 'trinity', 2, 4,
        'easter', 'sundays_after', 8, true, 'gold');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index,
        calculate_from, algorithm, distance,
        schedule_pattern, has_eve, color, note)
    VALUES ('The Body and Blood of Christ: Corpus Christi', 'corpus-christi', 2, 4,
        'easter', 'sundays_after', 9,
        'corpus-christi', true, 'gold', 'The Sunday summer schedule begins this evening.');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index,
        calculate_from, algorithm, distance, has_eve, color)
    VALUES ('The Third Sunday of Advent', 'rose-advent', 2, 5,
        'christmas', 'sundays_before', 2, true, 'rose');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index,
        calculate_from, algorithm, distance, has_eve, color)
    VALUES ('The Fourth Sunday in Lent', 'rose-lent', 2, 5,
        'ash-wednesday', 'sundays_after', 3, true, 'rose');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index,
        calculate_from, algorithm, distance, has_eve, color,
        valid_end)
    VALUES ('The Sacred Heart of Jesus', 'sacred-heart', 3, 5,
        'pentecost', 'days_after', 19, true, 'white',
        '2008-12-31 23:59:59' AT TIME ZONE 'America/New_York');

-- rambler down

TRUNCATE TABLE moveable_feasts RESTART IDENTITY;


-- TODO: Floating feasts

-- "Of Our Lady" Saturdays
-- The First Book of Common Prayer, 1549

-- TODO: Federal holidays

-- Thanksgiving Day
-- Independence Day
-- Martin Luther King Day
-- Presidents' Day
-- Memorial Day
-- Labor Day
-- Columbus Day

-- todo: answered questions:
-- How do the days marked "Of Our Lady" work? There seems to be roughly one a month, but I don't know what the pattern is.
    -- Saturdays the would otherwise be green, during a green season, become Of Our Lady
    -- This used to be true year-round
    -- Stopped in 2013 (year-round through 2012)
-- How is the date of "The First Book of Common Prayer, 1549" determined?
    -- First free weekday after Pentecost for which there's no other commemoration
-- Do we celebrate Sacred Heart (19 days after Pentecost) anymore?  It appears through 2008.
    -- Officially done with that

-- todo: ask for clarification
-- Should I standardize the shifting names of the Dedication of the Church? (if so, we just have one color change, not three name changes)
-- Need more info on how the Dedication of the Church works, as its description in LF&F is similar to a level 2, but we don't seem to treat it quite that way

