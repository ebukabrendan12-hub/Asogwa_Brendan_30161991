-- Run these deliberately invalid statements one at a time, outside a transaction.
-- Each should fail at the named constraint; the sample rows should remain unchanged.

-- 1. passenger primary duplicate. Expected: pk_passenger, SQLSTATE 23505.
INSERT INTO portfolio."passenger" ("passenger_id", "full_name", "email", "created_on")
VALUES (1001, 'Casey Test', 'casey.pk@example.test', '2026-01-20');

-- 2. passenger email duplicate. Expected: uq_passenger_0, SQLSTATE 23505.
INSERT INTO portfolio."passenger" ("passenger_id", "full_name", "email", "created_on")
VALUES (9001, 'Casey Test', 'avery.morgan@example.test', '2026-01-20');

-- 3. passenger id null. Expected: passenger_id, SQLSTATE 23502.
INSERT INTO portfolio."passenger" ("passenger_id", "full_name", "email", "created_on")
VALUES (NULL, 'Casey Test', 'casey.idnull@example.test', '2026-01-20');

-- 4. passenger name null. Expected: full_name, SQLSTATE 23502.
INSERT INTO portfolio."passenger" ("passenger_id", "full_name", "email", "created_on")
VALUES (9002, NULL, 'casey.namenull@example.test', '2026-01-20');

-- 5. passenger email null. Expected: email, SQLSTATE 23502.
INSERT INTO portfolio."passenger" ("passenger_id", "full_name", "email", "created_on")
VALUES (9003, 'Casey Test', NULL, '2026-01-20');

-- 6. passenger date null. Expected: created_on, SQLSTATE 23502.
INSERT INTO portfolio."passenger" ("passenger_id", "full_name", "email", "created_on")
VALUES (9004, 'Casey Test', 'casey.datenull@example.test', NULL);

-- 7. flight primary duplicate. Expected: pk_flight, SQLSTATE 23505.
INSERT INTO portfolio."flight" ("flight_id", "flight_code", "origin", "destination", "departure_at", "capacity")
VALUES (2001, 'QX-PKTEST', 'Eastfield', 'Westhaven', '2026-03-01T10:00:00Z', 80);

-- 8. flight schedule duplicate. Expected: uq_flight_0, SQLSTATE 23505.
INSERT INTO portfolio."flight" ("flight_id", "flight_code", "origin", "destination", "departure_at", "capacity")
VALUES (9005, 'QX101', 'Eastfield', 'Westhaven', '2026-02-10T09:30:00Z', 80);

-- 9. flight id null. Expected: flight_id, SQLSTATE 23502.
INSERT INTO portfolio."flight" ("flight_id", "flight_code", "origin", "destination", "departure_at", "capacity")
VALUES (NULL, 'QX-IDNULL', 'Eastfield', 'Westhaven', '2026-03-02T10:00:00Z', 80);

-- 10. flight code null. Expected: flight_code, SQLSTATE 23502.
INSERT INTO portfolio."flight" ("flight_id", "flight_code", "origin", "destination", "departure_at", "capacity")
VALUES (9006, NULL, 'Eastfield', 'Westhaven', '2026-03-03T10:00:00Z', 80);

-- 11. flight origin null. Expected: origin, SQLSTATE 23502.
INSERT INTO portfolio."flight" ("flight_id", "flight_code", "origin", "destination", "departure_at", "capacity")
VALUES (9007, 'QX-ORNULL', NULL, 'Westhaven', '2026-03-04T10:00:00Z', 80);

-- 12. flight destination null. Expected: destination, SQLSTATE 23502.
INSERT INTO portfolio."flight" ("flight_id", "flight_code", "origin", "destination", "departure_at", "capacity")
VALUES (9008, 'QX-DENULL', 'Eastfield', NULL, '2026-03-05T10:00:00Z', 80);

-- 13. flight departure null. Expected: departure_at, SQLSTATE 23502.
INSERT INTO portfolio."flight" ("flight_id", "flight_code", "origin", "destination", "departure_at", "capacity")
VALUES (9009, 'QX-DEPNUL', 'Eastfield', 'Westhaven', NULL, 80);

-- 14. flight capacity null. Expected: capacity, SQLSTATE 23502.
INSERT INTO portfolio."flight" ("flight_id", "flight_code", "origin", "destination", "departure_at", "capacity")
VALUES (9010, 'QX-CAPNUL', 'Eastfield', 'Westhaven', '2026-03-06T10:00:00Z', NULL);

