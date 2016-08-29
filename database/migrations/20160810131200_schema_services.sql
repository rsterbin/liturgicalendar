
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
-- These functions make it easier to pull the right schedules and service patterns
--

CREATE OR REPLACE FUNCTION valid_for_date(
    given timestamp with time zone,
    valid_start timestamp with time zone,
    valid_end timestamp with time zone
) RETURNS boolean AS '
    SELECT ( $2 is null and $3 is null )
        or ( $2 is null and $3 > $1 )
        or ( $3 is null and $2 < $1 )
        or ( $2 is not null and $3 is not null and $1 between $2 and $3 );'
    LANGUAGE SQL;

CREATE OR REPLACE FUNCTION valid_for_date_range(
    given_start timestamp with time zone,
    given_end timestamp with time zone,
    valid_start timestamp with time zone,
    valid_end timestamp with time zone
) RETURNS boolean AS '
    SELECT ( $3 is null and $4 is null )
        or ( $3 is null and $4 >= $1 )
        or ( $4 is null and $3 <= $2 )
        or ( $3 is not null and $4 is not null and $3 <= $2 and $4 >= $1 );'
    LANGUAGE SQL;

-- rambler down

DROP TABLE service_patterns;
DROP TABLE schedule_services;
DROP TABLE schedules;
DROP TABLE services;
DROP FUNCTION valid_for_date(given timestamp with time zone, valid_start timestamp with time zone, valid_end timestamp with time zone);
DROP FUNCTION valid_for_date_range(given_start timestamp with time zone, given_end timestamp with time zone, valid_start timestamp with time zone, valid_end timestamp with time zone);

