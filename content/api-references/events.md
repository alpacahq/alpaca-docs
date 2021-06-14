---
bookHidden: false
weight: 5
summary: Open brokerage accounts, enable commission-free trading, and manage the ongoing user experience with Alpaca Broker API
---

# Events

Events API provide event push as well as historical queries via SSE.

Some notes for Events Streaming

- If `until` is specified, `since` is required.
- If `until_id` is specified, `since_id` is required.
- Both `since` and `since_id` cannot be specified.
- If `until` or `until_id` is specified and the stream reaches to the end of queried range, the server disconnects the stream.
- Historical events are streamed immediately if queried, and updates are pushed as events occur.

---

## **Account Status**

`GET /v1/events/accounts/status`

### Request

#### Sample Request

#### Parameters

| Attribute  | Type        | Requirement                         | Notes                |
| ---------- | ----------- | ----------------------------------- | -------------------- |
| `since`    | string/date | {{<hint info>}}Optional {{</hint>}} | Format: `YYYY-MM-DD` |
| `until`    | string/date | {{<hint info>}}Optional {{</hint>}} | Format: `YYYY-MM-DD` |
| `since_id` | int         | {{<hint info>}}Optional {{</hint>}} |                      |
| `until_id` | int         | {{<hint info>}}Optional {{</hint>}} |                      |

### Response

#### Sample Response

```
data: {
  "account_id":"4db36989-6565-4011-9126-39fe6b3d9bf6",
  "account_number":"",
  "at":"2021-06-14T09:59:15.232782Z",
  "event_id":122039,
  "kyc_results":null,
  "status_from":"",
  "status_to":"APPROVED"
  }

data: {
  "account_id":"4db36989-6565-4011-9126-39fe6b3d9bf6",
  "account_number":"937975699",
  "at":"2021-06-14T09:59:15.558338Z",
  "event_id":122040,
  "kyc_results":null,
  "status_from":"APPROVED",
  "status_to":"ACTIVE"
  }
```

#### Parameters

| Attribute        | Type   | Notes                                                                             |
| ---------------- | ------ | --------------------------------------------------------------------------------- |
| `account_id`     | string | UUID                                                                              |
| `account_number` | string | Human readable                                                                    |
| `at`             | string | Timestamp of event                                                                |
| `event_id`       | int    | monotonically increasing 64bit integer                                            |
| `kyc_results`    | string | Results of KYC if applicable. Can be nullable.                                    |
| `status_from`    | string | Account [status]({{< relref "accounts/accounts/#account-status" >}}) changed from |
| `status_to`      | string | Account [status]({{< relref "accounts/accounts/#account-status" >}}) changed to   |
| `reason`         | string | Optional                                                                          |

### KYC Results

For partners who utilize Alpaca's KYC service for opening brokerage accounts and additional `kyc_results` object is represented on the account status updates.

#### Response

##### Sample Response

```
data: {
    "account_id": "081781bb-a9a0-4bde-bd65-e14b703e092b",
    "account_number": "932473536",
    "at": "2021-04-22T10:43:24.622749Z",
    "event_id": 3641,
    "kyc_results": {
        "reject": null,
        "accept": null,
        "indeterminate": {
            "TAX_IDENTIFICATION": {}
        }
    },
    "status_from": "ACTION_REQUIRED",
    "status_to": "ACTION_REQUIRED"
}
```

##### Parameters

| Attribute        | Type            | Notes                                                                             |
| ---------------- | --------------- | --------------------------------------------------------------------------------- |
| `account_id`     | string          | UUID                                                                              |
| `account_number` | string          | Human readable                                                                    |
| `at`             | string          | Timestamp of event                                                                |
| `event_id`       | int             | monotonically increasing 64bit integer                                            |
| `kyc_results`    | enum.KYCResults | `ACCEPT`, `INDETERMINATE` or `REJECT`                                             |
| `status_from`    | string          | Account [status]({{< relref "accounts/accounts/#account-status" >}}) changed from |
| `status_to`      | string          | Account [status]({{< relref "accounts/accounts/#account-status" >}}) changed to   |
| `reason`         | string          | Optional                                                                          |

If an account request's state is set to `REJECTED` or `ACTION_REQUIRED` the specific KYC results to take action on will wind up in one of three states:

- `ACCEPT` - no further action required
- `INDETERMINATE` - must be resolved by correspondent users, can be appealed by uploading new documents or by updating accounts on the Account API
- `REJECT` - check failed

#### Result Codes

The following result codes may return for a CIP check.

