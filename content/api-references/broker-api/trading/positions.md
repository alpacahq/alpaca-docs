---
bookHidden: false
weight: 2
summary: Open brokerage accounts, enable crypto and stock trading, and manage the ongoing user experience with Alpaca Broker API
---

# Positions

The positions API provides information about an account’s current open positions. The response will include information such as cost basis, shares traded, and market value, which will be updated live as price information is updated. Once a position is closed, it will no longer be queryable through this API.

---

## **The Position Object**

### Sample Position Object

```json
{
  "asset_id": "904837e3-3b76-47ec-b432-046db621571b",
  "symbol": "AAPL",
  "exchange": "NASDAQ",
  "asset_class": "us_equity",
  "avg_entry_price": "100.0",
  "qty": "5",
  "side": "long",
  "market_value": "600.0",
  "cost_basis": "500.0",
  "unrealized_pl": "100.0",
  "unrealized_plpc": "0.20",
  "unrealized_intraday_pl": "10.0",
  "unrealized_intraday_plpc": "0.0084",
  "current_price": "120.0",
  "lastday_price": "119.0",
  "change_today": "0.0084"
}
```

### Attributes

| Attribute                  | Type          | Notes                                                                               |
| -------------------------- | ------------- | ----------------------------------------------------------------------------------- |
| `asset_id`                 | string/UUID   | Asset ID                                                                            |
| `symbol`                   | string        | Asset symbol                                                                        |
| `exchange`                 | string        | Exchange name of the asset                                                          |
| `asset_class`              | string        | Asset class name                                                                    |
| `avg_entry_price`          | string/number | Average entry price of the position                                                 |
| `qty`                      | string/int    | The number of shares                                                                |
| `side`                     | string        | `long`                                                                              |
| `market_value`             | string/number | Total dollar amount of the position                                                 |
| `cost_basis`               | string/number | Total cost basis in dollar                                                          |
| `unrealized_pl`            | string/number | Unrealized profit/loss in dollars                                                   |
| `unrealized_plpc`          | string/number | Unrealized profit/loss percent (by a factor of 1)                                   |
| `unrealized_intraday_pl`   | string/number | Unrealized profit/loss in dollars for the day                                       |
| `unrealized_intraday_plpc` | string/number | Unrealized profit/loss percent (by a factor of 1)                                   |
| `current_price`            | string/number | Current asset price per share                                                       |
| `lastday_price`            | string/number | Last day’s asset price per share based on the closing value of the last trading day |
| `change_today`             | string/number | Percent change from last day price (by a factor of 1)                               |
| `swap_rate`                | string/number | description needed.                                                                 |
| `usd`                      | string/number | description needed.                                                                 |
| `avg_entry_swap_rate`      | string/number | description needed.                                                                 |

---

## **Getting All Positions**

`GET /v1/trading/accounts/{account_id}/positions`

Retrieves a list of the account's open positions.

### Request

N/A

### Response

An array of Position objects

---

## **Getting an Open Position**

`GET /v1/trading/accounts/{account_id}/positions/{symbol}`

Retrieves the account's open position for the given `symbol` or `asset_id`.

### Request

#### Parameters

| Attribute | Type   | Notes                             |
| --------- | ------ | --------------------------------- |
| `symbol`  | string | PATH - The `symbol` or `asset_id` |

### Response

The requested Position object

#### Error Codes

{{<hint warning>}}**`404`** - Not Found: Position is not found{{</hint>}}

---

## **Close All Positions**

`DELETE /v1/trading/accounts/{account_id}/positions`

Closes (liquidates) all of the account’s open long and short positions. A response will be provided for each order that is attempted to be cancelled. If an order is no longer cancelable, the server will respond with status 500 and reject the request.

### Request

#### Parameters

| Attribute       | Type    | Notes                                                                                  |
| --------------- | ------- | -------------------------------------------------------------------------------------- |
| `cancel_orders` | boolean | QUERY - If true is specified, cancel all open orders before liquidating all positions. |

### Response

HTTP 207 Multi-Status with body; an array of objects that include the order id and http status code for each status request.

#### Error Codes

{{<hint warning>}}**`500`** - Failed to liquidate{{</hint>}}

---

## **Closing a Position**

`DELETE /v1/trading/accounts/{account_id}/positions/{symbol}`

Closes (liquidates) the account’s open position for the given `symbol`. Works for both long and short positions.

### Request

#### Parameters

| Attribute    | Type   | Notes                                                |
| ------------ | ------ | ---------------------------------------------------- |
| `symbol`     | string | PATH - `symbol` or `asset_id`                        |
| `qty`        | string | QUERY - The number of shares to liquidate            |
| `percentage` | string | QUERY - Percentage of position you want to liquidate |

### Response

An Order object

#### Error Codes

{{<hint warning>}}**`404`** - Not Found: Order is not found{{</hint>}}

&nbsp;
