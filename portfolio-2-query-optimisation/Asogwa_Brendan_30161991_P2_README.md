# Airline / Flight Booking System — SQL queries

## 1. Show related booking, passenger, flight records (up to 20).

```sql
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
```

| booking_booking_id | booking_booked_on | passenger_passenger_id | passenger_full_name | flight_flight_id | flight_flight_code |
| --- | --- | --- | --- | --- | --- |
| 3001 | 2026-01-15 | 1001 | Avery Morgan | 2001 | QX101 |
| 3002 | 2026-01-16 | 1002 | Jordan Lee | 2001 | QX101 |

## 2. Find flight records where flight_code matches "QX101" (up to 20).

```sql
SELECT * FROM portfolio."flight"
WHERE "flight_code" IS NOT DISTINCT FROM 'QX101'
ORDER BY "flight_id"
LIMIT 20;
```

| flight_id | flight_code | origin | destination | departure_at | capacity |
| --- | --- | --- | --- | --- | --- |
| 2001 | QX101 | Northport | Lakeview | 2026-02-10T09:30:00+00:00 | 120 |

## 3. Count booking records for each passenger_id (up to 20 groups).

```sql
SELECT "passenger_id", count(*) AS record_count
FROM portfolio."booking"
GROUP BY "passenger_id"
ORDER BY record_count DESC, "passenger_id" NULLS LAST
LIMIT 20;
```

| passenger_id | record_count |
| --- | --- |
| 1001 | 1 |
| 1002 | 1 |


## Index comparison

| Phase | Median (ms) | Three runs (ms) | Plan nodes | Buffer hits |
| --- | --- | --- | --- | --- |
| Before index | 2.023 | 2.023, 1.982, 2.024 | Sort → Seq Scan | 274 |
| After index | 0.297 | 0.295, 0.323, 0.297 | Sort → Bitmap Heap Scan → Bitmap Index Scan | 55 |

The median execution time changed from 2.023 ms to 0.297 ms. The measured plan used p2_filter_idx. The results matched in both phases. An index adds storage and write-maintenance costs; timings depend on the selected lookup and environment.

## Execution plans

### Before index, run 1

```text
Sort (actual time=1.986..1.993 rows=50 loops=1)
  Seq Scan on booking (actual time=0.015..1.949 rows=50 loops=1)
Planning Time: 0.325 ms
Execution Time: 2.023 ms
```

### Before index, run 2

```text
Sort (actual time=1.947..1.955 rows=50 loops=1)
  Seq Scan on booking (actual time=0.015..1.909 rows=50 loops=1)
Planning Time: 0.349 ms
Execution Time: 1.982 ms
```

### Before index, run 3

```text
Sort (actual time=1.988..1.995 rows=50 loops=1)
  Seq Scan on booking (actual time=0.015..1.948 rows=50 loops=1)
Planning Time: 0.346 ms
Execution Time: 2.024 ms
```

### After index, run 1

```text
Sort (actual time=0.221..0.228 rows=50 loops=1)
  Bitmap Heap Scan on booking (actual time=0.033..0.184 rows=50 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.014..0.014 rows=50 loops=1)
Planning Time: 0.521 ms
Execution Time: 0.295 ms
```

### After index, run 2

```text
Sort (actual time=0.268..0.275 rows=50 loops=1)
  Bitmap Heap Scan on booking (actual time=0.057..0.23 rows=50 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.037..0.037 rows=50 loops=1)
Planning Time: 0.534 ms
Execution Time: 0.323 ms
```

### After index, run 3

```text
Sort (actual time=0.242..0.248 rows=50 loops=1)
  Bitmap Heap Scan on booking (actual time=0.035..0.204 rows=50 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.015..0.015 rows=50 loops=1)
Planning Time: 0.56 ms
Execution Time: 0.297 ms
```

## Reproduce

Use a fresh database with the Portfolio 1 schema and sample data. Run Asogwa_Brendan_30161991_P2_Queries.sql, then Asogwa_Brendan_30161991_P2_Optimisation.sql. The optimisation script creates a separate performance table and runs EXPLAIN (ANALYZE, BUFFERS).

[Query screenshot](screenshots/Asogwa_Brendan_30161991_P2_QueryResults.png) · [Index comparison](screenshots/Asogwa_Brendan_30161991_P2_IndexComparison.png)

## References

- [PostgreSQL — EXPLAIN](https://www.postgresql.org/docs/17/using-explain.html)

