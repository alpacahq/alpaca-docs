---
weight: 10
bookFlatSection: true
title: Market Data
---

# Market Data

Access Alpaca's historical and real-time US stock market data through REST API and WebSocket.

### Data sources

Alpaca provides market data from two data sources:

**1. IEX (Investors Exchange LLC) which accounts for ~2.5% market volume**

* IEX is optimal to start testing out the platform and to utilize in applications where visualizing accurate price information may not take precedence.

**2. All US exchanges which accounts for 100% market volume**

* This Alpaca data feed is coming as direct feed from exchanges consolidated by the Securities Information Processors (SIPs). These link the U.S. markets by processing and consolidating all bid/ask quotes and trades from every trading venue into a single, easily consumed data feed.


* This gives ultra low latency and high reliability as the data comes directly into Alpaca's bare metal servers located in New Jersey sitting next to most of the market participants. 


* SIP data is great for creating your trading app or stock screener where accurate price information is essential for traders. 


### Sandbox access

You can access the IEX market data with your Broker API key. This is free of charge and you can redistribute it to your end user without any additional agreement.

#### Base URL:

`https://data.sandbox.alpaca.markets/v2`

#### URL:

`wss://stream.data.sandbox.alpaca.markets/v2/{source}`


To enable market data on a production environment please reach out to our sales team and they will set you up in no time.

To access Alpaca's SIP data it entails additional agreement and charges and corresponding exchanges. If you need this integration, please contact us.



## **Historical data**

### Subscription plans

The limitations listed below are default values but can be configured upon request.

**IEX**

* 5+ years historical data available
* Historical data is delayed by	15 minutes
* REST API calls are limited at 200/min


**SIP**

* 5+ years historical data available
* Historical data is not delayed
* REST API calls are unlimited



### Common behavior
#### Base URL

Alpaca Data API v2 provides historical data through multiple endpoints. These endpoints have the same URL prefix:

`https://data.alpaca.markets/v2`

This URL will default to the IEX data as long as SIP data is not enabled for broker account.

#### Authentication 

The authentication is done the same way as with the Trading API, simply set the following HTTP headers:

APCA-API-KEY-ID
APCA-API-SECRET-KEY

#### Limiting

Use the limit query parameter. The value should be in the range 1 - 10000 (endpoints included) with 1000 being the default if unspecified.

#### Paging

To support querying long timespans continuously we support paging in our API. If the result you have received contains a `next_page_token` that is **not** `null` there may be more data available in the timeframe you have chosen. Include the token you have received as the `page_token` query parameter for the next request you make while leaving the other parameters unchanged to continue where the previous response left off.

#### Ordering

The results are ordered in ascending order by time.


### Trades

The Trades API provides historcial trade data for a given ticker symbol on a specified date.

`GET/v2/stocks/{symbol}/trades`

Returns trades for the queried stock symbol.


#### Parameters

##### Path Parameters

| Attribute | Type             | Requirement                         | Notes                                           |
| --------- | ---------------- | ----------------------------------- | ----------------------------------------------- |
| `symbol`   | string | {{<hint danger>}}Required {{</hint>}} | The symbol to query for  |


##### Query Parameters

| Attribute | Type             | Requirement                         | Notes                                           |
| --------- | ---------------- | ----------------------------------- | ----------------------------------------------- |
| `start`   | string | {{<hint danger>}}Required {{</hint>}} | Filter data equal to or after this time in RFC-3339 format. Fractions of a second are not accepted  |
| `end`   | string | {{<hint danger>}}Required {{</hint>}} | Filter data equal to or before this time in RFC-3339 format. Fractions of a second are not accepted  |
| `limit`   | int | {{<hint info>}}Optional {{</hint>}} | Number of data points to return. Must be in range 1-10000, defaults to 1000  |
| `page_token`   | string | {{<hint info>}}Optional {{</hint>}} | Pagination token to continue from  |


#### Response

{{<hint good>}}
A trades response object.

{{</hint>}}


#### Errors

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


#### Example of one trade

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
#### Properties

| Attribute | Type       | Notes                  |
| --------- | ---------- | ---------------------- |
| `t`   | string/timestamp | Timestamp in RFC-3339 format with nanosecond precision |
| `x`     | string | Exchange where the trade happened|
| `p`     | number | Trade price|
| `s`     | int    | Trade size |
| `c`     | array<string> | Trade conditions |
| `i`     | int | Trade ID |
| `z`     | string | Tape |


#### Example of multiple trades

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

#### Properties

| Attribute | Type       | Notes                  |
| --------- | ---------- | ---------------------- |
| `trades`   | array<trade> | Array of trades |
| `symbol`     | string | Symbol that was queried|
| `next_page_token`     | string (Nullable) | Token that can be used to query the next page|


### Quotes

