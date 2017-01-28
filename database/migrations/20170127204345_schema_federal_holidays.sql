
-- rambler up

--
-- This table defines the federal holidays, which are calculated according to an
-- algorithm the way feasts are, but do not carry colors or services, just notes
-- and sometimes special church open/close times.
--

CREATE TABLE federal_holidays (
    holiday_id serial,
    name text NOT NULL,
    code text NOT NULL,
    calculate_from text NOT NULL,
    algorithm text NOT NULL,
    distance integer NOT NULL,
    placement_index integer,
    open_time time,
    close_time time,
    note text,
    skip_name boolean NOT NULL DEFAULT FALSE,
    valid_start timestamp with time zone NULL,
    valid_end timestamp with time zone NULL,
    CONSTRAINT federal_holidays_pk PRIMARY KEY (holiday_id)
);

CREATE INDEX federal_holidays_code_idx ON federal_holidays (code);
CREATE INDEX federal_holidays_placement_idx ON federal_holidays (placement_index);

-- rambler down

DROP TABLE federal_holidays;

