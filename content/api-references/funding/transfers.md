---
bookHidden: false
weight: 3
summary: Open brokerage accounts, enable commission-free trading, and manage the ongoing user experience with Alpaca Broker API
---

# Transfers

Transfers allow you to transfer money/balance into your end customers' account (deposits) or out (withdrawal).

---

## **The Transfer Object**

### Sample Object

```json
{
  "id": "be3c368a-4c7c-4384-808e-f02c9f5a8afe",
  "relationship_id": "0f08c6bc-8e9f-463d-a73f-fd047fdb5e94",
  "account_id": "c8f1ef5d-edc0-4f23-9ee4-378f19cb92a4",
  "type": "ach",
  "status": "COMPLETE",
  "amount": "5000",
  "direction": "INCOMING",
  "created_at": "2021-05-05T07:55:31.190788Z",
  "updated_at": "2021-05-05T08:13:33.029539Z",
  "expires_at": "2021-05-12T07:55:31.190719Z"
}
```

### Attributes

| Attribute                | Type            | Notes                                                               |
| ------------------------ | --------------- | ------------------------------------------------------------------- |
| `id`                     | string          | The transfer ID                                                     |
| `relationship_id`        | string          | The ACH relationship ID (can also be `bank_id` in the case of wire) |
| `account_id`             | string          | The account ID                                                      |
| `type`                   | ENUM            | `ach` or `wire`                                                     |
| `status`                 | ENUM            | `QUEUED`, `PENDING`, `REJECTED`, `APPROVED`                         |
| `amount`                 | decimal         | Must be > 0.00                                                      |
| `direction`              | ENUM            | `INCOMING`, `OUTGOING`                                              |
| `created_at`             | string/timedate | Timedate when transfer was created                                  |
| `updated_at`             | string/timedate | Timedate when transfer was updated                                  |
| `expires_at`             | string/timedate | Timedate when transfer was expired                                  |
| `additional_information` | string          | Additional information. Only applies to wire.                       |

---

## **Creating a Transfer Entity**

`POST /v1/accounts/{account_id}/transfers`

Create a new transfer to an account to fund it.

In the sandbox environment, you can instantly deposit to or withdraw from an account with a virtual money amount. In the production environment, this endpoint is used only for requesting an outgoing (withdrawal) wire transfer at this moment. For the wire transfer (in production), you need to create a bank resource first using the Bank API. For more on how to fund an account in sandbox please check out this tutorial [here](https://alpaca.markets/learn/fund-broker-api/).

### Request

#### Sample Request

```json
{
  "transfer_type": "ach",
  "relationship_id": "<relationship_id UUID>",
  "amount": "500",
  "direction": "INCOMING"
}
```

#### Parameters

| Parameter                | Type                   | Required                                               | Notes                                                                                                                           |
| ------------------------ | ---------------------- | ------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------- |
| `transfer_type`          | ENUM.TransferType      | {{<hint danger>}}Required {{</hint>}}                  | `ach`, `wire` - Sandbox currently only supports `ach`                                                                           |
| `relationship_id`        | string/UUID            | {{<hint danger>}}Required if `type = ach` {{</hint>}}  | The `ach_relationship` created for the `account_id` [here]({{< relref "../funding/ACH/#creating-an-ach-relationship" >}})       |
| `bank_id`                | string/UUID            | {{<hint danger>}}Required if `type = wire` {{</hint>}} | The `bank_relationship` created for the `account_id` [here]({{< relref "../funding/bank/#creating-a-new-bank-relationship" >}}) |
| `amount`                 | string/int             | {{<hint danger>}}Required {{</hint>}}                  | Must be >0                                                                                                                      |
| `direction`              | ENUM.TransferDirection | {{<hint danger>}}Required {{</hint>}}                  | `INCOMING` or `OUTGOING`                                                                                                        |
| `timing`                 | ENUM.TransferTiming    | {{<hint danger>}}Required {{</hint>}}                  | Only `immediate`                                                                                                                |
| `additional_information` | string                 | {{<hint danger>}}Required {{</hint>}}                  | Only in the case where `transfer_type = wire`                                                                                   |

### Response

If successful, will return a newly Transfer Entity.

---

## **Retrieving All Transfers by Account**

`GET /v1/accounts/{account_id}/transfers`

You can query a list of transfers for an account.

### Request

#### Parameters

| Attribute   | Type | Notes                             |
| ----------- | ---- | --------------------------------- |
| `direction` | ENUM | Optional - `INCOMING`, `OUTGOING` |
| `limit`     | int  | Optional                          |
| `offset`    | int  | Optional                          |

### Response

Returns a list of transfer entities ordered by `created_at`.

---

## **Deleting a Transfer**

`DELETE /v1/accounts/{account_id}/transfers/{transfer_id}`

### Request

N/A

### Response

{{<hint good>}}**`204`** - Success (No Content){{</hint>}}

#### Error Codes

{{<hint warning>}}**`404`** - Transfer Not Found {{</hint>}}

&nbsp;
