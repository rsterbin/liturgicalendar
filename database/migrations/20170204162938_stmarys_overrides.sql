
-- rambler up

--
-- Define overrides
--

INSERT INTO overrides (target_date, target_block, note)
    VALUES ('2004-04-08', 'base', E'There is no 12:15 PM Mass today.
The Watch Before the Blessed Sacrament follows the liturgy.
Evening Prayer is said only by those who are unable to participate in the Evening Mass of the Lord\'s Supper.'); -- 1

INSERT INTO override_services (override_id, name, start_time) VALUES
    (1, 'Morning Prayer', '08:30:00'),
    (1, E'The Evening Mass of the Lord\'s Supper', '18:00:00');

-- rambler down

DELETE FROM override_services;
ALTER SEQUENCE override_services_override_service_id_seq RESTART;
DELETE FROM overrides;
ALTER SEQUENCE overrides_override_id_seq RESTART;

