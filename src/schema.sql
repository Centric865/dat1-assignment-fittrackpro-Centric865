.open fittrackpro.db
.mode column

CREATE TABLE locations(
    location_id INTEGER PRIMARY KEY,
    name TEXT,
    address VARCHAR(7),
    phone_number VARCHAR(11),
    email VARCHAR CHECK (email LIKE '%@%'),
    opening_hours TIME
);

CREATE TABLE members(
    member_id INTEGER PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    email VARCHAR CHECK (email LIKE '%@%')
    phone_number INTEGER,
    date_of_birth DATE 
)