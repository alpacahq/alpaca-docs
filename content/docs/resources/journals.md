---
bookHidden: false
weight: 8
---

# Journals 📰

With Alpaca’s Journal API we’ve made it easier than ever to transfer cash, or stocks from your broker firm account to other firm accounts or end customer accounts.

We have also integrated ‘simulated’ Alpaca backoffice journal updates to make your systems more robust.

Types of journals

- JNLC
- JNLS

---

## Retrieving Journal Entries

`GET/v1/journals.v3`

### Request

#### Parameters

| Attribute      | Type   | Requirement                         | Notes                                                                        |
| -------------- | ------ | ----------------------------------- | ---------------------------------------------------------------------------- |
| `after`        | string | {{<hint info>}}Optional {{</hint>}} | By journal creation date. Format: 2020-01-01                                 |
| `before`       | string | {{<hint info>}}Optional {{</hint>}} | By journal creation date. Format: 2020-01-01                                 |
| `status`       | string | {{<hint info>}}Optional {{</hint>}} | ENUM: `pending`, `canceled`, `executed`, `rejected`, `deleted` and `refused` |
| `entry_type`   | string | {{<hint info>}}Optional {{</hint>}} | ENUM: `JNLC` or `JNLS`                                                       |
| `to_account`   | string | {{<hint info>}}Optional {{</hint>}} | The account that received the journal                                        |
| `from_account` | string | {{<hint info>}}Optional {{</hint>}} | The account that initiated the journal                                       |

### Response

An array of journal objects.

#### Sample Response

```json
[
  {
    "id": "f45g67h8-d1fc-4136-aa4f-cf4460aecdfc",
    "to_account": "g7h7rg66-6f2a-433c-8c33-17b66b8941fa",
    "entry_type": "JNLS",
    "symbol": "AAPL",
    "qty": "2",
    "price": "128.23",
    "status": "executed",
    "from_account": "8k4f3d-4483-4199-840f-6c5fe0b7ca24",
    "settle_date": "2020-12-24",
    "system_date": "2020-12-24",
    "description": "this is a test journal"
  },
  {
    "id": "h7h5g33f-ef01-4458-9a4b-9598727a406f",
    "to_account": "3gtt65jd-6f2a-433c-8c33-17b66b8941fa",
    "entry_type": "JNLC",
    "status": "canceled",
    "from_account": "8fjkjn-4483-4199-840f-6c5fe0b7ca24",
    "settle_date": "2020-12-24",
    "system_date": "2020-12-24",
    "net_amount": "115.5",
    "description": "this is a test journal"
  }
]
```

#### Properties

| Attribute      | Type        | Notes                                                                |
| -------------- | ----------- | -------------------------------------------------------------------- |
| `id`           | string/UUID | The journal ID                                                       |
| `to_account`   | string      | The account ID that received the journal                             |
| `from_account` | string      | The account ID that initiated the journal                            |
| `entry_type`   | string      | ENUM: `JNLC` or `JNLS`                                               |
| `symbol`       | string      | In the case of `JNLS` - the symbol of the security journaled         |
| `qty`          | string      | In the case of `JNLS` - the quantity of the securities journaled     |
| `price`        | string      | In the case of `JNLS` - the price of the security journaled          |
| `status`       | string/ENUM | The status of the journal. ENUM: `pending`, `executed` or `rejected` |
| `settle_date`  | date        | Date string in “%Y-%m-%d” format                                     |
| `system_date`  | date        | Date string in “%Y-%m-%d” format                                     |
| `net_amount`   | string      | In the case of `JNLC` - the total cash amount journaled              |
| `description`  | string      |                                                                      |

#### Error Codes

{{<hint warning>}}**`401`** - Invalid Params {{</hint>}}

---

## Deleting a Journal

`DELETE /v1/journals.v3/{journal_id}`

### Request

N/A

### Response

**`204`** - Invalid Params

#### Error Codes

{{<hint warning>}}**`404`** - Journal Not Found{{</hint>}}
{{<hint warning>}}**`422`** - Cannot Be Deleted{{</hint>}}

