---
weight: 5
title: Crypto Trading
summary: Enable crypto trading for your end users with low cost trading tiers.
---

# Crypto for Broker API

Alpaca supports crypto trading 24 hours a day, every day. Crypto is available for testing in sandbox, in case you want to allow your users to trade crypto please reach out to the Sales or Developer Success team.

Crypto trading is currently available for eligible international participants and participants in all US jurisdictions with the exception of New York. 

## Enabling Crypto

To enable crypto trading for an account, the crypto agreements must be signed by the user. All account balances will represent the crypto trading activities. 

In the case of new users, the crypto agreement can be submitted via the Accounts API where `crypto_agreement` is part of the agreements attribute.

*Part of the request*
```json
{
    "agreements": [
        {
        "agreement": "crypto_agreement",
        "signed_at": "2021-09-11T18:09:33Z",
        }
    ]
}
```

In the case of existing users the account has to be updated with the `crypto_agreement` which can be submitted on the `PATCH /v1/accounts/{account_id}` endpoint.


*Request*
```json
{
  "agreements": [
    {
      "agreement": "crypto_agreement",
      "signed_at": "2021-10-11T18:13:44Z",
      "ip_address": "185.13.21.99"
    }
  ]
}
```

Once the crypto agreement is added to the user account no further edits can be made to the agreements.

To determine whether the account is all set to start trading crypto, use the `crypto_status` attribute from the Account API endpoint response object.

*Response example*
```json
{
  "id": "9feee08f-22d2-4804-89c1-bf01166aad52",
  "account_number": "943690069",
  "status": "ACTIVE",
  "crypto_status": "ACTIVE",
}
```


**Crypto Status**

| Attribute             | Description                                           |
|-----------------------|-------------------------------------------------------|
| `INACTIVE`            | Account not enabled to trade crypto live              |
| `ACTIVE`              | Crypto account is active and can start trading        |
| `SUBMISSION_FAILED`   | Account submissions has failed                        |



## Supported Assets

The number of supported cryptocurrencies is above 20 on the Alpaca platform. We
constantly evaluate the list and aim to to grow the number of supported
currencies.

Tradable cryptocurrencies can be identified through the Assets API where the asset entity has `class = crypto` and `tradable = true`.

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

All cryptocurrency assets are fractionable but the supported decimal points vary depending on the cryptocurrency.

| Symbol    | Minimum Qty  | Qty Increment | Price Increment  |
|-----------|--------------|---------------|------------------|
| AAVEUSD   | 0.01         | 0.01          | $0.1             |
| AVAXUSD   | 0.10        | 0.10         | $0.0005             |
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
| PAXGUSD   | 0.0001       | 0.0001        | $0.1             |
| SHIBUSD   | 100000       | 100000        | $0.00000001      |
| SOLUSD    | 0.01         | 0.01          | $0.0025          |
| SUSHIUSD  | 0.5          | 0.5           | $0.0001          |
| USDTUSD   | 0.01         | 0.01          | $0.0001          |
| TRXUSD    | 1            | 1             | $0.0000025       |
| UNIUSD    | 0.1          | 0.1           | $0.001           |
| WBTCUSD   | 0.0001       | 0.0001        | $1               |
| YFIUSD    | 0.001        | 0.001         | $5               |


Note these values could change in the future.

## Supported Orders
When submitting crypto orders through the Orders API, Market, Limit and Stop Limit orders are supported while the supported
`time_in_force` values are `gtc`, and `ioc`. We accept fractional
orders as well with either `notional` or `qty` provided.

## Required disclosures

Below you will find required disclosure templates to safely support crypto in your applications as a broker with Alpaca.

### Onboarding Disclosures

When onboarding your users as a broker offering crypto the following disclosure is required. During your onboarding flow make sure the user is able to read and affirmatively acknowledge, such as through a separate checkbox, the following text:

I have read, understood, and agree to be bound by Alpaca Crypto LLC and `[your legal entity]` account terms, and all other terms, disclosures and disclaimers applicable to me, as referenced in the Alpaca Crypto Agreement. I also acknowledge that the Alpaca Crypto Agreement contains a pre-dispute arbitration clause in Section 26.

### Buy/Sell Order Screen Disclosures

As a broker enabling the placement of cryptocurrency orders, the following disclosures should appear on the user’s order entry screen, on the app or website, immediately prior to the user submitting the buy or sell order.

#### Buy Order Disclosure

By placing an order to buy `[$ amount of / number of ]` `[cryptocurrency]`, you are 
directing and authorizing Alpaca Securities LLC to transfer funds necessary 
to cover the purchase costs from your Alpaca Securities LLC account into 
your Alpaca Crypto LLC account.  Cryptocurrency services are facilitated by 
Alpaca Crypto LLC.  Cryptocurrencies are not securities and are not FDIC 
insured or protected by SIPC.  [Disclosures](https://files.alpaca.markets/disclosures/library/CryptoRiskDisclosures.pdf).

#### Sell Order Disclosure

By placing an order to sell `[$ amount of / number of ]` `[cryptocurrency]`, you are 
directing and authorizing Alpaca Crypto LLC to transfer settled funds from 
the sale into your Alpaca Securities LLC account.  Cryptocurrency services 
are facilitated by Alpaca Crypto LLC.  Cryptocurrencies are not securities and
are not FDIC insured or protected by SIPC.  [Disclosures](https://files.alpaca.markets/disclosures/library/CryptoRiskDisclosures.pdf).

## Margin and Short Selling
Cryptocurrencies are non-marginable. This means that you cannot use leverage to
buy them and orders are evaluated against `non_marginable_buying_power`.

Cryptocurrencies are not shortable.


## Trading Hours
Crypto trading is offered for 24 hours everyday and your orders will be executed
throughout the day.


## Market Data
Alpaca provides crypto data from multiple venues but currently routes all orders to FTX.

Crypto exchanges supported by Alpaca:
| Exchange Code    | Name of Exchange |
|------------------|------------------|
| ERSX             | ErisX            |
| CBSE             | Coinbase         |
| FTXU             | FTX              |


## FAQ


**Is crypto available across 50 states?**
Crypto is currently available in 49 states with the exception of New York.


**Is crypto available in all countries?**
Alpaca is supported in all countries listed [here](https://alpaca.markets/support/countries-alpaca-is-available/).


**Can I use crypto only in my app?**
Yes. If you want to enable crypto trading only for your users, you can do so by showing only the crypto assets within the product. 


**Does the portfolio history support crypto 24/7?**
The portfolio history does not yet support a 24/7 cycle.


**Are the same documents available for crypto as for equities?**
Monthly statements and trade confirmations are not generated for crypto trading.
Tax documents (1099-MISC) will be provided for the crypto trades by Alpaca.


**Can I add my own markup to the spread?**
Yes, Alpaca can set your preferred percentage to add the markup/premium to the crypto spread.


**Can I transfer cryptocurrency into/out of Alpaca?**
Users can buy and sell cryptocurrency on Alpaca. However, we do not support transferring crypto into or out of accounts at this time.


----

{{< info-box >}} Cryptocurrency trading is offered through an account with
Alpaca Crypto LLC. Alpaca Crypto LLC is not a member of FINRA or SIPC.
Cryptocurrencies are not stocks and your cryptocurrency investments are not
protected by either FDIC or SIPC. {{< /info-box >}}