- `IDENTITY_VERIFICATION`: identity needs to be verified
- `TAX_IDENTIFICATION`: tax ID to be verified
- `ADDRESS_VERIFICATION`: address needs to be verified
- `DATE_OF_BIRTH`: date of birth needs to be verified
- `PEP`: further information needs to be submitted if account is politically exposed person
- `FAMILY_MEMBER_PEP`: further information needs to be submitted if family member is a politically exposed person
- `CONTROL_PERSON`
- `AFFILIATED`
- `OTHER`

#### Appeal

The table below shows the documents required to appeal the various CIP rejection reasons:

| Result Code             | Government Issued ID Card             | Tax ID Card                           | Statement (utility bill, etc.)      |
| ----------------------- | ------------------------------------- | ------------------------------------- | ----------------------------------- |
| `IDENTITY_VERIFICATION` | {{<hint danger>}}Required {{</hint>}} | -                                     | -                                   |
| `TAX_IDENTIFICATION`    | -                                     | {{<hint danger>}}Required {{</hint>}} | -                                   |
| `ADDRESS_VERIFICATION`  | {{<hint danger>}}Required {{</hint>}} | -                                     | {{<hint info>}}Optional {{</hint>}} |
| `DATE_OF_BIRTH`         | {{<hint danger>}}Required {{</hint>}} | -                                     | -                                   |

The table below shows the additional information required to appeal the various CIP rejection reasons:

| Result Code         | Additional information required                                                                               |
| ------------------- | ------------------------------------------------------------------------------------------------------------- |
| `PEP`               | Job title / occupation and address                                                                            |
| `FAMILY_MEMBER_PEP` | Name of politically exposed person if immediate family                                                        |
| `CONTROL_PERSON`    | Company name, company ticker, company address and company email                                               |
| `AFFILIATED`        | Company / firm name, company / firm address, company / firm email, company / firm registration number         |
| `OTHER`             | For specific cases our operational team might return with a customized message within the `OTHER` result code |

## **Trade Updates**

`GET /v1/events/trades`

### Request

#### Sample Request

#### Parameters

| Attribute  | Type        | Requirement                         | Notes                |
| ---------- | ----------- | ----------------------------------- | -------------------- |
| `since`    | string/date | {{<hint info>}}Optional {{</hint>}} | Format: `YYYY-MM-DD` |
| `until`    | string/date | {{<hint info>}}Optional {{</hint>}} | Format: `YYYY-MM-DD` |
| `since_id` | int         | {{<hint info>}}Optional {{</hint>}} |                      |
| `until_id` | int         | {{<hint info>}}Optional {{</hint>}} |                      |

### Response

#### Sample Response

```
data:
  {
    "account_id":"c8f1ef5d-edc0-4f23-9ee4-378f19cb92a4",
    "at":"2021-06-14T10:04:05.172241Z",
    "event":"new",
    "event_id":3014423,
    "execution_id":"a829b698-da07-479f-91e6-f204c77573fc",
    "order":{
      "asset_class":"us_equity",
      "asset_id":"b0b6dd9d-8b9b-48a9-ba46-b9d54906e415",
      "canceled_at":null,
      "client_order_id":"d6499947-dacd-4f85-a728-81734dc39c27",
      "commission":"1.1",
      "created_at":"2021-06-14T10:04:05.150255Z",
      "expired_at":null,
      "extended_hours":false,
      "failed_at":null,
      "filled_at":null,
      "filled_avg_price":null,
      "filled_qty":"0",
      "hwm":null,
      "id":"d507255a-b072-4fb7-96f3-9ad5a9c02b2a",
      "legs":null,
      "limit_price":null,
      "notional":"10",
      "order_class":"",
      "order_type":"market",
      "qty":null,
      "replaced_at":null,
      "replaced_by":null,
      "replaces":null,
      "side":"buy",
      "status":"new",
      "stop_price":null,
      "submitted_at":"2021-06-14T10:04:05.0937Z",
      "symbol":"AAPL",
      "time_in_force":"day",
      "trail_percent":null,
      "trail_price":null,
      "type":"market",
      "updated_at":"2021-06-14T10:04:05.165088Z"
      }
  }
```

#### Parameters

| Attribute      | Type            | Notes                                                                                                                                                            |
| -------------- | --------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `account_id`   | string          | The UUID of the account                                                                                                                                          |
| `at`           | string/timedate | Timestamp of event                                                                                                                                               |
| `event`        | string          | [Events]({{< relref "#trade-events" >}})                                                                                                                         |
| `event_id`     | int             | monotonically increasing 64bit integer                                                                                                                           |
| `execution_id` | string          | Corresponding execution of an order. If an order gets filled over two executions (a `partial_fill` for example), you will receive two events with different IDs. |

