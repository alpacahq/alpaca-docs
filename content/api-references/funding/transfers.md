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
  "reason": null,
  "amount": "5000",
  "direction": "INCOMING",
  "created_at": "2021-05-05T07:55:31.190788Z",
  "updated_at": "2021-05-05T08:13:33.029539Z",
  "expires_at": "2021-05-12T07:55:31.190719Z"
}
```

### Attributes

| Attribute                | Type                                                               | Notes                                                               |
| ------------------------ | ------------------------------------------------------------------ | ------------------------------------------------------------------- |
| `id`                     | string/UUID                                                        | The transfer ID                                                     |
| `relationship_id`        | string/UUID                                                        | The ACH relationship ID (can also be `bank_id` in the case of wire) |
| `account_id`             | string/UUID                                                        | The account ID                                                      |
| `type`                   | [ENUM.TransferType]({{< relref "#enumtransfertype" >}})            |                                                                     |
| `status`                 | [ENUM.TransferStatus]({{< relref "#enumtransferstatus" >}})        |                                                                     |
| `reason`                 | string (nullable)                                                  | Cause of the status                                                 |
| `amount`                 | string/decimal                                                     | Must be > 0.00                                                      |
| `direction`              | [ENUM.TransferDirection]({{< relref "##enumtransferdirection" >}}) |                                                                     |
| `created_at`             | string/timedate                                                    | Timedate when transfer was created                                  |
| `updated_at`             | string/timedate                                                    | Timedate when transfer was updated                                  |
| `expires_at`             | string/timedate                                                    | Timedate when transfer was expired                                  |
| `additional_information` | string                                                             | Additional information. Only applies to wire.                       |

### ENUM.TransferType

| Attribute | Description                       |
| --------- | --------------------------------- |
| `ach`     | Transfer via ACH (US Only)        |
| `wire`    | Transfer via wire (international) |

### ENUM.TransferStatus

| Attribute  | Description                                   |
| ---------- | --------------------------------------------- |
| `QUEUED`   | Transfer is in queue to be processed          |
| `PENDING`  | Transfer is pending processing                |
| `REJECTED` | Transfer is rejected                          |
| `APPROVED` | Transfer is approved                          |
| `COMPLETE` | Transfer is completed. This is a final state. |

### ENUM.TransferDirection

| Attribute  | Description                                     |
| ---------- | ----------------------------------------------- |
| `INCOMING` | Funds incoming to user's account (deposit)      |
| `OUTGOING` | Funds outgoing from user's account (withdrawal) |

### Fixtures

Transfer API supports fixtures in Sandbox Environment. You can pass the desired transfer status in the optional `additional_information` field when creating a transfer.

| Attribute  | Description                           |
| ---------- | ------------------------------------- |
| `QUEUED`   | `/fixtures/status=QUEUED/fixtures/`   |
| `PENDING`  | `/fixtures/status=PENDING/fixtures/`  |
| `REJECTED` | `/fixtures/status=REJECTED/fixtures/` |
| `APPROVED` | `/fixtures/status=APPROVED/fixtures/` |

#### Sample Fixture

Simulating a rejected account.

```json
{
  "additional_information": "/fixtures/status=REJECTED/fixtures/"
}
```

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

| Parameter                | Type                                                               | Required                                                   | Notes                                                                                                                           |
| ------------------------ | ------------------------------------------------------------------ | ---------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| `transfer_type`          | [ENUM.TransferType]({{< relref "#enumtransfertype" >}})            | {{<hint danger>}}Required {{</hint>}}                      | Sandbox currently only supports `ach`                                                                                           |
| `relationship_id`        | string/UUID                                                        | {{<hint danger>}}Required if `type = ach` {{</hint>}}      | The `ach_relationship` created for the `account_id` [here]({{< relref "../funding/ACH/#creating-an-ach-relationship" >}})       |
| `bank_id`                | string/UUID                                                        | {{<hint danger>}}Required if `type = wire` {{</hint>}}     | The `bank_relationship` created for the `account_id` [here]({{< relref "../funding/bank/#creating-a-new-bank-relationship" >}}) |
| `amount`                 | string/decimal                                                     | {{<hint danger>}}Required {{</hint>}}                      | Must be > 0.00                                                                                                                  |
| `direction`              | [ENUM.TransferDirection]({{< relref "##enumtransferdirection" >}}) | {{<hint danger>}}Required {{</hint>}}                      |                                                                                                                                 |
| `timing`                 | ENUM.TransferTiming                                                | {{<hint danger>}}Required {{</hint>}}                      | Only `immediate`                                                                                                                |
| `additional_information` | string                                                             | {{<hint info>}}Optional - Applies only to wires{{</hint>}} | Additional wire details                                                                                                         |

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
