.open fittrackpro.db
.mode column

DROP TABLE IF EXISTS contacts; 
DROP TABLE IF EXISTS locations;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS class_schedule;
DROP TABLE IF EXISTS equipment;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS membership;
DROP TABLE IF EXISTS class_attendance;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS personal_training_sessions;
DROP TABLE IF EXISTS member_health_metrics;
DROP TABLE IF EXISTS equipment_maintenance_log;



CREATE TABLE locations (
    location_id INTEGER PRIMARY KEY NOT NULL,
    name VARCHAR,
    address VARCHAR,
    phone_number VARCHAR CHECK (length(replace(phone_number, ' ', '')) >= 10),
    email VARCHAR(40) CHECK(email LIKE '%@%') 
);

CREATE TABLE members (
    member_id INTEGER PRIMARY KEY NOT NULL,
    first_name VARCHAR,
    last_name VARCHAR,
    email VARCHAR(40) CHECK(email LIKE '%@%._%'),
    phone_number VARCHAR CHECK (length(replace(phone_number, ' ', '')) >= 10),
    date_of_birth DATE,
    join_date DATE,
    emergency_contact_name VARCHAR,
    emergency_contact_phone VARCHAR CHECK (length(replace(phone_number, ' ', '')) >= 10)
);

CREATE TABLE staff (
    staff_id INTEGER PRIMARY KEY NOT NULL,
    first_name VARCHAR,
    last_name VARCHAR,
    email VARCHAR(40) CHECK(email LIKE '%@%._%'),
    phone_number VARCHAR CHECK (length(replace(phone_number, ' ', '')) >= 10),
    position VARCHAR CHECK (position IN ('Trainer', 'Manager', 'Receptionist', 'Maintenance')), 
    hire_date DATE,
    location_id INTEGER,
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE equipment (
    equipment_id INTEGER PRIMARY KEY NOT NULL,
    name VARCHAR,
    type VARCHAR CHECK (type IN ('Cardio', 'Strength')), 
    purchase_date DATE,
    last_maintenance_date DATE,
    next_maintenance_date DATE,
    location_id INTEGER,
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE classes (
    class_id INTEGER PRIMARY KEY NOT NULL,
    name VARCHAR,
    description VARCHAR,
    capacity INTEGER,
    duration INTEGER,
    location_id INTEGER,
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE class_schedule (
    schedule_id INTEGER,
    class_id INTEGER,
    staff_id INTEGER,
    start_time DATE,
    end_time DATE,
    FOREIGN KEY (class_id) REFERENCES classes(class_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE membership (
    membership_id  INTEGER PRIMARY KEY NOT NULL,
    member_id INTEGER,
    type VARCHAR,
    start_date DATE,
    end_date DATE,
    status VARCHAR CHECK(status IN ('Active' , 'Inactive')),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE attendance (
    attendance_id INTEGER PRIMARY KEY NOT NULL,
    member_id INTEGER ,
    location_id INTEGER ,
    check_in_time DATE,
    check_out_time DATE ,
    FOREIGN KEY (location_id) REFERENCES locations(location_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE class_attendance (
    class_attendance_id INTEGER PRIMARY KEY NOT NULL,
    schedule_id INTEGER,
    member_id INTEGER,
    attendance_status VARCHAR CHECK(attendance_status IN ('Registered', 'Attended', 'Unattended')),
    FOREIGN KEY (schedule_id) REFERENCES class_schedule(schedule_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE payments (
    payment_id INTEGER PRIMARY KEY NOT NULL,
    member_id INTEGER,
    amount REAL,
    payment_date DATE,
    payment_method VARCHAR CHECK(payment_method IN('Monthly membership fee', 'Day pass', 'Cash')),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE personal_training_sessions(
    session_id INTEGER PRIMARY KEY NOT NULL,
    member_id INTEGER,
    staff_id INTEGER,
    session_date DATE,
    start_time DATE,
    end_time DATE,
    notes VARCHAR,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE member_health_metrics (
    metric_id INTEGER PRIMARY KEY NOT NULL,
    member_id INTEGER,
    measurement_date DATE,
    weight REAL,
    body_fat_percentage REAL,
    muscle_mass REAL,
    bmi REAL,
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE equipment_maintenance_log (
    log_id INTEGER PRIMARY KEY NOT NULL,
    equipment_id INTEGER,
    maintenance_date DATE,
    description VARCHAR,
    staff_id INTEGER,
    FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);