---
bookHidden: false
weight: 3
title: ACH Relationships
summary: Open brokerage accounts, enable commission-free trading, and manage the ongoing user experience with Alpaca Broker API
---

# ACH Relationships API

With the ACH Relationship API you can list, create and cancel ACH relationships with your end customers.

## **The ACH Relationship Object**

### Sample Object

```json
{
  "id": "794c3c51-71a8-4186-b5d0-247b6fb4045e",
  "account_id": "9d587d7a-7b2c-494f-8ad8-5796bfca0866",
  "created_at": "2021-04-08T23:01:53.35743328Z",
  "updated_at": "2021-04-08T23:01:53.35743328Z",
  "status": "QUEUED",
  "account_owner_name": "John Doe",
  "bank_account_type": "CHECKING",
  "bank_account_number": "123456789abc",
  "bank_routing_number": "121000358",
  "nickname": "Bank of America Checking"
}
```

### Attributes

| Attribute             | Type            | Notes                           |
| --------------------- | --------------- | ------------------------------- |
| `id`                  | string          | UUID                            |
| `account_id`          | string          | UUID                            |
| `created_at`          | string/timedate |                                 |
| `updated_at`          | string/timedate |                                 |
| `status`              | ENUM.AchStatus  | `QUEUED`, `APPROVED`, `PENDING` |
| `account_owner_name`  | ENUM            | Name of the account owner       |
| `bank_account_type`   | string          |                                 |
| `bank_account_number` | string/number   |                                 |
| `bank_routing_number` | string/number   |                                 |
| `nickname`            | string          |                                 |

---

## **Creating an ACH Relationship**

`POST /v1/accounts/{account_id}/ach_relationships`

### Request

#### Sample Request

```json
{
  "account_owner_name": "John Doe",
  "bank_account_type": "CHECKING",
  "bank_account_number": "32131231abc",
  "bank_routing_number": "121000358",
  "nickname": "Bank of America Checking"
}
```

#### Parameters

| Parameter             | Type   | Required                              | Notes                           |
| --------------------- | ------ | ------------------------------------- | ------------------------------- |
| `account_owner_name`  | string | {{<hint danger>}}Required {{</hint>}} |                                 |
| `bank_account_type`   | string | {{<hint danger>}}Required {{</hint>}} | Must be `CHECKING` or `SAVINGS` |
| `bank_account_number` | string | {{<hint danger>}}Required {{</hint>}} |                                 |
| `bank_routing_number` | string | {{<hint danger>}}Required {{</hint>}} |                                 |
| `nickname`            | string | {{<hint info>}}Optional {{</hint>}}   |                                 |

### Response

If successful, will return `200` code with a newly created ACH Relationship entity.

#### Error Codes

{{<hint warning>}}
400 - Bad Request
{{</hint>}}

{{<hint warning>}}
401 - Not Authorized

_Invalid credentials_
{{</hint>}}

{{<hint warning>}}
400 - Forbidden

_The account already has an active relationship_
{{</hint>}}

---

## **Retrieving ACH Relationships for Account**

`GET /v1/accounts/{account_id}/ach_relationships`

### Request

#### Parameters

| Attribute  | Type   | Requirement                        | Notes                                              |
| ---------- | ------ | ---------------------------------- | -------------------------------------------------- |
| `statuses` | string | {{<hint info>}}Optional{{</hint>}} | Multiple statuses (comma separated) are supported. |

### Response

Returns a list of ACH relationships.

---

## **Deleting an ACH Relationship**

`DELETE /v1/accounts/{account_id}/ach_relationships/{relationship_id}`

### Request

N/A

### Response

**`204`** - Success (No Content)

#### Error Codes

{{<hint warning>}}
400 - Invalid Request Body

`account_id` or `relationship_id` invalid
{{</hint>}}

{{<hint warning>}}
401 - Unauthorized

{{</hint>}}

{{<hint warning>}}
404 - Relationship Not Found

{{</hint>}}

&nbsp;
