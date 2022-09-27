---
weight: 10
title: Activities and Fees
summary: Crypto API supports over 52+ crypto pairs tradable using USD, BTC and USDT
---

# Crypto Activities

## Crypto Fees

Alpaca stock trading remains commission-free, where crypto trading includes a small fee per trade dependant on volume. See the below table with volume-tiered fee pricing:

| **Tier** | **30d Trading Volume (USD)** | **via Trading API** | **via Dashboard / OAuth** |
| -------- | ---------------------------- | ------------------- | ------------------------- |
| 1        | 0                            | 25 bps              | 25 bps                    |
| 2        | >500,000                     | 22 bps              | 22 bps                    |
| 3        | >1,000,000                   | 20 bps              | 20 bps                    |
| 4        | >5,000,000                   | 18 bps              | 18 bps                    |
| 5        | >10,000,000                  | 15 bps              | 15 bps                    |
| 6        | >25,000,000                  | 13 bps              | 13 bps                    |
| 7        | >50,000,000                  | 10 bps              | 12 bps                    |
| 8        | >100,000,000                 | 8 bps               | 12 bps                    |

The crypto fee will be charged on the credited crypto asset/fiat (what you receive) per trade. Some examples,

- Buy `ETH/BTC`, you receive `ETH`, the fee is denominated in `ETH`
- Sell `ETH/BTC`, you receive `BTC`, the fee is denominated in `BTC`
- Buy `ETH/USD`, you receive `ETH`, the fee is denominated in `ETH`
- Sell `ETH/USD`, you receive `USD`, the fee is denominated in `USD`

To get the fees incured from crypto trading you can use [Activities API]({{< relref "../api-references/trading-api/account-activities" >}}) to query `activity_type` by `CFEE` or `FEE`. See below example of `CFEE` object,

```json
{
    "id": "20220812000000000::53be51ba-46f9-43de-b81f-576f241dc680",
    "activity_type": "CFEE",
    "date": "2022-08-12",
    "net_amount": "0",
    "description": "Coin Pair Transaction Fee (Non USD)",
    "symbol": "ETHUSD",
    "qty": "-0.000195",
    "price": "1884.5",
    "status": "executed"
}
```

Fees are currently calculated and posted end of day. If you query on same day of trade you might not get results. We will be providing an update for fee posting to be real-time in the near future.


{{< hint info >}}
For latest information regarding crypto fees see our [Crypto FAQs](https://alpaca.markets/support/alpaca-crypto-coin-pair-faq/).
{{< /hint >}}