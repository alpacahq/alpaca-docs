---
title: Historical Data
weight: 100
summary: Alpaca Crypto Data API provides historical data for more than 5 years.
---

# Historical Crypto Data

## Trades

The Trades API provides historcial trade data for a given crypto symbol on a specified date.

{{< rest-endpoint resource="crypto-trades" method="GET" path="/v1beta1/crypto/{symbol}/trades" useh3="true" >}}

### Response

{{< rest-entity-example name="crypto-trades" >}}

### Properties

{{< rest-entity-desc name="crypto-trades" >}}

## Latest Trade

The Latest trade API provides the latest trade data for a given crypto symbol.

{{< rest-endpoint resource="crypto-latest-trade" method="GET" path="/v1beta1/crypto/{symbol}/trades/latest" useh3="true" >}}

### Response

{{< rest-entity-example name="crypto-latest-trade" >}}

### Properties

{{< rest-entity-desc name="crypto-latest-trade" >}}

## Multi Trades

The Multi Trades API provides the latest trade data for a comma-separated list of crypto symbols.

{{< rest-endpoint resource="crypto-multi-trades" method="GET" path="/v1beta1/crypto/trades" useh3="true" >}}

### Response

{{< rest-entity-example name="crypto-multi-trades" >}}

### Properties

{{< rest-entity-desc name="crypto-multi-trades" >}}

## Quotes

The Quotes API provides quotes for a given crypto symbol at a specified date.

{{< rest-endpoint resource="crypto-quotes" method="GET" path="/v1beta1/crypto/{symbol}/quotes" useh3="true" >}}

### Response

{{< rest-entity-example name="crypto-quotes" >}}

### Properties

{{< rest-entity-desc name="crypto-quotes" >}}

## Latest Quote

The Latest Quote API provides the latest quote data for a given ticker symbol.

{{< rest-endpoint resource="crypto-latest-quote" method="GET" path="/v1beta1/crypto/{symbol}/quotes/latest" useh3="true" >}}

### Response

{{< rest-entity-example name="crypto-latest-quote" >}}

### Properties

{{< rest-entity-desc name="crypto-latest-quote" >}}

## Multi Quotes

The Multi Quotes API provides the latest quote data for each of the queried crypto symbols.

{{< rest-endpoint resource="crypto-multi-quotes" method="GET" path="/v1beta1/crypto/quotes" useh3="true" >}}

### Response

{{< rest-entity-example name="crypto-multi-quotes" >}}

### Properties

{{< rest-entity-desc name="crypto-multi-quotes" >}}

## Bars

The Bars API returns aggregate historical data for the requested crypto symbol.

{{< rest-endpoint resource="crypto-bars" method="GET" path="/v1beta1/crypto/{symbol}/bars" useh3="true" >}}

### Response

{{< rest-entity-example name="crypto-bars" >}}

### Properties

{{< rest-entity-desc name="crypto-bars" >}}

## Multi Bars

The Multi Bars API returns aggregate historical data for each of the requested crypto symbols.

{{< rest-endpoint resource="crypto-multi-bars" method="GET" path="/v1beta1/crypto/bars" useh3="true" >}}

### Response

{{< rest-entity-example name="crypto-multi-bars" >}}

### Properties

{{< rest-entity-desc name="crypto-multi-bars" >}}

## Snapshot

The Snapshot API returns the latest trade, latest quote, latest minute bar, latest daily bar, and previous daily bar data for a given crypto symbol.

{{< rest-endpoint resource="crypto-snapshot" method="GET" path="/v1beta1/crypto/{symbol}/snapshot" useh3="true" >}}

### Response

{{< rest-entity-example name="crypto-snapshot" >}}

### Properties

{{< rest-entity-desc name="crypto-snapshot" >}}

## Multi Snapshots

The Multi Snapshots API returns the latest trade, latest quote, minute bar daily bar, and previous daily bar data for each of the given crypto symbols.

{{< rest-endpoint resource="crypto-multi-snapshots" method="GET" path="/v1beta1/crypto/snapshots" useh3="true" >}}

### Response

{{< rest-entity-example name="crypto-multi-snapshots" >}}

### Properties

{{< rest-entity-desc name="crypto-multi-snapshots" >}}

## Latest XBBO

The Latest XBBO API returns the latest cross best bid and offer across exchanges.

{{< rest-endpoint resource="crypto-xbbo" method="GET" path="/v1beta1/crypto/{symbol}/xbbo/latest" useh3="true" >}}

### Response

{{< rest-entity-example name="crypto-xbbo" >}}

### Properties

{{< rest-entity-desc name="crypto-xbbo" >}}
