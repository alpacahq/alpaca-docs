---
weight: 11
title: Historical Data
---

# Historical Stock Pricing Data


{{< hint info >}}
**Introducing the asof parameter** 

The asof date parameter allows for querying for symbol data before it was renamed.

For example: FB was renamed to META on 2022-06-09. Querying META with an asof date after 2022-06-09 will also yield FB data.

The special value of "-" means symbol mapping is skipped, and the data is returned as it was valid at its time. The same happens if the queried symbol is not found on the given asof date. Querying FB symbol with an asof date after 2022-06-09 will only return data with the FB ticker, not with META. But with an asof date before 2022-06-09, META will also be returned (as FB).
{{</hint>}}

## **Trades** 

The Trades API provides historical trade data for a given ticker symbol on a specified date.

`GET/v2/stocks/{symbol}/trades`

Returns trades for the queried stock symbol.

### Parameters

##### Path Parameters

| Attribute | Type   | Requirement                           | Notes                    |
| --------- | ------ | ------------------------------------- | ------------------------ |
| `symbol`  | string | {{<hint danger>}}Required {{</hint>}} | The symbol to query for. |

#### Query Parameters

| Attribute    | Type   | Requirement                         | Notes                                                                                                                                                                                          |
| ------------ | ------ | ----------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --- |
| `start`      | string | {{<hint info>}}Optional {{</hint>}} | Filter data equal to or after this time in RFC-3339 format. Defaults to the beginning of the current day.                                              |
| `end`        | string | {{<hint info>}}Optional {{</hint>}} | Filter data equal to or before this time in RFC-3339 format. Defaults to the current time.                                                             |
| `limit`      | int    | {{<hint info>}}Optional {{</hint>}} | Number of data points to return. Must be in range 1-10000, defaults to 1000.                                                                                                                   |
| `page_token` | string | {{<hint info>}}Optional {{</hint>}} | Pagination token to continue from. 
| `asof`  | string | {{<hint info>}}Optional {{</hint>}}  | The asof date of the queried stock symbol in YYYY-MM-DD format. Default is the current day. This date will be used to look up the queried security. If the given security was renamed in the past, all its symbols will be returned. |                                                                                                                                                            |
| `feed`       | string | {{<hint info>}}Optional {{</hint>}} | The feed to pull market data from. This is either `iex`, `otc`, or `sip`. `sip` and `otc` are only available to those with a subscription. Default is `iex` for free plans and `sip` for paid. |     |
| `currency` | string | {{<hint info>}}Optional {{</hint>}} | The currency for the returned prices in ISO 4217 standard. E.g. EUR, JPY. Defaults to USD.  |

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

### Example of a trades response

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

