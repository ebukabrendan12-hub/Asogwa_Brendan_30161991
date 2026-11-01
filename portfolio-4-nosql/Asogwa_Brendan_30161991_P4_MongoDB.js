// Run once in mongosh against a fresh exercise database.
// These records are fictional events for the case study.
(async function () {
  db = db.getSiblingDB('portfolio_nosql');
  if ((await db.getCollectionNames()).includes("booking_events")) {
    throw new Error('The exercise collection already exists. Use a fresh database.');
  }

  // The validator checks the stable event fields while details can vary.
  await db.createCollection("booking_events", {
    validator: {
    "$jsonSchema": {
        "bsonType": "object",
        "required": [
            "_id",
            "schemaVersion",
            "simulation",
            "eventType",
            "occurredAt",
            "source",
            "embedded",
            "references",
            "details"
        ],
        "properties": {
            "_id": {
                "bsonType": "string",
                "minLength": 1
            },
            "schemaVersion": {
                "enum": [
                    1
                ]
            },
            "simulation": {
                "enum": [
                    true
                ]
            },
            "eventType": {
                "bsonType": "string",
                "enum": [
                    "booking_created",
                    "seat_changed"
                ]
            },
            "occurredAt": {
                "bsonType": "date"
            },
            "source": {
                "bsonType": "object",
                "required": [
                    "entity",
                    "key",
                    "snapshot"
                ],
                "properties": {
                    "entity": {
                        "enum": [
                            "booking"
                        ]
                    },
                    "key": {
                        "bsonType": "object",
                        "required": [
                            "booking_id"
                        ]
                    },
                    "snapshot": {
                        "bsonType": "object"
                    }
                }
            },
            "embedded": {
                "bsonType": "object"
            },
            "references": {
                "bsonType": "object"
            },
            "details": {
                "bsonType": "object"
            }
        }
    }
},
    validationLevel: 'strict', validationAction: 'error'
  });

  // Insert the four example events and show their IDs.
  printjson(await db.getCollection("booking_events").insertMany([
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
    },
    {
        "_id": "event_000002",
        "schemaVersion": 1,
        "simulation": true,
        "eventType": "seat_changed",
        "occurredAt": ISODate("2030-01-01T10:01:00Z"),
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
            "channel": "mobile",
            "note": "Illustrative event-specific metadata",
            "examples": {
                "reason": "illustrative reason",
                "previous_seat": "illustrative previous_seat",
                "new_seat": "illustrative new_seat"
            }
        }
    },
    {
        "_id": "event_000003",
        "schemaVersion": 1,
        "simulation": true,
        "eventType": "booking_created",
        "occurredAt": ISODate("2030-01-01T10:02:00Z"),
        "source": {
            "entity": "booking",
            "key": {
                "booking_id": 3002
            },
            "snapshot": {
                "booking_id": 3002,
                "passenger_id": 1002,
                "flight_id": 2001,
                "booked_on": "2026-01-16",
                "seat_code": "12B",
                "status": "confirmed",
                "fare_amount": 245.5
            }
        },
        "embedded": {
            "passenger": [
                {
                    "key": {
                        "passenger_id": 1002
                    },
                    "snapshot": {
                        "passenger_id": 1002,
                        "full_name": "Jordan Lee",
                        "email": "jordan.lee@example.test",
                        "created_on": "2026-01-11"
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
    },
    {
        "_id": "event_000004",
        "schemaVersion": 1,
        "simulation": true,
        "eventType": "seat_changed",
        "occurredAt": ISODate("2030-01-01T10:03:00Z"),
        "source": {
            "entity": "booking",
            "key": {
                "booking_id": 3002
            },
            "snapshot": {
                "booking_id": 3002,
                "passenger_id": 1002,
                "flight_id": 2001,
                "booked_on": "2026-01-16",
                "seat_code": "12B",
                "status": "confirmed",
                "fare_amount": 245.5
            }
        },
        "embedded": {
            "passenger": [
                {
                    "key": {
                        "passenger_id": 1002
                    },
                    "snapshot": {
                        "passenger_id": 1002,
                        "full_name": "Jordan Lee",
                        "email": "jordan.lee@example.test",
                        "created_on": "2026-01-11"
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
            "channel": "mobile",
            "note": "Illustrative event-specific metadata",
            "examples": {
                "reason": "illustrative reason",
                "previous_seat": "illustrative previous_seat",
                "new_seat": "illustrative new_seat"
            }
        }
    }
]));
  await db.getCollection("booking_events").createIndex({eventType: 1, occurredAt: -1}, {name: 'event_type_time'});

  // 1. Find the first sample event type (up to five documents).
  printjson(await db.getCollection("booking_events").find({"eventType":"booking_created"}).sort({_id:1}).limit(5).toArray());

  // 2. Find events for the first source record using nested key fields (up to five).
  printjson(await db.getCollection("booking_events").find({"source.key.booking_id":3001}).sort({_id:1}).limit(5).toArray());

  // 3. Find events in the sample time range using a MongoDB Date filter (up to five).
  printjson(await db.getCollection("booking_events").find({"occurredAt":{"$gte":ISODate("2030-01-01T10:00:00Z"), "$lt":ISODate("2030-01-01T11:00:00Z")}}).sort({_id:1}).limit(5).toArray());

  // 4. Count documents for each event type.
  printjson(await db.getCollection("booking_events").aggregate([{"$group":{"_id":"$eventType", "documentCount":{"$sum":1}}}, {"$sort":{"_id":1}}]).toArray());

  // A date stored as text should be rejected by the validator.
  try {
    await db.getCollection("booking_events").insertOne({...{
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
}, _id: 'invalid_date_example', occurredAt: 'not-a-date'});
  } catch (error) { print('Invalid date error: ' + error.code); }

  // Reusing an event ID should be rejected by the unique _id index.
  try { await db.getCollection("booking_events").insertOne({
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
}); }
  catch (error) { print('Duplicate ID error: ' + error.code); }

  print('Document count: ' + await db.getCollection("booking_events").countDocuments());
})().catch(error => { print(error.stack || String(error)); quit(1); });