---

## Creating a Journal

`POST /v1/journals.v3`

### Request

#### Sample Request

```json
{
  "from_account": "c94bu7rn-4483-4199-840f-6c5fe0b7ca24",
  "entry_type": "JNLC",
  "to_account": "fn68sbrk-6f2a-433c-8c33-17b66b8941fa",
  "amount": "51",
  "description": "test text /fixtures/status=rejected/fixtures/"
}
```

#### Parameters

| Attribute      | Type           | Requirement                           | Notes                                                                                                                                                                                                                                                                                                                      |
| -------------- | -------------- | ------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `to_account`   | string         | {{<hint danger>}}Required {{</hint>}} | The `account_id` you wish to journal to                                                                                                                                                                                                                                                                                    |
| `from_account` | string         | {{<hint danger>}}Required {{</hint>}} | The `account_id` you wish to journal from                                                                                                                                                                                                                                                                                  |
| `entry_type`   | string         | {{<hint danger>}}Required {{</hint>}} | ENUM: `JNLC` or `JNLS`                                                                                                                                                                                                                                                                                                     |
| `amount`       | string/numeric | {{<hint danger>}}Required {{</hint>}} | Required if `entry_type` = `JNLC`                                                                                                                                                                                                                                                                                          |
| `symbol`       | string         | {{<hint danger>}}Required {{</hint>}} | Required if `entry_type` = `JNLS`                                                                                                                                                                                                                                                                                          |
| `qty`          | string/numeric | {{<hint danger>}}Required {{</hint>}} | Required if `entry_type` = `JNLS`                                                                                                                                                                                                                                                                                          |
| `description`  | string         | {{<hint info>}}Optional {{</hint>}}   | Max 1024 characters. Can include fixtures. ENUM: `pending` or `rejected`. Journal's status will become this value at the end of the current market day (will default to `executed` if no fixture is inputted). The description can contain fixtures in the following format: `/fixtures/key1=value1,key2=value2/fixtures`. |

Fixture Rules

- No Fixtures
  - anything **below** limit is executed immediately
  - anything **above** limit is pending until executed at EOD,
- With Fixtures
  - any status = `rejected` will be rejected EOD
  - any status = `pending` will be pending forever

### Response

```json
{
  "id": "f45g67h8-d1fc-4136-aa4f-cf4460aecdfc",
  "to_account": "g7h7rg66-6f2a-433c-8c33-17b66b8941fa",
  "entry_type": "JNLS",
  "symbol": "AAPL",
  "qty": "2",
  "price": "128.23",
  "status": "executed",
  "from_account": "8k4f3d-4483-4199-840f-6c5fe0b7ca24",
  "settle_date": "2020-12-24",
  "description": "this is a test journal"
}
```

#### Parameters

| Attribute      | Type          | Notes                                                                |
| -------------- | ------------- | -------------------------------------------------------------------- |
| `id`           | string/UUID   | The UUID of the journal                                              |
| `to_account`   | string/UUID   | The `account_id` you journaled into                                  |
| `from_account` | string/UUID   | The `account_id` you journaled from                                  |
| `entry_type`   | string        | ENUM: `JNLC` or `JNLS`                                               |
| `symbol`       | string        | In the case of `JNLS` - the symbol of the security journaled         |
| `qty`          | string        | In the case of `JNLS` - the quantity of the securities journaled     |
| `price`        | string        | In the case of `JNLS` - the price of the security journaled          |
| `status`       | string        | The status of the journal. ENUM: `pending`, `executed` or `rejected` |
| `settle_date`  | string/date   | Date string in “%Y-%m-%d” format                                     |
| `net_amount`   | string/number | In the case of `JNLC` - the total cash amount journaled              |
| `description`  | string        |                                                                      |

#### Error Codes

{{<hint warning>}}**`400`** - Invalid Request Body{{</hint>}}
{{<hint warning>}}**`404`** - Account Not Found{{</hint>}}
{{<hint warning>}}**`403`** - Insufficient Balance (JNLC) or Insufficient Assets (JNLS){{</hint>}}
