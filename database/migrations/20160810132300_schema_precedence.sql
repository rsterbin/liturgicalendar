
-- rambler up

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

-- rambler down

DROP TABLE observance_types;

