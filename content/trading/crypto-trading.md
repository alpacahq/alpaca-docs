---
title: Crypto Trading
weight: 55
aliases:
    - /crypto-trading.md
---

# Crypto Trading

We now offer crypto trading through our API and the Alpaca web dashboard! Trade all day, seven days a week, as frequently as you'd like. 

Crypto trading is currently available for eligible international participants and participants in all US jurisdictions with the exception of New York. Existing Alpaca users in approved jurisdictions can enable crypto trading capabilities now via the dashboard.

New users in approved jurisdictions can sign up for an account [here](https://app.alpaca.markets/signup) to start trading crypto now.

## Supported Assets

The number of supported cryptocurrencies is above 20 now on the Alpaca platform. We
constantly evaluate the list and aim to to grow the number of supported
currencies.

Tradable cryptocurrencies can be identified through the [Assets API]({{< relref "../api-references/trading-api/assets" >}}) where the asset entity has `class = crypto` and `tradable = true`.

```json
{
    "id": "64bbff51-59d6-4b3c-9351-13ad85e3c752",
    "class": "crypto",
    "exchange": "FTXU",
    "symbol": "BTCUSD",
    "name": "Bitcoin",
    "status": "active",
    "tradable": true,
    "marginable": false,
    "shortable": false,
    "easy_to_borrow": false,
    "fractionable": true
}
```

Please note that the symbol appears with `USD`, such as `BTCUSD` instead of `BTC`.

## Supported Orders
When submitting crypto orders through the [Orders API]({{< relref "../api-references/trading-api/orders" >}}) and the Alpaca web dashboard, Market, Limit and Stop Limit orders are supported while the supported
`time_in_force` values are `gtc`, and `ioc`. We accept fractional
orders as well with either `notional` or `qty` provided.

Learn more about [orders]({{< relref "/trading/orders.md" >}}) and [fractional trading]({{< relref "/trading/fractional-trading.md" >}}). 

All cryptocurrency assets are fractionable but the supported decimal points vary depending on the cryptocurrency.

| Symbol    | Minimum Qty  | Qty Increment | Price Increment  |
|-----------|--------------|---------------|------------------|
| AAVEUSD   | 0.01         | 0.01          | $0.1             |
| ALGOUSD   | 1            | 1             | $0.0001          |
| AVAXUSD   | 0.10         | 0.10          | $0.0005          |
| BATUSD    | 1            | 1             | $0.000025        |
| BTCUSD    | 0.0001       | 0.0001        | $1               |
| BCHUSD    | 0.001        | 0.0001        | $0.025           |
| LINKUSD   | 0.1          | 0.1           | $0.0005          |    
| DAIUSD    | 0.1          | 0.1           | $0.0001          |
| DOGEUSD   | 1            | 1             | $0.0000005       |
| ETHUSD    | 0.001        | 0.001         | $0.1             |
| GRTUSD    | 1            | 1             | $0.00005         |
| LTCUSD    | 0.01         | 0.01          | $0.005           |
| MKRUSD    | 0.001        | 0.001         | $0.5             |
| MATICUSD  | 10           | 10            | $0.000001        |
| NEARUSD   | 0.1           | 0.1          | $0.001           |
| PAXGUSD   | 0.0001       | 0.0001        | $0.1             |
| SHIBUSD   | 100000       | 100000        | $0.00000001      |
| SOLUSD    | 0.01         | 0.01          | $0.0025          |
| SUSHIUSD  | 0.5          | 0.5           | $0.0001          |
| USDTUSD   | 0.01         | 0.01          | $0.0001          |
| TRXUSD    | 1            | 1             | $0.0000025       |
| UNIUSD    | 0.1          | 0.1           | $0.001           |
| WBTCUSD   | 0.0001       | 0.0001        | $1               |
| YFIUSD    | 0.001        | 0.001         | $5          |



Note these values could change in the future.

## Margin and Short Selling
Cryptocurrencies are non-marginable. This means that you cannot use leverage to
buy them and orders are evaluated against `non_marginable_buying_power`.

Cryptocurrencies are not shortable.

## Market Data
Crypto market data is provided through both the Free and Unlimited data plans.

## Transferring Crypto
At this time, we don't support transfers of crypto in or out of your account.
You have to fund your Alpaca account in USD first through the regular funding
methods.

## Trading Hours
Crypto trading is offered for 24 hours everyday and your orders will be executed
throughout the day.

----

{{< info-box >}} Cryptocurrency trading is offered through an account with
Alpaca Crypto LLC. Alpaca Crypto LLC is not a member of FINRA or SIPC.
Cryptocurrencies are not stocks and your cryptocurrency investments are not
protected by either FDIC or SIPC. {{< /info-box >}}
