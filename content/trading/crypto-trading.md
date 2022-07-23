---
title: Crypto Trading
weight: 5
aliases:
  - /crypto-trading.md
---

# Crypto Trading

We offer crypto trading through API and the Alpaca web dashboard! Trade all day, seven days a week, as frequently as you'd like.

Crypto trading is currently available for eligible international participants and participants in all US jurisdictions with the exception of New York. Existing Alpaca users in approved jurisdictions can enable crypto trading capabilities now via the dashboard.

New users in approved jurisdictions can sign up for an account [here](https://app.alpaca.markets/signup) to start trading crypto now.

## Supported Assets

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

Note that symbology for trading pairs has changed from our previous format, where `BTC/USD` was previosly referred to as `BTCUSD`. Our API has made proper changes to support the legacy convention as well for backwards compatibility.

For further reference see [Assets API]({{< relref "../api-references/trading-api/assets" >}}).



## Supported Orders

When submitting crypto orders through the [Orders API]({{< relref "../api-references/trading-api/orders" >}}) and the Alpaca web dashboard, Market, Limit and Stop Limit orders are supported while the supported
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
  "time_in_force": "day"
}'
```

The above request submits a market order via API to buy 0.0001 BTC with USD (`BTC/USD` pair) that is good till end of day.

To learn more see [orders]({{< relref "/trading/orders.md" >}}) and [fractional trading]({{< relref "/trading/fractional-trading.md" >}}).

All cryptocurrency assets are fractionable but the supported decimal points vary depending on the cryptocurrency. See [Assets entity]({{< relref "../api-references/trading-api/assets.md#asset-entity" >}}) for information on fractional precisions per asset.

Note these values could change in the future.

## Crypto Market Data

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

## Transferring Crypto

Alpaca now offers native on-chain crypto transfers with wallets! If you have crypto trading enabled and reside in an eligible US state or international jurisdiction you can access wallets on the web dashboard via the `Crypto Transfers` tab.

Alpaca wallets currently support transfers for Bitcoin, Ether, Solana and USDT (ERC20). To learn more on transferring crypto with Alpaca, see [Crypto Wallets FAQs](https://alpaca.markets/support/alpaca-crypto-coin-pair-faq/)

{{< hint info >}}
**Wallets API coming soon!**  

Wallets functionality via API is coming out soon so that you can automate your crypto transfers. We will send out communications and update documentation when its ready.
{{< /hint >}}

## Crypto Fees

Alpaca stock trading remains commission-free, where crypto trading includes a small fee per trade dependant on volume. See the below table with volume-tiered fee pricing:

| **Tier** | **30d Trading Volume (USD)** | **via Trading API** | **via Dashboard / OAuth** |
| -------- |----------------------------- | ------------------- | ------------------------- |
|    1   |            0               |     30 bps      |          50 bps       |
|    2   |        >500,000            |     28 bps      |          40 bps       |
|    3   |       >1,000,000           |     25 bps      |          30 bps       |
|    4   |       >5,000,000           |     20 bps      |          25 bps       |
|    5   |       >10,000,000          |     18 bps      |          20 bps       |
|    6   |       >25,000,000          |     15 bps      |          15 bps       |
|    7   |       >50,000,000          |   12.5 bps      |        12.5 bps       |
|    8   |       >100,000,000         |     10 bps      |        12.5 bps       |

The crypto fee will be charged on the credited crypto asset/fiat (what you receive) per trade. Some examples,

- Buy `ETH/BTC`, you receive `ETH`, the fee is denominated in `ETH`
- Sell `ETH/BTC`, you receive `BTC`, the fee is denominated in `BTC`
- Buy `ETH/USD`, you receive `ETH`, the fee is denominated in `ETH`
- Sell `ETH/USD`, you receive `USD`, the fee is denominated in `USD`

We will be updating this documentation section with instructions on how to obtain fee information programatically via API. For now, fees can be viewed in the web dashboard.

{{< hint info >}}
For latest information regarding crypto fees see our [Crypto FAQs](https://alpaca.markets/support/alpaca-crypto-coin-pair-faq/).
{{< /hint >}}

## Margin and Short Selling

Cryptocurrencies are non-marginable. This means that you cannot use leverage to
buy them and orders are evaluated against `non_marginable_buying_power`.

Cryptocurrencies are not shortable.

## Trading Hours

Crypto trading is offered for 24 hours everyday and your orders will be executed
throughout the day.

---

{{< info-box >}} Cryptocurrency trading is offered through an account with
Alpaca Crypto LLC. Alpaca Crypto LLC is not a member of FINRA or SIPC.
Cryptocurrencies are not stocks and your cryptocurrency investments are not
protected by either FDIC or SIPC. {{< /info-box >}}
