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

{{< hint warning >}}
**New Trading Pairs for Brokers coming soon!**  

We are rolling out crypto trading pairs which will allow your users to trade additional crypto assets with `BTC` and `USDT` as base assets on top of the current default `USD` pairs. The largest impact this new trading feature brings to brokers is a change in crypto pair symbol convention. For example, `BTCUSD` would now be represented as `BTC/USD`.

Changes have been made to APIs to be backwards compatible with the old representation of crypto symbols (e.g. `BTCUSD`). This should minimize disruption for any brokers not actively looking to support new pairs. Should you encounter any problems due to this change please reach out to support.

If your interested in rolling out new crypto trading pairs and want to enale on your environment reach out to support.

For more information on enabling new crypto pairs, see [Migration Steps]({{< relref "##migrating-to-new-crypto-pairs" >}}).

**Note: By end of Semptember, all brokers will be asked to change to the new symbology convention as this will be the default for crypto trading.**

{{< /hint >}}

Tradable cryptocurrencies can be identified through the [Assets API]({{<relref "../../api-references/broker-api/assets">}}) where the asset entity has `class = crypto` and `tradable = true`.

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


## Migrating to New Crypto Pairs

We are in the process of enabling new assets for brokers in the form of crypto pairs. This will enable brokers to execute trades to the traditional USD pairs and the new non-USD pairs. Prior to this change we only supported.

**Deadline to migrate to new crypto pairs is September 31st!** After this date we will switch all brokers to leverage new crypto pairs symbology. We highly recommend you switch prior to this date to avoid any unforeseen problems. We will enable crypto pairs on sandbox by defualt during migration period in preparation to move to the new pairs and symbology by default. Here are some steps to take care of during migration:


1. New symbology: Once crypto pairs are enabled [Assets API]({{<relref "../../api-references/broker-api/assets">}}) (`/v1/assets`) will start returning crypto assets with new symbology. For example, `BTCUSD` would now be returned as `BTC/USD` where we now separete the base and quote currencies.
2. Start consuming [crypto market data from `v1beta2` endpoints]({{<relref "../../api-references/market-data-api/crypto-pricing-data/historical.md">}}): Traditionally, brokers have been consuming crypto data from `v1beta1`, you will need to change to new market data endpoints to be able to consume data for pairs with new symbology. This includes both historical and real-time data. 
3. When submitting orders, you can contunue using old symbology as we have made this backwards compatible. However, we encourage changing order submission to use new symbology.
4. For positions, these will remain with the same symbology. This does not change as most crypto assets are quoted in `USD`.
5. For new crypto pairs, fees would be collected in quoted crypto assets. For example, a buy or sell of `ETH/BTC` would incur in a `BTC` fee collected as this is the quote currency/asset. For current pairs, such as `BTC/USD`, the collected fee would be in `USD` which is how this has typically worked.

{{<hint info>}}
**Reconciliation with new symbology**

Some brokers might leverage activities with current positions to do some form of reconciliation. Take note that positions will continue to use old symbology, such as `BTCUSD`, while activities will use new crypto pairs convention `BTC/USD`.

If you system previosly matched positions, with activities or other sources of information such as orders these migth cause problem and we encourage to do a broad sweep of these to make sure all is handled correctly with this new migration.
{{</hint>}}

{{<hint warning>}}
**Crypto Fee Revenue Notice**
If you enable non-USD crypto trading you will receive fees in the quote currency. Currently, non-USD quote crypto assets are `BTC` and `USDT`. As a broker business you would need to be ready to handle collecting crypto fees plus taking care of the necessary conversions if needed.
{{</hint>}}

### Crypto Pairs API Changes

With the introduction of crypto pairs some APIs have changed how certain fields return data, particularly the symbol key which will now include a forward slash (`/`) such as `BTC/USD`.

Below we go over some API examples of how things changed or reamined the same and explain why.

#### Assets API

Generally, the largest change with pairs have been the introduction of the the forward slash in the `symbol` field of the asset.

Additionally, the crypto asset `name` field has also change the naming convention given its now a pair of two assets.


{{< columns >}} <!-- begin columns block -->
##### Old Asset Objects

```json
{
    "id": "89691a28-7d5e-46bc-ab11-d5f3bf9ffffc",
    "class": "crypto",
    "exchange": "FTXU",
    "symbol": "BTCUSD",
    "name": "Bitcoin",
    "status": "active",
    "tradable": true,
    "marginable": true,
    "maintenance_margin_requirement": 30,
    "shortable": false,
    "easy_to_borrow": false,
    "fractionable": true,
    "min_order_size": "0.0001",
    "min_trade_increment": "0.0001",
    "price_increment": "1"
}
```

<---> <!-- magic separator, between columns -->

##### New Asset Object
```json
{
    "id": "276e2673-764b-4ab6-a611-caf665ca6340",
    "class": "crypto",
    "exchange": "FTXU",
    "symbol": "BTC/USD",
    "name": "BTC/USD pair",
    "status": "active",
    "tradable": true,
    "marginable": true,
    "maintenance_margin_requirement": 30,
    "shortable": false,
    "easy_to_borrow": false,
    "fractionable": true,
    "min_order_size": "0.0001",
    "min_trade_increment": "0.0001",
    "price_increment": "1"
}
```
{{< /columns >}}

