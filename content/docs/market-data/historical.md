---
weight: 11
title: Historical data
---

# Historical data

## Subscription plans

The limitations listed below are default values but can be configured upon request.

**Free plan**

* 5+ years historical SIP data available
* Historical data is delayed by	15 minutes
* REST API calls are limited at 200/min


**Unlimited plan**

* 5+ years historical SIP data available
* Historical data is not delayed
* Unlimited REST API 


## Common behavior

### Base URL

Alpaca Data API v2 provides historical data through multiple endpoints. These endpoints have the same URL prefix:


`https://data.alpaca.markets/v2`


This URL will default to the Free plan as long as the Unlimited plan is not enabled for the broker account.

### Authentication 

The authentication follows as described on the [authentication overview](https://alpaca.markets/docs/broker/api-overview/#authentication-and-rate-limit). 


### Limiting

Use the limit query parameter. The value should be in the range 1 - 10000 (endpoints included) with 1000 being the default if unspecified.

### Paging

To support querying long timespans continuously we support paging in our API. If the result you have received contains a `next_page_token` that is **not** `null` there may be more data available in the timeframe you have chosen. Include the token you have received as the `page_token` query parameter for the next request you make while leaving the other parameters unchanged to continue where the previous response left off.

### Ordering

The results are ordered in ascending order by time.


## Trades

The Trades API provides historcial trade data for a given ticker symbol on a specified date.

`GET/v2/stocks/{symbol}/trades`

Returns trades for the queried stock symbol.


### Parameters

#### Path Parameters

| Attribute | Type             | Requirement                         | Notes                                           |
| --------- | ---------------- | ----------------------------------- | ----------------------------------------------- |
| `symbol`   | string | {{<hint danger>}}Required {{</hint>}} | The symbol to query for  |


#### Query Parameters

| Attribute | Type             | Requirement                         | Notes                                           |
| --------- | ---------------- | ----------------------------------- | ----------------------------------------------- |
| `start`   | string | {{<hint danger>}}Required {{</hint>}} | Filter data equal to or after this time in RFC-3339 format. Fractions of a second are not accepted  |
| `end`   | string | {{<hint danger>}}Required {{</hint>}} | Filter data equal to or before this time in RFC-3339 format. Fractions of a second are not accepted  |
| `limit`   | int | {{<hint info>}}Optional {{</hint>}} | Number of data points to return. Must be in range 1-10000, defaults to 1000  |
| `page_token`   | string | {{<hint info>}}Optional {{</hint>}} | Pagination token to continue from  |


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
  "c": [
    " ",
    "T"
  ],
  "i": 52983525029461,
  "z": "B"
}
```

### Properties

| Attribute | Type       | Notes                  |
| --------- | ---------- | ---------------------- |
| `t`   | string/timestamp | Timestamp in RFC-3339 format with nanosecond precision |
| `x`     | string | Exchange where the trade happened|
| `p`     | number | Trade price|
| `s`     | int    | Trade size |
| `c`     | array<string> | Trade conditions |
| `i`     | int | Trade ID |
| `z`     | string | Tape |


### Example of multiple trades
```json
{
  "trades": [
      {
          "t": "2021-02-06T13:04:56.334320128Z",
          "x": "C",
          "p": 387.62,
          "s": 100,
          "c": [
              " ",
              "T"
          ],
          "i": 52983525029461,
          "z": "B"
      },
      {
          "t": "2021-02-06T13:09:42.325484032Z",
          "x": "C",
          "p": 387.69,
          "s": 100,
          "c": [
              " ",
              "T"
          ],
          "i": 52983525033813,
          "z": "B"
      }
  ],
  "symbol": "SPY",
  "next_page_token": "MjAyMS0wMi0wNlQxMzowOTo0Mlo7MQ=="
}
```

### Properties

| Attribute | Type       | Notes                  |
| --------- | ---------- | ---------------------- |
| `trades`   | array<trade> | Array of trades |
| `symbol`     | string | Symbol that was queried|
| `next_page_token`     | string (Nullable) | Token that can be used to query the next page|


## Quotes

The Quotes API provides NBBO quotes for a given ticker symbol at a specified date.

`GET/v2/stocks/{symbol}/quotes`
Returns quotes (NBBOs) for the queried stock symbol

### Parameters

#### Path Parameters

| Attribute | Type             | Requirement                         | Notes                                           |
| --------- | ---------------- | ----------------------------------- | ----------------------------------------------- |
| `symbol`   | string | {{<hint danger>}}Required {{</hint>}} | The symbol to query for  |


#### Query Parameters

| Attribute | Type             | Requirement                         | Notes                                           |
| --------- | ---------------- | ----------------------------------- | ----------------------------------------------- |
| `start`   | string | {{<hint danger>}}Required {{</hint>}} | Filter data equal to or after this time in RFC-3339 format. Fractions of a second are not accepted  |
| `end`   | string | {{<hint danger>}}Required {{</hint>}} | Filter data equal to or before this time in RFC-3339 format. Fractions of a second are not accepted  |
| `limit`   | int | {{<hint info>}}Optional {{</hint>}} | Number of data points to return. Must be in range 1-10000, defaults to 1000  |
| `page_token`   | string | {{<hint info>}}Optional {{</hint>}} | Pagination token to continue from  |


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


### Example of one quote
```json
{
  "t": "2021-02-06T13:35:08.946977536Z",
  "ax": "C",
  "ap": 387.7,
  "as": 1,
  "bx": "N",
  "bp": 387.67,
  "bs": 1,
  "c": [
    "R"
  ]
}
```

### Properties

| Attribute | Type       | Notes                  |
| --------- | ---------- | ---------------------- |
| `t`   | string/timestamp | Timestamp in RFC-3339 format with nanosecond precision |
| `ax`     | string | Ask exchange|
| `ap`     | number | Ask price|
| `as`     | int    | Ask size |
| `bx`     | string | Bid exchange|
| `bp`     | number | Bid price|
| `bs`     | int    | Bid size |
| `c`     | array<string> | Quote conditions |
| `i`     | int | Trade ID |
| `z`     | string | Tape |


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
          "c": [
              "R"
          ]
      },
      {
          "t": "2021-02-06T13:35:09.327977984Z",
          "ax": "C",
          "ap": 387.7,
          "as": 1,
          "bx": "C",
          "bp": 387.58,
          "bs": 1,
          "c": [
              "R"
          ]
      }
  ],
  "symbol": "SPY",
  "next_page_token": "MjAyMS0wMi0wNlQxMzozNTowOVo7MQ=="
}
```

