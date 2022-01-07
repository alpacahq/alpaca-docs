---
title: Historical Data
weight: 100
summary: Alpaca Crypto Data API provides historical data for more than 5 years.
---

#  Historical Crypto Data

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




