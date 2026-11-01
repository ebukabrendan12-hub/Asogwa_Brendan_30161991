-- Airline / Flight Booking System: tables, keys and business constraints.
-- Run once in a fresh PostgreSQL database.
BEGIN;
SET LOCAL standard_conforming_strings = on;
CREATE SCHEMA portfolio;
CREATE TABLE portfolio."passenger" (
  "passenger_id" bigint NOT NULL,
  "full_name" text NOT NULL,
  "email" text NOT NULL,
  "created_on" date NOT NULL,
  CONSTRAINT "pk_passenger" PRIMARY KEY ("passenger_id"),
  CONSTRAINT "uq_passenger_0" UNIQUE ("email")
);
CREATE TABLE portfolio."flight" (
  "flight_id" bigint NOT NULL,
  "flight_code" text NOT NULL,
  "origin" text NOT NULL,
  "destination" text NOT NULL,
  "departure_at" timestamptz NOT NULL,
  "capacity" bigint NOT NULL,
  CONSTRAINT "pk_flight" PRIMARY KEY ("flight_id"),
  CONSTRAINT "uq_flight_0" UNIQUE ("flight_code", "departure_at")
);
CREATE TABLE portfolio."booking" (
  "booking_id" bigint NOT NULL,
  "passenger_id" bigint NOT NULL,
  "flight_id" bigint NOT NULL,
  "booked_on" date NOT NULL,
  "seat_code" text NOT NULL,
  "status" text NOT NULL,
  "fare_amount" numeric(18,2) NOT NULL,
  CONSTRAINT "pk_booking" PRIMARY KEY ("booking_id")
);
ALTER TABLE portfolio."booking" ADD CONSTRAINT "fk_booking_0" FOREIGN KEY ("passenger_id") REFERENCES portfolio."passenger" ("passenger_id");
ALTER TABLE portfolio."booking" ADD CONSTRAINT "fk_booking_1" FOREIGN KEY ("flight_id") REFERENCES portfolio."flight" ("flight_id");
ALTER TABLE portfolio."flight" ADD CONSTRAINT "positive_flight_capacity" CHECK ("capacity" > 0);
CREATE UNIQUE INDEX "confirmed_seat_unique" ON portfolio."booking" ("flight_id", "seat_code") WHERE ("status" = 'confirmed');
ALTER TABLE portfolio."booking" ADD CONSTRAINT "valid_booking_status" CHECK (("status" = 'confirmed') OR ("status" = 'cancelled'));
ALTER TABLE portfolio."booking" ADD CONSTRAINT "nonnegative_fare" CHECK ("fare_amount" >= 0);
COMMIT;
