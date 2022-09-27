---
weight: 5
title: Crypto Orders
summary: Crypto API supports over 52+ crypto pairs tradable using USD, BTC and USDT
---

# Crypto Orders

When submitting crypto orders through the [Orders API]({{< relref "../api-references/crypto-api/orders" >}}) and the Alpaca web dashboard, Market, Limit and Stop Limit orders are supported while the supported
`time_in_force` values are `gtc`, and `ioc`. We accept fractional
orders as well with either `notional` or `qty` provided.

You can submit crypto orders for a any supported crypto pair via API, see the below cURL POST request.

```bash
curl --request POST 'https://paper-api.alpaca.markets/v2/orders' \
--header 'Apca-Api-Key-Id: <KEY>' \
--header 'Apca-Api-Secret-Key: <SECRET>' \
--header 'Content-Type: application/json' \
--data-raw '{
  "symbol": "BTC/USD",
  "qty": "0.0001",
  "side": "buy",
  "type": "market",
  "time_in_force": "gtc"
}'
```

The above request submits a market order via API to buy 0.0001 BTC with USD (`BTC/USD` pair) that is good till end of day.

{{<hint info>}}
**Note** We only support `gtc` and `ioc` time in force options for crypto orders.
{{</hint>}}

To learn more see [orders]({{< relref "/trading/orders.md" >}}) and [fractional trading]({{< relref "/trading/fractional-trading.md" >}}).

All cryptocurrency assets are fractionable but the supported decimal points vary depending on the cryptocurrency. See [Assets entity]({{< relref "../api-references/trading-api/assets.md#asset-entity" >}}) for information on fractional precisions per asset.

Note these values could change in the future.