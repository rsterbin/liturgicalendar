
-- rambler up

--
-- This table defines the floating feasts, which are not attached to a
-- particular calendar day, or calculated from a particular holiday, but are
-- placed where they best fit, according to a particular algorithm.
--

CREATE TABLE floating_feasts (
    floating_id serial,
    name text NOT NULL,
    code text NOT NULL,
    otype_id integer NOT NULL,
    placement_index integer,
    algorithm text NOT NULL,
    schedule_pattern text,
    has_eve boolean NOT NULL DEFAULT FALSE,
    eve_schedule_pattern text,
    eve_name text,
    color text,
    note text,
    valid_start timestamp with time zone NULL,
    valid_end timestamp with time zone NULL,
    CONSTRAINT floating_feasts_pk PRIMARY KEY (floating_id),
    CONSTRAINT floating_feasts_otype_fk FOREIGN KEY (otype_id)
        REFERENCES observance_types (otype_id)
        ON DELETE RESTRICT ON UPDATE NO ACTION
);

CREATE INDEX floating_feasts_code_idx ON floating_feasts (code);
CREATE INDEX floating_feasts_placement_idx ON floating_feasts (placement_index);

-- rambler down

DROP TABLE floating_feasts;

