---
bookHidden: false
weight: 2
title: "Account Activities"
summary: Open brokerage accounts, enable commission-free trading, and manage the ongoing user experience with Alpaca Broker API
---

# Account Activities

The account activities API provides access to a historical record of transaction activities that have impacted any accounts you’ve created. Trade execution activities and non-trade activities, such as dividend payments, are both reported through this endpoint.

## **The Trade Activity Object**

### Sample Object

```json
{
  "id": "20210510100104650::88b5f678-fef5-447b-af15-f21e367e6d8c",
  "account_id": "c8f1ef5d-edc0-4f23-9ee4-378f19cb92a4",
  "activity_type": "FILL",
  "transaction_time": "2021-05-10T14:01:04.650275Z",
  "type": "fill",
  "price": "128.33",
  "qty": "0.38962051",
  "side": "buy",
  "symbol": "AAPL",
  "leaves_qty": "0",
  "order_id": "fe060a1b-5b45-4eba-ba46-c3a3345d8255",
  "cum_qty": "0.38962051",
  "order_status": "filled"
}
```

### Attributes

| Attribute          | Type              | Notes                                                                                                |
| ------------------ | ----------------- | ---------------------------------------------------------------------------------------------------- |
| `id`               | string/UUID       | The activity ID                                                                                      |
| `account_id`       | string/UUID       | The account ID attributed to this activity. Could be a user's `account_id` or your firm `account_id` |
| `activity_type`    | ENUM.ActivityType | For trade activities it is always `FILL`                                                             |
| `transaction_time` | string/timestamp  | The time and date of when this trade was processed                                                   |
| `type`             | string            | `fill` or `partial_fill`                                                                             |
| `price`            | string/number     | The per-share price that the trade was executed at.                                                  |
| `qty`              | string/number     | The number of shares involved in the trade execution.                                                |
| `side`             | string            | Can be either `buy` or `sell`                                                                        |
| `symbol`           | string            | The symbol of the asset                                                                              |
| `leaves_qty`       | string/number     | For `partially_filled` orders, the quantity of shares that are left to be filled.                    |
| `order_id`         | string/UUID       | The ID for the order filled                                                                          |
| `cum_qty`          | string/number     | The cumulative quantity of shares involved in the execution.                                         |
| `order_status`     | string            | The status of the order                                                                              |

## **The Non Trade Activity (NTA) Object**

### Sample Object

```json
{
  "id": "20210512000000000::46b11ac3-baa2-4c36-bd5d-f917ab52d3e7",
  "account_id": "62c925a3-e72e-4153-919d-6a71c407423b",
  "activity_type": "CSD",
  "date": "2021-05-12",
  "net_amount": "1234",
  "description": "",
  "status": "executed"
}
```

### Attributes

| Attribute          | Type                                                         | Notes                                                                                                                |
| ------------------ | ------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------- |
| `id`               | string/UUID                                                  | The activity ID                                                                                                      |
| `account_id`       | string/UUID                                                  | The account ID attributed to this activity. Could be a user's `account_id` or your firm `account_id`                 |
| `activity_type`    | [ENUM.ActivityType]({{< relref "#enumactivitytype" >}})      | The type of the activity                                                                                             |
| `date`             | string/date                                                  | The date on which the activity occurred or on which the transaction associated with the activity settled.            |
| `net_amount`       | string/number                                                | The net amount of money (positive or negative) associated with the activity.                                         |
| `description`      | string                                                       |                                                                                                                      |
| `status`           | [ENUM.ActivityStatus]({{< relref "#enumaccountactivity" >}}) |                                                                                                                      |
| `symbol`           | string                                                       | The symbol of the security involved with the activity. Not present for all activity types.                           |
| `qty`              | string/number                                                | For dividend activities, the number of shares that contributed to the payment. Not present for other activity types. |
| `per_share_amount` | string/number                                                | For dividend activities, the average amount paid per share. Not present for other activity types.                    |

## **ENUMS**

### ENUM.AccountActivity

| Activity Status | Description                                                                                       |
| --------------- | ------------------------------------------------------------------------------------------------- |
| `executed`      | Activity has been executed.                                                                       |
| `correct`       | Activity has been executed, but required manual input from Alpaca. This is as valid as `executed` |
| `canceled`      | Activity recorded but canceled.                                                                   |

### Enum.ActivityType

