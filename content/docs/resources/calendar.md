---
bookHidden: false
weight: 3
---

# Calendar 🗓

&nbsp;

The calendar API serves the full list of market days from 1970 to 2029. It can also be queried by specifying a start and/or end time to narrow down the results. In addition to the dates, the response also contains the specific open and close times for the market days, taking into account early closures.

## **Retrieving the Market Calendar**

`GET /v1/calendar`

### Request

#### Sample Request

```json
{
  "start": "01-01-2020",
  "end": "01-01-2021"
}
```

#### Parameters

| Attribute | Type             | Requirement                         | Notes                                           |
| --------- | ---------------- | ----------------------------------- | ----------------------------------------------- |
| `start`   | string/timestamp | {{<hint info>}}Optional {{</hint>}} | The first date to retrieve data for (inclusive) |
| `end`     | string/timestamp | {{<hint info>}}Optional {{</hint>}} | The last date to retrieve data for (inclusive)  |

### Response

The calendar object

#### Sample Response

```json
{
  "date": "2018-01-03",
  "open": "09:30",
  "close": "16:00"
}
```

#### Parameters

| Attribute | Type   | Notes                                                        |
| --------- | ------ | ------------------------------------------------------------ |
| `date`    | string | Date string in “%Y-%m-%d” format                             |
| `open`    | string | The time the market opens at on this date in “%H:%M” format  |
| `close`   | string | The time the market closes at on this date in “%H:%M” format |
