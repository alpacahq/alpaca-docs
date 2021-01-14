---
title: Accounts API
type: docs
---

# Accounts

An `account` object defines the end customer interacting with the US stock market through your app. Once created, each account is given a unique `UUID` and a unique `account_number`.

---

## The Account Object

##### Sample Object

```json
{
  "contact": {
    "email_address": "john.doe@example.com",
    "phone_number": "555-666-7788",
    "street_address": ["20 N San Mateo Dr"],
    "city": "San Mateo",
    "state": "CA",
    "postal_code": "94401",
    "country": "USA"
  },
  "identity": {
    "given_name": "John",
    "family_name": "Doe",
    "date_of_birth": "1990-01-01",
    "tax_id": "666-55-4321",
    "tax_id_type": "ssn",
    "country_of_citizenship": "AUS",
    "country_of_birth": "AUS",
    "country_of_tax_residence": "AUS",
    "funding_source": ["employment_income"]
  },
  "disclosures": {
    "is_control_person": false,
    "is_affiliated_exchange_or_finra": false,
    "is_politically_exposed": false,
    "immediate_family_exposed": false
  },
  "agreements": [
    {
      "agreement": "margin_agreement",
      "signed_at": "2020-09-11T18:09:33Z",
      "ip_address": "185.13.21.99"
    },
    {
      "agreement": "account_agreement",
      "signed_at": "2020-09-11T18:13:44Z",
      "ip_address": "185.13.21.99"
    }
  ],
  "documents": [
    {
      "document_type": "cip",
      "content": "...",
      "mime_type": "application/pdf"
    },
    {
      "document_type": "identity_verification",
      "document_sub_type": "passport",
      "content": "...",
      "mime_type": "image/jpeg"
    }
  ],
  "trusted_contact": {
    "given_name": "Jane",
    "family_name": "Doe",
    "email_address": "jane.doe@example.com"
  }
}
```

---

## Available Endpoints

---

### `POST /v1/accounts`

Submit an account application with KYC information. This will create a trading account for the end user. The account status may or may not be ACTIVE immediately and you will receive account status updates on the event API.

#### Request

##### Parameters

| Attribute         | Notes    |
| ----------------- | -------- |
| `contact`         | Required |
| `identity`        | Required |
| `disclosures`     | Required |
| `documents`       | Required |
| `trusted_contact` | Required |

All attributes below are required unless otherwise mentioned.

###### Contact

| Attribute        | Type   | Notes                                                                  |
| ---------------- | ------ | ---------------------------------------------------------------------- |
| `email_address`  | string |                                                                        |
| `phone_number`   | string | _Phone number should include the country code, format: "+11234567890"_ |
| `street_address` | string |                                                                        |
| `city`           | string |                                                                        |
| `state`          | string | optional - required if the account is based in USA                     |
| `postal_code`    | string | optional                                                               |

###### Identity

| Attribute                  | Type   | Notes                                                                                     |
| -------------------------- | ------ | ----------------------------------------------------------------------------------------- |
| `given_name`               | string |                                                                                           |
| `family_name`              | string |                                                                                           |
| `date_of_birth`            | date   |                                                                                           |
| `tax_id`                   | string |                                                                                           |
| `tax_id_type`              | ENUM   | `USA_SSN`, `AUS_TFN`, `AUS_ABN`, `SGP_NRIC`, `SGP_FIN`, `SGP_ASGD`, `SGP_ITR`, `OTHER`    |
| `country_of_citizenship`   | string | optional, 3 letter country code acceptable                                                |
| `country_of_birth`         | string | optional, 3 letter country code acceptable                                                |
| `country_of_tax_residency` | string | 3 letter country code acceptable                                                          |
| `funding_source`           | ENUM   | `employment_income`, `investments`, `inheritance`, `business_income`, `savings`, `family` |
| `annual_income_min`        |        | optional                                                                                  |
| `annual_income_max`        |        | optional                                                                                  |
| `liquid_net_worth_min`     |        | optional                                                                                  |
| `liquid_net_worth_max`     |        | optional                                                                                  |
| `total_net_worth_min`      |        | optional                                                                                  |
| `total_net_worth_max`      |        | optional                                                                                  |
| `extra`                    | object | any additional information used for KYC purposes                                          |

###### Disclosures

It is your responsibility as the service provider to denote if the account owner falls under each category defined by FINRA rules. We recommend asking these questions at any point of the onboarding process of each account owner in the form of Y/N and Radio Buttons.

`is_control_person` - boolean

`is_affiliated_exchange_or_finra` - boolean

`is_politically_exposed` - boolean

​`immediate_family_exposed` - boolean

​`employment_status` - ENUM.EmploymentStatus (optional)

- `unemployed` - string
- `employed` - string
- `student` - string
- `retired` - string

​`employer_name` - string
(optional)

​`employer_address` - string
(optional)

​`employment_position` - string
(optional)

###### Agreements

In order to comply with Alpaca's terms of service, each account owner must be presented the following agreements.

`[].agreement` - ENUM.Agreement

- `margin_agreement` - string
- `account_agreement` - string
- `customer_agreement` - string

​`[].signed_at` - string (timestamp)

​`[].ip_address` - string

###### Documents

1. **​`DocumentUpload`**

   This model consists of a series of documents based on the KYC requirements. Documents are binary objects whose contents are encoded in base64. Each encoded content size is limited to 32MB.

`document_type` ENUM.DocumentType

- `identity_verification`
- `address_verification`
- `date_of_birth_verification`
- `tax_id_verification`

`account_approval_letter`

`cip_result`

`document_sub_type` string (optional)

`content` base64 string

`mime_type` string

2. **`Document`**

