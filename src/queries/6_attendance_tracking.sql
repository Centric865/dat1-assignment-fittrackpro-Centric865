.open fittrackpro.db
.mode column

-- 6.1 
INSERT INTO attendance (member_id, location_id, check_in_time)
VALUES (7, 1, '2025-02-14 16:30:00');

-- 6.2 
SELECT DATE(check_in_time) AS visit_date, check_in_time, check_out_time
FROM attendance
WHERE member_id LIKE 5;

-- 6.3 
SELECT strftime('%w', check_in_time) AS day_of_week, COUNT(*) AS visit_count
FROM attendance
GROUP BY day_of_week
ORDER BY visit_count DESC
LIMIT 1;

-- 6.4 
SELECT l.name AS location_name, AVG(daily.visit_count) AS avg_daily_attendance
FROM locations l
INNER JOIN (
    SELECT location_id, 
           COUNT(*) AS visit_count 
    FROM attendance 
    GROUP BY location_id, DATE(check_in_time)
) daily ON l.location_id = daily.location_id
GROUP BY l.name;