| Activity Type | Description                               |
| ------------- | ----------------------------------------- |
| `FILL`        | Order Fills (Partial/Full)                |
| `ACATC`       | ACATS IN/OUT (Cash)                       |
| `ACATS`       | ACATS IN/OUT (Securities)                 |
| `CIL`         | Cash in Lieu of Stock                     |
| `CSD`         | Cash Disbursement (+)                     |
| `CSW`         | Cash Withdrawable                         |
| `DIV`         | Dividend                                  |
| `DIVCGL`      | Dividend (Capital Gain Long Term)         |
| `DIVCGS`      | Dividend (Capital Gain Short Term)        |
| `DIVNRA`      | Dividend Adjusted (NRA Withheld)          |
| `DIVROC`      | Dividend Return of Capital                |
| `DIVTXEX`     | Dividend (Tax Exempt)                     |
| `FEE`         | REG and TAF Fees                          |
| `INT`         | Interest (Credit/Margin)                  |
| `JNLC`        | Journal Entry (Cash)                      |
| `JNLS`        | Journal Entry (Stock)                     |
| `MA`          | Merger/Acquisition                        |
| `PTC`         | Pass Thru Change                          |
| `REORG`       | Reorg CA                                  |
| `SPIN`        | Stock Spinoff                             |
| `SPLIT`       | Stock Split                               |

---

## **Retrieving Account Activities**

`GET /v1/accounts/activities`

### Request

#### Parameters

| Attribute    | Type        | Requirement                         | Notes                                                                                       |
| ------------ | ----------- | ----------------------------------- | ------------------------------------------------------------------------------------------- |
| `date`       | date        | {{<hint info>}}Optional {{</hint>}} | Both formats `YYYY-MM-DD` and `YYYY-MM-DDTHH:MM:SSZ` supported.                             |
| `until`      | date        | {{<hint info>}}Optional {{</hint>}} | Both formats `YYYY-MM-DD` and `YYYY-MM-DDTHH:MM:SSZ` supported. _Cannot be used with date._ |
| `after`      | date        | {{<hint info>}}Optional {{</hint>}} | Both formats `YYYY-MM-DD` and `YYYY-MM-DDTHH:MM:SSZ` supported. _Cannot be used with date._ |
| `direction`  | string      | {{<hint info>}}Optional {{</hint>}} | _Defaults to `desc`_                                                                        |
| `account_id` | string/UUID | {{<hint info>}}Optional {{</hint>}} |                                                                                             |
| `page_size`  | int         | {{<hint info>}}Optional {{</hint>}} | _The maximum number of entries to return in the response_                                   |
| `page_token` | string      | {{<hint info>}}Optional {{</hint>}} | _The ID of the end of your current page of results_                                         |

Notes:

- Pagination is handled using the `page_token` and `page_size` parameters.
- `page_token` represents the ID of the end of your current page of results.
- If specified with a direction of `desc`, for example, the results will end before the activity with the specified ID.
- If specified with a direction of `asc`, results will begin with the activity immediately after the one specified.
- `page_size` is the maximum number of entries to return in the response.
- If `date` is not specified, the default and maximum value is 100.
- If `date` is specified, the default behavior is to return all results, and there is no maximum page size.

### Response

Returns an array of activities.

---

## **Retrieving Account Activities by Type**

`GET /v1/accounts/activities/{activity_type}`

### Request

#### Parameters

| Attribute    | Type        | Requirement                         | Notes                                                                                       |
| ------------ | ----------- | ----------------------------------- | ------------------------------------------------------------------------------------------- |
| `date`       | date        | {{<hint info>}}Optional {{</hint>}} | Both formats `YYYY-MM-DD` and `YYYY-MM-DDTHH:MM:SSZ` supported.                             |
| `until`      | date        | {{<hint info>}}Optional {{</hint>}} | Both formats `YYYY-MM-DD` and `YYYY-MM-DDTHH:MM:SSZ` supported. _Cannot be used with date._ |
| `after`      | date        | {{<hint info>}}Optional {{</hint>}} | Both formats `YYYY-MM-DD` and `YYYY-MM-DDTHH:MM:SSZ` supported. _Cannot be used with date._ |
| `direction`  | string      | {{<hint info>}}Optional {{</hint>}} | _Defaults to `desc`_                                                                        |
| `account_id` | string/UUID | {{<hint info>}}Optional {{</hint>}} |                                                                                             |
| `page_size`  | int         | {{<hint info>}}Optional {{</hint>}} | _The maximum number of entries to return in the response_                                   |
| `page_token` | int         | {{<hint info>}}Optional {{</hint>}} | _The ID of the end of your current page of results_                                         |

### Response

Returns an array of activities.

---

&nbsp;
