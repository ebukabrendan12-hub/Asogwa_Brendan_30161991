# Portfolio 4 — NoSQL and Advanced Data Models

I used MongoDB collection booking_events for booking_created and seat_changed events. These are fictional event examples based on booking, passenger, flight.

## Document model

| Field | Meaning |
| --- | --- |
| _id | Unique string event ID |
| eventType | One of the two selected case event labels |
| occurredAt | Native BSON Date; sample timestamps are in 2030 |
| source | Original entity, primary key and saved JSON snapshot |
| embedded | Linked record snapshots read with the event |
| references | Keys for linked sources kept outside the embedded snapshots |
| details | Event metadata whose fields vary |

Related passenger, flight details are stored as snapshots with the event. This makes an event readable in one document. It duplicates some information, and later SQL changes do not automatically update the snapshots. PostgreSQL continues to enforce the relational rules.

## Example document

```javascript
{
    "_id": "event_000001",
    "schemaVersion": 1,
    "simulation": true,
    "eventType": "booking_created",
    "occurredAt": ISODate("2030-01-01T10:00:00Z"),
    "source": {
        "entity": "booking",
        "key": {
            "booking_id": 3001
        },
        "snapshot": {
            "booking_id": 3001,
            "passenger_id": 1001,
            "flight_id": 2001,
            "booked_on": "2026-01-15",
            "seat_code": "12A",
            "status": "confirmed",
            "fare_amount": 245.5
        }
    },
    "embedded": {
        "passenger": [
            {
                "key": {
                    "passenger_id": 1001
                },
                "snapshot": {
                    "passenger_id": 1001,
                    "full_name": "Avery Morgan",
                    "email": "avery.morgan@example.test",
                    "created_on": "2026-01-10"
                },
                "via": [
                    "booking.passenger_id → passenger"
                ]
            }
        ],
        "flight": [
            {
                "key": {
                    "flight_id": 2001
                },
                "snapshot": {
                    "flight_id": 2001,
                    "flight_code": "QX101",
                    "origin": "Northport",
                    "destination": "Lakeview",
                    "departure_at": "2026-02-10T09:30:00Z",
                    "capacity": 120
                },
                "via": [
                    "booking.flight_id → flight"
                ]
            }
        ]
    },
    "references": {},
    "details": {
        "channel": "web"
    }
}
```

## Queries and results

| Query | Returned documents |
| --- | --- |
| Find the first sample event type (up to five documents). | 2 |
| Find events for the first source record using nested key fields (up to five). | 2 |
| Find events in the sample time range using a MongoDB Date filter (up to five). | 4 |
| Count documents for each event type. | 2 |

## 1. Find the first sample event type (up to five documents).

```javascript
db.getCollection("booking_events").find({"eventType":"booking_created"}).sort({_id:1}).limit(5).toArray();
```

Selected fields from the returned documents:

```json
[
  {
    "_id": "event_000001",
    "eventType": "booking_created",
    "occurredAt": {
      "$date": "2030-01-01T10:00:00Z"
    },
    "source": {
      "booking_id": 3001
    }
  },
  {
    "_id": "event_000003",
    "eventType": "booking_created",
    "occurredAt": {
      "$date": "2030-01-01T10:02:00Z"
    },
    "source": {
      "booking_id": 3002
    }
  }
]
```

## 2. Find events for the first source record using nested key fields (up to five).

```javascript
db.getCollection("booking_events").find({"source.key.booking_id":3001}).sort({_id:1}).limit(5).toArray();
```

Selected fields from the returned documents:

```json
[
  {
    "_id": "event_000001",
    "eventType": "booking_created",
    "occurredAt": {
      "$date": "2030-01-01T10:00:00Z"
    },
    "source": {
      "booking_id": 3001
    }
  },
  {
    "_id": "event_000002",
    "eventType": "seat_changed",
    "occurredAt": {
      "$date": "2030-01-01T10:01:00Z"
    },
    "source": {
      "booking_id": 3001
    }
  }
]
```

## 3. Find events in the sample time range using a MongoDB Date filter (up to five).

```javascript
db.getCollection("booking_events").find({"occurredAt":{"$gte":ISODate("2030-01-01T10:00:00Z"), "$lt":ISODate("2030-01-01T11:00:00Z")}}).sort({_id:1}).limit(5).toArray();
```

Selected fields from the returned documents:

```json
[
  {
    "_id": "event_000001",
    "eventType": "booking_created",
    "occurredAt": {
      "$date": "2030-01-01T10:00:00Z"
    },
    "source": {
      "booking_id": 3001
    }
  },
  {
    "_id": "event_000002",
    "eventType": "seat_changed",
    "occurredAt": {
      "$date": "2030-01-01T10:01:00Z"
    },
    "source": {
      "booking_id": 3001
    }
  },
  {
    "_id": "event_000003",
    "eventType": "booking_created",
    "occurredAt": {
      "$date": "2030-01-01T10:02:00Z"
    },
    "source": {
      "booking_id": 3002
    }
  },
  {
    "_id": "event_000004",
    "eventType": "seat_changed",
    "occurredAt": {
      "$date": "2030-01-01T10:03:00Z"
    },
    "source": {
      "booking_id": 3002
    }
  }
]
```

## 4. Count documents for each event type.

```javascript
db.getCollection("booking_events").aggregate([{"$group":{"_id":"$eventType", "documentCount":{"$sum":1}}}, {"$sort":{"_id":1}}]).toArray();
```

| _id | documentCount |
| --- | --- |
| booking_created | 2 |
| seat_changed | 2 |

## Validation and suitability

MongoDB inserted 4 documents. An invalid date type was rejected with code 121 and a repeated event ID with 11000. The collection still contained 4 valid documents. The compound eventType/occurredAt index supports those access fields; this exercise does not measure its speed.

The details field can vary across event types, while the common fields have a validator. Events can be added as separate documents rather than growing one large history record.

## Run the script

Connect mongosh to a fresh exercise database and run Asogwa_Brendan_30161991_P4_MongoDB.js. It selects portfolio_nosql, creates the collection, inserts the sample documents and displays the query results. [Implementation evidence](screenshots/Asogwa_Brendan_30161991_P4_DocumentsAndQueries.png).

## References

- [MongoDB — data modelling](https://www.mongodb.com/docs/manual/data-modeling/)

