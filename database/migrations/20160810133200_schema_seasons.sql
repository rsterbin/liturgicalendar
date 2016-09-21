
-- rambler up

--
-- This table defines the liturgical seasons that set the base color, name,
-- notes, and services for each part of the year
--

CREATE TABLE seasons (
    season_id serial,
    name text NOT NULL,
    code text NOT NULL,
    color text NOT NULL,
    sort_order integer NOT NULL,
    calculate_from text NOT NULL,
    algorithm text NOT NULL,
    distance integer,
    weekday_precedence integer NOT NULL,
    has_last_sunday boolean NOT NULL DEFAULT FALSE,
    counting_index integer NOT NULL DEFAULT 1,
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
    valid_start timestamp with time zone NULL,
    valid_end timestamp with time zone NULL,
    CONSTRAINT liturigal_seasons_pk PRIMARY KEY (season_id),
    CONSTRAINT liturigal_seasons_calc_from CHECK (calculate_from IN ('easter', 'christmas', NULL))
);

-- rambler down

DROP TABLE seasons;