To add an additional document after submission, please use the `Document` model below to replace any `DocumentUpload`

`document_type` enum.DocumentType

- `identity_verification`
- `address_verification`
- `date_of_birth_verification`
- `tax_id_verification`
- `account_approval_letter`

`cip_result`

`document_sub_type` string (optional)

`id` uuid

`mime_type` string

`created_at` time<timestamp>\*\*

###### Trusted Contact

(optional model)
This model input is optional. However, the client should make reasonable effort to obtain the trusted contact information. See more details in FINRA Notice 17-11

​`given_name` string
​
`family_name` string

​One of the following is required

1.  ​`email_address` string
2.  `phone_number` string
3.  `street_address` string
    - `city` string
    - `state` string
    - `postal_code` string
    - `country`string (3 letter country code acceptable)

##### Sample Request Model

```json
 "contact": {
  "email_address": "john.doe@example.com",
  "phone_number": "555-666-7788",
  "street_address": [
   "20 N San Mateo Dr"
  ],
  "city": "San Mateo",
  "state": "CA",
  "postal_code": "94401",
  "country": "USA"
 },
 "identity": {
  "given_name": "John",
  "family_name": "Doe",
  "date_of_birth": "1990-01-01",
  "tax_id": "666-55-4321",
  "tax_id_type": "ssn",
  "country_of_citizenship": "AUS",
  "country_of_birth": "AUS",
  "country_of_tax_residence": "AUS",
  "funding_source": ["employment_income"],
 },
 "disclosures": {
  "is_control_person": false,
  "is_affiliated_exchange_or_finra": false,
  "is_politically_exposed": false,
  "immediate_family_exposed": false
 },
 "agreements": [
  {
   "agreement": "margin_agreement",
   "signed_at": "2020-09-11T18:09:33Z",
   "ip_address": "185.13.21.99"
  },
  {
   "agreement": "account_agreement",
   "signed_at": "2020-09-11T18:13:44Z",
   "ip_address": "185.13.21.99"
  }
 ],
 "documents": [
  {
   "document_type": "cip",
   "content": "...",
   "mime_type": "application/pdf"
  },
  {
   "document_type": "identity_verification",
   "document_sub_type": "passport",
   "content": "...",
   "mime_type": "image/jpeg"
  }
 ],
 "trusted_contact": {
  "given_name": "Jane",
  "family_name": "Doe",
  "email_address": "jane.doe@example.com"
 }
}
```

#### Response

##### Parameters

If all parameters are valid and the application is accepted, you should receive a status code `200` with the following response model.

`id`
UUID that identifies the account for later reference

​`account_number`
A human-readable account number that can be shown to the end user.

​`status` - ENUM

- `SUBMITTED` - Application has been submitted and in process of review.
- `ACTION_REQUIRED` - Application requires manual action.
- `APPROVAL_PENDING` - Initial value. Application approval process is in process
- `APPROVED` - Account application has been approved, waiting to be `ACTIVE`
- `REJECTED` - Account application is rejected.
- `ACTIVE` - Account is fully active.
  - Trading and funding can only be processed if an account is `ACTIVE`
- `DISABLED` - Account is disabled, comes after `ACTIVE`
- `ACCOUNT_CLOSED` - Account is closed.

​`currency` - string
Always "USD"

​`created_at` - string
Format: YYYY-MM-DDTXX:YY:ZZ

##### Sample Response Body

```json
{
  "account": {
    "id": "0d18ae51-3c94-4511-b209-101e1666416b",
    "account_number": "9034005019",
    "status": "ACTIVE",
    "currency": "USD",
    "created_at": "2019-09-30T23:55:31.185998Z"
  }
}
```

##### Error Codes

400 - Bad Request
​ _The body in the request is not valid_

409 - Conflict
​ _There is already an existing account registered with the same email address_

422 - Unprocessable Entity
​ _Invalid input value_

500 - Internal Server Error
​ _Server error. Please contact Alpaca support._

---

### `GET /v1/accounts`

You can query a list of all the accounts that you submitted to Alpaca. You can tweak the query to return a list of accounts that fulfill certain conditions passed.

#### Request

##### Parameters

​`query` string (optional)
The response will contain all accounts that match with one of the tokens (space- delisted) in account number, names, email, ... (strings)

`created_after` - string <timestamp>
(optional)

`created_before` - string <timestamp>
(optional)

​`status` ENUM.AccountStatus (optional)

- `SUBMITTED` application has been submitted and in process of review.
- `ACTION_REQUIRED` application requires manual action
- `APPROVAL_PENDING` initial value. Application approval process is in process
- `APPROVED` Account application has been approved, waiting to be `ACTIVE`
- `REJECTED` Account application is rejected.
- `ACTIVE` Account is fully active.
  - Trading and funding can only be processed if an account is `ACTIVE`
- `DISABLED` Account is disabled, comes after `ACTIVE`
- `ACCOUNT_CLOSED`\*\* Account is closed.

`sort` - string
("asc" or "desc") - defaults to "desc" (optional)

`entities` - string
Comma-delimited entity names to include in the response

#### Response

Up to 1,000 items per query, ordered by `created_at`.

---

### `GET /v1/accounts/{account_id}`

You can query a specific account that you submitted to Alpaca by passing into the query the `account_id` associated with the account you're retrieving.

#### Request

N/A

#### Response

Will return an account if account with `account_id` exists, otherwise will throw an error.

---

### `PATCH /v1/accounts/{account_id}`

#### Request

N/A

#### Response

Will return an account if account with `account_id` exists, otherwise will throw an error.

---

### `DELETE /v1/accounts/{account_id}`

You can request to close/delete an account.

#### Request

##### Parameters

N/A

#### Response

Will return a response code, either in success or failure.

---
