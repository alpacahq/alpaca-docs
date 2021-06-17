---
bookHidden: false
weight: 8
summary: Open brokerage accounts, enable commission-free trading, and manage the ongoing user experience with Alpaca Broker API
title: Journals
---

# Journals

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

| Attribute      | Type                                                      | Notes                                                                                           |
| -------------- | --------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| `id`           | string/UUID                                               | The journal ID                                                                                  |
| `to_account`   | string                                                    | The account ID that received the journal - `account_status` must equal to `ACTIVE`              |
| `from_account` | string                                                    | The account ID that initiates the journal - `account_status` must equal to `ACTIVE` or `CLOSED` |
| `entry_type`   | string                                                    | ENUM: `JNLC` or `JNLS`                                                                          |
| `symbol`       | string                                                    | In the case of `JNLS` - the symbol of the security journaled                                    |
| `qty`          | string                                                    | In the case of `JNLS` - the quantity of the securities journaled                                |
| `price`        | string                                                    | In the case of `JNLS` - the price of the security journaled                                     |
| `status`       | [ENUM.JournalStatus]({{< relref "#enumjournalstatus" >}}) | The status of the journal                                                                       |
| `settle_date`  | date                                                      | Date string in “%Y-%m-%d” format                                                                |
| `system_date`  | date                                                      | Date string in “%Y-%m-%d” format                                                                |
| `net_amount`   | string                                                    | In the case of `JNLC` - the total cash amount journaled                                         |
| `description`  | string                                                    |                                                                                                 |

### ENUM.JournalStatus

| Status             | Description                                                                                                                                                   |
| ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `QUEUED`           | Journal in queue to be processed. Journal is not processed yet.                                                                                               |
| `SENT_TO_CLEARING` | Journal sent to be processed. Journal is not processed yet.                                                                                                   |
| `PENDING`          | Journal pending to be processed.                                                                                                                              |
| `EXECUTED`         | Journal executed and balances updated for both sides of the journal transaction. This is _not_ a final status, journals can be reversed if there is an error. |
| `REJECTED`         | Journal rejected. Please try again.                                                                                                                           |
| `CANCELED`         | Journal canceled. This is a **FINAL** status.                                                                                                                 |
| `REFUSED`          | Journal refused. Please try again.                                                                                                                            |
| `DELETED`          | Journal deleted. This is a **FINAL** status.                                                                                                                  |

---

## **Creating a Journal**

`POST /v1/journals`

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

| Attribute                           | Type              | Requirement                           | Notes                                                                                                                                                                                                                                                                                                                      |
| ----------------------------------- | ----------------- | ------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `to_account`                        | string            | {{<hint danger>}}Required {{</hint>}} | The `account_id` you wish to journal to                                                                                                                                                                                                                                                                                    |
| `from_account`                      | string            | {{<hint danger>}}Required {{</hint>}} | The `account_id` you wish to journal from                                                                                                                                                                                                                                                                                  |
| `entry_type`                        | string            | {{<hint danger>}}Required {{</hint>}} | ENUM: `JNLC` or `JNLS`                                                                                                                                                                                                                                                                                                     |
| `amount`                            | string/numeric    | {{<hint danger>}}Required {{</hint>}} | Required if `entry_type` = `JNLC`                                                                                                                                                                                                                                                                                          |
| `symbol`                            | string            | {{<hint danger>}}Required {{</hint>}} | Required if `entry_type` = `JNLS`                                                                                                                                                                                                                                                                                          |
| `qty`                               | string/numeric    | {{<hint danger>}}Required {{</hint>}} | Required if `entry_type` = `JNLS`                                                                                                                                                                                                                                                                                          |
| `description`                       | string            | {{<hint info>}}Optional {{</hint>}}   | Max 1024 characters. Can include fixtures. ENUM: `pending` or `rejected`. Journal's status will become this value at the end of the current market day (will default to `executed` if no fixture is inputted). The description can contain fixtures in the following format: `/fixtures/key1=value1,key2=value2/fixtures`. |
| `transmitter_name`                  | string            | {{<hint info>}}Optional {{</hint>}}   | Max 255 characters. See more details about [Travel Rule]({{< relref "/integration/funding.md#travel-rule" >}}).                                                                                                                                                                                                            |
| `transmitter_account_number`        | string            | {{<hint info>}}Optional {{</hint>}}   | Max 255 characters. See more details about [Travel Rule]({{< relref "/integration/funding.md#travel-rule" >}}).                                                                                                                                                                                                            |
| `transmitter_address`               | string            | {{<hint info>}}Optional {{</hint>}}   | Max 255 characters. See more details about [Travel Rule]({{< relref "/integration/funding.md#travel-rule" >}}).                                                                                                                                                                                                            |
| `transmitter_financial_institution` | string            | {{<hint info>}}Optional {{</hint>}}   | Max 255 characters. See more details about [Travel Rule]({{< relref "/integration/funding.md#travel-rule" >}}).                                                                                                                                                                                                            |
| `transmitter_timestamp`             | string<timestamp> | {{<hint info>}}Optional {{</hint>}}   | See more details about [Travel Rule]({{< relref "/integration/funding.md#travel-rule" >}}).                                                                                                                                                                                                                                |

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

