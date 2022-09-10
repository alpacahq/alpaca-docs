---
bookHidden: false
weight: 5
summary: Open brokerage accounts, enable crypto and stock trading, and manage the ongoing user experience with Alpaca Broker API
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

You can listen to events related to change of account status, usually when sending in `POST/accounts` requests.

`GET /v1/events/accounts/status`

### Request

#### Parameters

| Attribute               | Type            | Requirement                         | Notes                |
| ----------------------- | --------------- | ----------------------------------- | -------------------- |
| `id`                    | string          | {{<hint info>}}Optional {{</hint>}} |                      |
| `since`                 | string/date     | {{<hint info>}}Optional {{</hint>}} | Format: `YYYY-MM-DD` |
| `until`                 | string/date     | {{<hint info>}}Optional {{</hint>}} | Format: `YYYY-MM-DD` |
| `since_id`              | int             | {{<hint info>}}Optional {{</hint>}} |                      |
| `until_id`              | int             | {{<hint info>}}Optional {{</hint>}} |                      |


### Response

#### Sample Response

```
data: {
  "account_id":"4db36989-6565-4011-9126-39fe6b3d9bf6",
  "account_number":"",
  "at":"2021-06-14T09:59:15.232782Z",
  "crypto_status_from":"SUBMITTED",
  "crypto_status_to":"APPROVED",
  "event_id":122039,
  "kyc_results":null,
  "status_from":"SUBMITTED",
  "status_to":"APPROVED"
  }

data: {
  "account_id":"4db36989-6565-4011-9126-39fe6b3d9bf6",
  "account_number":"937975699",
  "at":"2021-06-14T09:59:15.558338Z",
  "crypto_status_from":"APPROVED",
  "crypto_status_to":"ACTIVE",
  "event_id":122040,
  "kyc_results":null,
  "status_from":"APPROVED",
  "status_to":"ACTIVE"
  }

data: {
    "account_id": "081781bb-a9a0-4bde-bd65-e14b703e092b",
    "account_number": "932473536",
    "at": "2021-06-14T10:00:00.000000Z",
    "crypto_status_from":"SUBMITTED",
    "crypto_status_to":"ACTION_REQUIRED",
    "event_id": 122041,
    "kyc_results": {
        "reject": {},
        "accept": {},
        "indeterminate": {
            "TAX_IDENTIFICATION": {}
        },
        "summary": "fail"
    },
    "status_from": "SUBMITTED",
    "status_to": "ACTION_REQUIRED"
}
```

#### Parameters

| Attribute            | Type                                       | Notes                                                                                    |
| -------------------- | ------------------------------------------ | ---------------------------------------------------------------------------------------- |
| `account_id`         | string                                     | UUID                                                                                     |
| `account_number`     | string                                     | Human readable                                                                           |
| `at`                 | string                                     | Timestamp of event                                                                       |
| `crypto_status_from` | string                                     | Account [crypto_status]({{< relref "accounts/accounts/#crypto-status" >}}) changed from  |
| `crypto_status_to`   | string                                     | Account [crypto_status]({{< relref "accounts/accounts/#crypto-status" >}}) changed to    |
| `event_id`           | int                                        | monotonically increasing 64bit integer                                                   |
| `kyc_results`        | [KYCResults]({{< relref "#kycresults" >}}) | Results of KYC if applicable. Can be nullable.                                           |
| `status_from`        | string                                     | Account [status]({{< relref "accounts/accounts/#account-status" >}}) changed from        |
| `status_to`          | string                                     | Account [status]({{< relref "accounts/accounts/#account-status" >}}) changed to          |
| `reason`             | string                                     | Optional                                                                                 |

#### KYCResults

For partners who utilize Alpaca's KYC service for opening brokerage accounts the results of the CIP check will be returned via the `kyc_results` object.
If an account's status is set to `REJECTED`, `ACTION_REQUIRED`, or `APPROVAL_PENDING` the specific KYC results that may require action from your end user will wind up in `ACCEPT`, `INDETERMINATE`, or `REJECT`.

