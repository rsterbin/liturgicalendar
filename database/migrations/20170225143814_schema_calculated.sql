
-- rambler up

--
-- These tables define the calculated and cached results for the liturgical calendar
--

CREATE TABLE calculated (
    calculated_id serial,
    target_date date NOT NULL,
    target_block text NOT NULL CHECK (target_block IN ('base', 'vigil')),
    name text,
    color text,
    note text,
    CONSTRAINT calculated_pk PRIMARY KEY (calculated_id),
    CONSTRAINT calculated_target_uq UNIQUE (target_date, target_block)
);

CREATE INDEX calculated_target_date_idx ON calculated (target_date);

CREATE TABLE calculated_services (
    calculated_service_id serial,
    calculated_id integer NOT NULL,
    name text NOT NULL,
    start_time time with time zone NOT NULL,
    CONSTRAINT calculated_services_pk PRIMARY KEY (calculated_service_id),
    CONSTRAINT calculated_services_target_uq FOREIGN KEY (calculated_id)
        REFERENCES calculated (calculated_id)
        ON DELETE CASCADE ON UPDATE NO ACTION
);

CREATE TABLE cached (
    cached_id serial,
    target_date date NOT NULL,
    target_block text NOT NULL CHECK (target_block IN ('base', 'vigil')),
    name text,
    color text,
    note text,
    CONSTRAINT cached_pk PRIMARY KEY (cached_id),
    CONSTRAINT cached_target_uq UNIQUE (target_date, target_block)
);

CREATE INDEX cached_target_date_idx ON cached (target_date);

CREATE TABLE cached_services (
    cached_service_id serial,
    cached_id integer NOT NULL,
    name text NOT NULL,
    start_time time with time zone NOT NULL,
    CONSTRAINT cached_services_pk PRIMARY KEY (cached_service_id),
    CONSTRAINT cached_services_target_uq FOREIGN KEY (cached_id)
        REFERENCES cached (cached_id)
        ON DELETE CASCADE ON UPDATE NO ACTION
);

-- rambler down

DROP TABLE cached_services;
DROP TABLE cached;
DROP TABLE calculated_services;
DROP TABLE calculated;