## **Creating a Batch Journal Transaction**

You can also create a batch journal request by using the following endpoint. This is enabled on `JNLC` for now only.

`POST /v1/journals/batch`

### Request

#### Sample Request

```json
{
  "entry_type": "JNLC",
  "from_account": "8f8c8cee-2591-4f83-be12-82c659b5e748",
  "entries": [
    {
      "to_account": "d7017fd9-60dd-425b-a09a-63ff59368b62",
      "amount": "10"
    },
    {
      "to_account": "94fa473d-9a92-40cd-908c-25da9fba1e65",
      "amount": "100"
    },
    {
      "to_account": "399f85f1-cbbd-4eaa-a934-70027fb5c1de",
      "amount": "1000"
    }
  ]
}
```

#### Attributes

| Attribute      | Type          | Requirement                           | Notes                                                           |
| -------------- | ------------- | ------------------------------------- | --------------------------------------------------------------- |
| `entry_type`   | string        | {{<hint danger>}}Required {{</hint>}} | ENUM: `JNLC` or `JNLS`                                          |
| `from_account` | string        | {{<hint danger>}}Required {{</hint>}} | The originator of funds. Most likely is your Sweep Firm Account |
| `to_account`   | string        | {{<hint danger>}}Required {{</hint>}} | The ID of the `to_account` that you want to journal into        |
| `amount`       | string/number | {{<hint danger>}}Required {{</hint>}} | Journal amount in `USD`                                         |
| `description`  | string        | {{<hint info>}}Optional {{</hint>}}   | Journal description, gets returned in the response              |

### Response

Every single request must be valid for the entire batch operation to succeed.

In the case of a successful request, the response will contain an array of journal objects with an extra attribute `error_message` in the case when a specific account fails to receive a journal.

#### Sample Response

```json
[
  {
    "error_message": "",
    "id": "0a9152c4-d232-4b00-9102-5fa19aca40cb",
    "entry_type": "JNLC",
    "from_account": "8f8c8cee-2591-4f83-be12-82c659b5e748",
    "to_account": "d7017fd9-60dd-425b-a09a-63ff59368b62",
    "symbol": "",
    "qty": null,
    "price": null,
    "status": "pending",
    "settle_date": null,
    "system_date": null,
    "net_amount": "10",
    "description": ""
  },
  {
    "error_message": "",
    "id": "84379534-bcee-4c22-abe8-a4a6286dd100",
    "entry_type": "JNLC",
    "from_account": "8f8c8cee-2591-4f83-be12-82c659b5e748",
    "to_account": "94fa473d-9a92-40cd-908c-25da9fba1e65",
    "symbol": "",
    "qty": null,
    "price": null,
    "status": "pending",
    "settle_date": null,
    "system_date": null,
    "net_amount": "100",
    "description": ""
  },
  {
    "error_message": "",
    "id": "56f106e5-25a4-4eee-96fa-25bb05dc86bc",
    "entry_type": "JNLC",
    "from_account": "8f8c8cee-2591-4f83-be12-82c659b5e748",
    "to_account": "399f85f1-cbbd-4eaa-a934-70027fb5c1de",
    "symbol": "",
    "qty": null,
    "price": null,
    "status": "pending",
    "settle_date": null,
    "system_date": null,
    "net_amount": "1000",
    "description": ""
  }
]
```

