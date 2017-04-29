--
-- Select the calendar for a date range out of the cached table
--
SELECT c.cached_id, c.target_date, c.target_block, c.name, 
   c.color, c.note, s.name AS service_name, 
   s.start_time AS service_start_time 
FROM cached c 
    LEFT JOIN cached_services s ON (c.cached_id = s.cached_id) 
WHERE c.target_date BETWEEN $1 AND $2 
ORDER BY c.target_date, c.target_block, s.start_time
