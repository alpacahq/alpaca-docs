---
weight: 40
title: Local Currency Trading
summary: Build stock brokerage in over 15+ local currencies
---

# Local Currency Trading

Local Currency Trading allows customers to trade US equities in over 15+ local currencies, with FX conversion done on-the-fly. Customers can place, monitor and sell their positions in their local currency.

API responses are all in your local currency, with all calculations handled by Alpaca.

Further below, we will examine the some common scenarios with LCT. The recurring theme you will notice is that many of Alpaca’s API commands are almost the same, it is just the response that have changed. In some cases, barring the introduction of a currency specification or a swap rate, the only indication of the trade being in Local Currency is the inclusion of a USD second order JSON.

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
| Omnibus in Sub Ledgie | Yes | Yes |
| Fully Disclosed Account Type | Yes | Yes |
| SSE Events | Yes | Yes |
| Rebalancing | No | Yes |
| Margin | No | Yes |

{{<hint info>}}
***Note**: Customer could have JIT or JIT Cash but not both. JIT controls buying power at the correspondent level, while JIT Cash controls buying power at Customer level.
{{</hint>}}

## Create LCT Account

For LCT, you can leverage the traditional Account API to create any of the following account types: 

- Fully Disclosed
- Omnibus
- Omnibus via the Alpaca Sub Ledger Solution

Below we go over some examples of creating accounts in Euro as the local currency.

### Fully Disclosed Account

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

### Omni Non-Disclosed Account

For customers who opt to use Alpaca’s Sub Ledger Functionality and are constrained by Data Sharing requirements, the Omni ND account is the ideal way of controlling both customer’s accounts and avoiding the costly construction of a Ledger software solution.

```json
{
  "account_type": "omnibus_non_disclosed",
  "contact": {
    "email_address": "happy@alpca.com"
  },
  "currency": "EUR",
  "entity_id": "9d784a7e-1695-3d84-9a6d-38e1951cda2a",
  "enabled_assets": [
      "us_equity",
      "crypto"
  ],
  "identity": {
    "authorized_person_id": "123123143132123123",
    "country_of_tax_residence": "ESP"
  }
}
```


## Fund LCT Account




## Estimate Stock Trade

Customers using LCT for the first time may not be sure how much their local currency can buy of a US stock. To address this pain point we created the [Order Estimation Endpoint]({{ }}). The customer can enter:

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
  "notional": "4000",
  "swap_fee_bps": 45
}
```

## Submit Stock Trade

We note here a few key LCT specific order attributes:

- Order `type` - must always be market
- `swap_fee` - this is the correspondent spread. You as the correspondent can increase or decrease this as you require. **Note**: Alpaca will have an separate spread
- Quantity-based orders will also be accepted

```json
```


## Get Account Position

```json
```

## Journaling Local Currency

#TODO: Change to EUR

```json
{
  "to_account": "44394ea3-d5bf-4dc7-a39a-155aedcb1fd8",
  "from_account": "ece23fa8-0319-4ee5-9d54-f0d55841084c",
  "entry_type": "JNLC",
  "amount": "15",
  "currency": "EUR",
  "description": "journaling 10"
}
```

```json
{
    "id": "3b1c71da-f9b4-4b4d-b8ee-96adfc8acb47",
    "entry_type": "JNLC",
    "from_account": "ece23fa8-0319-4ee5-9d54-f0d55841084c",
    "to_account": "44394ea3-d5bf-4dc7-a39a-155aedcb1fd8",
    "symbol": "",
    "qty": null,
    "price": "0",
    "status": "queued",
    "settle_date": null,
    "system_date": null,
    "net_amount": "15",
    "description": "journaling 10",
    "currency": "EUR"
}
```