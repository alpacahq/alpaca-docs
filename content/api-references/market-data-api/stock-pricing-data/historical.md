---
weight: 11
title: Historical Data
---

# Historical Stock Pricing Data

## **Subscription Plans**

The limitations listed below are default values but can be configured upon request.

**Free plan**

- 6+ years historical SIP data available
- Historical data is delayed by 15 minutes
- REST API calls are limited at 200/min

**Unlimited plan**

- 6+ years historical SIP data available
- Historical data is not delayed
- Unlimited REST API

## **Common Behavior**

### Base URL

Alpaca Data API v2 provides historical data through multiple endpoints. These endpoints have the same URL prefix:

`https://data.alpaca.markets/v2`

Sandbox URL prefix:

`https://data.sandbox.alpaca.markets/v2`

This URL will default to the Free plan as long as the Unlimited plan is not enabled for the broker account.

### Authentication

The authentication follows as described on the [authentication overview](https://alpaca.markets/docs/broker/api-overview/#authentication-and-rate-limit).

### Limiting

Use the limit query parameter. The value should be in the range 1 - 10000 (endpoints included) with 1000 being the default if unspecified.

### Paging

To support querying long timespans continuously we support paging in our API. If the result you have received contains a `next_page_token` that is **not** `null` there may be more data available in the timeframe you have chosen. Include the token you have received as the `page_token` query parameter for the next request you make while leaving the other parameters unchanged to continue where the previous response left off.

### Ordering

The results are ordered in ascending order by time.

## **Trades**

The Trades API provides historcial trade data for a given ticker symbol on a specified date.

`GET/v2/stocks/{symbol}/trades`

Returns trades for the queried stock symbol.

### Parameters

#### Path Parameters

| Attribute | Type   | Requirement                           | Notes                   |
| --------- | ------ | ------------------------------------- | ----------------------- |
| `symbol`  | string | {{<hint danger>}}Required {{</hint>}} | The symbol to query for |

#### Query Parameters

| Attribute    | Type   | Requirement                           | Notes                                                                                               |
| ------------ | ------ | ------------------------------------- | --------------------------------------------------------------------------------------------------- |
| `start`      | string | {{<hint danger>}}Required {{</hint>}} | Filter data equal to or after this time in RFC-3339 format. Fractions of a second are not accepted  |
| `end`        | string | {{<hint info>}}Optional {{</hint>}} | Filter data equal to or before this time in RFC-3339 format. Fractions of a second are not accepted |
| `limit`      | int    | {{<hint info>}}Optional {{</hint>}}   | Number of data points to return. Must be in range 1-10000, defaults to 1000                         |
| `page_token` | string | {{<hint info>}}Optional {{</hint>}}   | Pagination token to continue from                                                                   |

### Response

{{<hint good>}}
A trades response object.

{{</hint>}}

### Errors

{{<hint warning>}}
400 - Bad Request

​ _Invalid value for query parameter_
{{</hint>}}

{{<hint warning>}}
403 - Forbidden

​ _Unauthorized_
{{</hint>}}

{{<hint warning>}}
422 - Unprocessable

​ _Invalid query parameter_
{{</hint>}}

{{<hint warning>}}
429 - Too many requests

​ _Rate limit exceeded_
{{</hint>}}

### Example of one trade

```json
{
  "t": "2021-02-06T13:04:56.334320128Z",
  "x": "C",
  "p": 387.62,
  "s": 100,
  "c": [" ", "T"],
  "i": 52983525029461,
  "z": "B"
}
```

### Properties

| Attribute | Type             | Notes                                                  |
| --------- | ---------------- | ------------------------------------------------------ |
| `t`       | string/timestamp | Timestamp in RFC-3339 format with nanosecond precision |
| `x`       | string           | Exchange where the trade happened                      |
| `p`       | number           | Trade price                                            |
| `s`       | int              | Trade size                                             |
| `c`       | array<string>    | Trade conditions                                       |
| `i`       | int              | Trade ID                                               |
| `z`       | string           | Tape                                                   |

### Example of multiple trades

```json
{
  "trades": [
    {
      "t": "2021-02-06T13:04:56.334320128Z",
      "x": "C",
      "p": 387.62,
      "s": 100,
      "c": [" ", "T"],
      "i": 52983525029461,
      "z": "B"
    },
    {
      "t": "2021-02-06T13:09:42.325484032Z",
      "x": "C",
      "p": 387.69,
      "s": 100,
      "c": [" ", "T"],
      "i": 52983525033813,
      "z": "B"
    }
  ],
  "symbol": "SPY",
  "next_page_token": "MjAyMS0wMi0wNlQxMzowOTo0Mlo7MQ=="
}
```

### Properties

| Attribute         | Type              | Notes                                         |
| ----------------- | ----------------- | --------------------------------------------- |
| `trades`          | array<trade>      | Array of trades                               |
| `symbol`          | string            | Symbol that was queried                       |
| `next_page_token` | string (Nullable) | Token that can be used to query the next page |

## **Latest Trade**

The Latest Trade API provides the latest trade data for a given ticker symbol.

`GET/v2/stocks/{symbol}/trades/latest`

This endpoint returns latest trade for the requested security.

### Parameters

#### Path Parameters

| Attribute | Type   | Requirement                           | Notes                   |
| --------- | ------ | ------------------------------------- | ----------------------- |
| `symbol`  | string | {{<hint danger>}}Required {{</hint>}} | The symbol to query for |

### Response

{{<hint good>}}
A trades response object.

{{</hint>}}

### Errors

{{<hint warning>}}
400 - Bad Request

​ _Invalid value for query parameter_
{{</hint>}}

{{<hint warning>}}
403 - Forbidden

​ _Unauthorized_
{{</hint>}}

{{<hint warning>}}
404 - Not found

​ _Not found_
{{</hint>}}

{{<hint warning>}}
429 - Too many requests

​ _Rate limit exceeded_
{{</hint>}}

### Example of latest trade

```json
{
  "t": "2021-02-06T13:04:56.334320128Z",
  "x": "C",
  "p": 387.62,
  "s": 100,
  "c": [" ", "T"],
  "i": 52983525029461,
  "z": "B"
}
```

### Properties

| Attribute | Type             | Notes                                                  |
| --------- | ---------------- | ------------------------------------------------------ |
| `t`       | string/timestamp | Timestamp in RFC-3339 format with nanosecond precision |
| `x`       | string           | Exchange where the trade happened                      |
| `p`       | number           | Trade price                                            |
| `s`       | int              | Trade size                                             |
| `c`       | array<string>    | Trade conditions                                       |
| `i`       | int              | Trade ID                                               |
| `z`       | string           | Tape                                                   |

## **Quotes**

The Quotes API provides NBBO quotes for a single given ticker symbol at a specified date.

`GET/v2/stocks/{symbol}/quotes`
Returns quotes (NBBOs) for the queried stock symbol

### Parameters

#### Path Parameters

| Attribute | Type   | Requirement                           | Notes                   |
| --------- | ------ | ------------------------------------- | ----------------------- |
| `symbol`  | string | {{<hint danger>}}Required {{</hint>}} | The symbol to query for |

#### Query Parameters

| Attribute    | Type   | Requirement                           | Notes                                                                                               |
| ------------ | ------ | ------------------------------------- | --------------------------------------------------------------------------------------------------- |
| `start`      | string | {{<hint danger>}}Optional {{</hint>}} | Filter data equal to or after this time in RFC-3339 format. Fractions of a second are not accepted  |
| `end`        | string | {{<hint info>}}Optional {{</hint>}} | Filter data equal to or before this time in RFC-3339 format. Fractions of a second are not accepted |
| `limit`      | int    | {{<hint info>}}Optional {{</hint>}}   | Number of data points to return. Must be in range 1-10000, defaults to 1000                         |
| `page_token` | string | {{<hint info>}}Optional {{</hint>}}   | Pagination token to continue from                                                                   |

### Response

{{<hint good>}}
A quotes response object.

{{</hint>}}

### Errors

{{<hint warning>}}
400 - Bad Request

​ _Invalid value for query parameter_
{{</hint>}}

{{<hint warning>}}
403 - Forbidden

​ _Unauthorized_
{{</hint>}}

{{<hint warning>}}
422 - Unprocessable

​ _Invalid query parameter_
{{</hint>}}

{{<hint warning>}}
429 - Too many requests

​ _Rate limit exceeded_
{{</hint>}}

### Example of a single quote

```json
{
  "t": "2021-02-06T13:35:08.946977536Z",
  "ax": "C",
  "ap": 387.7,
  "as": 1,
  "bx": "N",
  "bp": 387.67,
  "bs": 1,
  "c": ["R"]
}
```

### Properties

| Attribute | Type             | Notes                                                  |
| --------- | ---------------- | ------------------------------------------------------ |
| `t`       | string/timestamp | Timestamp in RFC-3339 format with nanosecond precision |
| `ax`      | string           | Ask exchange                                           |
| `ap`      | number           | Ask price                                              |
| `as`      | int              | Ask size                                               |
| `bx`      | string           | Bid exchange                                           |
| `bp`      | number           | Bid price                                              |
| `bs`      | int              | Bid size                                               |
| `c`       | array<string>    | Quote conditions                                       |


## **Multi Quotes**

The Multi Quotes API provides NBBO quotes for multiple given ticker symbols at a specified date.

`GET/v2/stocks/quotes`
Returns quotes (NBBOs) for the queried stock symbol

### Parameters

#### Query Parameters

| Attribute    | Type   | Requirement                           | Notes                                                                                               |
| ------------ | ------ | ------------------------------------- | --------------------------------------------------------------------------------------------------- |
| `symbols`    | string | {{<hint danger>}}Required {{</hint>}} | The comma-separated symbols to query quotes for |
| `start`      | string | {{<hint danger>}}Optional {{</hint>}} | Filter data equal to or after this time in RFC-3339 format. Fractions of a second are not accepted  |
| `end`        | string | {{<hint info>}}Optional {{</hint>}} | Filter data equal to or before this time in RFC-3339 format. Fractions of a second are not accepted |
| `feed`      | string  | {{<hint info>}}Optional {{</hint>}}   | The data feed. Defaults iex for free users and sip for users with a subscription                         |
| `limit`      | int    | {{<hint info>}}Optional {{</hint>}}   | Number of data points to return. Must be in range 1-10000, defaults to 1000                         |
| `page_token` | string | {{<hint info>}}Optional {{</hint>}}   | Pagination token to continue from                                                                   |

### Response

{{<hint good>}}
A quotes response object.

{{</hint>}}

### Errors

{{<hint warning>}}
400 - Bad Request

​ _Invalid value for query parameter_
{{</hint>}}

{{<hint warning>}}
403 - Forbidden

​ _Unauthorized_
{{</hint>}}

{{<hint warning>}}
422 - Unprocessable

​ _Invalid query parameter_
{{</hint>}}

{{<hint warning>}}
429 - Too many requests

​ _Rate limit exceeded_
{{</hint>}}

### Example of multiple quotes

```json
{
  "quotes": [
    {
      "t": "2021-02-06T13:35:08.946977536Z",
      "ax": "C",
      "ap": 387.7,
      "as": 1,
      "bx": "N",
      "bp": 387.67,
      "bs": 1,
      "c": ["R"]
    },
    {
      "t": "2021-02-06T13:35:09.327977984Z",
      "ax": "C",
      "ap": 387.7,
      "as": 1,
      "bx": "C",
      "bp": 387.58,
      "bs": 1,
      "c": ["R"]
    }
  ],
  "symbol": "SPY",
  "next_page_token": "MjAyMS0wMi0wNlQxMzozNTowOVo7MQ=="
}
```

### Properties

| Attribute         | Type              | Notes                                         |
| ----------------- | ----------------- | --------------------------------------------- |
| `quotes`          | array<quote>      | Array of quotes                               |
| `symbol`          | string            | Symbol that was queried                       |
| `next_page_token` | string (Nullable) | Token that can be used to query the next page |

## **Latest Quote**

The Latest Quote API provides the latest quote data for a given ticker symbol.

`GET/v2/stocks/{symbol}/quotes/latest`

This endpoint returns latest quote for the requested security.

### Parameters

#### Path Parameters

| Attribute | Type   | Requirement                           | Notes                   |
| --------- | ------ | ------------------------------------- | ----------------------- |
| `symbol`  | string | {{<hint danger>}}Required {{</hint>}} | The symbol to query for |

### Response

{{<hint good>}}
A quotes response object.

{{</hint>}}

### Errors

{{<hint warning>}}
400 - Bad Request

​ _Invalid value for query parameter_
{{</hint>}}

{{<hint warning>}}
403 - Forbidden

​ _Unauthorized_
{{</hint>}}

{{<hint warning>}}
404 - Not found

​ _Not found_
{{</hint>}}

{{<hint warning>}}
429 - Too many requests

​ _Rate limit exceeded_
{{</hint>}}

### Example of latest quote

```json
{
  "t": "2021-02-06T13:35:08.946977536Z",
  "ax": "C",
  "ap": 387.7,
  "as": 1,
  "bx": "N",
  "bp": 387.67,
  "bs": 1,
  "c": ["R"]
}
```

### Properties

| Attribute | Type             | Notes                                                  |
| --------- | ---------------- | ------------------------------------------------------ |
| `t`       | string/timestamp | Timestamp in RFC-3339 format with nanosecond precision |
| `ax`      | string           | Ask exchange                                           |
| `ap`      | number           | Ask price                                              |
| `as`      | int              | Ask size                                               |
| `bx`      | string           | Bid exchange                                           |
| `bp`      | number           | Bid price                                              |
| `bs`      | int              | Bid size                                               |
| `c`       | array<string>    | Quote conditions                                       |

## **Bars**

The Bars API returns aggregate historical data for the requested securities.

`GET/v2/stocks/{symbol}/bars`

Returns bars for the queried stock symbol

### Parameters

#### Path Parameters

| Attribute | Type   | Requirement                           | Notes                   |
| --------- | ------ | ------------------------------------- | ----------------------- |
| `symbol`  | string | {{<hint danger>}}Required {{</hint>}} | The symbol to query for |

#### Query Parameters

| Attribute    | Type   | Requirement                           | Notes                                                                                                                                                           |
| ------------ | ------ | ------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `start`      | string | {{<hint danger>}}Required {{</hint>}} | Filter data equal to or after this time in RFC-3339 format. Fractions of a second are not accepted                                                              |
| `end`        | string | {{<hint danger>}}Required {{</hint>}} | Filter data equal to or before this time in RFC-3339 format. Fractions of a second are not accepted                                                             |
| `limit`      | int    | {{<hint info>}}Optional {{</hint>}}   | Number of data points to return. Must be in range 1-10000, defaults to 1000                                                                                     |
| `page_token` | string | {{<hint info>}}Optional {{</hint>}}   | Pagination token to continue from                                                                                                                               |
| `timeframe`  | string | {{<hint danger>}}Required {{</hint>}} | Timeframe for the aggregation. Available values are flexible for Min, Hour, Day time window sizes with a maximum constraint on the values: 60Min, 24Hour, 31Day |

### Response

{{<hint good>}}
A bars response object.

{{</hint>}}

### Errors

{{<hint warning>}}
400 - Bad Request

​ _Invalid value for query parameter_
{{</hint>}}

{{<hint warning>}}
403 - Forbidden

​ _Unauthorized_
{{</hint>}}

{{<hint warning>}}
422 - Unprocessable

​ _Invalid query parameter_
{{</hint>}}

{{<hint warning>}}
429 - Too many requests

​ _Rate limit exceeded_
{{</hint>}}

### Example of one bar

```json
{
  "t": "2021-02-01T16:01:00Z",
  "o": 133.32,
  "h": 133.74,
  "l": 133.31,
  "c": 133.5,
  "v": 9876
}
```

### Properties

| Attribute | Type             | Notes                                                  |
| --------- | ---------------- | ------------------------------------------------------ |
| `t`       | string/timestamp | Timestamp in RFC-3339 format with nanosecond precision |
| `o`       | number           | Open price                                             |
| `h`       | number           | High price                                             |
| `l`       | number           | Low price                                              |
| `c`       | number           | Close price                                            |
| `v`       | int              | Volume                                                 |

### Example of multiple bars

```json
{
  "bars": [
    {
      "t": "2021-02-01T16:01:00Z",
      "o": 133.32,
      "h": 133.74,
      "l": 133.31,
      "c": 133.5,
      "v": 9876
    },
    {
      "t": "2021-02-01T16:02:00Z",
      "o": 133.5,
      "h": 133.58,
      "l": 133.44,
      "c": 133.58,
      "v": 3567
    }
  ],
  "symbol": "AAPL",
  "next_page_token": "MjAyMS0wMi0wMVQxNDowMjowMFo7MQ=="
}
```

### Properties

| Attribute         | Type              | Notes                                         |
| ----------------- | ----------------- | --------------------------------------------- |
| `bars`            | array<bar>        | Array of bars                                 |
| `symbol`          | string            | Symbol that was queried                       |
| `next_page_token` | string (Nullable) | Token that can be used to query the next page |

## **Snapshot - Multiple Tickers**

The Snapshot API for multiple tickers provides the latest trade, latest quote, minute bar daily bar and previous daily bar data for the given ticker symbols.

`GET/v2/stocks/snapshots`
This endpoint returns the snapshots for the requested securities.

### Parameters

#### Path Parameters

| Attribute | Type   | Requirement                           | Notes                                    |
| --------- | ------ | ------------------------------------- | ---------------------------------------- |
| `symbols` | string | {{<hint danger>}}Required {{</hint>}} | The comma-separated symbols to query for |

### Response

{{<hint good>}}
A snapshot response object.

{{</hint>}}

### Errors

{{<hint warning>}}
400 - Bad Request

​ _Invalid value for query parameter_
{{</hint>}}

{{<hint warning>}}
403 - Forbidden

​ _Unauthorized_
{{</hint>}}

{{<hint warning>}}
429 - Too many requests

​ _Rate limit exceeded_
{{</hint>}}

### Example of snapshots for multiple tickers

```json
{
  "AAPL": {
    "latestTrade": {
      "t": "2021-05-11T20:00:00.435997104Z",
      "x": "Q",
      "p": 125.91,
      "s": 5589631,
      "c": ["@", "M"],
      "i": 179430,
      "z": "C"
    },
    "latestQuote": {
      "t": "2021-05-11T21:48:32.342305Z",
      "ax": "P",
      "ap": 125.68,
      "as": 4,
      "bx": "P",
      "bp": 125.6,
      "bs": 2,
      "c": ["R"]
    },
    "minuteBar": {
      "t": "2021-05-11T21:46:00Z",
      "o": 125.57,
      "h": 125.67,
      "l": 125.57,
      "c": 125.57,
      "v": 1722
    },
    "dailyBar": {
      "t": "2021-05-11T04:00:00Z",
      "o": 123.5,
      "h": 126.27,
      "l": 122.77,
      "c": 125.91,
      "v": 125853552
    },
    "prevDailyBar": {
      "t": "2021-05-10T04:00:00Z",
      "o": 129.41,
      "h": 129.54,
      "l": 126.81,
      "c": 126.85,
      "v": 79569305
    }
  },
  "TSLA": {
    "latestTrade": {
      "t": "2021-05-11T20:00:00.438347686Z",
      "x": "Q",
      "p": 617.2,
      "s": 268388,
      "c": ["@", "M"],
      "i": 301112,
      "z": "C"
    },
    "latestQuote": {
      "t": "2021-05-11T21:49:14.42603133Z",
      "ax": "P",
      "ap": 616.4,
      "as": 1,
      "bx": "Q",
      "bp": 616.05,
      "bs": 1,
      "c": ["R"]
    },
    "minuteBar": {
      "t": "2021-05-11T21:45:00Z",
      "o": 616,
      "h": 616,
      "l": 616,
      "c": 616,
      "v": 479
    },
    "dailyBar": {
      "t": "2021-05-11T04:00:00Z",
      "o": 599.24,
      "h": 627.0999,
      "l": 595.6,
      "c": 617.2,
      "v": 46393457
    },
    "prevDailyBar": {
      "t": "2021-05-10T04:00:00Z",
      "o": 664.71,
      "h": 665.05,
      "l": 627.6101,
      "c": 629.04,
      "v": 31336228
    }
  }
}
```

### Properties

| Attribute      | Type   | Notes                           |
| -------------- | ------ | ------------------------------- |
| `latestTrade`  | object | Latest trade object             |
| `latestQuote`  | object | Latest quote object             |
| `minuteBar`    | object | Minute bar object               |
| `dailyBar`     | object | Daily bar object                |
| `prevDailyBar` | object | Previous daily close bar object |

## **Snapshot - Ticker**

The Snapshot API for one ticker provides the latest trade, latest quote, minute bar daily bar and previous daily bar data for a given ticker symbol.

`GET/v2/stocks/{symbol}/snapshot`
This endpoint returns the snapshot for the requested security.

### Parameters

#### Path Parameters

| Attribute | Type   | Requirement                           | Notes                   |
| --------- | ------ | ------------------------------------- | ----------------------- |
| `symbol`  | string | {{<hint danger>}}Required {{</hint>}} | The symbol to query for |

### Response

{{<hint good>}}
A snapshot response object.

{{</hint>}}

### Errors

{{<hint warning>}}
400 - Bad Request

​ _Invalid value for query parameter_
{{</hint>}}

{{<hint warning>}}
403 - Forbidden

​ _Unauthorized_
{{</hint>}}

{{<hint warning>}}
429 - Too many requests

​ _Rate limit exceeded_
{{</hint>}}

### Example of a snapshot for one ticker

```json
{
  "symbol": "AAPL",
  "latestTrade": {
    "t": "2021-05-11T20:00:00.435997104Z",
    "x": "Q",
    "p": 125.91,
    "s": 5589631,
    "c": ["@", "M"],
    "i": 179430,
    "z": "C"
  },
  "latestQuote": {
    "t": "2021-05-11T22:05:02.307304704Z",
    "ax": "P",
    "ap": 125.68,
    "as": 12,
    "bx": "P",
    "bp": 125.6,
    "bs": 4,
    "c": ["R"]
  },
  "minuteBar": {
    "t": "2021-05-11T22:02:00Z",
    "o": 125.66,
    "h": 125.66,
    "l": 125.66,
    "c": 125.66,
    "v": 396
  },
  "dailyBar": {
    "t": "2021-05-11T04:00:00Z",
    "o": 123.5,
    "h": 126.27,
    "l": 122.77,
    "c": 125.91,
    "v": 125863164
  },
  "prevDailyBar": {
    "t": "2021-05-10T04:00:00Z",
    "o": 129.41,
    "h": 129.54,
    "l": 126.81,
    "c": 126.85,
    "v": 79569305
  }
}
```

### Properties

| Attribute      | Type   | Notes                           |
| -------------- | ------ | ------------------------------- |
| `latestTrade`  | object | Latest trade object             |
| `latestQuote`  | object | Latest quote object             |
| `minuteBar`    | object | Minute bar object               |
| `dailyBar`     | object | Daily bar object                |
| `prevDailyBar` | object | Previous daily close bar object |
