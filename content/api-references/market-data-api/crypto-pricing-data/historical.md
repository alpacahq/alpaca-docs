---
title: Historical Data
weight: 100
summary: Alpaca Crypto Data API provides historical data for more than 5 years.
---

# Historical Crypto Data

{{< hint warning >}}
**Looking for the old v1beta1 endpoints?**  

We have improved our market data endpoints and labeled them under a new v1beta2 tag. These are the preferred default request
crypto market data. 

If you need the reference to the older v1beta1 endpoints, see
[relevant documentation here]({{< relref "/api-references/market-data-api/crypto-pricing-data/historical-v1beta1.md" >}}).
{{< /hint >}}

{{< hint info >}}
**How is v1beta2 different from v1beta1?**  
  1. All endpoints now support multiple symbols as a query parameter.
  2. The symbol format has been changed. E.g. BTCUSD is changed to BTC/USD. 
  3. The latest order book endpoint has been introduced, while the latest cross-best bid and offer (XBBO) endpoint across exchanges is removed.



{{< /hint >}}

{{< hint info >}}
All crypto market data endpoints have been made public and require no authentication. However, please authenticate to increase your data rate limit.
{{< /hint >}}


## Trades

The crypto trades API provides historical trade data for a list of crypto symbols between the specified dates.

{{< rest-endpoint resource="crypto-trades-beta2" method="GET" path="/v1beta2/crypto/trades" useh3="true" >}}

### Errors

{{<hint warning>}}
400 - Bad Request

​One of the request parameters is invalid. See the returned message for details
{{</hint>}}

{{<hint warning>}}
403 - Forbidden

Authentication headers are missing or invalid.
{{</hint>}}

{{<hint warning>}}
404 - Not found

​The requested object was not found.
{{</hint>}}

### Response

{{< rest-entity-example name="crypto-trades-beta2" >}}

### Properties

{{< rest-entity-desc name="crypto-trades-beta2" >}}

## Latest Trade

The Latest trade API provides the latest trade data for given crypto symbol(s).

{{< rest-endpoint resource="crypto-latest-trades-beta2" method="GET" path="/v1beta2/crypto/latest/trades" useh3="true" >}}

### Errors

{{<hint warning>}}
400 - Bad Request

​One of the request parameters is invalid. See the returned message for details
{{</hint>}}

{{<hint warning>}}
403 - Forbidden

Authentication headers are missing or invalid.
{{</hint>}}

{{<hint warning>}}
404 - Not found

​The requested object was not found.
{{</hint>}}

### Response

{{< rest-entity-example name="crypto-latest-trades-beta2" >}}

### Properties

{{< rest-entity-desc name="crypto-latest-trades-beta2" >}}

## Quotes

The crypto quotes API provides historical quote data for a list of crypto symbols between the specified dates.

{{< rest-endpoint resource="crypto-quotes-beta2" method="GET" path="/v1beta2/crypto/quotes" useh3="true" >}}

### Errors

{{<hint warning>}}
400 - Bad Request

​One of the request parameters is invalid. See the returned message for details
{{</hint>}}

{{<hint warning>}}
403 - Forbidden

Authentication headers are missing or invalid.
{{</hint>}}

{{<hint warning>}}
404 - Not found

​The requested object was not found.
{{</hint>}}

### Response

{{< rest-entity-example name="crypto-quotes-beta2" >}}

### Errors

{{<hint warning>}}
400 - Bad Request

​One of the request parameters is invalid. See the returned message for details
{{</hint>}}

{{<hint warning>}}
403 - Forbidden

Authentication headers are missing or invalid.
{{</hint>}}

{{<hint warning>}}
404 - Unprocessable

​The requested object was not found.
{{</hint>}}


### Properties

{{< rest-entity-desc name="crypto-quotes-beta2" >}}

## Latest Quote

The Latest Quote API provides the latest quote data for given ticker symbol(s).

{{< rest-endpoint resource="crypto-latest-quotes-beta2" method="GET" path="/v1beta2/crypto/latest/quotes" useh3="true" >}}

### Errors

{{<hint warning>}}
400 - Bad Request

​One of the request parameters is invalid. See the returned message for details
{{</hint>}}

{{<hint warning>}}
403 - Forbidden

Authentication headers are missing or invalid.
{{</hint>}}

{{<hint warning>}}
404 - Not found

​The requested object was not found.
{{</hint>}}

### Response

{{< rest-entity-example name="crypto-latest-quotes-beta2" >}}

### Properties

{{< rest-entity-desc name="crypto-latest-quotes-beta2" >}}

## Bars

The crypto bars API provides historical bars aggregates for a list of crypto symbols between the specified dates.

{{< rest-endpoint resource="crypto-bars-beta2" method="GET" path="/v1beta2/crypto/bars" useh3="true" >}}

### Errors

{{<hint warning>}}
400 - Bad Request

​One of the request parameters is invalid. See the returned message for details
{{</hint>}}

{{<hint warning>}}
403 - Forbidden

Authentication headers are missing or invalid.
{{</hint>}}

{{<hint warning>}}
404 - Not found

​The requested object was not found.
{{</hint>}}

### Response

{{< rest-entity-example name="crypto-bars-beta2" >}}

### Properties

{{< rest-entity-desc name="crypto-bars-beta2" >}}

## Latest Bars

The Latest Bars API returns aggregate historical data for the requested crypto symbol(s).

{{< rest-endpoint resource="crypto-latest-bars-beta2" method="GET" path="/v1beta2/crypto/latest/bars" useh3="true" >}}

### Errors

{{<hint warning>}}
400 - Bad Request

​One of the request parameters is invalid. See the returned message for details
{{</hint>}}

{{<hint warning>}}
403 - Forbidden

Authentication headers are missing or invalid.
{{</hint>}}

{{<hint warning>}}
404 - Not found

​The requested object was not found.
{{</hint>}}

### Response

{{< rest-entity-example name="crypto-latest-bars-beta2" >}}

### Properties

{{< rest-entity-desc name="crypto-latest-bars-beta2" >}}

## Snapshot

The Snapshot API returns the latest trade, latest quote, latest minute bar, latest daily bar, and previous daily bar data for crypto symbol(s).

{{< rest-endpoint resource="crypto-snapshots-beta2" method="GET" path="/v1beta2/crypto/snapshots" useh3="true" >}}

### Errors

{{<hint warning>}}
400 - Bad Request

​One of the request parameters is invalid. See the returned message for details
{{</hint>}}

{{<hint warning>}}
403 - Forbidden

Authentication headers are missing or invalid.
{{</hint>}}

{{<hint warning>}}
404 - Not found

​The requested object was not found.
{{</hint>}}

### Response

{{< rest-entity-example name="crypto-snapshots-beta2" >}}

### Properties

{{< rest-entity-desc name="crypto-snapshots-beta2" >}}

## Latest Orderbook

The Latest Orderbook API returns the latest orderbook for crypto symbol(s).

{{< rest-endpoint resource="crypto-latest-orderbooks-beta2" method="GET" path="/v1beta2/crypto/latest/orderbooks" useh3="true" >}}

### Errors

{{<hint warning>}}
400 - Bad Request

​One of the request parameters is invalid. See the returned message for details
{{</hint>}}

{{<hint warning>}}
403 - Forbidden

Authentication headers are missing or invalid.
{{</hint>}}

{{<hint warning>}}
404 - Not found

​The requested object was not found.
{{</hint>}}

### Response

{{< rest-entity-example name="crypto-orderbooks-beta2" >}}

### Properties

{{< rest-entity-desc name="crypto-orderbooks-beta2" >}}

