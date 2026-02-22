.open fittrackpro.db
.mode column

-- 5.1 
SELECT m.member_id, m.first_name, m.last_name, ms.type AS membership_type, m.join_date
FROM members m
INNER JOIN membership ms ON m.member_id = ms.member_id
WHERE ms.status = 'Active';


-- 5.2 
SELECT ms.type AS membership_type, 
       AVG((strftime('%s', a.check_out_time) - strftime('%s', a.check_in_time)) / 60) AS avg_visit_duration_minutes
FROM membership ms
INNER JOIN attendance a ON ms.member_id = a.member_id
GROUP BY ms.type;

-- 5.3 
SELECT m.member_id, m.first_name, m.last_name, m.email, ms.end_date
FROM members m 
INNER JOIN membership ms ON m.member_id = ms.member_id
WHERE ms.end_date LIKE '2025%';