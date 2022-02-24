---
bookHidden: false
weight: 2
summary: Open brokerage accounts, enable commission-free trading, and manage the ongoing user experience with Alpaca Broker API
---

# Bank

With the Bank API you can create, and list associated bank accounts with your end customers.

---

## **The Bank Object**

### Sample Bank Object

```json
{
  "id": "9a7fb9b5-1f4d-420f-b6d4-0fd32008cec8",
  "account_id": "669c5a63-ab6c-4659-9c3b-ef1534059126",
  "name": "my bank detail",
  "status": "QUEUED",
  "country": "",
  "state_province": "",
  "postal_code": "",
  "city": "",
  "street_address": "",
  "account_number": "123456789abc",
  "bank_code": "123456789",
  "bank_code_type": "ABA",
  "created_at": "2021-01-09T12:14:18.683915267Z",
  "updated_at": "2021-01-09T12:14:18.683915267Z"
}
```

### Properties

| Attribute        | Type                                                | Description                                                    |
|------------------|-----------------------------------------------------|----------------------------------------------------------------|
| `id`             | string/UUID                                         | Bank relationship ID                                           |
| `account_id`     | string/UUID                                         | Account ID                                                     |
| `name`           | string                                              | Name of bank                                                   |
| `status`         | [ENUM.BankStatus]({{< relref "#enumbankstatus" >}}) |                                                                |
| `country`        | string                                              | Country where bank account is located                          |
| `state_province` | string                                              | State/Province where bank is located                           |
| `postal_code`    | string                                              | Postal code where bank is located                              |
| `city`           | string                                              | City where bank is located                                     |
| `street_address` | string                                              | Street address where bank is located                           |
| `account_number` | string                                              | Bank account number                                            |
| `bank_code`      | string                                              | Bank code                                                      |
| `bank_code_type` | string                                              | Bank identifier. `ABA` for domestic or `BIC` for international |
| `created_at`     | string                                              | Timedate when bank relationship was created                    |
| `updated_at`     | string                                              | Timedate when bank relationship was updated                    |

### ENUM.BankStatus
Represents the various states a Bank instance can be in

| Value              | Description |
|--------------------|-------------|
| `QUEUED`           |             |
| `SENT_TO_CLEARING` |             |
| `APPROVED`         |             |
| `CANCELED`         |             |


---

## **Retrieving Bank Relationship Details for Account**

`GET /v1/accounts/{account_id}/recipient_banks`

### Request

##### Path Parameters

| Attribute    | Type        | Required                             | Notes                                                                     |
|--------------|-------------|--------------------------------------|---------------------------------------------------------------------------|
| `account_id` | string/UUID | {{<hint danger>}}Required{{</hint>}} | An id for the related [Account]({{< relref "../accounts/accounts.md" >}}) |

### Response

{{<hint good>}}
200

An array of [Bank]({{< relref "#sample-bank-object" >}}) relationships attached to this Account.

An empty array will be returned if no Bank relationships have been attached to this account
{{</hint>}}
{{<hint warning>}}400 - Bad Request _The body in the request is not valid_{{</hint>}}

---

## **Deleting a Bank Relationship**

`DELETE /v1/accounts/{account_id}/recipient_banks/{bank_id}`

### Request

##### Path Parameters

| Attribute    | Type        | Required                              | Notes                                                                          |
|--------------|-------------|---------------------------------------|--------------------------------------------------------------------------------|
| `account_id` | string/UUID | {{<hint danger>}}Required{{</hint>}}  | An id for the related [Account]({{< relref "../accounts/accounts.md" >}})      |
| `bank_id`    | string/UUID | {{<hint danger>}}Required {{</hint>}} | The ID for the [Bank]({{< relref "#sample-bank-object" >}}) you wish to delete |

### Response

{{<hint good>}}204 - Success (No Content){{</hint>}}

{{<hint warning>}}400 - Bad Request{{</hint>}}

{{<hint warning>}}
404

_No Bank Relationship with the id specified by `bank_id` was found for this Account_
{{</hint>}}

---

## **Creating a New Bank Relationship**

`POST /v1/accounts/{account_id}/recipient_banks`

### Request

##### Parameters

| Attribute        | Type                | Required                              | Notes                                     |
|------------------|---------------------|---------------------------------------|-------------------------------------------|
| `name`           | string              | {{<hint danger>}}Required {{</hint>}} | Name of recipient bank                    |
| `bank_code_type` | enum.IdentifierType | {{<hint danger>}}Required {{</hint>}} | `ABA` (Domestic) or `BIC` (International) |
| `bank_code`      | string              | {{<hint danger>}}Required {{</hint>}} | 9-Digit ABA RTN (Routing Number) or BIC   |
| `account_number` | string              | {{<hint danger>}}Required {{</hint>}} |                                           |

##### The following Parameters are only available if creating an international Bank relationship, ie if `bank_code_type = BIC`

| Attribute        | Type   | Required                              |
|------------------|--------|---------------------------------------|
| `country`        | string | {{<hint danger>}}Required {{</hint>}} |
| `state_province` | string | {{<hint danger>}}Required {{</hint>}} |
| `postal_code`    | string | {{<hint danger>}}Required {{</hint>}} |
| `city`           | string | {{<hint danger>}}Required {{</hint>}} |
| `street_address` | string | {{<hint danger>}}Required {{</hint>}} |

##### Sample Request

```json
{
  "name": "Bank XYZ",
  "bank_code_type": "ABA",
  "bank_code": "123456789",
  "account_number": "123456789abc"
}
```

### Response

{{<hint good>}}
200 - Success

The created [Bank]({{< relref "#sample-bank-object" >}}) relationship
{{</hint>}}

{{<hint warning>}}400 - Bad Request{{</hint>}}

{{<hint warning>}}
409 - Conflict

_A Bank relationship already exists for this account_
{{</hint>}}

&nbsp;
