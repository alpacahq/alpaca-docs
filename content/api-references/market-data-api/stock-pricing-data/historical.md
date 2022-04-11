---
weight: 11
title: Historical Data
---

# Historical Stock Pricing Data

## **Trades**

The Trades API provides historcial trade data for a given ticker symbol on a specified date.

`GET/v2/stocks/{symbol}/trades`

Returns trades for the queried stock symbol.

### Parameters

##### Path Parameters

| Attribute | Type   | Requirement                           | Notes                   |
| --------- | ------ | ------------------------------------- | ----------------------- |
| `symbol`  | string | {{<hint danger>}}Required {{</hint>}} | The symbol to query for |

#### Query Parameters

| Attribute    | Type   | Requirement                         | Notes                                                                                                                                                                                            |
| ------------ | ------ | ----------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --- |
| `start`      | string | {{<hint info>}}Optional {{</hint>}} | Filter data equal to or after this time in RFC-3339 format. Fractions of a second are not accepted. Defaults to beginning of the current day.                                                    |
| `end`        | string | {{<hint info>}}Optional {{</hint>}} | Filter data equal to or before this time in RFC-3339 format. Fractions of a second are not accepted. Defaults to the current time.                                                               |
| `limit`      | int    | {{<hint info>}}Optional {{</hint>}} | Number of data points to return. Must be in range 1-10000, defaults to 1000                                                                                                                      |
| `page_token` | string | {{<hint info>}}Optional {{</hint>}} | Pagination token to continue from                                                                                                                                                                |
| `feed`       | string | {{<hint info>}}Optional {{</hint>}} | Which feed to pull market data from. This is either `iex`, `otc`, or `sip`. `sip` and `otc` are only available to those with a subscription. Default is `iex` for free plans and `sip` for paid. |     |

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
  "trades": [
    {
      "t": "2022-04-11T12:00:36.002951946Z",
      "x": "V",
      "p": 168.04,
      "s": 50,
      "c": ["@", "T", "I"],
      "i": 1,
      "z": "C"
    }
  ],
  "symbol": "AAPL",
  "next_page_token": "QUFQTHwyMDIyLTA0LTExVDEyOjAwOjM2LjAwMjk1MTk0Nlp8VnwwOTIyMzM3MjAzNjg1NDc3NTgwOQ=="
}
```

### Properties

| Attribute         | Type              | Notes                                                  |
| ----------------- | ----------------- | ------------------------------------------------------ |
| `trades`          | array             | Array of Trade objects                                 |
| `t`               | string/timestamp  | Timestamp in RFC-3339 format with nanosecond precision |
| `x`               | string            | Exchange where the trade happened                      |
| `p`               | number            | Trade price                                            |
| `s`               | int               | Trade size                                             |
| `c`               | array<string>     | Trade conditions                                       |
| `i`               | int               | Trade ID                                               |
| `z`               | string            | Tape                                                   |
| `symbol`          | string            | Symbol queried for                                     |
| `next_page_token` | string (Nullable) | Token that can be used to query the next page          |

## **Multi Trades**

The Multi Trades API provides historcial trade data for multiple given ticker symbols over a specified time period.

`GET/v2/stocks/trades`

Returns trades for the queried stock symbol.

### Parameters

#### Query Parameters

| Attribute    | Type   | Requirement                           | Notes                                                                                                                                                                                            |
| ------------ | ------ | ------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `symbols`    | string | {{<hint danger>}}Required {{</hint>}} | A comma separated string of symbols to get trades for                                                                                                                                            |
| `start`      | string | {{<hint info>}}Optional {{</hint>}}   | Filter data equal to or after this time in RFC-3339 format. Fractions of a second are not accepted. Defaults to beginning of the current day.                                                    |
| `end`        | string | {{<hint info>}}Optional {{</hint>}}   | Filter data equal to or before this time in RFC-3339 format. Fractions of a second are not accepted. Defaults to the current time.                                                               |
| `limit`      | int    | {{<hint info>}}Optional {{</hint>}}   | Number of data points to return. Must be in range 1-10000, defaults to 1000.                                                                                                                     |
| `page_token` | string | {{<hint info>}}Optional {{</hint>}}   | Pagination token to continue from.                                                                                                                                                               |
| `feed`       | string | {{<hint info>}}Optional {{</hint>}}   | Which feed to pull market data from. This is either `iex`, `otc`, or `sip`. `sip` and `otc` are only available to those with a subscription. Default is `iex` for free plans and `sip` for paid. |

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

### Example of multi-trades response

```json
{
  "trades": {
    "AAPL": [
      {
        "t": "2022-04-11T14:30:00.008348Z",
        "x": "D",
        "p": 166.48,
        "s": 1,
        "c": ["@", "I"],
        "i": 50688,
        "z": "C"
      }
    ]
  },
  "next_page_token": "QUFQTHwyMDIyLTA0LTExVDE0OjMwOjAwLjAwODM0ODAwMFp8RHwwOTIyMzM3MjAzNjg1NDgyNjQ5Ng=="
}
```

### Properties

| Attribute         | Type              | Notes                                                  |
| ----------------- | ----------------- | ------------------------------------------------------ |
| `trades`          | object            | Trades object                                          |
| `t`               | string/timestamp  | Timestamp in RFC-3339 format with nanosecond precision |
| `x`               | string            | Exchange where the trade happened                      |
| `p`               | number            | Trade price                                            |
| `s`               | int               | Trade size                                             |
| `c`               | array<string>     | Trade conditions                                       |
| `i`               | int               | Trade ID                                               |
| `z`               | string            | Tape                                                   |
| `next_page_token` | string (Nullable) | Token that can be used to query the next page          |

## **Latest Trade**

The Latest Trade API provides the latest trade data for a given ticker symbol.

`GET/v2/stocks/{symbol}/trades/latest`

This endpoint returns latest trade for the requested security.

### Parameters

#### Path Parameters

| Attribute | Type   | Requirement                           | Notes                   |
| --------- | ------ | ------------------------------------- | ----------------------- |
| `symbol`  | string | {{<hint danger>}}Required {{</hint>}} | The symbol to query for |

#### Query Parameters

| Attribute | Type   | Requirement                         | Notes                                                                                                                                                                                            |
| --------- | ------ | ----------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `feed`    | string | {{<hint info>}}Optional {{</hint>}} | Which feed to pull market data from. This is either `iex`, `otc`, or `sip`. `sip` and `otc` are only available to those with a subscription. Default is `iex` for free plans and `sip` for paid. |

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
  "symbol": "AAPL",
  "trade": {
    "t": "2022-04-11T17:56:08.406302477Z",
    "x": "V",
    "p": 166.81,
    "s": 300,
    "c": ["@"],
    "i": 10503,
    "z": "C"
  }
}
```

