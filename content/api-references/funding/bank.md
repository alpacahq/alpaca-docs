---
bookHidden: false
weight: 1
---

# Bank

With the Bank API you can create, and list associated bank accounts with your end customers.

---

## **The Bank Object**

### Sample Bank Object

```json
{
  "id": "9a7fb9b5-1f4d-420f-b6d4-0fd32008cec8",
  "account_id": "account_id_",
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

| Attribute        | Type        | Description                                                    |
| ---------------- | ----------- | -------------------------------------------------------------- |
| `id`             | string/UUID | Bank relationship ID                                           |
| `account_id`     | string/UUID | Account ID                                                     |
| `name`           | string      | Name of bank                                                   |
| `status`         | string/ENUM |                                                                |
| `country`        | string      | Country where bank account is located                          |
| `state_province` | string      | State/Province where bank is located                           |
| `postal_code`    | string      | Postal code where bank is located                              |
| `city`           | string      | City where bank is located                                     |
| `street_address` | string      | Street address where bank is located                           |
| `account_number` | string      | Bank account number                                            |
| `bank_code`      | string      | Bank code                                                      |
| `bank_code_type` | string      | Bank identifier. `ABA` for domestic or `BIC` for international |
| `created_at`     | string      | Timedate when bank relationship was created                    |
| `updated_at`     | string      | Timedate when bank relationship was updated                    |

---

## **Retrieving Bank Details for Account**

`GET /v1/accounts/{account_id}/recipient_banks`

### Request

##### Parameters

| Attribute   | Type            | Required                              | Notes                  |
| ----------- | --------------- | ------------------------------------- | ---------------------- |
| `status`    | enum.BankStatus | {{<hint danger>}}Required {{</hint>}} | `ACTIVE` or `INACTIVE` |
| `bank_name` | string          | {{<hint info>}}Optional {{</hint>}}   |

### Response

##### Parameters

| Attribute     | Type            | Notes                                                                    |
| ------------- | --------------- | ------------------------------------------------------------------------ |
| `id`          | string/UUID     | Bank ID                                                                  |
| `name`        | string          |                                                                          |
| `status`      | string          | `QUEUED`, `CANCEL_REQUESTED`, `SENT_TO_CLEARING`, `APPROVED`, `CANCELED` |
| `account_id`  | string/UUID     | Account ID                                                               |
| `clearing_id` | string          | Clearing ID                                                              |
| `created_at`  | string/timedate | Format: 2020-01-01T01:01:01Z                                             |
| `updated_at`  | string/timedate | Format: 2020-01-01T01:01:01Z                                             |
| `deleted_at`  | string/timedate | Format: 2020-01-01T01:01:01Z                                             |

#### Errors

400 - Bad Request
​ _The body in the request is not valid_

---

## **Deleting a Bank Account**

`DELETE /v1/accounts/{account_id}/recipient_banks/{bank_id}`

### Request

##### Parameters

| Attribute | Type        | Required                              | Notes |
| --------- | ----------- | ------------------------------------- | ----- |
| `bank_id` | string/UUID | {{<hint danger>}}Required {{</hint>}} |       |

### Response

400 - Bad Request

404 - Bank Not Found

204 - Success (No Content)

---

## **Creating a New Bank Relationship**

`POST /v1/accounts/{account_id}/recipient_banks`

### Request

##### Parameters

| Attribute        | Type                | Required                              | Notes                                     |
| ---------------- | ------------------- | ------------------------------------- | ----------------------------------------- |
| `name`           | string              | {{<hint danger>}}Required {{</hint>}} | Name of recipient bank                    |
| `bank_code_type` | enum.IdentifierType | {{<hint danger>}}Required {{</hint>}} | `ABA` (Domestic) or `BIC` (International) |
| `bank_code`      | string              | {{<hint danger>}}Required {{</hint>}} | 9-Digit ABA RTN (Routing Number) or BIC   |
| `country`        | string              | {{<hint danger>}}Required {{</hint>}} | Only for international banks              |
| `state_province` | string              | {{<hint danger>}}Required {{</hint>}} | Only for international banks              |
| `postal_code`    | string              | {{<hint danger>}}Required {{</hint>}} | Only for international banks              |
| `city`           | string              | {{<hint danger>}}Required {{</hint>}} | Only for international banks              |
| `street_address` | string              | {{<hint danger>}}Required {{</hint>}} | Only for international banks              |
| `account_number` | string              | {{<hint danger>}}Required {{</hint>}} | Only for international banks              |

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

##### Codes

400 - Bad Request

409 - Conflict

200 - Success

##### Sample Response

```json
{
  "id": "9a7fb9b5-1f4d-420f-b6d4-0fd32008cec8",
  "account_id": "account_id_",
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

&nbsp;
