-- Show related booking, passenger, flight records (up to 20).
SELECT t0."booking_id" AS "booking_booking_id",
       t0."booked_on" AS "booking_booked_on",
       t1."passenger_id" AS "passenger_passenger_id",
       t1."full_name" AS "passenger_full_name",
       t2."flight_id" AS "flight_flight_id",
       t2."flight_code" AS "flight_flight_code"
FROM portfolio."booking" t0
JOIN portfolio."passenger" t1 ON t0."passenger_id" = t1."passenger_id"
JOIN portfolio."flight" t2 ON t0."flight_id" = t2."flight_id"
ORDER BY t0."booking_id", t1."passenger_id", t2."flight_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT t0."booking_id" AS "booking_booking_id",
       t0."booked_on" AS "booking_booked_on",
       t1."passenger_id" AS "passenger_passenger_id",
       t1."full_name" AS "passenger_full_name",
       t2."flight_id" AS "flight_flight_id",
       t2."flight_code" AS "flight_flight_code"
FROM portfolio."booking" t0
JOIN portfolio."passenger" t1 ON t0."passenger_id" = t1."passenger_id"
JOIN portfolio."flight" t2 ON t0."flight_id" = t2."flight_id"
ORDER BY t0."booking_id", t1."passenger_id", t2."flight_id"
LIMIT 20;

-- Find flight records where flight_code matches "QX101" (up to 20).
SELECT * FROM portfolio."flight"
WHERE "flight_code" IS NOT DISTINCT FROM 'QX101'
ORDER BY "flight_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT * FROM portfolio."flight"
WHERE "flight_code" IS NOT DISTINCT FROM 'QX101'
ORDER BY "flight_id"
LIMIT 20;

-- Count booking records for each passenger_id (up to 20 groups).
SELECT "passenger_id", count(*) AS record_count
FROM portfolio."booking"
GROUP BY "passenger_id"
ORDER BY record_count DESC, "passenger_id" NULLS LAST
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT "passenger_id", count(*) AS record_count
FROM portfolio."booking"
GROUP BY "passenger_id"
ORDER BY record_count DESC, "passenger_id" NULLS LAST
LIMIT 20;
