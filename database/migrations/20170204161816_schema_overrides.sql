
-- rambler up

--
-- These tables define the overrides used to tweak a particular block in the liturgical calendar
--

CREATE TABLE overrides (
    override_id serial,
    target_date date NOT NULL,
    target_block text NOT NULL CHECK (target_block IN ('base', 'vigil')),
    name text,
    color text,
    note text,
    CONSTRAINT overrides_pk PRIMARY KEY (override_id),
    CONSTRAINT overrides_target_uq UNIQUE (target_date, target_block)
);

CREATE INDEX overrides_target_date_idx ON overrides (target_date);

CREATE TABLE override_services (
    override_service_id serial,
    override_id integer NOT NULL,
    name text NOT NULL,
    start_time time with time zone NOT NULL,
    CONSTRAINT override_services_pk PRIMARY KEY (override_service_id),
    CONSTRAINT override_services_target_uq FOREIGN KEY (override_id)
        REFERENCES overrides (override_id)
        ON DELETE CASCADE ON UPDATE NO ACTION
);

-- rambler down

DROP TABLE override_services;
DROP TABLE overrides;

