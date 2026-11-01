# Airline / Flight Booking System — database design

My case study records passenger, flight, booking.

## Users

- Passengers reviewing their bookings
- Airline staff managing flights and bookings

## Main operations

- Create and look up passenger bookings
- Find confirmed bookings for flights in a departure-time range
- Summarize confirmed bookings and booking value by flight

## Entities

| Entity | Information stored |
| --- | --- |
| passenger | Stores passenger identity and contact details. |
| flight | Stores a scheduled flight, its route, and seat capacity. |
| booking | Links one passenger to one scheduled flight and records their seat and booking status. |

## passenger

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| passenger_id | BIGINT | PK | Yes |
| full_name | TEXT |  | Yes |
| email | TEXT | Unique | Yes |
| created_on | DATE |  | Yes |
- Unique key: (email).

## flight

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| flight_id | BIGINT | PK | Yes |
| flight_code | TEXT |  | Yes |
| origin | TEXT |  | Yes |
| destination | TEXT |  | Yes |
| departure_at | TIMESTAMPTZ |  | Yes |
| capacity | INTEGER |  | Yes |
- Unique key: (flight_code, departure_at).

## booking

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| booking_id | BIGINT | PK | Yes |
| passenger_id | BIGINT | FK | Yes |
| flight_id | BIGINT | FK | Yes |
| booked_on | DATE |  | Yes |
| seat_code | TEXT |  | Yes |
| status | TEXT |  | Yes |
| fare_amount | NUMERIC(18,2) |  | Yes |
- passenger_id → passenger.passenger_id
- flight_id → flight.flight_id

## Relationships and business rules

- Each passenger email identifies at most one passenger.
- A flight code and departure time together identify one scheduled flight.
- A scheduled flight must have capacity greater than zero.
- Every booking references an existing passenger.
- Every booking references an existing scheduled flight.
- Only one confirmed booking may use a given seat code on a flight; apply a partial unique rule to flight_id and seat_code where status is confirmed.
- Booking status must be confirmed or cancelled.
- A booking fare must be zero or greater.

## Assumptions

- Each booking belongs to exactly one passenger and one scheduled flight; a passenger or flight may have multiple bookings.
- A seat code is unique among confirmed bookings for the same flight; cancelled bookings do not reserve seats.
- Worked normalization example: split a booking row containing passenger name and email, flight code and route, departure time, seat, and booking status into passenger, flight, and booking records. Booking retains passenger_id and flight_id as foreign keys, with each passenger and flight represented once.
- All records and example values used for this exercise are synthetic.

