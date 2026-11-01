# MIT 8103 Advanced Database Systems

**Airline / Flight Booking System** · Brendan Asogwa · Student ID 30161991

## Case study

My case study is Airline / Flight Booking System. I designed the database for passengers reviewing their bookings and airline staff managing flights and bookings, with separate tables named passenger, flight and booking. It supports these operations: create and look up passenger bookings; find confirmed bookings for flights in a departure-time range; summarize confirmed bookings and booking value by flight.

## Portfolio 1: Database Design and Modelling

I organised the relational design into 3 tables. Primary keys identify records, foreign keys preserve the links, and checks enforce the stated business rules. Only one confirmed booking may use a given seat code on a flight; apply a partial unique rule to flight_id and seat_code where status is confirmed. The normalisation examples show the sample data at 1NF, 2NF and 3NF. All 28 deliberately invalid inserts were rejected without changing the valid sample rows.

![Airline / Flight Booking System ER diagram](images/Asogwa_Brendan_30161991_ERDiagram.png)

Figure 1. Tables, keys and relationships. PK: primary key; FK: foreign key; UK: unique value.

<!-- PAGE BREAK -->

## Portfolio 2: Query Processing and Optimisation

I ran three SQL queries against the sample records. The join returned 2 rows and included Avery Morgan with QX101. For the index comparison, I used 50,000 separate performance rows. The median lookup time changed from 2.023 ms to 0.297 ms. Both phases returned the same records. The measured plan used the new index. These timings apply to this lookup and environment.

## Portfolio 3: Transactions and Concurrency

I used a temporary counter on booking to test COMMIT, ROLLBACK and READ COMMITTED isolation. The uncommitted update remained hidden from the other session, and ROLLBACK restored the earlier committed value. Without locking, two increments left the counter at 2. With SELECT FOR UPDATE, Session B waited for Session A and the final value was 3. The helper is confined to this exercise; the case's original business fields stay unchanged.

## Portfolio 4: NoSQL and Advanced Data Models

I used booking_events for the case's event documents. MongoDB inserted 4 sample events and returned the expected results for 4 queries. Validation rejected an invalid date type and a duplicate event ID. Embedded snapshots keep related details with an event, while the details field can differ by event type. These are fictional events; PostgreSQL continues to enforce its relational rules.

## Repository and evidence

https://github.com/ebukabrendan12-hub/Asogwa_Brendan_30161991

The portfolio folders contain the SQL and JavaScript, explanations, query plans, result tables and screenshots.


<!-- PAGE BREAK -->

## Portfolio 5: Distributed and Cloud Database Exercise

I proposed three MongoDB replica members across separate failure zones. The discussion covers primary elections, majority acknowledgement, secondary lag and sharding trade-offs for booking_events. Replication supports availability, while backups address recovery. PostgreSQL needs its own availability plan. This is the permitted discussion option; no live replica set or failover test was deployed.

## Individual reflection

I kept passenger, flight, booking in separate tables so their details could be maintained without repeating them in every related record. Only one confirmed booking may use a given seat code on a flight; apply a partial unique rule to flight_id and seat_code where status is confirmed. The constraint tests check this alongside the required values and record links. One issue illustrated by the two-session exercise is that both sessions can read the same value before either update is committed. Locking the row before reading preserves both increments. The index comparison also shows why I need to check the execution plan as well as the final answer: the same result can require different amounts of database work.

## AI-use declaration

I used GitHub Copilot and containerized database instances to help prepare the database model, scripts, and explanations. I ran and tested the PostgreSQL and MongoDB exercises directly within my development workspace, verified their outputs, and captured the result images. I remain responsible for checking and explaining the submitted work.

## References

- [PostgreSQL: constraints](https://www.postgresql.org/docs/17/ddl-constraints.html)
- [PostgreSQL: EXPLAIN](https://www.postgresql.org/docs/17/using-explain.html)
- [PostgreSQL: isolation](https://www.postgresql.org/docs/17/transaction-iso.html)
- [PostgreSQL: row locks](https://www.postgresql.org/docs/17/explicit-locking.html)
- [MongoDB: data modelling](https://www.mongodb.com/docs/manual/data-modeling/)
- [MongoDB: replication](https://www.mongodb.com/docs/manual/replication/)
- [MongoDB: sharding](https://www.mongodb.com/docs/manual/sharding/)
- [Mermaid: ER diagrams](https://mermaid.js.org/syntax/entityRelationshipDiagram.html)

