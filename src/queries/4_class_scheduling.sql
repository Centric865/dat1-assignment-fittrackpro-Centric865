.open fittrackpro.db
.mode column

-- 4.1 
SELECT c.class_id,c.name AS class_name, printf('%s% %%s', s.first_name, s.last_name) AS instructor_name
FROM classes c
INNER JOIN class_schedule cs ON c.class_id = cs.class_id
INNER JOIN staff s ON cs.staff_id = s.staff_id;


-- 4.2 
SELECT c.class_id, c.name, cs.start_time, cs.end_time, (c.capacity - COUNT(ca.member_id)) AS available_spots
FROM classes c
INNER JOIN class_schedule cs ON c.class_id = cs.class_id
LEFT JOIN class_attendance ca ON cs.schedule_id = ca.schedule_id
WHERE DATE(cs.start_time) = '2025-02-01' 
GROUP BY c.class_id, c.name, cs.start_time, cs.end_time, c.capacity;

-- 4.3 
INSERT INTO class_attendance (schedule_id, member_id)
SELECT schedule_id, 11
FROM class_schedule
WHERE class_id = 1 AND start_time LIKE '2025-02-01%';
-- 4.4 
DELETE FROM class_attendance
WHERE member_id = 3 AND schedule_id = 7;

-- 4.5 
SELECT c.class_id, c.name AS class_name, COUNT(ca.member_id) AS registration_count
FROM classes c
INNER JOIN class_schedule cs ON c.class_id = cs.class_id
INNER JOIN class_attendance ca ON cs.schedule_id = ca.schedule_id
GROUP BY c.class_id, c.name
ORDER BY registration_count DESC
LIMIT 1;

-- 4.6 
SELECT AVG(myCount) AS avg_classes_per_member
FROM (
    SELECT COUNT(schedule_id) AS myCount
    FROM class_attendance
    GROUP BY member_id
);