#### Trade Events

**Common events**

These are the events that are the expected results of actions you may have taken by sending API requests.

- `new`: Sent when an order has been routed to exchanges for execution.
- `fill`: Sent when your order has been completely filled.
  - `timestamp`: The time at which the order was filled.
  - `price`: The average price per share at which the order was filled.
  - `position_qty`: The size of your total position, after this fill event, in shares. Positive for long positions, negative for short positions.
- `partial_fill`: Sent when a number of shares less than the total remaining quantity on your order has been filled.
  - `timestamp`: The time at which the shares were filled.
  - `price`: The average price per share at which the shares were filled.
  - `position_qty`: The size of your total position, after this fill event, in shares. Positive for long positions, negative for short positions.
- `canceled`: Sent when your requested cancellation of an order is processed.
  - `timestamp`: The time at which the order was canceled.
- `expired`: Sent when an order has reached the end of its lifespan, as determined by the order’s time in force value.
- `timestamp`: The time at which the order expired.
- `done_for_day`: Sent when the order is done executing for the day, and will not receive further updates until the next trading day.
- `replaced`: Sent when your requested replacement of an order is processed.
  - `timestamp`: The time at which the order was replaced.

**Rarer events**

These are events that may rarely be sent due to unexpected circumstances on the exchanges. It is unlikely you will need to design your code around them, but you may still wish to account for the possibility that they will occur.

- `rejected`: Sent when your order has been rejected.
  - `timestamp`: The time at which the rejection occurred.
- `pending_new`: Sent when the order has been received by Alpaca and routed to the exchanges, but has not yet been accepted for execution.
- `stopped`: Sent when your order has been stopped, and a trade is guaranteed for the order, usually at a stated price or better, but has not yet occurred.
- `pending_cancel`: Sent when the order is awaiting cancellation. Most cancellations will occur without the order entering this state.
- `pending_replace`: Sent when the order is awaiting replacement.
- `calculated`: Sent when the order has been completed for the day - it is either `filled` or `done_for_day` - but remaining settlement calculations are still pending.
- `suspended`: Sent when the order has been suspended and is not eligible for trading.
- `order_replace_rejected`: Sent when the order replace has been rejected.
- `order_cancel_rejected`: Sent when the order cancel has been rejected.

---

## **Journal Status**

`GET /v1/events/journals/status`

### Request

#### Sample Request

#### Parameters

| Attribute  | Type   | Requirement                         | Notes                |
| ---------- | ------ | ----------------------------------- | -------------------- |
| `since`    | string | {{<hint info>}}Optional {{</hint>}} | Format: `YYYY-MM-DD` |
| `until`    | string | {{<hint info>}}Optional {{</hint>}} | Format: `YYYY-MM-DD` |
| `since_id` | int    | {{<hint info>}}Optional {{</hint>}} |                      |
| `until_id` | int    | {{<hint info>}}Optional {{</hint>}} |                      |

### Response

#### Sample Response

```
data: {
  "at":"2021-05-07T10:28:23.163857Z",
  "entry_type":"JNLC",
  "event_id":1406,
  "journal_id":"2f144d2a-91e6-46ff-8e37-959a701cc58d",
  "status_from":"",
  "status_to":"queued"
  }

data: {
  "at":"2021-05-07T10:28:23.468461Z",
  "entry_type":"JNLC",
  "event_id":1407,
  "journal_id":"2f144d2a-91e6-46ff-8e37-959a701cc58d",
  "status_from":"queued",
  "status_to":"pending"
  }

data: {
  "at":"2021-05-07T10:28:23.522047Z",
  "entry_type":"JNLC",
  "event_id":1408,
  "journal_id":"2f144d2a-91e6-46ff-8e37-959a701cc58d",
  "status_from":"pending",
  "status_to":"executed"
  }
```

#### Parameters

| Attribute     | Type   | Notes                                                           |
| ------------- | ------ | --------------------------------------------------------------- |
| `at`          | string | Timestamp of event                                              |
| `entry_type`  | string | JNLC or JNLS                                                    |
| `event_id`    | int    | Monotonically increasing 64bit integer                          |
| `journal_id`  | string | The UUID of the journal                                         |
| `status_from` | string | [Journal status]({{< relref "journals/#enumsjournalstatus" >}}) |
| `status_to`   | string | [Journal status]({{< relref "journals/#enumsjournalstatus" >}}) |

&nbsp;
