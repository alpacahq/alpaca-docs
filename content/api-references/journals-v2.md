---
bookHidden: false
weight: 8
summary: Open brokerage accounts, enable commission-free trading, and manage the ongoing user experience with Alpaca Broker API
title: Journals
---

# Journals V2 (Deprecated)

Journals API allows you to move cash or securities from one account to another.

There are two types of journals:

#### JNLC

Journal cash between accounts. You can simulate instant funding in both sandbox and production by journaling funds between your pre-funded sweep accounts and a user's account.

#### JNLS

Journal securities between accounts. Reward your users upon signing up or referring others by journaling small quantities of shares into their portfolios.

For more on Journals click [here]({{< relref "../../integration/funding/#cash-pooling" >}})

---

## **The Journal Object**

### Sample JNLC Object

```json
{
  "id": "h7h5g33f-ef01-4458-9a4b-9598727a406f",
  "to_account": "3gtt65jd-6f2a-433c-8c33-17b66b8941fa",
  "entry_type": "JNLC",
  "status": "executed",
  "from_account": "8fjkjn-4483-4199-840f-6c5fe0b7ca24",
  "settle_date": "2020-12-24",
  "system_date": "2020-12-24",
  "net_amount": "115.5",
  "description": "this is a test journal"
}
```

### Sample JNLS Object

```json
{
  "id": "f45g67h8-d1fc-4136-aa4f-cf4460aecdfc",
  "to_account": "g7h7rg66-6f2a-433c-8c33-17b66b8941fa",
  "entry_type": "JNLS",
  "symbol": "AAPL",
  "qty": "0.5",
  "price": "128.23",
  "status": "executed",
  "from_account": "8k4f3d-4483-4199-840f-6c5fe0b7ca24",
  "settle_date": "2020-12-24",
  "system_date": "2020-12-24",
  "description": "this is a test journal"
}
```

### Attributes

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

---

## **Creating a Journal**

`POST /v1/journals.v2`

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

A Journal object

#### Error Codes

{{<hint warning>}}**`400`** - Invalid Request Body{{</hint>}}
{{<hint warning>}}**`404`** - Account Not Found{{</hint>}}
{{<hint warning>}}**`403`** - Insufficient Balance (JNLC) or Insufficient Assets (JNLS){{</hint>}}

---

## **Retrieving Journal Entries**

`GET/v1/journals.v2`

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

#### Error Codes

{{<hint warning>}}**`401`** - Invalid Params {{</hint>}}

---

## **Deleting a Journal**

`DELETE /v1/journals.v2/{journal_id}`

You can only delete a journal if the journal is still in a pending state, if a journal is `executed` you will not be able to delete. The alternative is to create a mirror journal entry to reverse the flow of funds.

### Request

N/A

### Response

{{<hint good>}}**`204`** - Success (No Content){{</hint>}}

#### Error Codes

{{<hint warning>}}**`404`** - Journal Not Found{{</hint>}}
{{<hint warning>}}**`422`** - Cannot Be Deleted{{</hint>}}

&nbsp;
