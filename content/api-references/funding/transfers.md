---
bookHidden: false
weight: 2
summary: Open brokerage accounts, enable commission-free trading, and manage the ongoing user experience with Alpaca Broker API
---

# Transfers

Transfers allow you to transfer money/balance into your end customers' account (deposits) or out (withdrawal).

---

## **The Transfer Object**

### Sample Object

```json
{
  "id": "91223dde-52c8-4c8d-830d-06a4cf99a9b2",
  "account_id": "<account_id UUID>",
  "type": "wire",
  "status": "COMPLETE",
  "amount": "49",
  "direction": "INCOMING",
  "created_at": "2021-01-09T12:31:32.22841232Z",
  "updated_at": "2021-01-09T12:31:32.247925822Z",
  "expires_at": "2021-01-16T12:31:32.228332483Z",
  "additional_information": "my additional wire info details"
}
```

### Attributes

| Attribute    | Type            | Notes                                       |
| ------------ | --------------- | ------------------------------------------- |
| `id`         | string          | UUID                                        |
| `account_id` | string          | UUID                                        |
| `type`       | ENUM            | `ach` or `wire`                             |
| `status`     | ENUM            | `QUEUED`, `PENDING`, `REJECTED`, `APPROVED` |
| `amount`     | decimal         | Must be > 0                                 |
| `direction`  | ENUM            | `INCOMING`, `OUTGOING`                      |
| `created_at` | string/timedate | Timedate when transfer was created          |
| `updated_at` | string/timedate | Timedate when transfer was updated          |

---

## **Creating a Transfer Entity**

`POST /v1/accounts/{account_id}/transfers`

Create a new transfer to an account to fund it.

In the sandbox environment, you can instantly deposit to or withdraw from an account with a virtual money amount. In the production environment, this endpoint is used only for requesting an outgoing (withdrawal) wire transfer at this moment. For the wire transfer (in production), you need to create a bank resource first using the Bank API. For more on how to fund an account in sandbox please check out this tutorial [here](https://alpaca.markets/learn/fund-broker-api/).

### Request

#### Sample Request

```json
{
  "transfer_type": "wire",
  "bank_id": "<relationship_id UUID>",
  "amount": "500",
  "direction": "INCOMING",
  "additional_information": "my additional wire info details"
}
```

#### Parameters

| Parameter       | Type                   | Required                              | Notes                               |
| --------------- | ---------------------- | ------------------------------------- | ----------------------------------- |
| `transfer_type` | ENUM.TransferType      | {{<hint danger>}}Required {{</hint>}} | Required - `ach`, `wire`            |
| `bank_id`       | string/UUID            | {{<hint danger>}}Required {{</hint>}} | Required -                          |
| `amount`        | int                    | {{<hint danger>}}Required {{</hint>}} | Required. Must be >0                |
| `direction`     | ENUM.TransferDirection | {{<hint danger>}}Required {{</hint>}} | Required - `INCOMING` or `OUTGOING` |
| `timing`        | ENUM.TransferTiming    | {{<hint danger>}}Required {{</hint>}} | Required - `immediate`              |

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

**`204`** - Success (No Content)

#### Error Codes

{{<hint warning>}}**`404`** - Transfer Not Found {{</hint>}}

&nbsp;
