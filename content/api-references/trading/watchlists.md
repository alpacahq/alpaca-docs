---
bookHidden: false
weight: 4
summary: Open brokerage accounts, enable commission-free trading, and manage the ongoing user experience with Alpaca Broker API
---

# Watchlists

## **The Watchlist Object**

### Sample Watchlist

```json
{
  "account_id": "1d5493c9-ea39-4377-aa94-340734c368ae",
  "assets": [
    {
      "class": "us_equity",
      "easy_to_borrow": true,
      "exchange": "ARCA",
      "id": "b28f4066-5c6d-479b-a2af-85dc1a8f16fb",
      "marginable": true,
      "shortable": true,
      "status": "active",
      "symbol": "SPY",
      "tradable": true
    },
    {
      "class": "us_equity",
      "easy_to_borrow": false,
      "exchange": "NASDAQ",
      "id": "f801f835-bfe6-4a9d-a6b1-ccbb84bfd75f",
      "marginable": true,
      "shortable": false,
      "status": "active",
      "symbol": "AMZN",
      "tradable": true
    }
  ],
  "created_at": "2019-10-30T07:54:42.981322Z",
  "id": "fb306e55-16d3-4118-8c3d-c1615fcd4c03",
  "name": "Monday List",
  "updated_at": "2019-10-30T07:54:42.981322Z"
}
```

### Attributes

| Attribute    | Type                     | Description                                              |
| ------------ | ------------------------ | -------------------------------------------------------- |
| `id`         | string.UUID              | Watchlist ID                                             |
| `created_at` | string.Timestamp         | When watchlist was created                               |
| `updated_at` | string.Timestamp         | When watchlist was first updated                         |
| `name`       | string                   | Name of watchlist                                        |
| `account_id` | string                   | The account ID associated with watchlist                 |
| `assets`     | Array of `asset` objects | The contents of the watchlist, in the oder as registered |

---

## **Getting a List of Watchlists**

`GET /v1/trading/accounts/{account_id}/watchlists`

### Request

N/A

### Response

Returns the list of watchlists registered under the `account_id`

---

## **Creating a Watchlist**

`POST /v1/trading/accounts/{account_id}/watchlists`

### Request

#### Sample Request

```json
{
  "name": "my first watchlist",
  "symbols": ["AAPL","LMND","PLTR","AMZN","CSCO","A"]
}
```

### Response

Returns the watchlist object

#### Error Codes

{{<hint warning>}}**`404`** - Not Found

_One of the symbols is not found in the assets_
{{</hint>}}

{{<hint warning>}}**`422`** - Unprocessable

_Watchlist name is not unique, or some parameters are not valid_
{{</hint>}}

---

## **Getting a Watchlist by Watchlist ID**

`GET /v1/trading/accounts/{account_id}/watchlists/{watchlist_id}`

### Request

N/A

### Response

Returns the watchlist associated by `watchlist_id`

#### Error Codes

{{<hint warning>}}**`404`** - Not Found

_The requested watchlist is not found_
{{</hint>}}

---

## **Updating a Watchlist**

`PUT /v1/trading/accounts/{account_id}/watchlists/{watchlist_id}`

### Request

| Attribute | Type   | Description                                                   |
| --------- | ------ | ------------------------------------------------------------- |
| `name`    | string | New watchlist name                                            |
| `symbol`  | array  | The new list of symbol names to replace the watchlist content |

### Response

Watchlist object with updated content

#### Error Codes

{{<hint warning>}}**`404`** - Not Found

_The requested watchlist is not found, or one of the symbols is not found in the assets_
{{</hint>}}

{{<hint warning>}}**`422`** - Unprocessable

_Some parameters are not valid_
{{</hint>}}

---

## **Adding an Asset to a Watchlist**

`POST /v1/trading/accounts/{account_id}/watchlists/{watchlist_id}`

### Request

| Attribute | Type  | Description                             |
| --------- | ----- | --------------------------------------- |
| `symbol`  | array | The symbol name to add to the watchlist |

### Response

Watchlist object with updated content

{{<hint warning>}}**`404`** - Not Found

_The requested watchlist is not found, or one of the symbols is not found in the assets_
{{</hint>}}

{{<hint warning>}}**`422`** - Unprocessable

_Some parameters are not valid_
{{</hint>}}

---

## **Deleting a Watchlist**

`DELETE /v1/trading/accounts/{account_id}/watchlists/{watchlist_id}`

Deletes a watchlist. This is permanent.

### Request

N/A

### Response

#### Error Codes

{{<hint warning>}}**`404`** - Not Found

_The requested watchlist is not found_
{{</hint>}}

---

## **Removing a Symbol from a Watchlist**

`DELETE /v1/trading/accounts/{account_id}/watchlists/{watchlist_id}/{symbol}`

Delete one entry for an asset by symbol name

### Request

N/A

### Response

#### Error Codes

{{<hint warning>}}**`404`** - Not Found

_The requested watchlist is not found_
{{</hint>}}

&nbsp;
