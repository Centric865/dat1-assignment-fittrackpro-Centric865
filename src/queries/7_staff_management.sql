.open fittrackpro.db
.mode column

-- 7.1 
SELECT staff_id, first_name, last_name, position
FROM staff
ORDER BY position;


-- 7.2 
SELECT s.staff_id, s.first_name, s.last_name, COUNT(pts.session_id) AS session_count
FROM staff s
JOIN personal_training_sessions pts ON s.staff_id = pts.staff_id
WHERE pts.session_date >= '2025-01-20' 
  AND pts.session_date <= DATE('2025-01-20', '+30 days')
GROUP BY s.staff_id, s.first_name, s.last_name;
