# Airline / Flight Booking System — normalisation

The example uses the saved sample records. The full set of fields is in the design and schema.

## Starting grouped records

| passenger_id | booking records (list) |
| --- | --- |
| 1001 | [3001] |
| 1002 | [3002] |


The record IDs are grouped in a list. In 1NF, each record has its own row and each cell holds one value.

## 1NF: one value per cell

| booking.booking_id | booking.passenger_id | booking.flight_id | booking.seat_code | passenger.passenger_id | passenger.full_name | flight.flight_id | flight.flight_code |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 3001 | 1001 | 2001 | 12A | 1001 | Avery Morgan | 2001 | QX101 |
| 3002 | 1002 | 2001 | 12B | 1002 | Jordan Lee | 2001 | QX101 |

Key: booking_id.

## 2NF: depend on the whole key

The declared candidate keys do not introduce a partial dependency here, so the 1NF rows stay unchanged at this step.

## booking_example

| booking.booking_id | booking.passenger_id | booking.flight_id | booking.seat_code | passenger.passenger_id | passenger.full_name | flight.flight_id | flight.flight_code |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 3001 | 1001 | 2001 | 12A | 1001 | Avery Morgan | 2001 | QX101 |
| 3002 | 1002 | 2001 | 12B | 1002 | Jordan Lee | 2001 | QX101 |

## 3NF: store each entity’s details once

The entity keys determine their own descriptions. Related records keep foreign keys rather than repeating those descriptions.

## passenger

| passenger_id | full_name | email | created_on |
| --- | --- | --- | --- |
| 1001 | Avery Morgan | avery.morgan@example.test | 2026-01-10 |
| 1002 | Jordan Lee | jordan.lee@example.test | 2026-01-11 |

## flight

| flight_id | flight_code | origin | destination | departure_at | capacity |
| --- | --- | --- | --- | --- | --- |
| 2001 | QX101 | Northport | Lakeview | 2026-02-10T09:30:00+00:00 | 120 |
| 2002 | QX205 | Lakeview | Pinecrest | 2026-02-11T14:15:00+00:00 | 90 |

## booking

| booking_id | passenger_id | flight_id | booked_on | seat_code | status | fare_amount |
| --- | --- | --- | --- | --- | --- | --- |
| 3001 | 1001 | 2001 | 2026-01-15 | 12A | confirmed | 245.5 |
| 3002 | 1002 | 2001 | 2026-01-16 | 12B | confirmed | 245.5 |

## Dependencies

- passenger: (passenger_id) → full_name, email, created_on
- flight: (flight_id) → flight_code, origin, destination, departure_at, capacity
- booking: (booking_id) → passenger_id, flight_id, booked_on, seat_code, status, fare_amount

Joining the decomposed sample tables reproduces the original 2 example rows. The design assumes the declared keys describe the relevant business dependencies.
