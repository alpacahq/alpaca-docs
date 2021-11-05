---
bookHidden: false
weight: 1
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
| `account_owner_name`  | string          | Name of the account owner       |
| `bank_account_type`   | string          | Must be `CHECKING` or `SAVINGS` |
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

| Parameter             | Type   | Required                              | Notes                                 |
| --------------------- | ------ | ------------------------------------- | ------------------------------------- |
| `account_owner_name`  | string | {{<hint danger>}}Required {{</hint>}} |                                       |
| `bank_account_type`   | string | {{<hint danger>}}Required {{</hint>}} | Must be `CHECKING` or `SAVINGS`       |
| `bank_account_number` | string | {{<hint danger>}}Required {{</hint>}} | In sandbox, this must be valid format |
| `bank_routing_number` | string | {{<hint danger>}}Required {{</hint>}} | In sandbox, this must be valid format |
| `nickname`            | string | {{<hint info>}}Optional {{</hint>}}   |                                       |

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
409 - Conflict

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

_`account_id` or `relationship_id` invalid_
{{</hint>}}

{{<hint warning>}}
401 - Unauthorized

{{</hint>}}

{{<hint warning>}}
404 - Relationship Not Found

{{</hint>}}

---
 
## **Plaid Integration for Bank Transfers**

We have integrated with Plaid to allow you to seamlessly link your Plaid account to Alpaca. The integration will allow your end-users to verify their account instantly through Plaid’s trusted front-end module. 

Leveraging this allows you to generate Plaid Processor Tokens on behalf of your end-users, which allows Alpaca to immediately retrieve a user's bank details in order to deposit or withdraw funds on the Alpaca platform. 

You can utilize your Plaid account and activate the Alpaca integration within the Plaid dashboard.

The integration requires [Plaid API Keys](https://plaid.com/docs/auth/partnerships/alpaca/) 

### Obtaining a Plaid Processor Token
A Plaid processor token is used to enable Plaid integrations with partners. After a customer connects their bank using Plaid Link, a processor token can be generated at any time. Please refer to the [Plaid Processor Token](https://plaid.com/docs/auth/partnerships/alpaca/) using Alpaca page for creating a token and additional details.

Exchange token

```bash
curl -X POST https://sandbox.plaid.com/item/public_token/exchange \
  -H 'Content-Type: application/json' \
  -d '{
    "client_id": "[Plaid Client ID]",
    "secret": "[Plaid secret]",
    "public_token": "[Public token]"
  }'
  ```
 Create a processor token for a specific account id.
  
  ```bash
curl -X POST https://sandbox.plaid.com/processor/token/create \
  -H 'Content-Type: application/json' \
  -d '{
    "client_id": "PLAID_CLIENT_ID",
    "secret": "PLAID_SECRET",
    "access_token": "ACCESS_TOKEN",
    "account_id": "ACCOUNT_ID",
    "processor": "alpaca"
  }'
  ```

For a valid request, the API will return a JSON response similar to:
```json
  { 
 "processor_token": "processor-sandbox-0asd1-a92nc",
 "request_id": "m8MDnv9okwxFNBV"
  }
```

## **Processor Token Flow**

![processor-token-flow](processortokenflow.png)

1. End-user links bank account using Plaid

2. Plaid returns a public token to you

3. You will submit a public token to Plaid in exchange for an access token 

4. You will submit access token to Plaid’s ‘/processor/token/create’ endpoint and receive Processor Token (specific to Alpaca) 

5. You will make a call to the processor endpoint to pass Alpaca the processor token, to initiate the payment. To pass the processor token use the ACH relationships endpoint (Link). 

#### Sample Request

`POST /v1/accounts/{account_id}/ach_relationships`

```json
[
  {
    "processor_token": "processor-sandbox-161c86dd-d470-47e9-a741-d381c2b2cb6f",
  }
]
```

#### Sample response

```json
[
  {
  "id": "794c3c51-71a8-4186-b5d0-247b6fb4045e",
  "account_id": "9d587d7a-7b2c-494f-8ad8-5796bfca0866",
  "created_at": "2021-04-08T23:01:53.35743328Z",
  "updated_at": "2021-04-08T23:01:53.35743328Z",
  "status": "QUEUED",
  "account_owner_name": "John Doe",
  "nickname": "Bank of America Checking"
  }
]
```

6. Alpaca makes a call to Plaid to retrieve the Account and Routing number* using the processor token  

7. Alpaca saves the processor token and account and routing number internally for future use. Alpaca uses account information for NACHA file creation and processing 

*Can include Auth, Identity, Balance info - if the broker API wants to initiate a transfer, we use the transfer endpoint

&nbsp;