| Attribute                | Type                                                      | Notes                                                                                                                             |
| ------------------------ | --------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `ACCEPT`                 | [ENUM.KYCResultType]({{< relref "#enumkycresulttype" >}}) | No further action required on the specific KYCResultType(s) returned in this field                                                |
| `INDETERMINATE`          | [ENUM.KYCResultType]({{< relref "#enumkycresulttype" >}}) | Must be resolved by your end user, can be appealed by uploading new documents or by updating accounts on the Account API          |
| `REJECT`                 | [ENUM.KYCResultType]({{< relref "#enumkycresulttype" >}}) | The KYCResultType(s) have been rejected due to insufficient or unsatisfactory documentation provided                              |
| `additional_information` | string                                                    | Used to display a custom message.                                                                                                 |
| `summary`                | ENUM.KYCResultSummaryType                                 | Either `pass` or `fail`. Used to indicate if KYC has completed and passed or not. This field is used for internal purposes only.  |

#### ENUM.KYCResultType

The following result codes may return for a CIP check.

| Attribute                   | Notes                                                                                                                                                             |
| --------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `IDENTITY_VERIFICATION`     | Identity needs to be verified                                                                                                                                     |
| `TAX_IDENTIFICATION`        | Tax ID number needs to be verified                                                                                                                                |
| `ADDRESS_VERIFICATION`      | Address needs to be verified                                                                                                                                      |
| `DATE_OF_BIRTH`             | Date of birth needs to be verified                                                                                                                                |
| `INVALID_IDENTITY_PASSPORT` | Identity needs to be verified via a government issued ID. This is commonly used in conjuction with `OTHER` to describe the exact document needed.                 |
| `SELFIE_VERIFICATION`       | Identity needs to be verified via a live selfie of the account owner                                                                                              |
| `PEP`                       | Further information needs to be submitted if account owner is politically exposed person                                                                          |
| `FAMILY_MEMBER_PEP`         | Further information needs to be submitted if family member is a politically exposed person                                                                        |
| `CONTROL_PERSON`            | Further information needs to be submitted if account owner is a control person                                                                                    |
| `AFFILIATED`                | Further information needs to be submitted if account owner is affiliated to finra or an exchange                                                                  |
| `VISA_TYPE_OTHER`           | Further information needs to be submitted about account owner's visa                                                                                              |
| `W8BEN_CORRECTION`          | Idenfitying information submitted by the user was incorrect so a new, corrected, W8BEN needs to be submitted                                                      |
| `COUNTRY_NOT_SUPPORTED`     | The account owner's country of tax residence is not supported by our KYC providers. In this case, we'll manully perform KYC on the user                           |
| `WATCHLIST_HIT`             | Results from the watchlist screening need further investigation before account opening. No action is needed from the user                                         |
| `OTHER`                     | A custom message will be sent to describe exactly what is needed from the account owner. The message will be displayed in the `additional_information` attribute. |
| `OTHER_PARTNER`             | A custom message will be sent to relay information relevant only to the partner. The message will be displayed in the `additional_information` attribute.         |

#### Appeal

The table below shows the documents required to appeal the various CIP rejection reasons:

| Result Code                 | Government Issued ID Card             | Tax ID Card                           | Statement (utility bill, etc.)      | Selfie                                |
| --------------------------- | ------------------------------------- | ------------------------------------- | ----------------------------------- | ------------------------------------- |
| `IDENTITY_VERIFICATION`     | {{<hint danger>}}Required {{</hint>}} | -                                     | -                                   | -                                     |
| `TAX_IDENTIFICATION`        | -                                     | {{<hint danger>}}Required {{</hint>}} | -                                   | -                                     |
| `ADDRESS_VERIFICATION`      | {{<hint danger>}}Required {{</hint>}} | -                                     | {{<hint info>}}Optional {{</hint>}} | -                                     |
| `DATE_OF_BIRTH`             | {{<hint danger>}}Required {{</hint>}} | -                                     | -                                   | -                                     |
| `SELFIE_VERIFICATION`       | -                                     | -                                     | -                                   | {{<hint danger>}}Required {{</hint>}} |


The table below shows the additional information required to appeal the various CIP rejection reasons:

| Result Code          | Additional information required                                                                                               |
| -------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| `PEP`                | Job title / occupation and address                                                                                            |
| `FAMILY_MEMBER_PEP`  | Name of politically exposed person if immediate family                                                                        |
| `CONTROL_PERSON`     | Company name, company address, and company email                                                                              |
| `AFFILIATED`         | Company / firm name, company / firm address, company / firm email                                                             |
| `VISA_TYPE_OTHER`    | Visa type and expiration date                                                                                                 |
| `W8BEN_CORRECTION`   | An updated W8BEN form with corrected information                                                                              |
| `OTHER`              | For specific cases our operational team might return with a customized message within the `additional_information` attribute. |

## **Trade Updates**

You can listen to events related to trade updates.

Most `market` trades sent during market hours are filled instantly; you can listen to `limit` order updates through this endpoint.

`GET /v1/events/trades`

### Request

#### Parameters

| Attribute  | Type        | Requirement                         | Notes                |
| ---------- | ----------- | ----------------------------------- | -------------------- |
| `id`       | string      | {{<hint info>}}Optional {{</hint>}} | description needed.  |
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
    },
    "timestamp": "2021-06-14T10:04:05.172241Z"
  }
```

#### Parameters

| Attribute      | Type             | Notes                                                                                                                                                                                     |
|----------------|------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `account_id`   | string           | The UUID of the account                                                                                                                                                                   |
| `at`           | string/timestamp | Timestamp of event                                                                                                                                                                        |
| `event`        | string           | See the [Trading Events]({{< relref "#trade-events" >}}) Enum for more details                                                                                                            |
| `event_id`     | int              | monotonically increasing 64bit integer                                                                                                                                                    |
| `execution_id` | string           | Corresponding execution of an order. If an order gets filled over two executions (a `partial_fill` for example), you will receive two events with different IDs.                          |
| `order`        | Order            | See the [Orders]({{< relref "./trading/orders.md" >}}) page for more details                                                                                                              |
| `timestamp`    | string/timestamp | Has various different meanings depending on the value of `event`, please see the [Trading Events]({{< relref "#trade-events" >}}) Enum for more details on when it means different things |

##### The following Parameters are only present when `event` is either `fill` or `partial_fill`

| Attribute      | Type   | Notes                                                                                                                         |
|----------------|--------|-------------------------------------------------------------------------------------------------------------------------------|
| `price`        | string | The average price per share at which the order was filled.                                                                    |
| `position_qty` | string | The size of your total position, after this fill event, in shares. Positive for long positions, negative for short positions. |
| `qty`          | string | The amount of shares this Trade order was for                                                                                 |


#### Trade Events

**Common events**

These are the events that are the expected results of actions you may have taken by sending API requests.

The meaning of the `timestamp` field changes for each type; the meanings have been specified here for which types the
timestamp field will be present.

- `new`: Sent when an order has been routed to exchanges for execution.
- `fill`: Sent when your order has been completely filled.
  - `timestamp`: The time at which the order was filled.
- `partial_fill`: Sent when a number of shares less than the total remaining quantity on your order has been filled.
  - `timestamp`: The time at which the shares were filled.
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

You can listen to journal status updates as they get processed by our backoffice.

`GET /v1/events/journals/status`

### Request

#### Parameters

| Attribute               | Type    | Requirement                         | Notes                |
| ----------------------- | ------  | ----------------------------------- | -------------------- |
| `id`                    | string  | {{<hint info>}}Optional {{</hint>}} |                      |
| `since`                 | string  | {{<hint info>}}Optional {{</hint>}} | Format: `YYYY-MM-DD` |
| `until`                 | string  | {{<hint info>}}Optional {{</hint>}} | Format: `YYYY-MM-DD` |
| `since_id`              | int     | {{<hint info>}}Optional {{</hint>}} |                      |
| `until_id`              | int     | {{<hint info>}}Optional {{</hint>}} |                      |


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

---

## **Transfer Events**

You can listen to transfer status updates as they get processed by our backoffice, for both end-user and firm accounts.

For more on what those transfer statuses represent please click [here]({{< relref "funding/transfers/#enumtransferstatus" >}}).

`GET /v1/events/transfers/status`

### Request

#### Parameters

| Attribute                | Type            | Requirement                         | Notes                |
| ------------------------ | --------------- | ----------------------------------- | -------------------- |
| `id`                     | string          | {{<hint info>}}Optional {{</hint>}} |                      |
| `since`                  | string/date     | {{<hint info>}}Optional {{</hint>}} | Format: `YYYY-MM-DD` |
| `until`                  | string/date     | {{<hint info>}}Optional {{</hint>}} | Format: `YYYY-MM-DD` |
| `since_id`               | int             | {{<hint info>}}Optional {{</hint>}} |                      |
| `until_id`               | int             | {{<hint info>}}Optional {{</hint>}} |                      |


### Response

#### Sample Response

```
data: {"account_id":"8e00606a-c9ac-409a-ba45-f55e8f77984a","at":"2021-06-10T19:49:12.579109Z","event_id":15960,"status_from":"","status_to":"QUEUED","transfer_id":"c4ed4206-697b-4859-ab71-b9de6649859d"}