#### Orders API

For Orders API, you can now submit crypto orders to a crypto pair. You can still submit order to the typical `USD` pair, and the new `BTC` and `USDT` pairs.

You can also continue submitting order with older symbology (e.g. `BTCUSD`) as we have made this backwards compatible. However, we encourage you to update API submission to use new symbology.

Below some examples of submitting a `BTC` order using the old and new symbol convention.


{{< columns >}} <!-- begin columns block -->

##### Old Order Style

```json
{
  "symbol": "BTCUSD",
  "qty": "0.0001",
  "side": "buy",
  "type": "market",
  "time_in_force": "gtc"
}
```

<---> <!-- magic separator, between columns -->


##### New Order Style

```json
{
  "symbol": "BTC/USD",
  "qty": "0.0001",
  "side": "buy",
  "type": "market",
  "time_in_force": "gtc"
}
```

{{</ columns >}} <!-- begin columns block -->


Note that the response object for orders will return the new pairs `symbol` convetion. Regardless if you submit an order using old symbology, the Order API response will return new symbology in the response payload.

```json
{
    "id": "86d8ea2f-6e28-4e0f-8177-b640e358b8ce",
    "client_order_id": "f68c083e-2e44-4880-a5d9-e5529595b1ae",
    "created_at": "2022-08-25T23:23:25.57133376Z",
    "updated_at": "2022-08-25T23:23:25.57138752Z",
    "submitted_at": "2022-08-25T23:23:25.5700714Z",
    "filled_at": null,
    "expired_at": null,
    "canceled_at": null,
    "failed_at": null,
    "replaced_at": null,
    "replaced_by": null,
    "replaces": null,
    "asset_id": "276e2673-764b-4ab6-a611-caf665ca6340",
    "symbol": "BTC/USD",
    "asset_class": "crypto",
    "notional": null,
    "qty": "0.0001",
    "filled_qty": "0",
    "filled_avg_price": null,
    "order_class": "",
    "order_type": "market",
    "type": "market",
    "side": "buy",
    "time_in_force": "gtc",
    "limit_price": null,
    "stop_price": null,
    "status": "pending_new",
    "extended_hours": false,
    "legs": null,
    "trail_percent": null,
    "trail_price": null,
    "hwm": null,
    "commission": "0",
    "subtag": null,
    "source": null
}
```

#### Positions API

Positions were not impacted by the introduction of crypto pairs. Lets say you acquired a `BTC` position by submitting an order symbol `BTCUSD` or with new pair convention `BTC/USD`, the position will still be show as `BTCUSD`.

The reasoning behind this is that the position is a sole asset quoted typically in `USD`, whereas pairs are a combination of two assets (with a base and quote currency involve).

```json
{
    "asset_id": "89691a28-7d5e-46bc-ab11-d5f3bf9ffffc",
    "symbol": "BTCUSD",
    "exchange": "FTXU",
    "asset_class": "crypto",
    "asset_marginable": true,
    "qty": "1.0002997",
    "avg_entry_price": "22577.2578201313066474",
    "side": "long",
    "market_value": "21610.4747188",
    "cost_basis": "22584.0242243",
    "unrealized_pl": "-973.5495055",
    "unrealized_plpc": "-0.043107884397878",
    "unrealized_intraday_pl": "45.0054945",
    "unrealized_intraday_plpc": "0.0020869239631145",
    "current_price": "21604",
    "lastday_price": "21559",
    "change_today": "0.0020872953290969",
    "qty_available": "1.0002997"
}
```


#### Activities API

When using the Activities API, you can expect the receive fills with the new symbol convention introduced for pairs.

{{< columns >}}

##### Old Activity

```json
{
    "id": "20220721101546378::8abc16a3-dc77-407e-9b2f-72eea5884d05",
    "account_id": "18dac886-46e1-4d5f-99e6-b2d144352626",
    "activity_type": "FILL",
    "transaction_time": "2022-07-21T14:15:46.378759Z",
    "type": "fill",
    "price": "22577.555",
    "qty": "1",
    "side": "buy",
    "symbol": "BTCUSD",
    "leaves_qty": "0",
    "order_id": "8e948ae4-fa4d-4e00-a2f7-df16e3a3bf13",
    "cum_qty": "1",
    "order_status": "filled"
}
```
<--->
##### New Activity

```json
{
    "id": "20220825192347582::0fc5288b-c661-4f26-ad18-49aef5fd5c76",
    "account_id": "18dac886-46e1-4d5f-99e6-b2d144352626",
    "activity_type": "FILL",
    "transaction_time": "2022-08-25T23:23:47.582801Z",
    "type": "fill",
    "price": "21596.575",
    "qty": "0.0001",
    "side": "buy",
    "symbol": "BTC/USD",
    "leaves_qty": "0",
    "order_id": "ecf2468e-0d12-4b81-9267-918e91d728b7",
    "cum_qty": "0.0001",
    "order_status": "filled"
}
```

{{</ columns >}}


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
