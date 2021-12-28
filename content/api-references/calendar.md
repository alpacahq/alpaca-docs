---
bookHidden: false
weight: 1
bookFlatSection: true
weight: 1
title: Calendar API
summary: Calendar API serves the full list of market days from 1970 to 2029.
---

# Calendar

The calendar API serves the full list of market days from 1970 to 2029. It can also be queried by specifying a start and/or end time to narrow down the results. In addition to the dates, the response also contains the specific open and close times for the market days, taking into account early closures.

---

## **The Calendar Object**

### Sample Object

```json
{
  "date": "2021-04-06",
  "open": "09:30",
  "close": "16:00"
}
```

### Attributes

| Attribute | Type   | Notes                                                        |
| --------- | ------ | ------------------------------------------------------------ |
| `date`    | string | Date string in YYYY-MM-DD format                             |
| `open`    | string | The time the market opens at on this date in HH:MM format  |
| `close`   | string | The time the market closes at on this date in HH:MM format |

---

## **Retrieving the Market Calendar**

`GET /v1/calendar`

### Request

#### Query Parameters

| Attribute | Type             | Requirement                         | Notes                                           |
| --------- | ---------------- | ----------------------------------- | ----------------------------------------------- |
| `start`   | string/timestamp | {{<hint info>}}Optional {{</hint>}} | The first date to retrieve data for (inclusive) in YYYY-MM-DD format |
| `end`     | string/timestamp | {{<hint info>}}Optional {{</hint>}} | The last date to retrieve data for (inclusive) in YYYY-MM-DD format |

### Response

The calendar object

&nbsp;
