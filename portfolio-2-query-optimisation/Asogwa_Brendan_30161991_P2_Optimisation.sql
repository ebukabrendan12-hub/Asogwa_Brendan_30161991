-- A separate performance table using the case's booking.booked_on type.
-- Only this field and a lab row ID are copied. Business constraints stay in Portfolio 1.
-- Generated values are for measuring a selective lookup, not complete case records.
CREATE SCHEMA query_lab;
CREATE TABLE query_lab."booking" AS
SELECT "booked_on", 0::bigint AS "lab_row_id" FROM portfolio."booking" WITH NO DATA;
INSERT INTO query_lab."booking" ("booked_on", "lab_row_id")
SELECT (DATE '2030-01-01' + (g % 1000)::integer), g FROM generate_series(1, 50000) AS g;
ANALYZE query_lab."booking";

-- Before: warm the lookup, then measure it three times.
SELECT "lab_row_id", "booked_on"
FROM query_lab."booking"
WHERE "booked_on" = (DATE '2030-01-01' + (42 % 1000)::integer)
ORDER BY "lab_row_id";
EXPLAIN (ANALYZE, BUFFERS)
SELECT "lab_row_id", "booked_on"
FROM query_lab."booking"
WHERE "booked_on" = (DATE '2030-01-01' + (42 % 1000)::integer)
ORDER BY "lab_row_id";
EXPLAIN (ANALYZE, BUFFERS)
SELECT "lab_row_id", "booked_on"
FROM query_lab."booking"
WHERE "booked_on" = (DATE '2030-01-01' + (42 % 1000)::integer)
ORDER BY "lab_row_id";
EXPLAIN (ANALYZE, BUFFERS)
SELECT "lab_row_id", "booked_on"
FROM query_lab."booking"
WHERE "booked_on" = (DATE '2030-01-01' + (42 % 1000)::integer)
ORDER BY "lab_row_id";

CREATE INDEX p2_filter_idx ON query_lab."booking" USING btree ("booked_on");

-- After: run the same lookup and repeat the measurements.
SELECT "lab_row_id", "booked_on"
FROM query_lab."booking"
WHERE "booked_on" = (DATE '2030-01-01' + (42 % 1000)::integer)
ORDER BY "lab_row_id";
EXPLAIN (ANALYZE, BUFFERS)
SELECT "lab_row_id", "booked_on"
FROM query_lab."booking"
WHERE "booked_on" = (DATE '2030-01-01' + (42 % 1000)::integer)
ORDER BY "lab_row_id";
EXPLAIN (ANALYZE, BUFFERS)
SELECT "lab_row_id", "booked_on"
FROM query_lab."booking"
WHERE "booked_on" = (DATE '2030-01-01' + (42 % 1000)::integer)
ORDER BY "lab_row_id";
EXPLAIN (ANALYZE, BUFFERS)
SELECT "lab_row_id", "booked_on"
FROM query_lab."booking"
WHERE "booked_on" = (DATE '2030-01-01' + (42 % 1000)::integer)
ORDER BY "lab_row_id";