| Attribute         | Type              | Notes                                         |
| ----------------- | ----------------- | --------------------------------------------- |
| `trades`          | array             | Array of [Trade objects](#trade)              |
| `symbol`          | string            | Symbol queried for                            |
| `next_page_token` | string (Nullable) | Token that can be used to query the next page |

## **Multi Trades**

The Multi Trades API provides historical trade data for multiple given ticker symbols over a specified time period.

`GET/v2/stocks/trades`

Returns trades for the queried stock symbols.

### Parameters

#### Query Parameters

| Attribute    | Type   | Requirement                           | Notes                                                                                                                                                                                          |
| ------------ | ------ | ------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `symbols`    | string | {{<hint danger>}}Required {{</hint>}} | A comma separated string of symbols to get trades for.                                                                                       
| `start`      | string | {{<hint info>}}Optional {{</hint>}}   | Filter data equal to or after this time in RFC-3339 format. Defaults to the beginning of the current day.                                              |
| `end`        | string | {{<hint info>}}Optional {{</hint>}}   | Filter data equal to or before this time in RFC-3339 format. Defaults to the current time.                                                             |
| `limit`      | int    | {{<hint info>}}Optional {{</hint>}}   | Number of data points to return. Must be in range 1-10000, defaults to 1000.          |                                                                                    
| `asof`  | string | {{<hint info>}}Optional {{</hint>}}  | The asof date of the queried stock symbol in YYYY-MM-DD format. Default is the current day. This date will be used to look up the queried security. If the given security was renamed in the past, all its symbols will be returned. |                                                                       |
| `feed`       | string | {{<hint info>}}Optional {{</hint>}}   | The feed to pull market data from. This is either `iex`, `otc`, or `sip`. `sip` and `otc` are only available to those with a subscription. Default is `iex` for free plans and `sip` for paid. |
| `page_token` | string | {{<hint info>}}Optional {{</hint>}}   | Pagination token to continue from. 
| `currency` | string | {{<hint info>}}Optional {{</hint>}} | The currency for the returned prices in ISO 4217 standard. E.g. EUR, JPY. Defaults to USD.  |


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

### Example of a multi trades response

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

| Attribute         | Type              | Notes                                                                                                             |
| ----------------- | ----------------- | ----------------------------------------------------------------------------------------------------------------- |
| `trades`          | object            | A JSON object whose keys are the stock symbols queried for and whose values are arrays of [Trade objects](#trade) |
| `next_page_token` | string (Nullable) | Token that can be used to query the next page                                                                     |

## **Latest Trade**

The Latest Trade API provides the latest trade data for a given ticker symbol.

`GET/v2/stocks/{symbol}/trades/latest`

This endpoint returns latest trade data for the requested security.

### Parameters

#### Path Parameters

| Attribute | Type   | Requirement                           | Notes                    |
| --------- | ------ | ------------------------------------- | ------------------------ |
| `symbol`  | string | {{<hint danger>}}Required {{</hint>}} | The symbol to query for. |

#### Query Parameters

| Attribute | Type   | Requirement                         | Notes                                                                                                                                                                                          |
| --------- | ------ | ----------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `feed`    | string | {{<hint info>}}Optional {{</hint>}} | The feed to pull market data from. This is either `iex`, `otc`, or `sip`. `sip` and `otc` are only available to those with a subscription. Default is `iex` for free plans and `sip` for paid. |
| `currency` | string | {{<hint info>}}Optional {{</hint>}} | The currency for the returned prices in ISO 4217 standard. E.g. EUR, JPY. Defaults to USD.  |

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

### Example of a latest trade response

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

| Attribute | Type   | Notes                       |
| --------- | ------ | --------------------------- |
| `symbol`  | string | Symbol that was queried for |
| `trade`   | object | [Trade object](#trade)      |

## **Latest Multi Trades**

The Latest Multi Trades API provides the latest historical trade data for multiple given ticker symbols.

`GET/v2/stocks/trades/latest`

Returns the latest trade data for the queried stock symbols.

### Parameters

#### Query Parameters

| Attribute | Type   | Requirement                           | Notes                                                                                                                                                                                          |
| --------- | ------ | ------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `symbols` | string | {{<hint danger>}}Required {{</hint>}} | A comma separated string of symbols to get trades for.                                                                                                                                         |
| `feed`    | string | {{<hint info>}}Optional {{</hint>}}   | The feed to pull market data from. This is either `iex`, `otc`, or `sip`. `sip` and `otc` are only available to those with a subscription. Default is `iex` for free plans and `sip` for paid. |
| `currency` | string | {{<hint info>}}Optional {{</hint>}} | The currency for the returned prices in ISO 4217 standard. E.g. EUR, JPY. Defaults to USD.  |

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

### Example of a latest multi trades response

```json
{
  "trades": {
    "TSLA": {
      "t": "2022-04-12T17:05:06.936423531Z",
      "x": "V",
      "p": 995,
      "s": 100,
      "c": ["@"],
      "i": 10741,
      "z": "C"
    },
    "AAPL": {
      "t": "2022-04-12T17:05:17.428334819Z",
      "x": "V",
      "p": 167.86,
      "s": 100,
      "c": ["@"],
      "i": 7980,
      "z": "C"
    }
  }
}
```

### Properties

| Attribute | Type   | Notes                                                                                                   |
| --------- | ------ | ------------------------------------------------------------------------------------------------------- |
| `trades`  | object | A JSON object whose keys are the stock symbols queried for and whose values are [Trade objects](#trade) |

## **Quotes**

The Quotes API provides NBBO quotes for a given ticker symbol over a specified time period.

`GET/v2/stocks/{symbol}/quotes`

Returns quotes (NBBOs) for the queried stock symbol.

### Parameters

#### Path Parameters

| Attribute | Type   | Requirement                           | Notes                    |
| --------- | ------ | ------------------------------------- | ------------------------ |
| `symbol`  | string | {{<hint danger>}}Required {{</hint>}} | The symbol to query for. |

#### Query Parameters

| Attribute    | Type   | Requirement                         | Notes                                                                                                                                                                                            |
| ------------ | ------ | ----------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `start`      | string | {{<hint info>}}Optional {{</hint>}} | Filter data equal to or after this time in RFC-3339 format. Defaults to the beginning of the current day.                                                |
| `end`        | string | {{<hint info>}}Optional {{</hint>}} | Filter data equal to or before this time in RFC-3339 format. Defaults to the current time.                                                               |
| `limit`      | int    | {{<hint info>}}Optional {{</hint>}} | Number of data points to return. Must be in range 1-10000, defaults to 1000.                                                            |
| `asof`  | string | {{<hint info>}}Optional {{</hint>}}  | The asof date of the queried stock symbol in YYYY-MM-DD format. Default is the current day. This date will be used to look up the queried security. If the given security was renamed in the past, all its symbols will be returned. | 
| `feed`       | string | {{<hint info>}}Optional {{</hint>}} | Which feed to pull market data from. This is either `iex`, `otc`, or `sip`. `sip` and `otc` are only available to those with a subscription. Default is `iex` for free plans and `sip` for paid. |
| `page_token` | string | {{<hint info>}}Optional {{</hint>}} | Pagination token to continue from.                                                                                                                                                               |
| `currency` | string | {{<hint info>}}Optional {{</hint>}} | The currency for the returned prices in ISO 4217 standard. E.g. EUR, JPY. Defaults to USD.  |

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

### Example of a quotes response

```json
{
  "quotes": [
    {
      "t": "2022-04-12T08:00:00.000177Z",
      "ax": "Q",
      "ap": 165.15,
      "as": 4,
      "bx": "K",
      "bp": 165,
      "bs": 2,
      "c": ["R"],
      "z": "C"
    }
  ],
  "symbol": "AAPL",
  "next_page_token": "QUFQTHwyMDIyLTA0LTEyVDA4OjAwOjAwLjAwMDE3NzAwMFp8MEVEQjcxRDc="
}
```

### Properties

| Attribute         | Type              | Notes                                         |
| ----------------- | ----------------- | --------------------------------------------- |
| `quotes`          | array             | Array of [Quote objects](#quote)              |
| `symbol`          | string            | Symbol that was queried for                   |
| `next_page_token` | string (Nullable) | Token that can be used to query the next page |

## **Multi Quotes**

The Multi Quotes API provides NBBO quotes for multiple given ticker symbols over a specified time period.

`GET/v2/stocks/quotes`

Returns quotes (NBBOs) for the queried stock symbols.

### Parameters

#### Query Parameters

| Attribute    | Type   | Requirement                           | Notes                                                                                                                                                                                          |
| ------------ | ------ | ------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `symbols`    | string | {{<hint danger>}}Required {{</hint>}} | The comma-separated symbols to query quotes for.                                                                                       
| `start`      | string | {{<hint info>}}Optional {{</hint>}}   | Filter data equal to or after this time in RFC-3339 format. Defaults to the beginning of the current day.                                              |
| `end`        | string | {{<hint info>}}Optional {{</hint>}}   | Filter data equal to or before this time in RFC-3339 format. Defaults to the current time.                                                             |
| `feed`       | string | {{<hint info>}}Optional {{</hint>}}   | The feed to pull market data from. This is either `iex`, `otc`, or `sip`. `sip` and `otc` are only available to those with a subscription. Default is `iex` for free plans and `sip` for paid. |

| `limit`      | int    | {{<hint info>}}Optional {{</hint>}}   | Number of data points to return. Must be in range 1-10000, defaults to 1000.                                                                                      | `asof`  | string | {{<hint info>}}Optional {{</hint>}}  | The asof date of the queried stock symbol in YYYY-MM-DD format. Default is the current day. This date will be used to look up the queried security. If the given security was renamed in the past, all its symbols will be returned. |                             |
| `page_token` | string | {{<hint info>}}Optional {{</hint>}}   | Pagination token to continue from.                                                                                                                                                             |
| `currency` | string | {{<hint info>}}Optional {{</hint>}} | The currency for the returned prices in ISO 4217 standard. E.g. EUR, JPY. Defaults to USD.  |

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

### Example of a multi quotes response

```json
{
  "quotes": {
    "AAPL": [
      {
        "t": "2022-04-12T08:00:00.000177Z",
        "ax": "Q",
        "ap": 165.15,
        "as": 4,
        "bx": "K",
        "bp": 165,
        "bs": 2,
        "c": ["R"],
        "z": "C"
      }
    ]
  },
  "next_page_token": "QUFQTHwyMDIyLTA0LTEyVDA4OjAwOjAwLjAwMDE3NzAwMFp8MEVEQjcxRDc="
}
```

### Properties

| Attribute         | Type              | Notes                                                                                                             |
| ----------------- | ----------------- | ----------------------------------------------------------------------------------------------------------------- |
| `quotes`          | object            | A JSON object whose keys are the stock symbols queried for and whose values are arrays of [Quote objects](#quote) |
| `next_page_token` | string (Nullable) | Token that can be used to query the next page                                                                     |

## **Latest Quote**

The Latest Quote API provides the latest quote data for a given ticker symbol.

`GET/v2/stocks/{symbol}/quotes/latest`

This endpoint returns the latest quote data for the requested security.

### Parameters

#### Path Parameters

| Attribute | Type   | Requirement                           | Notes                    |
| --------- | ------ | ------------------------------------- | ------------------------ |
| `symbol`  | string | {{<hint danger>}}Required {{</hint>}} | The symbol to query for. |

#### Query Parameters

| Attribute | Type   | Requirement                         | Notes                                                                                                                                                                                          |
| --------- | ------ | ----------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `feed`    | string | {{<hint info>}}Optional {{</hint>}} | The feed to pull market data from. This is either `iex`, `otc`, or `sip`. `sip` and `otc` are only available to those with a subscription. Default is `iex` for free plans and `sip` for paid. |
| `currency` | string | {{<hint info>}}Optional {{</hint>}} | The currency for the returned prices in ISO 4217 standard. E.g. EUR, JPY. Defaults to USD.  |


### Response

{{<hint good>}}
A quote response object.

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

### Example of a latest quote response

```json
{
  "symbol": "AAPL",
  "quote": {
    "t": "2022-04-12T17:16:36.390749849Z",
    "ax": "V",
    "ap": 170.34,
    "as": 1,
    "bx": "V",
    "bp": 165.5,
    "bs": 1,
    "c": ["R"],
    "z": "C"
  }
}
```

### Properties

| Attribute | Type   | Notes                       |
| --------- | ------ | --------------------------- |
| `symbol`  | string | Symbol that was queried for |
| `quote`   | object | [Quote object](#quote)      |

## **Latest Multi Quotes**

The Latest Multi Quotes API provides the latest NBBO quotes for multiple given stock symbols.

`GET/v2/stocks/quotes/latest`

Returns quotes (NBBOs) for the queried stock symbols.

### Parameters

#### Query Parameters

| Attribute | Type   | Requirement                           | Notes                                                                                                                                                                                          |
| --------- | ------ | ------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `symbols` | string | {{<hint danger>}}Required {{</hint>}} | The comma-separated symbols to query quotes for.                                                                                                                                               |
| `feed`    | string | {{<hint info>}}Optional {{</hint>}}   | The feed to pull market data from. This is either `iex`, `otc`, or `sip`. `sip` and `otc` are only available to those with a subscription. Default is `iex` for free plans and `sip` for paid. |
| `currency` | string | {{<hint info>}}Optional {{</hint>}} | The currency for the returned prices in ISO 4217 standard. E.g. EUR, JPY. Defaults to USD.  |

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

### Example of a latest multi quotes response

```json
{
  "quotes": {
    "TSLA": {
      "t": "2022-04-12T17:26:45.009288296Z",
      "ax": "V",
      "ap": 1020,
      "as": 1,
      "bx": "V",
      "bp": 990,
      "bs": 1,
      "c": ["R"],
      "z": "C"
    },
    "AAPL": {
      "t": "2022-04-12T17:26:44.962998616Z",
      "ax": "V",
      "ap": 170,
      "as": 1,
      "bx": "V",
      "bp": 168.03,
      "bs": 1,
      "c": ["R"],
      "z": "C"
    }
  }
}
```

### Properties

| Attribute | Type   | Notes                                                                                                   |
| --------- | ------ | ------------------------------------------------------------------------------------------------------- |
| `quotes`  | object | A JSON object whose keys are the stock symbols queried for and whose values are [Quote objects](#quote) |

## **Bars**

The Bars API returns aggregate historical data for the requested security over a specified time period.

`GET/v2/stocks/{symbol}/bars`

Returns bars for the queried stock symbol.

{{<hint info>}}
**Calculating Stock Minute Bars**

Interested in learning how stock minute bars are calculated? See our [stock minute bars learn article](https://alpaca.markets/learn/stock-minute-bars/) for insights.

{{</hint>}}

### Parameters

#### Path Parameters

| Attribute | Type   | Requirement                           | Notes                    |
| --------- | ------ | ------------------------------------- | ------------------------ |
| `symbol`  | string | {{<hint danger>}}Required {{</hint>}} | The symbol to query for. |

#### Query Parameters

| Attribute    | Type   | Requirement                           | Notes                                                                                                                                                                                          |
| ------------ | ------ | ------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `timeframe`  | string | {{<hint danger>}}Required {{</hint>}} | Timeframe of the aggregation. Available values are flexible for Min, Hour, Day, Week and Month time window sizes with a maximum constraint on the values: 59Min, 23Hour, 1Day, 1Week, 12Month. |
| `start`      | string | {{<hint info>}}Optional {{</hint>}}   | Filter data equal to or after this time in RFC-3339 format. Defaults to the beginning of the current day.                                              |
| `end`        | string | {{<hint info>}}Optional {{</hint>}}   | Filter data equal to or before this time in RFC-3339 format. Defaults to the current time.                                                             |
| `limit`      | int    | {{<hint info>}}Optional {{</hint>}}   | Number of data points to return. Must be in range 1-10000, defaults to 1000.                                                                                                                   |
| `page_token` | string | {{<hint info>}}Optional {{</hint>}}   | Pagination token to continue from.                                                                                                                                                             |
| `adjustment` | string | {{<hint info>}}Optional {{</hint>}}   | Specifies the corporate action adjustment for the returned bars. Options are: ‘raw’, ‘split’, ‘dividend’ or ‘all’. Default value is‘raw’.                                                      |
| `asof`  | string | {{<hint info>}}Optional {{</hint>}}  | The asof date of the queried stock symbol in YYYY-MM-DD format. Default is the current day. This date will be used to look up the queried security. If the given security was renamed in the past, all its symbols will be returned. |
| `feed`       | string | {{<hint info>}}Optional {{</hint>}}   | The feed to pull market data from. This is either `iex`, `otc`, or `sip`. `sip` and `otc` are only available to those with a subscription. Default is `iex` for free plans and `sip` for paid. |
| `currency` | string | {{<hint info>}}Optional {{</hint>}} | The currency for the returned prices in ISO 4217 standard. E.g. EUR, JPY. Defaults to USD.  |

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

### Example of a bars response

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

| Attribute         | Type              | Notes                                         |
| ----------------- | ----------------- | --------------------------------------------- |
| `bars`            | array             | Array of [bar objects](#bar)                  |
| `symbol`          | string            | The symbol queried for                        |
| `next_page_token` | string (Nullable) | Token that can be used to query the next page |

## **Multi Bars**

The Multi Bars API returns aggregated historical data for multiple given ticker symbols over a specified time period.

`GET/v2/stocks/bars`

Returns bars for the queried stock symbols.

{{<hint info>}}
**Calculating Stock Minute Bars**

Interested in learning how stock minute bars are calculated? See our [stock minute bars learn article](https://alpaca.markets/learn/stock-minute-bars/) for insights.

{{</hint>}}

### Parameters

#### Query Parameters

| Attribute    | Type   | Requirement                           | Notes                                                                                                                                                                                          |
| ------------ | ------ | ------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `symbols`    | string | {{<hint danger>}}Required {{</hint>}} | The comma-separated symbols to query for.                                                                                                                                                      |
| `timeframe`  | string | {{<hint danger>}}Required {{</hint>}} | Timeframe of the aggregation. Available values are flexible for Min, Hour, Day, Week and Month time window sizes with a maximum constraint on the values: 59Min, 23Hour, 1Day, 1Week, 12Month. |
| `start`      | string | {{<hint info>}}Optional {{</hint>}}   | Filter data equal to or after this time in RFC-3339 format. Defaults to the beginning of the current day.                                              |
| `end`        | string | {{<hint info>}}Optional {{</hint>}}   | Filter data equal to or before this time in RFC-3339 format. Defaults to the current time.                                                             |
| `limit`      | int    | {{<hint info>}}Optional {{</hint>}}   | Number of data points to return. Must be in range 1-10000, defaults to 1000.                                                                                                                   |
| `page_token` | string | {{<hint info>}}Optional {{</hint>}}   | Pagination token to continue from.                                                                                      
| `asof`  | string | {{<hint info>}}Optional {{</hint>}}  | The asof date of the queried stock symbol in YYYY-MM-DD format. Default is the current day. This date will be used to look up the queried security. If the given security was renamed in the past, all its symbols will be returned. |                                                                      |
| `adjustment` | string | {{<hint info>}}Optional {{</hint>}}   | Specifies the corporate action adjustment for the returned bars. Options are: ‘raw’, ‘split’, ‘dividend’ or ‘all’. Default value is‘raw’.                                                      |
| `feed`       | string | {{<hint info>}}Optional {{</hint>}}   | The feed to pull market data from. This is either `iex`, `otc`, or `sip`. `sip` and `otc` are only available to those with a subscription. Default is `iex` for free plans and `sip` for paid. |
| `currency` | string | {{<hint info>}}Optional {{</hint>}} | The currency for the returned prices in ISO 4217 standard. E.g. EUR, JPY. Defaults to USD.  |

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

### Example of a multi symbol bars response

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

| Attribute         | Type              | Notes                                                                                                         |
| ----------------- | ----------------- | ------------------------------------------------------------------------------------------------------------- |
| `bars`            | object            | A JSON object whose keys are the stock symbols queried for and whose values are arrays of [Bar objects](#bar) |
| `next_page_token` | string (Nullable) | Token that can be used to query the next page                                                                 |

## **Latest Bar**

The Latest Bar API returns the latest minute-aggregated historical bar for the requested security.

`GET/v2/stocks/{symbol}/bars/latest`

Returns the latest minute bar for the queried stock symbol.

{{<hint info>}}
**Calculating Stock Minute Bars**

Interested in learning how stock minute bars are calculated? See our [stock minute bars learn article](https://alpaca.markets/learn/stock-minute-bars/) for insights.

{{</hint>}}

### Parameters

#### Path Parameters

| Attribute | Type   | Requirement                           | Notes                    |
| --------- | ------ | ------------------------------------- | ------------------------ |
| `symbol`  | string | {{<hint danger>}}Required {{</hint>}} | The symbol to query for. |

#### Query Parameters

| Attribute | Type   | Requirement                         | Notes                                                                                                                                                                                          |
| --------- | ------ | ----------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `feed`    | string | {{<hint info>}}Optional {{</hint>}} | The feed to pull market data from. This is either `iex`, `otc`, or `sip`. `sip` and `otc` are only available to those with a subscription. Default is `iex` for free plans and `sip` for paid. |
| `currency` | string | {{<hint info>}}Optional {{</hint>}} | The currency for the returned prices in ISO 4217 standard. E.g. EUR, JPY. Defaults to USD.  |

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

### Example of a latest bar response

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

| Attribute | Type   | Notes                     |
| --------- | ------ | ------------------------- |
| `symbol`  | string | The symbol queried for    |
| `bar`     | object | Latest [bar object](#bar) |

## **Latest Multi Bars**

The Latest Multi Bars API returns the latest minute-aggregated historical bar data for multiple given ticker symbols.

`GET/v2/stocks/bars/latest`

Returns bars for the queried stock symbols.

{{<hint info>}}
**Calculating Stock Minute Bars**

Interested in learning how stock minute bars are calculated? See our [stock minute bars learn article](https://alpaca.markets/learn/stock-minute-bars/) for insights.

{{</hint>}}

### Parameters

#### Query Parameters

| Attribute | Type   | Requirement                           | Notes                                                                                                                                                                                          |
| --------- | ------ | ------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `symbols` | string | {{<hint danger>}}Required {{</hint>}} | The comma-separated symbols to query for.                                                                                                                                                      |
| `feed`    | string | {{<hint info>}}Optional {{</hint>}}   | The feed to pull market data from. This is either `iex`, `otc`, or `sip`. `sip` and `otc` are only available to those with a subscription. Default is `iex` for free plans and `sip` for paid. |
| `currency` | string | {{<hint info>}}Optional {{</hint>}} | The currency for the returned prices in ISO 4217 standard. E.g. EUR, JPY. Defaults to USD.  |

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

### Example of a latest multi bars response

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

| Attribute | Type   | Notes                                                                                               |
| --------- | ------ | --------------------------------------------------------------------------------------------------- |
| `bars`    | object | A JSON object whose keys are the stock symbols queried for and whose values are [Bar objects](#bar) |

## **Snapshot**

The Snapshot API provides the latest trade, latest quote, minute bar daily bar, and previous daily bar data for a given ticker symbol.

`GET/v2/stocks/{symbol}/snapshot`

This endpoint returns the snapshot for the requested security.

### Parameters

#### Path Parameters

| Attribute | Type   | Requirement                           | Notes                    |
| --------- | ------ | ------------------------------------- | ------------------------ |
| `symbol`  | string | {{<hint danger>}}Required {{</hint>}} | The symbol to query for. |

#### Query Parameters

| Attribute | Type   | Requirement                         | Notes                                                                                                                                                                                          |
| --------- | ------ | ----------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `feed`    | string | {{<hint info>}}Optional {{</hint>}} | The feed to pull market data from. This is either `iex`, `otc`, or `sip`. `sip` and `otc` are only available to those with a subscription. Default is `iex` for free plans and `sip` for paid. |

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

### Example of a snapshot response for one ticker

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

| Attribute      | Type   | Notes                                   |
| -------------- | ------ | --------------------------------------- |
| `symbol`       | string | Symbol that was queried for             |
| `latestTrade`  | object | Latest [Trade object](#trade)           |
| `latestQuote`  | object | Latest [Quote object](#quote)           |
| `minuteBar`    | object | Minute [Bar object](#bar)               |
| `dailyBar`     | object | Daily [Bar object](#bar)                |
| `prevDailyBar` | object | Previous daily close [Bar object](#bar) |

## **Multi Snapshots**

The Snapshot API for multiple tickers provides the latest trade, latest quote, minute bar daily bar, and previous daily bar data for each given ticker symbol.

`GET/v2/stocks/snapshots`

This endpoint returns snapshot objects for the requested securities.

### Parameters

#### Query Parameters

| Attribute | Type   | Requirement                           | Notes                                     |
| --------- | ------ | ------------------------------------- | ----------------------------------------- |
| `symbols` | string | {{<hint danger>}}Required {{</hint>}} | The comma-separated symbols to query for. |

#### Path Parameters

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

### Example of a snapshots response for multiple tickers

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

| Attribute      | Type   | Notes                                   |
| -------------- | ------ | --------------------------------------- |
| `latestTrade`  | object | Latest [Trade object](#trade)           |
| `latestQuote`  | object | Latest [Quote object](#quote)           |
| `minuteBar`    | object | Minute [Bar object](#bar)               |
| `dailyBar`     | object | Daily [Bar object](#bar)                |
| `prevDailyBar` | object | Previous daily close [Bar object](#bar) |

## **Response Object Properties**

This section details the properties for trade, quote, and bar objects.

### Trade

A Trade object contains the details of one trade, such as the time of the trade, trade price, trade size, and trade exchange.
Trade objects return from the Trades, Multi Trades, Latest Trade, Latest Multi Trades, Snapshot, and Multi Snapshots endpoints.

```json
{
  "t": "2022-04-11T14:30:00.008348Z",
  "x": "D",
  "p": 166.48,
  "s": 1,
  "c": ["@", "I"],
  "i": 50688,
  "z": "C"
}
```

**Properties**

| Attribute | Type             | Notes                                                  |
| --------- | ---------------- | ------------------------------------------------------ |
| `t`       | string/timestamp | Timestamp in RFC-3339 format with nanosecond precision |
| `x`       | string           | Exchange where the trade happened                      |
| `p`       | number           | Trade price                                            |
| `s`       | int              | Trade size                                             |
| `c`       | array<string>    | Trade conditions                                       |
| `i`       | int              | Trade ID                                               |
| `z`       | string           | Tape                                                   |

### Quote

A Quote object contains the National Best Bid and Offer (NBBO) data for a security. Quotes return from
the Quotes, Multi Quotes, Latest Quote, Latest Multi Quotes, Snapshot, and Multi Snapshots endpoints.

```json
{
  "t": "2022-04-13T20:00:00.063514032Z",
  "ax": "V",
  "ap": 0,
  "as": 0,
  "bx": "V",
  "bp": 0,
  "bs": 0,
  "c": ["R"],
  "z": "C"
}
```

**Properties**

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
| `z`       | string           | Tape                                                   |

### Bar

A Bar object contains information such as open, high, low, and closing price for a stock. Bars return from
the Bars, Multi Bars, Latest Bar, Latest Multi Bars, Snapshot, and Multi Snapshot endpoints.

```json
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
```

**Properties**

| Attribute | Type             | Notes                                                  |
| --------- | ---------------- | ------------------------------------------------------ |
| `t`       | string/timestamp | Timestamp of open price in RFC-3339 format with nanosecond precision |
| `o`       | number           | Open price                                             |
| `h`       | number           | High price                                             |
| `l`       | number           | Low price                                              |
| `c`       | number           | Close price                                            |
| `v`       | int              | Volume                                                 |
| `n`       | int              | Number of trades                                       |
| `vw`      | number           | Volume-weighted average price                          |
