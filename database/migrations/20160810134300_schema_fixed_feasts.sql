
-- rambler up

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

-- rambler down

DROP TABLE fixed_feasts;