### Properties

| Attribute | Type             | Notes                                                  |
| --------- | ---------------- | ------------------------------------------------------ |
| `symbol`  | string           | Symbol that was queried for                            |
| `trade`   | object           | Trade object                                           |
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
Returns quotes (NBBOs) for the queried stock symbol.

### Parameters

#### Path Parameters

| Attribute | Type   | Requirement                           | Notes                   |
| --------- | ------ | ------------------------------------- | ----------------------- |
| `symbol`  | string | {{<hint danger>}}Required {{</hint>}} | The symbol to query for |

#### Query Parameters

| Attribute    | Type   | Requirement                           | Notes                                                                                               |
| ------------ | ------ | ------------------------------------- | --------------------------------------------------------------------------------------------------- |
| `start`      | string | {{<hint danger>}}Required {{</hint>}} | Filter data equal to or after this time in RFC-3339 format. Fractions of a second are not accepted  |
| `end`        | string | {{<hint info>}}Optional {{</hint>}}   | Filter data equal to or before this time in RFC-3339 format. Fractions of a second are not accepted |
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

The Multi Quotes API provides NBBO quotes for multiple given ticker symbols over a specified time period.

`GET/v2/stocks/quotes`
Returns quotes (NBBOs) for the queried stock symbols.

### Parameters

#### Query Parameters

