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

| Attribute  | Type   | Notes    |
| ---------- | ------ | -------- |
| `since`    | string | Optional |
| `until`    | string | Optional |
| `since_id` | int    | Optional |
| `until_id` | int    | Optional |

### Response

#### Sample Response

#### Parameters

| Attribute        | Type   | Notes                                                                             |
| ---------------- | ------ | --------------------------------------------------------------------------------- |
| `event_id`       | int    | monotonically increasing 64bit integer                                            |
| `at`             | string | Timestamp of event                                                                |
| `account_id`     | string | UUID                                                                              |
| `account_number` | string | Human readable                                                                    |
| `status_from`    | string | Account [status]({{< relref "accounts/accounts/#account-status" >}}) changed from |
| `status_to`      | string | Account [status]({{< relref "accounts/accounts/#account-status" >}}) changed to   |
| `reason`         | string | Optional                                                                          |

---

## **Trade Updates**

`GET /v1/events/trades`

### Request

#### Sample Request

#### Parameters

| Attribute  | Type   | Notes    |
| ---------- | ------ | -------- |
| `since`    | string | Optional |
| `until`    | string | Optional |
| `since_id` | int    | Optional |
| `until_id` | int    | Optional |

### Response

#### Sample Response

```json
[
  {
    "account_id": "d7017fd9-60dd-425b-a09a-63ff59368b62",
    "at": "2021-04-21T13:43:12.525561Z",
    "event": "fill",
    "event_id": 2989808,
    "order": {
      "asset_class": "us_equity",
      "asset_id": "b0b6dd9d-8b9b-48a9-ba46-b9d54906e415",
      "canceled_at": null,
      "client_order_id": "d05b84fe-1ca0-445f-a3bd-84acba7fb2c2",
      "commission": "0",
      "created_at": "2021-04-21T13:43:12.464983Z",
      "expired_at": null,
      "extended_hours": false,
      "failed_at": null,
      "filled_at": "2021-04-21T13:43:12.476511Z",
      "filled_avg_price": "131.355",
      "filled_qty": "0.1",
      "hwm": null,
      "id": "a8ced16c-bd19-4abc-8442-33bb0488ff8c",
      "legs": null,
      "limit_price": null,
      "notional": null,
      "order_class": "",
      "order_type": "market",
      "qty": "0.1",
      "replaced_at": null,
      "replaced_by": null,
      "replaces": null,
      "side": "buy",
      "status": "filled",
      "stop_price": null,
      "submitted_at": "2021-04-21T13:43:12.442864Z",
      "symbol": "AAPL",
      "time_in_force": "day",
      "trail_percent": null,
      "trail_price": null,
      "type": "market",
      "updated_at": "2021-04-21T13:43:12.506039Z"
    },
    "position_qty": "6.1",
    "price": "131.355",
    "qty": "0.1",
    "timestamp": "2021-04-21T13:43:12.476511077Z"
  }
]
```

#### Parameters

| Attribute    | Type   | Notes                                    |
| ------------ | ------ | ---------------------------------------- |
| `event_id`   | int    | monotonically increasing 64bit integer   |
| `at`         | string | Timestamp of event                       |
| `event`      | string | [Events]({{< relref "#trade-events" >}}) |
| `account_id` | string | The `account_id`                         |

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
- ``: Sent when the order has been completed for the day - it is either “filled” or “done_for_day” - but remaining settlement calculations are still pending.
- `suspended`: Sent when the order has been suspended and is not eligible for trading.
- `order_replace_rejected`: Sent when the order replace has been rejected.
- `order_cancel_rejected`: Sent when the order cancel has been rejected.

---

## **Journal Status**

`GET /v1/events/journals/status`

### Request

#### Sample Request

#### Parameters

| Attribute  | Type   | Notes    |
| ---------- | ------ | -------- |
| `since`    | string | Optional |
| `until`    | string | Optional |
| `since_id` | int    | Optional |
| `until_id` | int    | Optional |

### Response

#### Sample Response

```json
{
  "event_id": 52,
  "at": "2020-11-19T15:09:39.726417Z",
  "account_number": "924535",
  "entry_type": "JNLC",
  "journal_id": "6ba62a00-cdfc-4b86-5643-6e8f7ba89dcc",
  "status_from": "pending",
  "status_to": "executed"
}
```

#### Parameters

| Attribute     | Type   | Notes                                                           |
| ------------- | ------ | --------------------------------------------------------------- |
| `event_id`    | int    | monotonically increasing 64bit integer                          |
| `at`          | string | Timestamp of event                                              |
| `entry_type`  | string | JNLC or JNLS                                                    |
| `journal_id`  | string |                                                                 |
| `status_from` | string | [Journal status]({{< relref "journals/#enumsjournalstatus" >}}) |
| `status_to`   | string | [Journal status]({{< relref "journals/#enumsjournalstatus" >}}) |

&nbsp;
