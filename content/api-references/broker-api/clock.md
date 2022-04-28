---
bookHidden: false
weight: 1
bookFlatSection: false
weight: 1
title: Clock
summary: Clock API serves the current market timestamp, whether or not the market is currently open, as well as the times of the next market open and close.
---

# Clock

The Clock API serves the current market timestamp, whether or not the market is currently open, as well as the times of the next market open and close.

---

## **The Clock Object**

### Sample Object

```json
{
  "timestamp": "2022-04-28T14:07:45.485843765-04:00",
  "is_open": true,
  "next_open": "2022-04-29T09:30:00-04:00",
  "next_close": "2022-04-28T16:00:00-04:00"
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