-- 15. booking primary duplicate. Expected: pk_booking, SQLSTATE 23505.
INSERT INTO portfolio."booking" ("booking_id", "passenger_id", "flight_id", "booked_on", "seat_code", "status", "fare_amount")
VALUES (3001, 1001, 2001, '2026-01-20', '19A', 'cancelled', 100);

-- 16. booking passenger missing. Expected: fk_booking_0, SQLSTATE 23503.
INSERT INTO portfolio."booking" ("booking_id", "passenger_id", "flight_id", "booked_on", "seat_code", "status", "fare_amount")
VALUES (9011, 9012, 2001, '2026-01-20', '19B', 'cancelled', 100);

-- 17. booking flight missing. Expected: fk_booking_1, SQLSTATE 23503.
INSERT INTO portfolio."booking" ("booking_id", "passenger_id", "flight_id", "booked_on", "seat_code", "status", "fare_amount")
VALUES (9013, 1001, 9014, '2026-01-20', '19C', 'cancelled', 100);

-- 18. booking id null. Expected: booking_id, SQLSTATE 23502.
INSERT INTO portfolio."booking" ("booking_id", "passenger_id", "flight_id", "booked_on", "seat_code", "status", "fare_amount")
VALUES (NULL, 1001, 2001, '2026-01-20', '20A', 'cancelled', 100);

-- 19. booking passenger null. Expected: passenger_id, SQLSTATE 23502.
INSERT INTO portfolio."booking" ("booking_id", "passenger_id", "flight_id", "booked_on", "seat_code", "status", "fare_amount")
VALUES (9015, NULL, 2001, '2026-01-20', '20B', 'cancelled', 100);

-- 20. booking flight null. Expected: flight_id, SQLSTATE 23502.
INSERT INTO portfolio."booking" ("booking_id", "passenger_id", "flight_id", "booked_on", "seat_code", "status", "fare_amount")
VALUES (9016, 1001, NULL, '2026-01-20', '20C', 'cancelled', 100);

-- 21. booking date null. Expected: booked_on, SQLSTATE 23502.
INSERT INTO portfolio."booking" ("booking_id", "passenger_id", "flight_id", "booked_on", "seat_code", "status", "fare_amount")
VALUES (9017, 1001, 2001, NULL, '20D', 'cancelled', 100);

-- 22. booking seat null. Expected: seat_code, SQLSTATE 23502.
INSERT INTO portfolio."booking" ("booking_id", "passenger_id", "flight_id", "booked_on", "seat_code", "status", "fare_amount")
VALUES (9018, 1001, 2001, '2026-01-20', NULL, 'cancelled', 100);

-- 23. booking status null. Expected: status, SQLSTATE 23502.
INSERT INTO portfolio."booking" ("booking_id", "passenger_id", "flight_id", "booked_on", "seat_code", "status", "fare_amount")
VALUES (9019, 1001, 2001, '2026-01-20', '20E', NULL, 100);

-- 24. booking fare null. Expected: fare_amount, SQLSTATE 23502.
INSERT INTO portfolio."booking" ("booking_id", "passenger_id", "flight_id", "booked_on", "seat_code", "status", "fare_amount")
VALUES (9020, 1001, 2001, '2026-01-20', '20F', 'cancelled', NULL);

-- 25. flight capacity nonpositive. Expected: positive_flight_capacity, SQLSTATE 23514.
INSERT INTO portfolio."flight" ("flight_id", "flight_code", "origin", "destination", "departure_at", "capacity")
VALUES (9021, 'QX-ZEROCAP', 'Eastfield', 'Westhaven', '2026-03-07T10:00:00Z', 0);

-- 26. booking confirmed seat duplicate. Expected: confirmed_seat_unique, SQLSTATE 23505.
INSERT INTO portfolio."booking" ("booking_id", "passenger_id", "flight_id", "booked_on", "seat_code", "status", "fare_amount")
VALUES (9022, 1001, 2001, '2026-01-21', '12A', 'confirmed', 100);

-- 27. booking status invalid. Expected: valid_booking_status, SQLSTATE 23514.
INSERT INTO portfolio."booking" ("booking_id", "passenger_id", "flight_id", "booked_on", "seat_code", "status", "fare_amount")
VALUES (9023, 1001, 2001, '2026-01-21', '21A', 'pending', 100);

-- 28. booking fare negative. Expected: nonnegative_fare, SQLSTATE 23514.
INSERT INTO portfolio."booking" ("booking_id", "passenger_id", "flight_id", "booked_on", "seat_code", "status", "fare_amount")
VALUES (9024, 1001, 2001, '2026-01-21', '21B', 'cancelled', -1);
