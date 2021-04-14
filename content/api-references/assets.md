---
bookHidden: false
weight: 2
summary: Open brokerage accounts, enable commission-free trading, and manage the ongoing user experience with Alpaca Broker API
---

# Assets

The assets API serves as the master list of assets available for trade and data consumption from Alpaca.

Assets are sorted by asset class, exchange and symbol. Some assets are not tradable with Alpaca. These assets will be marked with the flag `tradable=false`.

---

## **The Asset Object**

### Sample Object

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

### Attributes

| Attribute        | Type        | Description                                                                                                                                                 |
| ---------------- | ----------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `id`             | string.UUID | Asset ID                                                                                                                                                    |
| `class`          | string      | Always `us_equity`                                                                                                                                          |
| `exchange`       | string      | `AMEX`, `ARCA`, `BATS`, `NYSE`, `NASDAQ`, `NYSEARCA`                                                                                                        |
| `symbol`         | string      | The symbol of the asset                                                                                                                                     |
| `name`           | string      | The official name of the asset                                                                                                                              |
| `status`         | string      | `ACTIVE` or `INACTIVE`                                                                                                                                      |
| `tradable`       | boolean     | Asset is tradable on Alpaca or not                                                                                                                          |
| `marginable`     | boolean     | Asset is marginable or not                                                                                                                                  |
| `shortable`      | boolean     | Asset is shortable or not                                                                                                                                   |
| `easy_to_borrow` | boolean     | Asset is easy-to-borrow or not (filtering for `easy_to_borrow = True` is the best way to check whether the name is currently available to short at Alpaca). |
| `fractionable`   | boolean     | Asset is fractionable or not                                                                                                                                |

---

## **Retrieving All Assets**

`GET /v1/assets`

### Request

#### Parameters

| Attribute     | Type   | Required                            | Notes                                 |
| ------------- | ------ | ----------------------------------- | ------------------------------------- |
| `status`      | string | {{<hint info>}}Optional {{</hint>}} | eg: `ACTIVE`. Will default to **all** |
| `asset_class` | string | {{<hint info>}}Optional {{</hint>}} |

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

`GET /v1/assets/symbol`

### Request

N/A

### Response

The requested asset object

#### Error Codes

{{<hint warning>}}**`404`** - Asset Not Found {{</hint>}}

&nbsp;
