---
title: Crypto Pricing API
weight: 100
summary: Alpaca Market Data API provides real-time & 5+ years of historical cryptocurrency pricing data.
---

# Crypto Pricing API

**Please note that Alpaca Crypto Data is in beta - we welcome any feedback to improve our offering.**

Alpaca provides crypto data from multiple venues and but currently routes orders to FTX.US only.

List of **crypto** exchanges which are supported by Alpaca.

| Exchange Code | Name of Exchange      |
|---------------|-----------------------|
| ERSX          | ErisX                 |
| FTXU          | FTX                   |
| CBSE          | Coinbase              |

### Common behavior
**Base URL**

The Crypto Data API provides historical data through multiple endpoints. These endpoints have the same URL prefix (omitted from now on):

```
https://data.alpaca.markets/v1beta2/crypto
```

This URL is the **same for both subscription plans**, there is no limitation

{{< hint info >}}
**Broker API Businesses Sandbox Access**  

You can access the crypto market data with your Broker API key. 

#### Historical Base URL

`https://data.sandbox.alpaca.markets/v1beta2/crypto`

#### Stream URL

`wss://stream.data.sandbox.alpaca.markets/v1beta2/crypto`

{{< /hint >}}

### **Authentication**

The authentication is done the same way as with the Trading API, simply set the following HTTP headers:

- `APCA-API-KEY-ID`
- `APCA-API-SECRET-KEY`

### **Limiting**

Use the `limit` query parameter. The value should be in the range **1 - 10000** (endpoints included) with **1000 being the default** if unspecified.

### **Paging**

To support querying long timespans continuously we support paging in our API. If the result you have received contains a `next_page_token` that is **not `null`** there may be more data available in the timeframe you have chosen. Include the token you have received as the `page_token` query parameter for the next request you make while leaving the other parameters unchanged to continue where the previous response left off.

### **Ordering**

The results are ordered in ascending order by time.

### **Timestamps**

The timestamps for trades, quotes, and bars correspond to when a trade was executed or a quote was generated on the exchange or OTC desk.
