.open fittrackpro.db
.mode column

-- 4.1 
SELECT c.class_id, 
       c.name AS class_name, 
       printf('%s% %%s', s.first_name, s.last_name) AS instructor_name
FROM classes c
INNER JOIN class_schedule cs ON c.class_id = cs.class_id
INNER JOIN staff s ON cs.staff_id = s.staff_id;


-- 4.2 


-- 4.3 


-- 4.4 


-- 4.5 


-- 4.6 

