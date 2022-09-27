---
weight: 5
title: Crypto Pricing Data
summary: Crypto API supports over 52+ crypto pairs tradable using USD, BTC and USDT
---

# Crypto Pricing Data

## Historical Data

Alpaca provides free limited crypto data and a more advanced unlimited paid plan. To learn more on our paid plan or to subscribe see [Alpaca Data](https://alpaca.markets/data).

To request trading pairs data via REST API, see [Crypto Pricing Data REST API Reference]({{< relref "../api-references/market-data-api/crypto-pricing-data/historical.md" >}}).

The example below requests latest orderbook data (bid and asks) for the following three crypto trading pairs: `BTC/USD`, `ETH/BTC` and `ETH/USD`.

```bash
curl --request GET 'data.alpaca.markets/v1beta2/crypto/latest/orderbooks?symbols=BTC/USD,ETH/BTC,ETH/USD' \
--header 'Apca-Api-Key-Id: <KEY>' \
--header 'Apca-Api-Secret-Key: <SECRET>'
```

```json
{
    "orderbooks": {
        "BTC/USD": {
            "a": [
                {
                    "p": 23541,
                    "s": 0.6118
                },
                ...
            ],
            "b": [
                {
                    "p": 23535,
                    "s": 0.0084
                },
                ...
            ],
            "t": "2022-07-19T22:12:18.485428736Z"
        },
        "ETH/USD": { ... }
        },
        "ETH/BTC": { ... }
    }
}
```

## Real-time Data

Additionally, you can subcribe to real-time crypto data via Websockets. Example below leverages `wscat` to subscribe to `BTC/USD` orderbook.

```bash
 $ wscat -c wss://stream.data.alpaca.markets/v1beta2/crypto
Connected (press CTRL+C to quit)
< [{"T":"success","msg":"connected"}]
> {"action": "auth", "key": "<KEY>", "secret": "<SECRET>"}
< [{"T":"success","msg":"authenticated"}]
> {"action":"subscribe","orderbooks":["BTC/USD"]}
< [{"T":"subscription","trades":[],"quotes":[],"orderbooks":["BTC/USD"],"bars":[],"updatedBars":[],"dailyBars":[]}]
< [{"T":"o","S":"BTC/USD","t":"2022-07-19T22:18:43.569566208Z","b":[{"p":23475,"s":0.124},{"p":23474,"s":0.2129},{"...
```

For further reference of real-time crypto pricing data. see [Real-time Data Reference section]({{< relref "../api-references/market-data-api/crypto-pricing-data/realtime.md" >}}).