| Attribute    | Type   | Requirement                           | Notes                                                                                                                                                                                            |
| ------------ | ------ | ------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `symbols`    | string | {{<hint danger>}}Required {{</hint>}} | The comma-separated symbols to query quotes for                                                                                                                                                  |
| `start`      | string | {{<hint danger>}}Required {{</hint>}} | Filter data equal to or after this time in RFC-3339 format. Fractions of a second are not accepted                                                                                               |
| `end`        | string | {{<hint info>}}Optional {{</hint>}}   | Filter data equal to or before this time in RFC-3339 format. Fractions of a second are not accepted                                                                                              |
| `feed`       | string | {{<hint info>}}Optional {{</hint>}}   | Which feed to pull market data from. This is either `iex`, `otc`, or `sip`. `sip` and `otc` are only available to those with a subscription. Default is `iex` for free plans and `sip` for paid. |
| `limit`      | int    | {{<hint info>}}Optional {{</hint>}}   | Number of data points to return. Must be in range 1-10000, defaults to 1000                                                                                                                      |
| `page_token` | string | {{<hint info>}}Optional {{</hint>}}   | Pagination token to continue from                                                                                                                                                                |

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
| `symbol`          | string            | Symbol that was queried for                   |
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

The Bars API returns aggregate historical data for the requested security.

`GET/v2/stocks/{symbol}/bars`

Returns bars for the queried stock symbol.

### Parameters

#### Path Parameters

| Attribute | Type   | Requirement                           | Notes                    |
| --------- | ------ | ------------------------------------- | ------------------------ |
| `symbol`  | string | {{<hint danger>}}Required {{</hint>}} | The symbol to query for. |

#### Query Parameters

