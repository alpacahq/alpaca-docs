---
bookHidden: false
weight: 3
summary: Open brokerage accounts, enable crypto and stock trading, and manage the ongoing user experience with Alpaca Broker API
---

# Portfolio History

The portfolio history API returns the timeseries data for equity and profit loss information of the account.

---

## **The Portfolio History Object**

### Sample Object

```json
{
  "timestamp": [1580826600000, 1580827500000, 1580828400000],
  "equity": [27423.73, 27408.19, 27515.97],
  "profit_loss": [11.8, -3.74, 104.04],
  "profit_loss_pct": [
    0.000430469507254688, -0.0001364369455197062, 0.0037954277571845543
  ],
  "base_value": 27411.93,
  "timeframe": "15Min"
}
```

### Attributes

| Attribute         | Type                            | Description                                                                    |
| ----------------- | ------------------------------- | ------------------------------------------------------------------------------ |
| `timestamp`       | array of epoch int (in seconds) | time of each data element, left-labeled (the beginning of time window)         |
| `equity`          | array of number                 | equity value of the account in dollar amount as of the end of each time window |
| `profit_loss`     | array of number                 | profit/loss in dollar from the base value                                      |
| `profit_loss_pct` | array of number                 | profit/loss in percentage from the base value                                  |
| `base_value`      | number                          | basis in dollar of the profit loss calculation                                 |
| `timeframe`       | string                          | time window size of each data element                                          |

---

## **Getting Account Portfolio History**

`GET /v1/trading/accounts/{account_id}/account/portfolio/history`

Returns timeseries data about equity and profit/loss (P/L) of the account in requested timespan.

### Request

#### Parameters

| Attribute        | Type        | Required                            | Notes                                                                                                                                                                              |
| ---------------- | ----------- | ----------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `period`         | string      | {{<hint info>}}Optional {{</hint>}} | The duration of the data in _number_ + _unit_, such as `1D`. _unit_ can be `D` for day, `W` for week, `M` for month and `A` for year. Defaults to `1M`.                            |
| `timeframe`      | string      | {{<hint info>}}Optional {{</hint>}} | The resolution of time window. `1Min`, `5Min`, `15Min`, `1H`, or `1D`. If omitted, `1Min` for less than 7 days period, `15Min` for less than 30 days, or otherwise `1D`.           |
| `date_end`       | string/date | {{<hint info>}}Optional {{</hint>}} | The date the data is returned up to, in “YYYY-MM-DD” format. Defaults to the current market date (rolls over at the market open if `extended_hours` is false, otherwise at 7am ET) |
| `extended_hours` | boolean     | {{<hint info>}}Optional {{</hint>}} | If `true`, include extended hours in the result. This is effective only for timeframe less than `1D`.                                                                              |
| `since_midnight` | boolean     | {{<hint info>}}Optional {{</hint>}} | If `true` returns the current day of portfolio history |

### Response

The requested portfolio history object

&nbsp;
