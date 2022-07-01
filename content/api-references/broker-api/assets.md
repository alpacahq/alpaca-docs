---
bookHidden: false
bookFlatSection: false
weight: 1
title: Assets
summary: Assets API serves as the master list of assets available for trade and data consumption from Alpaca.
---

# Assets

The assets API serves as the master list of assets available for trade and data consumption from Alpaca.

Assets are sorted by asset class, exchange and symbol. Some assets are not tradable with Alpaca. These assets will be marked with the flag `tradable=false`.

---

## **The Asset Object**

Currently, two classes of assets exist: `us_equity` and `crypto`.

### Sample Equity Asset Object

```json
{
  "id": "904837e3-3b76-47ec-b432-046db621571b",
  "class": "us_equity",
  "exchange": "NASDAQ",
  "symbol": "AAPL",
  "name": "Apple Inc. Common Stock",
  "status": "active",
  "tradable": true,
  "marginable": true,
  "shortable": true,
  "easy_to_borrow": true,
  "fractionable": true
}
```

### Sample Crypto Asset Object

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
        "fractionable": true,
        "min_order_size": "0.0001",
        "min_trade_increment": "0.0001",
        "price_increment": "1"
}
```

### Attributes

| Attribute        | Type        | Description                                                                                                                                                 |
| ---------------- | ----------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `id`             | string.UUID | Asset ID                                                                                                                                                    |
| `class`          | string      | ENUM: `us_equity` or `crypto`                                                                                                                               |
| `exchange`       | string      | `AMEX`, `ARCA`, `BATS`, `NYSE`, `NASDAQ`, `NYSEARCA`, `OTC`                                                                                                 |
| `symbol`         | string      | The symbol of the asset                                                                                                                                     |
| `name`           | string      | The official name of the asset                                                                                                                              |
| `status`         | string      | ENUM: `active` or `inactive`                                                                                                                                |
| `tradable`       | boolean     | Asset is tradable on Alpaca or not                                                                                                                          |
| `marginable`     | boolean     | Asset is marginable or not                                                                                                                                  |
| `shortable`      | boolean     | Asset is shortable or not                                                                                                                                   |
| `easy_to_borrow` | boolean     | Asset is easy-to-borrow or not (filtering for `easy_to_borrow = True` is the best way to check whether the name is currently available to short at Alpaca). |
| `fractionable`   | boolean     | Asset is fractionable or not                                                                                                                                |
| `min_order_size`   | string     | Minimum order size.  Field available for crypto only.                                                                                                                                |
| `min_trade_increment`   | string     | Amount a trade quantity can be incremented by.  Field available for crypto only.                                                                                                                             |
| `price_increment`   | string     | Amount the price can be incremented by. Field available for crypto only.                                                                                                                           |
---

## **Retrieving All Assets**

`GET /v1/assets`

### Request

#### Parameters

| Attribute     | Type   | Required                            | Notes                                 |
| ------------- | ------ | ----------------------------------- | ------------------------------------- |
| `status`      | string | {{<hint info>}}Optional {{</hint>}} | eg: `ACTIVE`. Will default to **all** |
| `asset_class` | string | {{<hint info>}}Optional {{</hint>}} |                                       |

### Response

An array of asset objects.

---

## **Retrieving an Asset by ID**

`GET /v1/assets/:id`

### Request

N/A

### Response

The requested asset object

#### Error Codes

{{<hint warning>}}**`404`** - Asset Not Found {{</hint>}}

---

## **Retrieving an Asset by Symbol**

`GET /v1/assets/:symbol`

### Request

N/A

### Response

The requested asset object

#### Error Codes

{{<hint warning>}}**`404`** - Asset Not Found {{</hint>}}

&nbsp;
