-- Fictional sample records for Airline / Flight Booking System.
BEGIN;
SET LOCAL standard_conforming_strings = on;
INSERT INTO portfolio."passenger" ("passenger_id", "full_name", "email", "created_on") VALUES (1001, 'Avery Morgan', 'avery.morgan@example.test', '2026-01-10');
INSERT INTO portfolio."passenger" ("passenger_id", "full_name", "email", "created_on") VALUES (1002, 'Jordan Lee', 'jordan.lee@example.test', '2026-01-11');
INSERT INTO portfolio."flight" ("flight_id", "flight_code", "origin", "destination", "departure_at", "capacity") VALUES (2001, 'QX101', 'Northport', 'Lakeview', '2026-02-10T09:30:00Z', 120);
INSERT INTO portfolio."flight" ("flight_id", "flight_code", "origin", "destination", "departure_at", "capacity") VALUES (2002, 'QX205', 'Lakeview', 'Pinecrest', '2026-02-11T14:15:00Z', 90);
INSERT INTO portfolio."booking" ("booking_id", "passenger_id", "flight_id", "booked_on", "seat_code", "status", "fare_amount") VALUES (3001, 1001, 2001, '2026-01-15', '12A', 'confirmed', 245.5);
INSERT INTO portfolio."booking" ("booking_id", "passenger_id", "flight_id", "booked_on", "seat_code", "status", "fare_amount") VALUES (3002, 1002, 2001, '2026-01-16', '12B', 'confirmed', 245.5);
COMMIT;
