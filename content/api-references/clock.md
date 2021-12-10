---
bookHidden: false
weight: 20
summary: Open brokerage accounts, enable commission-free trading, and manage the ongoing user experience with Alpaca Broker API
---

# Clock

The clock API serves the current market timestamp, whether or not the market is currently open, as well as the times of the next market open and close.

---

## **The Clock Object**

### Sample Object

```json
{
  "timestamp": "2018-04-01T12:00:00.000Z",
  "is_open": true,
  "next_open": "2018-04-01T12:00:00.000Z",
  "next_close": "2018-04-01T12:00:00.000Z"
}
```

### Attributes

| Attribute    | Type             | Requirement                       |
| ------------ | ---------------- | --------------------------------- |
| `timestamp`  | string/timestamp | Current timestamp                 |
| `is_open`    | boolean          | Whether the market is open or not |
| `next_open`  | string/timestamp | Next market open timestamp        |
| `next_close` | string/timestamp | Next market close timestamp       |

---

## **Get the Clock**

`GET /v1/clock`

### Request

N/A

### Response

Returns the Clock object.

&nbsp;