#### Attributes

| Attribute       | Type                                                      | Notes                                                            |
| --------------- | --------------------------------------------------------- | ---------------------------------------------------------------- |
| `error_message` | string                                                    | Description of why this journal transaction failed               |
| `id`            | string/UUID                                               | The journal ID                                                   |
| `to_account`    | string                                                    | The account ID that received the journal                         |
| `from_account`  | string                                                    | The account ID that initiated the journal                        |
| `entry_type`    | string                                                    | ENUM: `JNLC` or `JNLS`                                           |
| `symbol`        | string                                                    | In the case of `JNLS` - the symbol of the security journaled     |
| `qty`           | string                                                    | In the case of `JNLS` - the quantity of the securities journaled |
| `price`         | string                                                    | In the case of `JNLS` - the price of the security journaled      |
| `status`        | [ENUM.JournalStatus]({{< relref "#enumjournalstatus" >}}) | The status of the journal                                        |
| `settle_date`   | date                                                      | Date string in “%Y-%m-%d” format                                 |
| `system_date`   | date                                                      | Date string in “%Y-%m-%d” format                                 |
| `net_amount`    | string                                                    | In the case of `JNLC` - the total cash amount journaled          |
| `description`   | string                                                    | Journal description passed in the request                        |

#### Error Codes

Note that if there is an invalid `account_id` the whole batch operation will be canceled.

{{<hint warning>}}**`400`** - Invalid Request Body{{</hint>}}
{{<hint warning>}}**`404`** - Account Not Found{{</hint>}}
{{<hint warning>}}**`403`** - Insufficient Balance (JNLC) or Insufficient Assets (JNLS){{</hint>}}

---

## **Retrieving Journal Entries**

`GET/v1/journals`

### Request

#### Parameters

| Attribute      | Type   | Requirement                         | Notes                                                     |
| -------------- | ------ | ----------------------------------- | --------------------------------------------------------- |
| `after`        | string | {{<hint info>}}Optional {{</hint>}} | By journal creation date. Format: 2020-01-01              |
| `before`       | string | {{<hint info>}}Optional {{</hint>}} | By journal creation date. Format: 2020-01-01              |
| `status`       | string | {{<hint info>}}Optional {{</hint>}} | [ENUM.JournalStatus]({{< relref "#enumjournalstatus" >}}) |
| `entry_type`   | string | {{<hint info>}}Optional {{</hint>}} | ENUM: `JNLC` or `JNLS`                                    |
| `to_account`   | string | {{<hint info>}}Optional {{</hint>}} | The account that received the journal                     |
| `from_account` | string | {{<hint info>}}Optional {{</hint>}} | The account that initiated the journal                    |

### Response

An array of journal objects.

#### Error Codes

{{<hint warning>}}**`401`** - Invalid Params {{</hint>}}

---

## **Deleting a Journal**

`DELETE /v1/journals/{journal_id}`

You can only delete a journal if the journal is still in a pending state, if a journal is `executed` you will not be able to delete. The alternative is to create a mirror journal entry to reverse the flow of funds.

### Request

N/A

### Response

{{<hint good>}}**`204`** - Success (No Content){{</hint>}}

#### Error Codes

{{<hint warning>}}**`404`** - Journal Not Found{{</hint>}}
{{<hint warning>}}**`422`** - Cannot Be Deleted{{</hint>}}

&nbsp;
