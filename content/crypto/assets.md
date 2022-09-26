---
weight: 5
title: Available Assets
summary: Crypto API supports over 52+ crypto pairs tradable using USD, BTC and USDT
---

# Avialable Crypto Assets


Alpaca supports over 20+ unique crypto assets across 52 trading pairs. Current trading pairs are based on BTC, USD, and USDT with more assets and trading pairs coming soon.

To query all available crypto assets and pairs you can you use the following API call,

```bash
curl --request GET 'https://api.alpaca.markets/v2/assets?asset_class=crypto' \
--header 'Apca-Api-Key-Id: <KEY>' \
--header 'Apca-Api-Secret-Key: <SECRET>'
```

Below is a sample trading pair object composed of two assets, `BTC` and `USD`.

```json
{
  "id": "276e2673-764b-4ab6-a611-caf665ca6340",
  "class": "crypto",
  "exchange": "FTXU",
  "symbol": "BTC/USD",
  "name": "BTC/USD pair",
  "status": "active",
  "tradable": true,
  "marginable": false,
  "shortable": false,
  "easy_to_borrow": false,
  "fractionable": true,
  "min_order_size": "0.0001",
  "min_trade_increment": "0.0001",
  "price_increment": "1"
}
```

For further reference see [Assets API]({{< relref "../api-references/crypto-api/assets" >}}).