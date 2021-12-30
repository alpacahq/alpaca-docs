---
title: Historical data
weight: 100
summary: Alpaca Crypto Data API provides historical data for more than 5 years.
---

# Historical Data

**Please note that Alpaca Crypto Data is in beta - we welcome any feedback to improve our offering.**

Alpaca provides crypto data from multiple venues and does not route orders to all venues even though it offers data.

List of **crypto** exchanges which are supported by Alpaca.

| Exchange Code | Name of Exchange      |
| ------------- | --------------------- |     
| ERSX          | ErisX                 |
| GNSS          | Genesis               |
| CBSE          | Coinbase              |


## Common behavior

**Base URL**

The Crypto Data API provides historical data through multiple endpoints. These endpoints have the same URL prefix (omitted from now on):

```
https://data.alpaca.markets/v1beta1/crypto
```

This URL is the **same for both subscription plans**, there is no limitation 


**Authentication**
The authentication is done the same way as with the [Trading API](https://alpaca.markets/docs/api-documentation/api-v2/#authentication), simply set the following HTTP headers:

- `APCA-API-KEY-ID`
- `APCA-API-SECRET-KEY`


**Limiting**

Use the `limit` query parameter. The value should be in the range **1 - 10000** (endpoints included) with **1000 being the default** if unspecified.


**Paging**

To support querying long timespans continuously we support paging in our API. If the result you have received contains a `next_page_token` that is **not `null`** there may be more data available in the timeframe you have chosen. Include the token you have received as the `page_token` query parameter for the next request you make while leaving the other parameters unchanged to continue where the previous response left off.


**Ordering**

The results are ordered in ascending order by time.

**Timestamps**

The timestamps for trades, quotes, and bars correspond to when a trade was executed or a quote was generated on the exchange or OTC desk.

## Trades

The Trades API provides historcial trade data for a given crypto symbol on a specified date.

{{< rest-endpoint resource="crypto-trades" method="GET" path="/v1beta1/crypto/{symbol}/trades" useh3="true" >}}


### Response

{{< rest-entity-example name="crypto-trades" >}}


### Properties

{{< rest-entity-desc name="crypto-trades" >}}



## Latest trade

The Latest trade API provides the latest trade data for a given crypto symbol.

{{< rest-endpoint resource="crypto-latest-trade" method="GET" path="/v1beta1/crypto/{symbol}/trades/latest" useh3="true" >}}


### Response

{{< rest-entity-example name="crypto-latest-trade" >}}


### Properties

{{< rest-entity-desc name="crypto-latest-trade" >}}



## Quotes

The Quotes API provides quotes for a given crypto symbol at a specified date.

{{< rest-endpoint resource="crypto-quotes" method="GET" path="/v1beta1/crypto/{symbol}/quotes" useh3="true" >}}


### Response

{{< rest-entity-example name="crypto-quotes" >}}


### Properties

{{< rest-entity-desc name="crypto-quotes" >}}



## Latest quote

The Latest quote API provides the latest quote data for a given ticker symbol.

{{< rest-endpoint resource="crypto-latest-quote" method="GET" path="/v1beta1/crypto/{symbol}/quotes/latest" useh3="true" >}}


### Response

{{< rest-entity-example name="crypto-latest-quote" >}}


### Properties

{{< rest-entity-desc name="crypto-latest-quote" >}}



## Bars

The Bars API returns aggregate historical data for the requested securities.

{{< rest-endpoint resource="crypto-bars" method="GET" path="/v1beta1/crypto/{symbol}/bars" useh3="true" >}}


### Response

{{< rest-entity-example name="crypto-bars" >}}


### Properties

{{< rest-entity-desc name="crypto-bars" >}}


## XBBO

The XBBO API best bid and offer across venues.

{{< rest-endpoint resource="crypto-xbbo" method="GET" path="/v1beta1/crypto/{symbol}/xbbo/latest" useh3="true" >}}


### Response

{{< rest-entity-example name="crypto-xbbo" >}}


### Properties

{{< rest-entity-desc name="crypto-xbbo" >}}


## **Snapshot - Ticker**

The Snapshot API for one ticker provides the latest trade, latest quote, minute bar daily bar and previous daily bar data for a given ticker symbol.

`GET/v1beta1/crypto/{symbol}/snapshot`

This endpoint returns the snapshot for the requested security.

### Parameters

#### Path Parameters

| Attribute | Type   | Requirement                           | Notes                   |
| --------- | ------ | ------------------------------------- | ----------------------- |
| `symbol`  | string | {{<hint danger>}}Required {{</hint>}} | The symbol to query for |

#### Query Parameters

| Attribute | Type   | Requirement                           | Notes                   |
| --------- | ------ | ------------------------------------- | ----------------------- |
| `exchange`  | string | {{<hint danger>}}Required {{</hint>}} | The exchange that you'd like to query the snapshot data from |

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
404 - Not found

​ _Invalid value for path parameter_
{{</hint>}}

{{<hint warning>}}
422 - Unprocessable entity

​ _Invalid value for query parameter_
{{</hint>}}

{{<hint warning>}}
429 - Too many requests

​ _Rate limit exceeded_
{{</hint>}}

### Example of a snapshot for one ticker

```json
{
    "symbol": "BTCUSD",
    "latestTrade": {
        "t": "2021-12-23T19:26:49.984653Z",
        "x": "CBSE",
        "p": 50871.22,
        "s": 0.02,
        "tks": "S",
        "i": 254415322
    },
    "latestQuote": {
        "t": "2021-12-22T13:59:18.956Z",
        "x": "CBSE",
        "bp": 48599.99,
        "bs": 0.00869379,
        "ap": 48600,
        "as": 0.01449426
    },
    "minuteBar": {
        "t": "2021-12-23T19:25:00Z",
        "x": "CBSE",
        "o": 50855.01,
        "h": 50917.25,
        "l": 50849.99,
        "c": 50849.99,
        "v": 40.4265327,
        "n": 406,
        "vw": 50874.8168953414
    },
    "dailyBar": {
        "t": "2021-12-23T06:00:00Z",
        "x": "CBSE",
        "o": 48395.6,
        "h": 50974,
        "l": 48050.05,
        "c": 50849.99,
        "v": 7146.86855505,
        "n": 170503,
        "vw": 49405.9524594402
    },
    "prevDailyBar": {
        "t": "2021-12-22T06:00:00Z",
        "x": "CBSE",
        "o": 48998.06,
        "h": 49555,
        "l": 48073.53,
        "c": 48396.21,
        "v": 8844.16220315,
        "n": 269500,
        "vw": 48775.8157106311
    }
}
```

### Properties

| Attribute      | Type   | Notes                           |
| -------------- | ------ | ------------------------------- |
| `symbol`       | string | The ticker associated with this snapshot|
| `latestTrade`  | object | Latest trade object             |
| `latestQuote`  | object | Latest quote object             |
| `minuteBar`    | object | Minute bar object               |
| `dailyBar`     | object | Daily bar object                |
| `prevDailyBar` | object | Previous daily close bar object |