The Quotes API provides NBBO quotes for a given ticker symbol at a specified date.

`GET/v2/stocks/{symbol}/quotes`
Returns quotes (NBBOs) for the queried stock symbol

#### Parameters

##### Path Parameters

| Attribute | Type             | Requirement                         | Notes                                           |
| --------- | ---------------- | ----------------------------------- | ----------------------------------------------- |
| `symbol`   | string | {{<hint danger>}}Required {{</hint>}} | The symbol to query for  |


##### Query Parameters

| Attribute | Type             | Requirement                         | Notes                                           |
| --------- | ---------------- | ----------------------------------- | ----------------------------------------------- |
| `start`   | string | {{<hint danger>}}Required {{</hint>}} | Filter data equal to or after this time in RFC-3339 format. Fractions of a second are not accepted  |
| `end`   | string | {{<hint danger>}}Required {{</hint>}} | Filter data equal to or before this time in RFC-3339 format. Fractions of a second are not accepted  |
| `limit`   | int | {{<hint info>}}Optional {{</hint>}} | Number of data points to return. Must be in range 1-10000, defaults to 1000  |
| `page_token`   | string | {{<hint info>}}Optional {{</hint>}} | Pagination token to continue from  |


#### Response

{{<hint good>}}
A quotes response object.

{{</hint>}}


#### Errors

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


#### Example of one quote
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

#### Properties

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


#### Example of multiple quotes
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

#### Properties

| Attribute | Type       | Notes                  |
| --------- | ---------- | ---------------------- |
| `quotes`   | array<quote> | Array of quotes |
| `symbol`     | string | Symbol that was queried|
| `next_page_token`     | string (Nullable) | Token that can be used to query the next page|


### Bars

The bars API returns aggregate historical data for the requested securities.

`GET/v2/stocks/{symbol}/bars`
Returns bars for the queried stock symbol

#### Parameters

##### Path Parameters

| Attribute | Type             | Requirement                         | Notes                                           |
| --------- | ---------------- | ----------------------------------- | ----------------------------------------------- |
| `symbol`   | string | {{<hint danger>}}Required {{</hint>}} | The symbol to query for  |


##### Query Parameters

| Attribute | Type             | Requirement                         | Notes                                           |
| --------- | ---------------- | ----------------------------------- | ----------------------------------------------- |
| `start`   | string | {{<hint danger>}}Required {{</hint>}} | Filter data equal to or after this time in RFC-3339 format. Fractions of a second are not accepted  |
| `end`   | string | {{<hint danger>}}Required {{</hint>}} | Filter data equal to or before this time in RFC-3339 format. Fractions of a second are not accepted  |
| `limit`   | int | {{<hint info>}}Optional {{</hint>}} | Number of data points to return. Must be in range 1-10000, defaults to 1000  |
| `page_token`   | string | {{<hint info>}}Optional {{</hint>}} | Pagination token to continue from  |
| `timeframe`   | string | {{<hint danger>}}Required {{</hint>}} | Timeframe for the aggregation. Available values are flexible for Min, Hour, Day time window sizes with a maximum constraint on the values: 60Min, 24Hour, 31Day  |


#### Response

{{<hint good>}}
A bars response object.

{{</hint>}}


#### Errors

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


#### Example of one bar
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

#### Properties

| Attribute | Type       | Notes                  |
| --------- | ---------- | ---------------------- |
| `t`   | string/timestamp | Timestamp in RFC-3339 format with nanosecond precision |
| `o`     | number | Open price|
| `h`     | number | High price|
| `l`     | number    | Low price |
| `c`     | number | Close price|
| `v`     | int | Volume|


#### Example of multiple bars
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

#### Properties

| Attribute | Type       | Notes                  |
| --------- | ---------- | ---------------------- |
| `bars`   | array<bar> | Array of bars |
| `symbol`     | string | Symbol that was queried|
| `next_page_token`     | string (Nullable) | Token that can be used to query the next page|



## Real-time data

Alpaca Data API v2 provides websocket streaming for trades, quotes and minute bars. This helps receive the most up to date market information that could help your trading strategy to act upon certain market movements.

Once a connection is established and you have successfully authenticated yourself you can subscribe to trades, quotes and minute bars for a particular symbol or multiple symbols.


### Subscription plans

The limitations listed below are default values but can be configured upon request.

**IEX**

* You can only connect to IEX data source. One concurrent connection is allowed.
* Subscription is limited to 30 channels at a time for trades (trades) and quotes (quotes). 
* There is no limit for the number of channels with minute bars (bars).
* Minute bars are based on the trades from IEX.


**SIP**

* There is no limit for the number of channels at a time for trades, quotes and minute bars(trades,quotes and bars).
* Trades, quotes and mintue bars are direct feeds from the CTA (administered by NYSE) and UTP (administered by Nasdaq) SIPs.