### Properties

| Attribute | Type       | Notes                  |
| --------- | ---------- | ---------------------- |
| `quotes`   | array<quote> | Array of quotes |
| `symbol`     | string | Symbol that was queried|
| `next_page_token`     | string (Nullable) | Token that can be used to query the next page|


## Bars

The bars API returns aggregate historical data for the requested securities.

`GET/v2/stocks/{symbol}/bars`

Returns bars for the queried stock symbol

### Parameters

#### Path Parameters

| Attribute | Type             | Requirement                         | Notes                                           |
| --------- | ---------------- | ----------------------------------- | ----------------------------------------------- |
| `symbol`   | string | {{<hint danger>}}Required {{</hint>}} | The symbol to query for  |


#### Query Parameters

| Attribute | Type             | Requirement                         | Notes                                           |
| --------- | ---------------- | ----------------------------------- | ----------------------------------------------- |
| `start`   | string | {{<hint danger>}}Required {{</hint>}} | Filter data equal to or after this time in RFC-3339 format. Fractions of a second are not accepted  |
| `end`   | string | {{<hint danger>}}Required {{</hint>}} | Filter data equal to or before this time in RFC-3339 format. Fractions of a second are not accepted  |
| `limit`   | int | {{<hint info>}}Optional {{</hint>}} | Number of data points to return. Must be in range 1-10000, defaults to 1000  |
| `page_token`   | string | {{<hint info>}}Optional {{</hint>}} | Pagination token to continue from  |
| `timeframe`   | string | {{<hint danger>}}Required {{</hint>}} | Timeframe for the aggregation. Available values are flexible for Min, Hour, Day time window sizes with a maximum constraint on the values: 60Min, 24Hour, 31Day  |


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

| Attribute | Type       | Notes                  |
| --------- | ---------- | ---------------------- |
| `t`   | string/timestamp | Timestamp in RFC-3339 format with nanosecond precision |
| `o`     | number | Open price|
| `h`     | number | High price|
| `l`     | number    | Low price |
| `c`     | number | Close price|
| `v`     | int | Volume|


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

| Attribute | Type       | Notes                  |
| --------- | ---------- | ---------------------- |
| `bars`   | array<bar> | Array of bars |
| `symbol`     | string | Symbol that was queried|
| `next_page_token`     | string (Nullable) | Token that can be used to query the next page|