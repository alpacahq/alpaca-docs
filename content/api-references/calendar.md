---
bookHidden: false
weight: 3
summary: Open brokerage accounts, enable commission-free trading, and manage the ongoing user experience with Alpaca Broker API
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
| `date`    | string | Date string in “%Y-%m-%d” format                             |
| `open`    | string | The time the market opens at on this date in “%H:%M” format  |
| `close`   | string | The time the market closes at on this date in “%H:%M” format |

---

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

&nbsp;
