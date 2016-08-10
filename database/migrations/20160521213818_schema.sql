
-- rambler up

--
-- These tables define the services, the selection of services that make up a
-- daily (or eve-of) schedule, and the patterns that define which schedule is
-- chosen for which day of the week.
--

CREATE TABLE services (
    service_id serial,
    name text NOT NULL,
    start_time time with time zone NOT NULL,
    is_default boolean NOT NULL DEFAULT false,
    CONSTRAINT services_pk PRIMARY KEY (service_id)
);

CREATE INDEX services_start_time_idx ON services (start_time);
CREATE INDEX services_default_idx ON services (is_default);

CREATE TABLE schedules (
    schedule_id serial,
    name text NOT NULL,
    code text,
    valid_start timestamp with time zone NULL,
    valid_end timestamp with time zone NULL,
    is_default boolean NOT NULL DEFAULT false,
    is_custom boolean NOT NULL DEFAULT false,
    CONSTRAINT schedules_pk PRIMARY KEY (schedule_id)
);

CREATE INDEX schedules_code_idx ON schedules (code, valid_start, valid_end);
CREATE INDEX schedules_default_idx ON schedules (is_default, valid_start, valid_end);

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

--
-- This table defines the types of observances and their precedence (e.g., if
-- Saint Joseph's Day falls on Monday of Holy Week, is it celebrated then or
-- transferred to another day?)
--

CREATE TABLE observance_types (
    otype_id serial,
    name text NOT NULL,
    precedence integer NOT NULL,
    CONSTRAINT observance_types_pk PRIMARY KEY (otype_id)
);

--
-- This table defines the liturigal seasons that set the base color, name,
-- notes, and services for each part of the year
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

--
-- This table defines the fixed feasts, which are attached to a particular
-- calendar day, but can (depending on precedence) be transferred to another
-- day and/or have an associated "eve-of" service.
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

--
-- Define customizations (one-time calendar changes)
--

CREATE TABLE customizations (
    custom_id serial,
    override_date date NOT NULL,
    is_eve_schedule boolean NOT NULL DEFAULT false,
    override_title text,
    override_color text,
    override_note text,
    override_schedule_id integer,
    CONSTRAINT customizations_pk PRIMARY KEY (custom_id),
    CONSTRAINT customizations_override_schedule_fk FOREIGN KEY (override_schedule_id)
        REFERENCES schedules (schedule_id)
        ON DELETE RESTRICT ON UPDATE NO ACTION
);

CREATE INDEX customizations_idx ON customizations (override_date);

-- rambler down

DROP TABLE customizations;
DROP TABLE moveable_feasts;
DROP TABLE fixed_feasts;
DROP TABLE liturigal_seasons;
DROP TABLE observance_types;
DROP TABLE service_patterns;
DROP TABLE schedule_services;
DROP TABLE schedules;
DROP TABLE services;

-- todo: distinguish notes from abstinence notes

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

-- todo: by-year overrides
-- Candlemas
-- Assumption
-- 9/11 Requiem
-- Willibrord, Archbishop of Utrecht, Missionary to Frisia, 739 missing in 2006
-- Anniversary of the Dedication of the Church sometimes has an eve and occasionally a nonstandard Mass

-- todo: special cases in 2004:

-- MAUNDY THURSDAY
-- Morning Prayer 8:30 AM
-- There is no 12:15 PM Mass today.
-- THE EVENING MASS OF THE LORD'S SUPPER 6:00 PM
-- The Watch Before the Blessed Sacrament follows the liturgy.
-- Evening Prayer is said only by those who are unable to participate in the Evening Mass of the Lord's Supper.

-- GOOD FRIDAY
-- Morning Prayer 8:30 AM
-- THE CELEBRATION OF THE PASSION OF THE LORD 12:30 PM
-- THE CELEBRATION OF THE PASSION OF THE LORD 6:00 PM
-- Fast & Abstinence
-- The Good Friday Liturgy is celebrated twice for the pastoral needs of the community.
-- Confessions are heard following both liturgies by the parish clergy.
-- Evening Prayer is only said by those who are not able to participate in the Celebration of the Passion of the Lord.

