# Airline / Flight Booking System — ER diagram

```mermaid
erDiagram
    direction LR
    passenger {
        bigint passenger_id PK
        text full_name
        text email UK
        date created_on
    }
    flight {
        bigint flight_id PK
        text flight_code
        text origin
        text destination
        timestamptz departure_at
        integer capacity
    }
    booking {
        bigint booking_id PK
        bigint passenger_id FK
        bigint flight_id FK
        date booked_on
        text seat_code
        text status
        numeric fare_amount
    }
    passenger ||--o{ booking : "passenger_id"
    flight ||--o{ booking : "flight_id"
```

PK identifies a record; FK links to another table; UK marks a single-field unique value. The relationship ends show exactly one, zero or one, or zero or many records. Composite unique keys and conditional rules are listed in the schema and design.

[Diagram image](../images/Asogwa_Brendan_30161991_ERDiagram.png)
