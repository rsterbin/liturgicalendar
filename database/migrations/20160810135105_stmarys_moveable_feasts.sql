
-- rambler up

INSERT INTO moveable_feasts (name, code, otype_id, placement_index, algorithm,
        schedule_pattern, has_eve, eve_schedule_pattern, eve_name, color,
        valid_start)
    VALUES ('Easter Day', 'easter', 1, 1, 'easter',
        'easter', true, 'easter-eve', 'Easter Eve', 'gold',
        '2011-01-01 00:00:00' AT TIME ZONE 'America/New_York');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index, algorithm,
        schedule_pattern, has_eve, eve_schedule_pattern, eve_name, color,
        valid_end)
    VALUES ('The Sunday of the Resurrection: Easter Day', 'easter', 1, 1, 'easter',
        'easter', true, 'easter-eve', 'Easter Eve', 'white',
        '2010-12-31 23:59:59' AT TIME ZONE 'America/New_York');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index,
        algorithm, arg1, arg2, schedule_pattern, color, note,
        valid_start)
    VALUES ('Ash Wednesday', 'ash-wednesday', 1, 2,
        'days_before', 'easter', 40, 'ash-wednesday', 'purple',
        'Fast and Abstinence
Imposition of Ashes will be offered throughout the day from 7:00 AM to 8:00 PM.
The Daily Office is not prayed publicly on this day.',
        '2013-01-01 00:00:00' AT TIME ZONE 'America/New_York');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index,
        algorithm, arg1, arg2, schedule_pattern, color, note,
        valid_start, valid_end)
    VALUES ('Ash Wednesday', 'ash-wednesday', 1, 2,
        'days_before', 'easter', 40, 'ash-wednesday', 'purple',
        'Fast and Abstinence
Imposition of Ashes will be offered throughout the day from 7:00 AM to 8:00 PM.',
        '2008-01-01 00:00:00' AT TIME ZONE 'America/New_York',
        '2012-12-31 23:59:59' AT TIME ZONE 'America/New_York');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index,
        algorithm, arg1, arg2, schedule_pattern, color, note,
        valid_end)
    VALUES ('The First Day of Lent: Ash Wednesday', 'ash-wednesday', 1, 2,
        'days_before', 'easter', 40, 'ash-wednesday', 'purple',
        'Fast & Abstinence
Ashes are offered from 7:00 AM to 8:00 PM.
Weekdays in Lent are observed by special acts of discipline and self-denial.
Fridays of Lent are observed by abstinence from flesh meats.',
        '2007-12-31 23:59:59' AT TIME ZONE 'America/New_York');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index, algorithm, arg1, arg2,
        schedule_pattern, color, note,
        valid_start)
    VALUES ('Good Friday', 'good-friday', 1, 2, 'days_before', 2, 'easter',
        'good-friday', 'red', 'Fast & Abstinence
The parish clergy hear confessions following the liturgies.',
        '2014-01-01 00:00:00' AT TIME ZONE 'America/New_York');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index, algorithm, arg1, arg2,
        schedule_pattern, color, note,
        valid_start, valid_end)
    VALUES ('Good Friday', 'good-friday', 1, 2, 'days_before', 2, 'easter',
        'good-friday', 'black', 'Fast & Friday Abstinence
Confessions are heard following the liturgies.',
        '2011-01-01 00:00:00' AT TIME ZONE 'America/New_York',
        '2013-12-31 23:59:59' AT TIME ZONE 'America/New_York');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index, algorithm, arg1, arg2,
        schedule_pattern, color, note,
        valid_end)
    VALUES ('Good Friday', 'good-friday', 1, 2, 'days_before', 2, 'easter',
        'good-friday', 'red', 'Fast & Lenten Abstinence
The Good Friday Liturgy is celebrated twice for the pastoral needs of the community.
Confessions are heard following both liturgies by the parish clergy.',
        '2010-12-31 23:59:59' AT TIME ZONE 'America/New_York');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index, algorithm, arg1, arg2,
        schedule_pattern, color, note,
        valid_start)
    VALUES ('Holy Saturday', 'holy-saturday', 1, 3, 'days_before', 1, 'easter',
        'holy-saturday', 'red', 'Abstinence',
        '2011-01-01 00:00:00' AT TIME ZONE 'America/New_York');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index, algorithm, arg1, arg2,
        schedule_pattern, color, note,
        valid_end)
    VALUES ('Holy Saturday', 'holy-saturday', 1, 3, 'days_before', 1, 'easter',
        'holy-saturday', 'red', null,
        '2010-12-31 23:59:59' AT TIME ZONE 'America/New_York');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index, algorithm, arg1, arg2,
        schedule_pattern, color, note,
        valid_start)
    VALUES ('Maundy Thursday', 'maundy-thursday', 1, 3, 'days_before', 3, 'easter',
        'maundy-thursday', 'white', 'Abstinence
There are no noonday services today.
The Watch Before the Blessed Sacrament follows the Mass.',
        '2011-01-01 00:00:00' AT TIME ZONE 'America/New_York');

INSERT INTO moveable_feasts (name, code, otype_id, placement_index, algorithm, arg1, arg2,
        schedule_pattern, color, note,
        valid_end)
    VALUES ('Maundy Thursday', 'maundy-thursday', 1, 3, 'days_before', 3, 'easter',
        'maundy-thursday', 'white', 'There are no noonday services today.
The Watch Before the Blessed Sacrament follows the Mass.',
        '2010-12-31 23:59:59' AT TIME ZONE 'America/New_York');

-- rambler down

TRUNCATE TABLE moveable_feasts RESTART IDENTITY;

-- TODO: Remaining moveable feasts

-- Ascension Day
-- Day of Pentecost
-- Trinity Sunday
-- Corpus Christi
-- Thanksgiving Day
-- "Of Our Lady" Saturdays
-- The First Book of Common Prayer, 1549
-- Dedication of the Church (old timing)

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