| Attribute    | Type   | Requirement                           | Notes                                                                                                                                                                                            |
| ------------ | ------ | ------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `start`      | string | {{<hint info>}}Optional {{</hint>}}   | Filter data equal to or after this time in RFC-3339 format. Fractions of a second are not accepted. Defaults to beginning of the current day.                                                    |
| `end`        | string | {{<hint info>}}Optional {{</hint>}}   | Filter data equal to or before this time in RFC-3339 format. Fractions of a second are not accepted. Defaults to the current time.                                                               |
| `limit`      | int    | {{<hint info>}}Optional {{</hint>}}   | Number of data points to return. Must be in range 1-10000, defaults to 1000.                                                                                                                     |
| `page_token` | string | {{<hint info>}}Optional {{</hint>}}   | Pagination token to continue from.                                                                                                                                                               |
| `timeframe`  | string | {{<hint danger>}}Required {{</hint>}} | Timeframe of the aggregation. Available values are flexible for Min, Hour, Day, Week and Month time window sizes with a maximum constraint on the values: 59Min, 23Hour, 1Day, 1Week, 12Month.   |
| `adjustment` | string | {{<hint info>}}Optional {{</hint>}}   | Specifies the corporate action adjustment for the returned bars. Options are: ‘raw’, ‘split’, ‘dividend’ or ‘all’. Default value is‘raw’.                                                        |
| `feed`       | string | {{<hint info>}}Optional {{</hint>}}   | Which feed to pull market data from. This is either `iex`, `otc`, or `sip`. `sip` and `otc` are only available to those with a subscription. Default is `iex` for free plans and `sip` for paid. |

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
  "bars": [
    {
      "t": "2022-04-11T08:00:00Z",
      "o": 168.99,
      "h": 169.81,
      "l": 168.99,
      "c": 169,
      "v": 7170,
      "n": 206,
      "vw": 169.233976
    }
  ],
  "symbol": "AAPL",
  "next_page_token": "QUFQTHxNfDIwMjItMDQtMTFUMDg6MDA6MDAuMDAwMDAwMDAwWg=="
}
```

### Properties

| Attribute         | Type              | Notes                                                  |
| ----------------- | ----------------- | ------------------------------------------------------ |
| `bars`            | array             | Array of bar objects                                   |
| `t`               | string/timestamp  | Timestamp in RFC-3339 format with nanosecond precision |
| `o`               | number            | Open price                                             |
| `h`               | number            | High price                                             |
| `l`               | number            | Low price                                              |
| `c`               | number            | Close price                                            |
| `v`               | int               | Volume                                                 |
| `n`               | int               | Number of trades                                       |
| `vw`              | number            | Volume-weighted average price                          |
| `symbol`          | string            | The symbol queried for                                 |
| `next_page_token` | string (Nullable) | Token that can be used to query the next page          |

## **Multi Bars**

The Multi Bars API returns aggregated historical data for multiple given ticker symbols over a specified time period.

`GET/v2/stocks/bars`

Returns bars for the queried stock symbols.

### Parameters

#### Query Parameters

| Attribute    | Type   | Requirement                           | Notes                                                                                                                                                                                          |
| ------------ | ------ | ------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `symbols`    | string | {{<hint danger>}}Required {{</hint>}} | The comma-separated symbols to query for.                                                                                                                                                      |
| `start`      | string | {{<hint info>}}Optional {{</hint>}}   | Filter data equal to or after this time in RFC-3339 format. Fractions of a second are not accepted. Defaults to beginning of the current day.                                                  |
| `end`        | string | {{<hint info>}}Optional {{</hint>}}   | Filter data equal to or before this time in RFC-3339 format. Fractions of a second are not accepted. Defaults to the current time.                                                             |
| `limit`      | int    | {{<hint info>}}Optional {{</hint>}}   | Number of data points to return. Must be in range 1-10000, defaults to 1000.                                                                                                                   |
| `page_token` | string | {{<hint info>}}Optional {{</hint>}}   | Pagination token to continue from.                                                                                                                                                             |
| `timeframe`  | string | {{<hint danger>}}Required {{</hint>}} | Timeframe of the aggregation. Available values are flexible for Min, Hour, Day, Week and Month time window sizes with a maximum constraint on the values: 59Min, 23Hour, 1Day, 1Week, 12Month. |
| `adjustment` | string | {{<hint info>}}Optional {{</hint>}}   | Specifies the corporate action adjustment for the returned bars. Options are: ‘raw’, ‘split’, ‘dividend’ or ‘all’. Default value is‘raw’.                                                      |

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

### Example of a multi-symbol bars object

```json
{
  "bars": {
    "AAPL": [
      {
        "t": "2022-04-11T04:00:00Z",
        "o": 168.77,
        "h": 169.03,
        "l": 166.1,
        "c": 166.975,
        "v": 40180280,
        "n": 435528,
        "vw": 167.08951
      }
    ],
    "TSLA": [
      {
        "t": "2022-04-11T04:00:00Z",
        "o": 980.14,
        "h": 1008.4681,
        "l": 976,
        "c": 991.1412,
        "v": 13754547,
        "n": 547096,
        "vw": 990.827506
      }
    ]
  },
  "next_page_token": "VFNMQXxEfDIwMjItMDQtMTFUMDQ6MDA6MDAuMDAwMDAwMDAwWg=="
}
```

### Properties

| Attribute         | Type              | Notes                                                  |
| ----------------- | ----------------- | ------------------------------------------------------ |
| `bars`            | array<bar>        | Array of bars                                          |
| `t`               | string/timestamp  | Timestamp in RFC-3339 format with nanosecond precision |
| `o`               | number            | Open price                                             |
| `h`               | number            | High price                                             |
| `l`               | number            | Low price                                              |
| `c`               | number            | Close price                                            |
| `v`               | int               | Volume                                                 |
| `n`               | int               | Number of trades                                       |
| `vw`              | number            | Volume-weighted average price                          |
| `next_page_token` | string (Nullable) | Token that can be used to query the next page          |

## **Latest Bar**

The Latest Bar API returns the latest minute-aggregated historical bar for the requested security.

`GET/v2/stocks/{symbol}/bars/latest`

Returns the latest minute bar for the queried stock symbol.

### Parameters

#### Path Parameters

| Attribute | Type   | Requirement                           | Notes                   |
| --------- | ------ | ------------------------------------- | ----------------------- |
| `symbol`  | string | {{<hint danger>}}Required {{</hint>}} | The symbol to query for |

#### Query Parameters

| Attribute | Type   | Requirement                         | Notes                                                                                                                                                                                            |
| --------- | ------ | ----------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `feed`    | string | {{<hint info>}}Optional {{</hint>}} | Which feed to pull market data from. This is either `iex`, `otc`, or `sip`. `sip` and `otc` are only available to those with a subscription. Default is `iex` for free plans and `sip` for paid. |

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

### Example of latest bar

```json
{
  "symbol": "AAPL",
  "bar": {
    "t": "2022-04-11T16:59:00Z",
    "o": 167.035,
    "h": 167.05,
    "l": 166.995,
    "c": 167.005,
    "v": 1979,
    "n": 21,
    "vw": 167.016832
  }
}
```

### Properties

| Attribute | Type             | Notes                                                  |
| --------- | ---------------- | ------------------------------------------------------ |
| `symbol`  | string           | The symbol queried for                                 |
| `bar`     | object           | Latest bar object                                      |
| `t`       | string/timestamp | Timestamp in RFC-3339 format with nanosecond precision |
| `o`       | number           | Open price                                             |
| `h`       | number           | High price                                             |
| `l`       | number           | Low price                                              |
| `c`       | number           | Close price                                            |
| `v`       | int              | Volume                                                 |
| `n`       | int              | Number of trades                                       |
| `vw`      | number           | Volume-weighted average price                          |

## **Latest Multi Bars**

The Latest Multi Bars API returns the latest minute-aggregated historical bar data for multiple given ticker symbols.

`GET/v2/stocks/bars/latest`

Returns bars for the queried stock symbols.

### Parameters

#### Query Parameters

| Attribute | Type   | Requirement                           | Notes                                                                                                                                                                                            |
| --------- | ------ | ------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `symbols` | string | {{<hint danger>}}Required {{</hint>}} | The comma-separated symbols to query for.                                                                                                                                                        |
| `feed`    | string | {{<hint info>}}Optional {{</hint>}}   | Which feed to pull market data from. This is either `iex`, `otc`, or `sip`. `sip` and `otc` are only available to those with a subscription. Default is `iex` for free plans and `sip` for paid. |

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

### Example of a multi-symbol bars object

```json
{
  "bars": {
    "GME": {
      "t": "2022-04-11T17:33:00Z",
      "o": 144.29,
      "h": 144.56,
      "l": 144.29,
      "c": 144.55,
      "v": 304,
      "n": 4,
      "vw": 144.467895
    },
    "AAPL": {
      "t": "2022-04-11T17:34:00Z",
      "o": 166.87,
      "h": 166.98,
      "l": 166.81,
      "c": 166.98,
      "v": 1765,
      "n": 25,
      "vw": 166.871524
    }
  }
}
```

### Properties

| Attribute | Type             | Notes                                                  |
| --------- | ---------------- | ------------------------------------------------------ |
| `bars`    | object           | Bars object                                            |
| `t`       | string/timestamp | Timestamp in RFC-3339 format with nanosecond precision |
| `o`       | number           | Open price                                             |
| `h`       | number           | High price                                             |
| `l`       | number           | Low price                                              |
| `c`       | number           | Close price                                            |
| `v`       | int              | Volume                                                 |
| `n`       | int              | Number of trades                                       |
| `vw`      | number           | Volume-weighted average price                          |

## **Snapshot**

The Snapshot API provides the latest trade, latest quote, minute bar daily bar, and previous daily bar data for a given ticker symbol.

`GET/v2/stocks/{symbol}/snapshot`
This endpoint returns the snapshot for the requested security.

### Parameters

#### Path Parameters

| Attribute | Type   | Requirement                           | Notes                   |
| --------- | ------ | ------------------------------------- | ----------------------- |
| `symbol`  | string | {{<hint danger>}}Required {{</hint>}} | The symbol to query for |

#### Query Parameters

| Attribute | Type   | Requirement                         | Notes                                                                                                                                                                                            |
| --------- | ------ | ----------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `feed`    | string | {{<hint info>}}Optional {{</hint>}} | Which feed to pull market data from. This is either `iex`, `otc`, or `sip`. `sip` and `otc` are only available to those with a subscription. Default is `iex` for free plans and `sip` for paid. |

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

| Attribute      | Type   | Notes                            |
| -------------- | ------ | -------------------------------- |
| `symbol`       | string | Symbol that was queried for.     |
| `latestTrade`  | object | Latest trade object.             |
| `latestQuote`  | object | Latest quote object.             |
| `minuteBar`    | object | Minute bar object.               |
| `dailyBar`     | object | Daily bar object.                |
| `prevDailyBar` | object | Previous daily close bar object. |

## **Multi Snapshots**

The Snapshot API for multiple tickers provides the latest trade, latest quote, minute bar daily bar, and previous daily bar data for the given ticker symbols.

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