### Common behavior

#### URL
To access real-time data use the URL below, substituting `iex` or `sip` to `{source}` depending on your subscription.

`wss://stream.data.alpaca.markets/v2/{source}`

Attemption to access a data source not available for your subscription will result in an error during authentication.

#### Message format
Every message you receive from the server will be in the format:

`[{"T": "{message_type}", {contents}},...]`

Control messages (i.e. where `"T"` is `error`, `success` or `subscription`) always arrive in arrays of size one to make their processing easier.

Data points however may arrive in arrays that have a length that is greater than one. This is to facilitate clients whose connection is not fast enough to handle data points sent one by one. Our server buffers the outgoing messages but slow clients may get disconnected if their buffer becomes full.


#### Encoding and compression
Messages over the websocket are in encoded as clear text.

To reduce bandwidth requirements we have implemented compression as per [RFC-7692](https://tools.ietf.org/html/rfc7692). Our SDKs handle this for you so in most cases you won’t have to implement anything yourself.


### Communication flow

The communication can be thought of as two separate phases: **establishment** and **receiving data**.

#### Establishment

To establish the connection **first you will need to connect** to our server using the URL above.

Upon successfully connecting, you will receive the welcome message:

`[{"T":"success","msg":"connected"}]`

Now you will need to **authenticate** yourself using your credentials by sending the following message:

`{"action": "auth", "key": "{APCA-API-KEY-ID}", "secret": "{APCA-API-SECRET-KEY}"}`

Please note that each account can have up to one concurrent websocket connection. Subsequent attempts to connect are rejected.

If you provided correct credentials you will receive another `success` message:

`[{"T":"success","msg":"authenticated"}]`

#### Receiving data
Congratulations, you are ready to receive real-time market data!

You can send one or more subscription messages (described [below](https://alpaca.markets/docs/api-documentation/api-v2/market-data/alpaca-data-api-v2/real-time/#subscribe) and after confirmation you will receive the corresponding market data.

At any time you can subscribe to or unsubscribe from symbols. Please note that due to the internal buffering mentioned above for a short while you may receive data points for symbols you have recently unsubscribed from.

### Client to server

#### Authentication
After connecting you will have to authenticate as described above.

`{"action":"auth","key":"PK******************","secret":"***********************************"}`

#### Subscribe
You can subscribe to `trades`, `quotes` and `bars` of a particular symbol (or `*` for every symbol in the case of `bars`). A `subscribe` message should contain what subscription you want to add to your current subscriptions in your session so you don’t have to send what you’re already subscribed to.

`{"action":"subscribe","trades":["AAPL"],"quotes":["AMD","CLDR"],"bars":["AAPL","VOO"]}`

You can also omit either one of them (`trades`, `quotes` or `bars`) if you don’t want to subscribe to any symbols in that category but be sure to include at least one of the three.

Unsubscribe#
Much like `subscribe` you can also send an `unsubscribe` message that subtracts the list of subscriptions specified from your current set of subscriptions.

`{"action":"unsubscribe","trades":["VOO"],"quotes":["IBM"],"bars":[]}`

### Server to client

#### Control messages
You may receive the following control messages during your session.

`[{"T":"success","msg":"connected"}]`

You have successfully connected to our server.

`[{"T":"success","msg":"authenticated"}]`

You have successfully authenticated.

#### Errors
You may receive an error during your session. You can differentiate between them using the list below.

`[{"T":"error","code":400,"msg":"invalid syntax"}]`

The message you sent to the server did not follow the specification

`[{"T":"error","code":401,"msg":"not authenticated"}]`

You have attempted to subscribe or unsubscribe before authentication.

`[{"T":"error","code":402,"msg":"auth failed"}]`

You have provided invalid authentication credentials.

`[{"T":"error","code":403,"msg":"already authenticated"}]`

You have already successfully authenticated during your current session.

`[{"T":"error","code":404,"msg":"auth timeout"}]`

You failed to successfully authenticate after connecting. You have a few seconds to authenticate after connecting.

`[{"T":"error","code":405,"msg":"symbol limit exceeded"}]`

The symbol subscription request you sent would put you over the limit set by your subscription package. If this happens your symbol subscriptions are the same as they were before you sent the request that failed.

`[{"T":"error","code":406,"msg":"connection limit exceeded"}]`

You already have an ongoing authenticated session.

`[{"T":"error","code":407,"msg":"slow client"}]`

You may receive this if you are too slow to process the messages sent by the server. Please note that this is not guaranteed to arrive before you are disconnected to avoid keeping slow connections active forever.

`[{"T":"error","code":408,"msg":"v2 not enabled"}]`

The account does not have access to Data v2.

`[{"T":"error","code":409,"msg":"insufficient subscription"}]`

You have attempted to access a data source not available in your subscription package.

`[{"T":"error","code":500,"msg":"internal error"}]`

An unexpected error occurred on our end and we are investigating the issue.

**Subscription confirmation**

After subscribing or unsubscribing you will receive a message that describes your current list of subscriptions.

`[{"T":"subscription","trades":["AAPL"],"quotes":["AMD","CLDR"],"bars":["IBM","AAPL","VOO"]}]`

You will always receive your entire list of subscriptions, as illustrated by the sample communication excerpt below:

```json
> {"action": "subscribe", "trades": ["AAPL"], "quotes": ["AMD", "CLDR"], "bars": ["*"]}
< [{"T":"subscription","trades":["AAPL"],"quotes":["AMD","CLDR"],"bars":["*"]}]
> {"action": "unsubscribe", "bars": ["*"]}
> [{"T":"subscription","trades":["AAPL"],"quotes":["AMD","CLDR"],"bars":[]}]
```


### Data points

Multiple data points may arrive in each message received from the server. These data points have the following formats, depending on their type.

### Trade schema

| Attribute | Type       | Notes                  |
| --------- | ---------- | ---------------------- |
| `T`   | string | message type, always “t” |
| `S`     | string | symbol|
| `i`     | int | trade ID|
| `x`     | string    | exchange code where the trade occurred |
| `p`     | number | trade price|
| `s`     | int | trade size|
| `t`     | string | RFC-3339 formatted timestamp with nanosecond precision|
| `c`     | array<string> | trade condition|
| `z`     | string | tape |


#### Example
```json
{
  "T": "t",
  "i": 96921,
  "S": "AAPL",
  "x": "D",
  "p": 126.55,
  "s": 1,
  "t": "2021-02-22T15:51:44.208Z",
  "c": [
    "@",
    "I"
  ],
  "z": "C"
}
```


### Quote schema

| Attribute | Type       | Notes                  |
| --------- | ---------- | ---------------------- |
| `T`   | string | message type, always “q” |
| `S`     | string | symbol|
| `ax`     | string | ask exchange code|
| `ap`     | number    | ask price |
| `as`     | int | ask size|
| `bx`     | string | bid exchange code|
| `bp`     | number    | bid price |
| `bs`     | int | bid size|
| `s`     | int | trade size|
| `t`     | string | RFC-3339 formatted timestamp with nanosecond precision|
| `c`     | array<string> | quote condition|
| `z`     | string | tape |


#### Example
```json
{
  "T": "q",
  "S": "AMD",
  "bx": "U",
  "bp": 87.66,
  "bs": 1,
  "ax": "Q",
  "ap": 87.68,
  "as": 4,
  "t": "2021-02-22T15:51:45.335689322Z",
  "c": [
    "R"
  ],
  "z": "C"
}
```


### Bar schema

| Attribute | Type       | Notes                  |
| --------- | ---------- | ---------------------- |
| `T`   | string | message type, always “b” |
| `S`     | string | symbol|
| `o`     | number | open price|
| `h`     | number    | high price |
| `l`     | number | low price|
| `c`     | number | close price|
| `v`     | int    | volume |
| `t`     | string | RFC-3339 formatted timestamp|

#### Example
```json
{
  "T": "b",
  "S": "SPY",
  "o": 388.985,
  "h": 389.13,
  "l": 388.975,
  "c": 389.12,
  "v": 49378,
  "t": "2021-02-22T19:15:00Z"
}
```


#### Streaming example

```json
$ wscat -c wss://stream.data.alpaca.markets/v2/sip
connected (press CTRL+C to quit)
< [{"T":"success","msg":"connected"}]
> {"action": "auth", "key": "*****", "secret": "*****"}
< [{"T":"success","msg":"authenticated"}]
> {"action": "subscribe", "trades": ["AAPL"], "quotes": ["AMD", "CLDR"], "bars": ["*"]}
< [{"T":"t","i":96921,"S":"AAPL","x":"D","p":126.55,"s":1,"t":"2021-02-22T15:51:44.208Z","c":["@","I"],"z":"C"}]
< [{"T":"q","S":"AMD","bx":"U","bp":87.66,"bs":1,"ax":"X","ap":87.67,"as":1,"t":"2021-02-22T15:51:45.3355677Z","c":["R"],"z":"C"},{"T":"q","S":"AMD","bx":"U","bp":87.66,"bs":1,"ax":"Q","ap":87.68,"as":4,"t":"2021-02-22T15:51:45.335689322Z","c":["R"],"z":"C"},{"T":"q","S":"AMD","bx":"U","bp":87.66,"bs":1,"ax":"X","ap":87.67,"as":1,"t":"2021-02-22T15:51:45.335806018Z","c":["R"],"z":"C"}]
```

