---
weight: 40
title: Local Currency Trading
summary: Build stock brokerage in over 15+ local currencies
---

# Local Currency Trading

Local Currency Trading allows customers to trade US equities in over 15+ local currencies, with FX conversion done on-the-fly. Customers can place, monitor and sell their positions in their local currency.

API responses are all in your local currency, with all calculations handled by Alpaca.

Further below, we will examine the some common scenarios with LCT. The recurring theme you will notice is that many of Alpaca’s API commands are almost the same, it is just the response that have changed. In some cases, barring the introduction of a currency specification or a swap rate, the only indication of the trade being in Local Currency is the inclusion of a USD second order JSON.

For further questions about LCT, such as supported currencies or any other relevant details, [see LCT FAQs](https://alpaca.markets/support/local-currency-trading-faq).

## Supported Features

| Feature          | LCT          | Broker API (USD) |
| ---------------- | ------------ | ---------------- |
| Allows Trading in Local Currency of US equities | Yes | No |
| Supports JIT*  | Yes | Yes |
| Supports JIT Cash* | Yes | Yes |
| Stop and Limit Orders | No | Yes |
| Swap Rate on the Orders Endpoint | Yes | No |
| Supports Crypto | No | Yes |
| Market Data  | Yes, in local currency | No |
| Omnibus | No | Yes |
| Omnibus in Sub Ledger | Yes | Yes |
| Fully Disclosed Account Type | Yes | Yes |
| SSE Events | Yes | Yes |
| Rebalancing | No | Yes |
| Margin | No | Yes |

{{<hint info>}}
***Note**: Customer could have JIT or JIT Cash but not both. JIT controls buying power at the correspondent level, while JIT Cash controls buying power at Customer level.
{{</hint>}}

## Get Market Data

With LCT, we have introduced a `currency` parameter for stock market data. You can request
pricing data for any equity and we will handle the necessary convertions to quote the asset in the requested local currency. 

The example below shows how to get pricing data for `AAPL` in Euro. The pricing information is converted from USD to the relevant local currency on the fly with the latest FX rate at the point in time of query.


```bash
curl --request GET 'https://data.alpaca.markets/v2/stocks/AAPL/bars?start=2021-05-01T0:00:00Z&end=2021-05-31T11:00:00Z&timeframe=1Min&currency=EUR'
```

```json
{
    "bars": [
        {
            "t": "2021-05-03T08:00:00Z",
            "o": 109.58,
            "h": 109.87,
            "l": 109.58,
            "c": 109.69,
            "v": 4106,
            "n": 75,
            "vw": 109.72
        },
        ...
    ],
    "currency": "EUR",
    "symbol": "AAPL",
    "next_page_token": "QUFQTHxNfDIwMjEtMDUtMDRUMTI6NTA6MDAuMDAwMDAwMDAwWg=="
}
```

Note currency key value is `EUR`. Request the same endpoint without the `currency` parameter to compare the pricing data agaisnt its USD equivalent.

## Create LCT Account

For LCT, you can leverage the traditional [Account API]({{<relref "../../api-references/broker-api/accounts/accounts">}}) to create any of the following account types: 

- Fully Disclosed
- Omnibus
- Omnibus via the Alpaca Sub Ledger Solution

Below we provide an example of creating a account for a fully-disclosed setup with Euro as the local currency. 

```json
{
  "contact": {
    "email_address": "cool_alpaca_test@example.com",
    "phone_number": "555-666-7788",
    "street_address": ["20 N San Mateo Dr"],
    "city": "San Mateo",
    "state": "CA",
    "postal_code": "94401",
    "country": "USA"
  },
  "identity": {
    "given_name": "John",
    "family_name": "Doe",
    "date_of_birth": "1990-01-01",
    "tax_id": "666-55-4321",
    "tax_id_type": "USA_SSN",
    "country_of_citizenship": "USA",
    "country_of_birth": "USA",
    "country_of_tax_residence": "USA",
    "funding_source": ["employment_income"],
    "annual_income_min": "30000",
    "annual_income_max": "50000",
    "liquid_net_worth_min": "100000",
    "liquid_net_worth_max": "150000"
  },
  "disclosures": {
    "is_control_person": false,
    "is_affiliated_exchange_or_finra": false,
    "is_politically_exposed": false,
    "immediate_family_exposed": false
  },
  "agreements": [
   {
      "agreement": "customer_agreement",
      "signed_at": "2020-09-11T18:13:44Z",
      "ip_address": "185.13.21.99",
      "revision": "19.2022.02"
   },
   {
      "agreement": "crypto_agreement",
      "signed_at": "2020-09-11T18:13:44Z",
      "ip_address": "185.13.21.99",
      "revision": "04.2021.10"
    }
  ],
  "documents": [
    {
      "document_type": "identity_verification",
      "document_sub_type": "passport",
      "content": "/9j/Cg==",
      "mime_type": "image/jpeg"
    }
  ],
  "trusted_contact": {
    "given_name": "Jane",
    "family_name": "Doe",
    "email_address": "jane.doe@example.com"
  },
  "currency": "EUR"
}
```

Note the newly introduced `currency` parameter as part of the payload to create a new code.

## Fund LCT Account

Accounts can be funded for LCT by either:

- Bank Wire
- Just in Time Cash
- Just In Time

The below example funds one of our Euro accounts created above, with JIT Cash API `POST /v1/transfers/jit/transactions` with the following body:

```json
{
  "account_id": "27529bc0-3ab5-34f5-ac29-54a98162472d",
  "entry_type": "JTD",
  "currency": "EUR",
  "amount": "500000",
  "description": "Test JIT EUR"
}
```

Calling the above mentioned API yields the following response,

```json
{
    "id": "9a0ab8c2-4575-46b6-a6cc-f280c899b756",
    "account_id": "27529bc0-3ab5-34f5-ac29-54a98162472d",
    "created_at": "2022-08-31T16:29:44-04:00",
    "system_date": "2022-08-31",
    "entry_type": "JTD",
    "amount": "500000",
    "currency": "EUR",
    "description": "Test JIT EUR"
}
```


## Estimate Stock Trade

Customers using LCT for the first time may not be sure how much their local currency can buy of a US stock. To address this pain point we created the [Order Estimation Endpoint]({{<relref "../../api-references/broker-api/trading/orders/#estimating-an-order">}}). The customer can enter:

- the security 
- the notional value
- on the developer side you can input your swap rate to return the realistic value that your customer will receive.

We get in return indicative quantity, average price and USD value.

```json
{
  "symbol": "AAPL",
  "side": "buy",
  "type": "market",
  "time_in_force": "day",
  "notional": "400",
  "swap_fee_bps": 45
}
```

The above payload will get an [estimation]({{<relref "../../api-references/broker-api/trading/orders/#estimating-an-order">}}) for a market order to purchase AAPL stock with a notional amount of 400 EUR.

```json
{
    "id": "b2f5f3f9-f6b9-4051-9e92-5872248f4830",
    "client_order_id": "b67e1ff9-794a-45b1-bd22-8d40f66c9f6a",
    "created_at": "2022-08-31T20:49:31.203137997Z",
    "updated_at": "2022-08-31T20:49:31.203137997Z",
    "submitted_at": "2022-08-31T20:49:31.200932908Z",
    "filled_at": "2022-08-31T20:49:31.200932908Z",
    "expired_at": null,
    "canceled_at": null,
    "failed_at": null,
    "replaced_at": null,
    "replaced_by": null,
    "replaces": null,
    "asset_id": "93f58d0b-6c53-432d-b8ce-2bad264dbd94",
    "symbol": "AAPL",
    "asset_class": "us_equity",
    "notional": "400",
    "qty": null,
    "filled_qty": "2.527276938",
    "filled_avg_price": "156.769502669363693758",
    "order_class": "",
    "order_type": "market",
    "type": "market",
    "side": "buy",
    "time_in_force": "day",
    "limit_price": null,
    "stop_price": null,
    "status": "filled",
    "extended_hours": false,
    "legs": null,
    "trail_percent": null,
    "trail_price": null,
    "hwm": null,
    "commission": "0",
    "swap_rate": "0.9948565977241001",
    "swap_fee_bps": "95",
    "subtag": null,
    "source": null,
    "usd": {
        "notional": "398.2483",
        "filled_avg_price": "157.58"
    }
}
```

Note the `usd` object at the bottom.

## Submit Stock Trade

Once having estimated a given order, we can actually commit to and execute the order using the usual [Order API]({{<relref "../../api-references/broker-api/trading/orders#creating-an-order">}}).

We note here a few key LCT specific order attributes:

- Order `type` - must always be market
- `swap_fee_bps` - this is the correspondent spread. You as the correspondent can increase or decrease this as you require. **Note**: Alpaca will have an separate spread
- Quantity-based orders will also be accepted

```json
{
  "symbol": "AAPL",
  "notional": "400",
  "side": "buy",
  "type": "market",
  "time_in_force": "day",
  "swap_fee_bps": 100
}
```

The response for the purchase of `AAPL` worth 400 EUR can be seen below,

```json
{
    "id": "5e9ead9b-c73d-47d3-abcf-14301b4bc44c",
    "client_order_id": "6125fce1-ecf3-4ea9-a020-2f97f237fbca",
    "created_at": "2022-08-31T20:51:30.710557089Z",
    "updated_at": "2022-08-31T20:51:30.710618479Z",
    "submitted_at": "2022-08-31T20:51:30.70808831Z",
    "filled_at": null,
    "expired_at": null,
    "canceled_at": null,
    "failed_at": null,
    "replaced_at": null,
    "replaced_by": null,
    "replaces": null,
    "asset_id": "93f58d0b-6c53-432d-b8ce-2bad264dbd94",
    "symbol": "AAPL",
    "asset_class": "us_equity",
    "notional": "400",
    "qty": null,
    "filled_qty": "0",
    "filled_avg_price": null,
    "order_class": "",
    "order_type": "market",
    "type": "market",
    "side": "buy",
    "time_in_force": "day",
    "limit_price": null,
    "stop_price": null,
    "status": "pending_new",
    "extended_hours": false,
    "legs": null,
    "trail_percent": null,
    "trail_price": null,
    "hwm": null,
    "commission": "0",
    "swap_rate": "0.9947972168892468",
    "swap_fee_bps": "150",
    "subtag": null,
    "source": null,
    "usd": {
        "notional": "396.0606",
        "filled_avg_price": null
    }
}
```


## Get Account Position

The below position is the `AAPL` stock purchased previosly with 400 EUR.

```json
[
    {
        "asset_id": "93f58d0b-6c53-432d-b8ce-2bad264dbd94",
        "symbol": "AAPL",
        "exchange": "NASDAQ",
        "asset_class": "us_equity",
        "asset_marginable": false,
        "qty": "2.5132",
        "avg_entry_price": "156.7700934095764032",
        "side": "long",
        "market_value": "393.969232",
        "cost_basis": "393.9945987569474165523984",
        "unrealized_pl": "-0.0253667569474165523984",
        "unrealized_plpc": "-0.000064383514463",
        "unrealized_intraday_pl": "-0.02536675694741652224",
        "unrealized_intraday_plpc": "-0.000064383514463",
        "current_price": "156.76",
        "lastday_price": "158.087157481573854921",
        "change_today": "-0.008395099910178",
        "swap_rate": "1.0048551416746259",
        "avg_entry_swap_rate": "0.9947972168892468",
        "usd": {
            "avg_entry_price": "157.59",
            "market_value": "392.0656974929108971",
            "cost_basis": "396.055188",
            "unrealized_pl": "-0.0252441928148389",
            "unrealized_plpc": "-0.000064383514463",
            "unrealized_intraday_pl": "-0.0252441928148389",
            "unrealized_intraday_plpc": "-0.000064383514463",
            "current_price": "156.0025853465346558",
            "lastday_price": "157.3233304236430846",
            "change_today": "-0.0083545374472457"
        },
        "qty_available": "2.5132"
    }
]
```

## Journaling Local Currency

Journalling in LCT is almost exactly the same as our regular Journals API.

In this example we will journal some Euro between two accounts.

```json
{
  "from_account": "51461a2a-8f98-3aa5-ae51-fad8d03037b3",
  "entry_type": "JNLC",
  "to_account": "27529bc0-3ab5-34f5-ac29-54a98162472d",
  "amount": "5000",
  "currency": "EUR",
  "description": "Test Euro Journal"
}
```

```json
{
    "id": "1717b9c7-f516-4e85-a21b-bbeb7ef7a87a",
    "entry_type": "JNLC",
    "from_account": "51461a2a-8f98-3aa5-ae51-fad8d03037b3",
    "to_account": "27529bc0-3ab5-34f5-ac29-54a98162472d",
    "symbol": "",
    "qty": null,
    "price": "0",
    "status": "queued",
    "settle_date": null,
    "system_date": null,
    "net_amount": "5000",
    "description": "Test Euro Journal",
    "currency": "EUR"
}
```