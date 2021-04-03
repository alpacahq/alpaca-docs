---
bookHidden: false
weight: 5
---

# Events 🚨

Events API provide event push as well as historical queries via SSE.

---

## **Account Status**

`GET /v1/events/accounts/status`

### Request

##### Parameters

| Attribute  | Type   | Notes    |
| ---------- | ------ | -------- |
| `since`    | string | Optional |
| `until`    | string | Optional |
| `since_id` | int    | Optional |
| `until_id` | int    | Optional |

Notes

- If `until` is specified, `since` is required.
- If `until_id` is specified, `since_id` is required.
- Both `since` and `since_id` cannot be specified.
- If `until` or `until_id` is specified and the stream reaches to the end of queried range, the server disconnects the stream.
- Historical events are streamed immediately if queried, and updates are pushed as events occur.

### Response

##### Parameters

| Attribute        | Type   | Notes                                  |
| ---------------- | ------ | -------------------------------------- |
| `event_id`       | int    | monotonically increasing 64bit integer |
| `at`             | string | Timestamp of event                     |
| `account_id`     | string | UUID                                   |
| `account_number` | string | Human readable                         |
| `status_from`    | string | Status changed from                    |
| `status_to`      | string | Status changed to                      |
| `reason`         | string | Optional                               |

## **Trade Updates**

`GET /v1/events/trades`

### Request

##### Parameters

| Attribute  | Type   | Notes    |
| ---------- | ------ | -------- |
| `since`    | string | Optional |
| `until`    | string | Optional |
| `since_id` | int    | Optional |
| `until_id` | int    | Optional |

Notes

- If `until` is specified, `since` is required.
- If `until_id` is specified, `since_id` is required.
- Both `since` and `since_id` cannot be specified.
- If `until` or `until_id` is specified and the stream reaches to the end of queried range, the server disconnects the stream.
- Historical events are streamed immediately if queried, and updates are pushed as events occur.

### Response

## **Journal Status**

`GET /v1/events/journal/status`

### Request

##### Parameters

| Attribute  | Type   | Notes    |
| ---------- | ------ | -------- |
| `since`    | string | Optional |
| `until`    | string | Optional |
| `since_id` | int    | Optional |
| `until_id` | int    | Optional |

Notes

- If `until` is specified, `since` is required.
- If `until_id` is specified, `since_id` is required.
- Both `since` and `since_id` cannot be specified.
- If `until` or `until_id` is specified and the stream reaches to the end of queried range, the server disconnects the stream.
- Historical events are streamed immediately if queried, and updates are pushed as events occur.

### Response

##### Parameters

| Attribute     | Type   | Notes                                  |
| ------------- | ------ | -------------------------------------- |
| `event_id`    | int    | monotonically increasing 64bit integer |
| `at`          | string | Timestamp of event                     |
| `entry_type`  | string | JNLC or JNLS                           |
| `journal_id`  | string |                                        |
| `status_from` | string |                                        |
| `status_to`   | string |                                        |

##### Sample Reponse

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
