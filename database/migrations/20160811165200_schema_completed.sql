
-- rambler up

--
-- These tables define the title, schedule of services, and color to be used for a particular day.
--

CREATE TABLE completed (
    completed_id serial,
    title text NOT NULL,
    day date NOT NULL,
    is_vigil boolean NOT NULL DEFAULT false,
    color text NOT NULL,
    note text,
    CONSTRAINT completed_pk PRIMARY KEY (completed_id),
    CONSTRAINT completed_uq UNIQUE (day, is_vigil)
);

CREATE TABLE completed_services (
    cservice_id serial,
    completed_id integer NOT NULL,
    name text NOT NULL,
    start_time time with time zone NOT NULL,
    CONSTRAINT completed_services_pk PRIMARY KEY (cservice_id),
    CONSTRAINT completed_services_completed_fk FOREIGN KEY (completed_id)
        REFERENCES completed (completed_id)
        ON DELETE CASCADE ON UPDATE NO ACTION
);

-- rambler down

DROP TABLE completed_services;
DROP TABLE completed;

