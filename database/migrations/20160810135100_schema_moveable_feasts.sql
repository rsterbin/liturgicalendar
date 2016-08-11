
-- rambler up

--
-- This table defines the moveable feasts, which are not attached to a
-- particular calendar day, but are calculated, usually from the date of Easter
-- or the date of Christmas, but sometimes by other means.
--

CREATE TABLE moveable_feasts (
    moveable_id serial,
    name text NOT NULL,
    code text NOT NULL,
    otype_id integer NOT NULL,
    placement_index integer,
    calculate_from text NOT NULL,
    algorithm text NOT NULL,
    distance integer,
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
        ON DELETE RESTRICT ON UPDATE NO ACTION,
    CONSTRAINT moveable_feasts_calc_from CHECK (calculate_from IN ('easter', 'christmas', NULL))
);

CREATE INDEX moveable_feasts_code_idx ON moveable_feasts (code);
CREATE INDEX moveable_feasts_placement_idx ON moveable_feasts (placement_index);

-- rambler down

DROP TABLE moveable_feasts;