data: {"account_id":"8e00606a-c9ac-409a-ba45-f55e8f77984a","at":"2021-06-10T19:52:24.066998Z","event_id":15961,"status_from":"QUEUED","status_to":"SENT_TO_CLEARING","transfer_id":"c4ed4206-697b-4859-ab71-b9de6649859d"}

data: {"account_id":"8e00606a-c9ac-409a-ba45-f55e8f77984a","at":"2021-06-10T20:02:24.280178Z","event_id":15962,"status_from":"SENT_TO_CLEARING","status_to":"COMPLETE","transfer_id":"c4ed4206-697b-4859-ab71-b9de6649859d"}
```

#### Parameters

| Attribute     | Type   | Notes                                                                     |
| ------------- | ------ | ------------------------------------------------------------------------- |
| `account_id`  | string | Account UUID                                                              |
| `at`          | string | Timedate of when the transfer status changed                              |
| `event_id`    | string | Monotonically increasing 64bit integer                                    |
| `status_from` | string | [Transfer status]({{< relref "funding/transfers/#enumtransferstatus" >}}) |
| `status_to`   | string | [Transfer status]({{< relref "funding/transfers/#enumtransferstatus" >}}) |
| `transfer_id` | string | Transfer UUID                                                             |

---

## **Non Trading Activities Events**

You can listen to when NTAs are pushed such as CSDs, JNLC (journals) or FEEs.

`GET /v1/events/nta`

### Request

#### Parameters

| Attribute               | Type            | Requirement                         | Notes                |
| ----------------------- | --------------- | ----------------------------------- | -------------------- |
| `id`                    | string          | {{<hint info>}}Optional {{</hint>}} |                      |
| `since`                 | string/date     | {{<hint info>}}Optional {{</hint>}} | Format: `YYYY-MM-DD` |
| `until`                 | string/date     | {{<hint info>}}Optional {{</hint>}} | Format: `YYYY-MM-DD` |
| `since_id`              | int             | {{<hint info>}}Optional {{</hint>}} |                      |
| `until_id`              | int             | {{<hint info>}}Optional {{</hint>}} |                      |
| `include_preprocessing` | boolean         | {{<hint info>}}Optional {{</hint>}} |                      |

### Response

#### Sample Response

```
data: {"account_id":"8e00606a-c9ac-409a-ba45-f55e8f77984a","at":"2021-06-11T10:46:59.265594Z","description":"","entry_type":"CSD","event_id":12437,"id":"f427a6da-248b-4dfb-ae8e-c9a844e39375","net_amount":49999,"per_share_amount":null,"price":"0","qty":0,"settle_date":"2021-06-10","status":"executed","symbol":"","system_date":"2021-06-10"}

data: {"account_id":"c96a5e16-7fca-425a-b67b-0814d064bfc0","at":"2021-06-09T10:45:43.636694Z","description":"ID: 347a459b-71f0-40bb-b451-31f32120b2cc - hi","entry_type":"JNLC","event_id":5019,"id":"d0aad3d1-710d-4461-a78f-7860a088ed4e","net_amount":200,"per_share_amount":null,"price":"0","qty":0,"settle_date":"2021-06-08","status":"correct","symbol":"","system_date":"2021-06-08"}
```

#### Parameters

Read more on what Non Trade Activities Events mean and the fields they include [here]({{< relref "accounts/account-activities/" >}}).

&nbsp;
