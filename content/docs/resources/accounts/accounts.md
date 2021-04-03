---
bookHidden: false
weight: 1
title: "Account"
---

# Accounts 👯‍♀️

The Accounts API allows you to create and manage the accounts under your brokerage account.

---

## **The Account Model**

### Sample Account Object

```json
{
  "contact": {
    "email_address": "cool_alpaca@example.com",
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
    "tax_id_type": "USA_SSN",
    "country_of_citizenship": "USA",
    "country_of_birth": "USA",
    "country_of_tax_residence": "USA",
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
    },
    {
      "agreement": "customer_agreement",
      "signed_at": "2020-09-11T18:13:44Z",
      "ip_address": "185.13.21.99"
    }
  ],
  "documents": [
    {
      "document_type": "cip_result",
      "content": "VGhlcmUgYXJlIG5vIHdpbGQgYWxwYWNhcy4=",
      "mime_type": "application/pdf"
    },
    {
      "document_type": "identity_verification",
      "document_sub_type": "passport",
      "content": "QWxwYWNhcyBjYW5ub3QgbGl2ZSBhbG9uZS4=",
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

### Attributes

#### Parameters

| Attribute         | Notes                                                                                        |
| ----------------- | -------------------------------------------------------------------------------------------- |
| `contact`         | Contact information about the user                                                           |
| `identity`        | KYC information about the user                                                               |
| `disclosures`     | Required disclosures about the user                                                          |
| `documents`       | Any documents that need to be uploaded (eg. passport, visa, ...)                             |
| `trusted_contact` | The contact information of a trusted contact to the user in case account recovery is needed. |

**Contact**

| Attribute        | Type   | Notes |
| ---------------- | ------ | ----- |
| `email_address`  | string |       |
| `phone_number`   | string |       |
| `street_address` | string |       |
| `city`           | string |       |
| `state`          | string |       |
| `postal_code`    | string |       |

**Identity**

| Attribute                  | Type                                                                    | Notes |
| -------------------------- | ----------------------------------------------------------------------- | ----- |
| `given_name`               | string                                                                  |       |
| `family_name`              | string                                                                  |       |
| `date_of_birth`            | date                                                                    |       |
| `tax_id`                   | string                                                                  |       |
| `tax_id_type`              | [ENUM.TaxIdType](/docs/resources/accounts/accounts/#tax-id-type)        |       |
| `country_of_citizenship`   | string                                                                  |       |
| `country_of_birth`         | string                                                                  |       |
| `country_of_tax_residency` | string                                                                  |       |
| `funding_source`           | [ENUM.FundingSource](/docs/resources/accounts/accounts/#funding-source) |       |
| `annual_income_min`        | string/number                                                           |       |
| `annual_income_max`        | string/number                                                           |       |
| `liquid_net_worth_min`     | string/number                                                           |       |
| `liquid_net_worth_max`     | string/number                                                           |       |
| `total_net_worth_min`      | string/number                                                           |       |
| `total_net_worth_max`      | string/number                                                           |       |
| `extra`                    | object                                                                  |       |

**Disclosures**

It is your responsibility as the service provider to denote if the account owner falls under each category defined by FINRA rules. We recommend asking these questions at any point of the onboarding process of each account owner in the form of Y/N and Radio Buttons.

| Attribute                         | Type                                                                          | Notes |
| --------------------------------- | ----------------------------------------------------------------------------- | ----- |
| `is_control_person`               | boolean                                                                       |       |
| `is_affiliated_exchange_or_finra` | boolean                                                                       |       |
| `is_politically_exposed`          | boolean                                                                       |       |
| `immediate_family_exposed`        | boolean                                                                       |       |
| `employment_status`               | [ENUM.EmploymentStatus](/docs/resources/accounts/accounts/#employment-status) |       |
| `employer_name`                   | string                                                                        |       |
| `employer_address`                | string                                                                        |       |
| `employment_position`             | string                                                                        |       |

**Agreements**

In order to comply with Alpaca's terms of service, each account owner must be presented the following agreements.

| Attribute       | Type                                                               | Notes |
| --------------- | ------------------------------------------------------------------ | ----- |
| `[].agreement`  | [ENUM.DocumentType](/docs/resources/accounts/accounts/#agreements) |       |
| `[].signed_at`  | string (timestamp)                                                 |       |
| `[].ip_address` | string                                                             |       |

**Documents**

1. **​`DocumentUpload`**

   This model consists of a series of documents based on the KYC requirements. Documents are binary objects whose contents are encoded in base64. Each encoded content size is limited to 32MB.

   | Attribute           | Type                                                                  | Notes |
   | ------------------- | --------------------------------------------------------------------- | ----- |
   | `document_type`     | [ENUM.DocumentType](/docs/resources/accounts/accounts/#document-type) |       |
   | `document_sub_type` | string                                                                |       |
   | `content`           | base64 string                                                         |       |
   | `mime_type`         | string                                                                |       |

2. **`Document`**

   To add an additional document after submission, please use the `Document` model below to replace any `DocumentUpload`

   | Attribute           | Type                                                                  | Notes |
   | ------------------- | --------------------------------------------------------------------- | ----- |
   | `document_type`     | [ENUM.DocumentType](/docs/resources/accounts/accounts/#document-type) |       |
   | `document_sub_type` | string                                                                |       |
   | `id`                | UUID                                                                  |       |
   | `mime_type`         | string                                                                |       |
   | `created_at`        | timestamp string                                                      |       |

**Trusted Contact**

This model input is optional. However, the client should make reasonable effort to obtain the trusted contact information. See more details in FINRA Notice 17-11

| Attribute     | Type   | Notes      |
| ------------- | ------ | ---------- |
| `given_name`  | string | First name |
| `family_name` | string | Last name  |

In addition, only one of the following is **required**,

| Attribute        | Type   | Notes |
| ---------------- | ------ | ----- |
| `email_address`  | string |       |
| `phone_number`   | string |       |
| `street_address` | string |       |
| `city`           | string |       |
| `state`          | string |       |
| `postal_code`    | string |       |
| `country`        | string |       |

### Enums

#### Tax ID Type

| Attribute       | Description                           |
| --------------- | ------------------------------------- |
| `USA_SSN`       | USA Social Security Number            |
| `AUS_TFN`       | Australian Tax File Number            |
| `AUS_ABN`       | Australian Business Number            |
| `DEU_TAX_ID`    | German Tax ID (Identifikationsnummer) |
| `FRA_SPI`       | French SPI (Reference Tax Number)     |
| `GBR_UTR`       | UK UTR (Unique Taxpayer Reference)    |
| `GBR_NINO`      | UK NINO (National Insurance Number)   |
| `HUN_TIN`       | Hungarian TIN Number                  |
| `IND_PAN`       | Indian PAN Number                     |
| `ISR_TAX_ID`    | Israel Tax ID (Teudat Zehut)          |
| `ITA_TAX_ID`    | Italian Tax ID (Codice Fiscale)       |
| `JPN_TAX_ID`    | Japanese Tax ID (Koijin Bango)        |
| `NLD_TIN`       | Netherlands TIN Number                |
| `SGP_NRIC`      | Singapore NRIC                        |
| `SGP_FIN`       | Singapore FIN                         |
| `SGP_ASGD`      | Singapore ASGD                        |
| `SGP_ITR`       | Singapore ITR                         |
| `SWE_TAX_ID`    | Swedish Tax ID (Personnummer)         |
| `NOT_SPECIFIED` | Other Tax IDs                         |

- Please feel free to reach out to Alpaca if you need other tax ID types.

#### Funding Source

| Attribute           | Description       |
| ------------------- | ----------------- |
| `employment_income` | Employment income |
| `investments`       | Investments       |
| `inheritance`       | Inheritance       |
| `business_income`   | Business income   |
| `savings`           | Savings           |
| `family`            | Family            |

#### Employment Status

| Attribute    | Description |
| ------------ | ----------- |
| `unemployed` | Unemployed  |
| `employed`   | Employed    |
| `student`    | Student     |
| `retired`    | Retired     |

#### Agreements

| Attribute            | Description        |
| -------------------- | ------------------ |
| `margin_agreement`   | Margin agreement   |
| `account_agreement`  | Account agreement  |
| `customer_agreement` | Customer agreement |

#### Document Type

| Attribute                    | Description                |
| ---------------------------- | -------------------------- |
| `identity_verification`      | Identity verification      |
| `address_verification`       | Address verification       |
| `date_of_birth_verification` | Date of birth verification |
| `tax_id_verification`        | Tax ID verification        |

#### Account Status

| Attribute          | Description                                                                                   |
| ------------------ | --------------------------------------------------------------------------------------------- |
| `SUBMITTED`        | Application has been submitted and in process of review                                       |
| `ACTION_REQUIRED`  | Application requires manual action                                                            |
| `APPROVAL_PENDING` | Initial value. Application approval process is in process                                     |
| `APPROVED`         | Account application has been approved, waiting to be `ACTIVE`                                 |
| `REJECTED`         | Account application is rejected                                                               |
| `ACTIVE`           | Account is fully active. Trading and funding can only be processed if an account is `ACTIVE`. |
| `DISABLED`         | Account is disabled, comes after `ACTIVE`                                                     |
| `ACCOUNT_CLOSED`   | Account is closed                                                                             |

---

## **Creating an Account**

`POST /v1/accounts`

Submit an account application with KYC information. This will create a trading account for the end user. The account status may or may not be ACTIVE immediately and you will receive account status updates on the event API.

### Request

##### Sample Request Model

```json
{
  "contact": {
    "email_address": "cool_alpaca@example.com",
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
    "tax_id_type": "USA_SSN",
    "country_of_citizenship": "USA",
    "country_of_birth": "USA",
    "country_of_tax_residence": "USA",
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
    },
    {
      "agreement": "customer_agreement",
      "signed_at": "2020-09-11T18:13:44Z",
      "ip_address": "185.13.21.99"
    }
  ],
  "documents": [
    {
      "document_type": "cip_result",
      "content": "VGhlcmUgYXJlIG5vIHdpbGQgYWxwYWNhcy4=",
      "mime_type": "application/pdf"
    },
    {
      "document_type": "identity_verification",
      "document_sub_type": "passport",
      "content": "QWxwYWNhcyBjYW5ub3QgbGl2ZSBhbG9uZS4=",
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

#### Parameters

| Attribute         | Requirement                           |
| ----------------- | ------------------------------------- |
| `contact`         | {{<hint danger>}}Required {{</hint>}} |
| `identity`        | {{<hint danger>}}Required {{</hint>}} |
| `disclosures`     | {{<hint danger>}}Required {{</hint>}} |
| `documents`       | {{<hint danger>}}Required {{</hint>}} |
| `trusted_contact` | {{<hint info>}}Optional {{</hint>}}   |

**Contact**

| Attribute        | Type   | Requirement                           | Notes                                                                                                  |
| ---------------- | ------ | ------------------------------------- | ------------------------------------------------------------------------------------------------------ |
| `email_address`  | string | {{<hint danger>}}Required {{</hint>}} |                                                                                                        |
| `phone_number`   | string | {{<hint danger>}}Required {{</hint>}} | _Phone number should include the country code, format: "+15555555555"_                                 |
| `street_address` | string | {{<hint danger>}}Required {{</hint>}} |                                                                                                        |
| `city`           | string | {{<hint danger>}}Required {{</hint>}} |                                                                                                        |
| `state`          | string | {{<hint info>}}Optional{{</hint>}}    | {{<hint danger>}}required if `country_of_tax_residency` in identity model (below) is ‘USA’ {{</hint>}} |
| `postal_code`    | string | {{<hint info>}}Optional {{</hint>}}   |                                                                                                        |

**Identity**

| Attribute                  | Type                                                                    | Requirement                           | Notes                                            |
| -------------------------- | ----------------------------------------------------------------------- | ------------------------------------- | ------------------------------------------------ |
| `given_name`               | string                                                                  | {{<hint danger>}}Required {{</hint>}} |                                                  |
| `family_name`              | string                                                                  | {{<hint danger>}}Required {{</hint>}} |                                                  |
| `date_of_birth`            | date                                                                    | {{<hint danger>}}Required {{</hint>}} |                                                  |
| `tax_id`                   | string                                                                  | {{<hint info>}}Optional {{</hint>}}   | Required if `tax_id_type` is set.                |
| `tax_id_type`              | [ENUM.TaxIdType](/docs/resources/accounts/accounts/#tax-id-type)        | {{<hint info>}}Optional {{</hint>}}   | Required if `tax_id` is set.                     |
| `country_of_citizenship`   | string                                                                  | {{<hint info>}}Optional {{</hint>}}   | 3 letter country code acceptable                 |
| `country_of_birth`         | string                                                                  | {{<hint info>}}Optional {{</hint>}}   | 3 letter country code acceptable                 |
| `country_of_tax_residency` | string                                                                  | {{<hint danger>}}Required {{</hint>}} | 3 letter country code acceptable                 |
| `funding_source`           | [ENUM.FundingSource](/docs/resources/accounts/accounts/#funding-source) | {{<hint danger>}}Required {{</hint>}} |                                                  |
| `annual_income_min`        | string/number                                                           | {{<hint info>}}Optional {{</hint>}}   |                                                  |
| `annual_income_max`        | string/number                                                           | {{<hint info>}}Optional {{</hint>}}   |                                                  |
| `liquid_net_worth_min`     | string/number                                                           | {{<hint info>}}Optional {{</hint>}}   |                                                  |
| `liquid_net_worth_max`     | string/number                                                           | {{<hint info>}}Optional {{</hint>}}   |                                                  |
| `total_net_worth_min`      | string/number                                                           | {{<hint info>}}Optional {{</hint>}}   |                                                  |
| `total_net_worth_max`      | string/number                                                           | {{<hint info>}}Optional {{</hint>}}   |                                                  |
| `extra`                    | object                                                                  | {{<hint info>}}Optional {{</hint>}}   | Any additional information used for KYC purposes |

**Disclosures**

It is your responsibility as the service provider to denote if the account owner falls under each category defined by FINRA rules. We recommend asking these questions at any point of the onboarding process of each account owner in the form of Y/N and Radio Buttons.

| Attribute                         | Type                                                                          | Requirement                           | Notes                                                                                                                                                                 |
| --------------------------------- | ----------------------------------------------------------------------------- | ------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `is_control_person`               | boolean                                                                       | {{<hint danger>}}Required {{</hint>}} | Whether user holds a controlling position in a publicly traded company, member of the board of directors or has policy making abilities in a publicly traded company. |
| `is_affiliated_exchange_or_finra` | boolean                                                                       | {{<hint danger>}}Required {{</hint>}} |                                                                                                                                                                       |
| `is_politically_exposed`          | boolean                                                                       | {{<hint danger>}}Required {{</hint>}} |                                                                                                                                                                       |
| `immediate_family_exposed`        | boolean                                                                       | {{<hint danger>}}Required {{</hint>}} | If your user’s immediate family member (sibling, husband/wife, child, parent) is either politically exposed or holds a control position.                              |
| `employment_status`               | [ENUM.EmploymentStatus](/docs/resources/accounts/accounts/#employment-status) | {{<hint info>}}Optional {{</hint>}}   |                                                                                                                                                                       |
| `employer_name`                   | string                                                                        | {{<hint info>}}Optional {{</hint>}}   |                                                                                                                                                                       |
| `employer_address`                | string                                                                        | {{<hint info>}}Optional {{</hint>}}   |                                                                                                                                                                       |
| `employment_position`             | string                                                                        | {{<hint info>}}Optional {{</hint>}}   |                                                                                                                                                                       |

**Agreements**

In order to comply with Alpaca's terms of service, each account owner must be presented the following agreements.

| Attribute       | Type                                                               | Requirement                           | Notes |
| --------------- | ------------------------------------------------------------------ | ------------------------------------- | ----- |
| `[].agreement`  | [ENUM.DocumentType](/docs/resources/accounts/accounts/#agreements) | {{<hint danger>}}Required {{</hint>}} |       |
| `[].signed_at`  | string (timestamp)                                                 | {{<hint danger>}}Required {{</hint>}} |
| `[].ip_address` | string                                                             | {{<hint danger>}}Required {{</hint>}} |

**Documents**

1. **​`DocumentUpload`**

   This model consists of a series of documents based on the KYC requirements. Documents are binary objects whose contents are encoded in base64. Each encoded content size is limited to 32MB.

   | Attribute           | Type                                                                  | Required                              | Notes |
   | ------------------- | --------------------------------------------------------------------- | ------------------------------------- | ----- |
   | `document_type`     | [ENUM.DocumentType](/docs/resources/accounts/accounts/#document-type) | {{<hint danger>}}Required{{</hint>}}  |       |
   | `document_sub_type` | string                                                                | {{<hint info>}}Optional {{</hint>}}   |
   | `content`           | base64 string                                                         | {{<hint danger>}}Required {{</hint>}} |
   | `mime_type`         | string                                                                | {{<hint danger>}}Required {{</hint>}} |

2. **`Document`**

   To add an additional document after submission, please use the `Document` model below to replace any `DocumentUpload`

   | Attribute           | Type                                                                  | Required                             | Notes |
   | ------------------- | --------------------------------------------------------------------- | ------------------------------------ | ----- |
   | `document_type`     | [ENUM.DocumentType](/docs/resources/accounts/accounts/#document-type) | {{<hint danger>}}Required{{</hint>}} |       |
   | `document_sub_type` | string                                                                | {{<hint info>}}Optional {{</hint>}}  |
   | `id`                | UUID                                                                  | {{<hint danger>}}Required{{</hint>}} |
   | `mime_type`         | string                                                                | {{<hint danger>}}Required{{</hint>}} |
   | `created_at`        | timestamp string                                                      | {{<hint danger>}}Required{{</hint>}} |

**Trusted Contact**

This model input is optional. However, the client should make reasonable effort to obtain the trusted contact information. See more details in FINRA Notice 17-11

| Attribute     | Type   | Required                             | Notes      |
| ------------- | ------ | ------------------------------------ | ---------- |
| `given_name`  | string | {{<hint danger>}}Required{{</hint>}} | First name |
| `family_name` | string | {{<hint danger>}}Required{{</hint>}} | Last name  |

In addition, only one of the following is **required**,

| Attribute        | Type   | Required                           | Notes                         |
| ---------------- | ------ | ---------------------------------- | ----------------------------- |
| `email_address`  | string | {{<hint info>}}Optional{{</hint>}} |                               |
| `phone_number`   | string | {{<hint info>}}Optional{{</hint>}} |                               |
| `street_address` | string | {{<hint info>}}Optional{{</hint>}} |                               |
| `city`           | string | {{<hint info>}}Optional{{</hint>}} | If `street_address` is chosen |
| `state`          | string | {{<hint info>}}Optional{{</hint>}} | If `street_address` is chosen |
| `postal_code`    | string | {{<hint info>}}Optional{{</hint>}} | If `street_address` is chosen |
| `country`        | string | {{<hint info>}}Optional{{</hint>}} | If `street_address` is chosen |

### Response

#### Parameters

If all parameters are valid and the application is accepted, you should receive a status code `200` with the following response model.

| Attribute        | Type               | Notes                                                                   |
| ---------------- | ------------------ | ----------------------------------------------------------------------- |
| `id`             | UUID               | UUID that identifies the account for later reference                    |
| `account_number` | string             | A human-readable account number that can be shown to the end user       |
| `status`         | enum.AccountStatus | [ENUM.AccountStatus](/docs/resources/accounts/accounts/#account-status) |
| `currency`       | string             | Always USD                                                              |
| `last_equity`    | string             | EOD equity calculation (cash + long market value + short market value)  |
| `created_at`     | string             | Format: YYYY-MM-DDTXX:YY:ZZ                                             |

#### Sample Response Body

```json
{
  "account": {
    "id": "0d18ae51-3c94-4511-b209-101e1666416b",
    "account_number": "9034005019",
    "status": "ACTIVE",
    "currency": "USD",
    "last_equity": "1500.65",
    "created_at": "2019-09-30T23:55:31.185998Z"
  }
}
```

#### Error Codes

{{<hint warning>}}**`400`** - **Bad Request:** The body in the request is not valid{{</hint>}}
{{<hint warning>}}**`409`** - **Conflict:** There is already an existing account registered with the same email address{{</hint>}}
{{<hint warning>}}**`422`** - **Unprocessable Entity:** Invalid input value{{</hint>}}
{{<hint warning>}}**`4500`** - **Internal Server Error​:** Some server error occurred. Please contact Alpaca.{{</hint>}}

---

## **Listing All Accounts**

`GET /v1/accounts`

You can query a list of all the accounts that you submitted to Alpaca. You can tweak the query to return a list of accounts that fulfill certain conditions passed.

### Request

##### Parameters

| Attribute        | Type               | Required                           | Notes                                                                                                                                     |
| ---------------- | ------------------ | ---------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| `query`          | string             | {{<hint info>}}Optional{{</hint>}} | The response will contain all accounts that match with one of the tokens (space- delisted) in account number, names, email, ... (strings) |
| `created_after`  | string, timestamp  | {{<hint info>}}Optional{{</hint>}} |
| `created_before` | string, timestamp  | {{<hint info>}}Optional{{</hint>}} |
| `status`         | ENUM.AccountStatus | {{<hint info>}}Optional{{</hint>}} | [ENUM.AccountStatus](/docs/resources/accounts/accounts/#account-status)                                                                   |
| `sort`           | string             | {{<hint info>}}Optional{{</hint>}} | `asc` or `desc`. Defaults to `desc`                                                                                                       |
| `entities`       | string             | {{<hint info>}}Optional{{</hint>}} | Comma-delimited entity names to include in the response                                                                                   |

### Response

Up to 1,000 items per query, ordered by `created_at`.

---

## **Listing an Account**

`GET /v1/accounts/{account_id}`

You can query a specific account that you submitted to Alpaca by passing into the query the `account_id` associated with the account you're retrieving.

### Request

N/A

### Response

Will return an account if account with `account_id` exists, otherwise will throw an error.

---

## **Updating an Account**

`PATCH /v1/accounts/{account_id}`

This operation updates account information. The following attribute are modifiable.

### Request

##### Parameters

**Contact**

| Attribute        | Key        | Required                           | Notes                                                                           |
| ---------------- | ---------- | ---------------------------------- | ------------------------------------------------------------------------------- |
| `email_address`  | [].contact | {{<hint info>}}Optional{{</hint>}} | Email addresses should be verified prior to using this operation to update them |
| `phone_number`   | [].contact | {{<hint info>}}Optional{{</hint>}} |                                                                                 |
| `street_address` | [].contact | {{<hint info>}}Optional{{</hint>}} |                                                                                 |
| `city`           | [].contact | {{<hint info>}}Optional{{</hint>}} |                                                                                 |
| `state`          | [].contact | {{<hint info>}}Optional{{</hint>}} |                                                                                 |
| `postal_code`    | [].contact | {{<hint info>}}Optional{{</hint>}} |                                                                                 |

- Partners are responsible for submitting updated documents as required by the updates being made
- Guidance for Form W-8BEN on changes in circumstance can be found at https://www.irs.gov/instructions/iw8ben
- Letters sent to customers on address changes should blind carbon copy (bcc) support@alpaca.markets

**Identity**

| Attribute              | Key         | Required                           | Notes |
| ---------------------- | ----------- | ---------------------------------- | ----- |
| `funding_source`       | [].identity | {{<hint info>}}Optional{{</hint>}} |       |
| `annual_income_min`    | [].identity | {{<hint info>}}Optional{{</hint>}} |       |
| `annual_income_max`    | [].identity | {{<hint info>}}Optional{{</hint>}} |       |
| `liquid_net_worth_min` | [].identity | {{<hint info>}}Optional{{</hint>}} |       |
| `liquid_net_worth_max` | [].identity | {{<hint info>}}Optional{{</hint>}} |       |
| `total_net_worth_min`  | [].identity | {{<hint info>}}Optional{{</hint>}} |       |
| `total_net_worth_max`  | [].identity | {{<hint info>}}Optional{{</hint>}} |       |

**Disclosures**

| Attribute                         | Key            | Required                           | Notes |
| --------------------------------- | -------------- | ---------------------------------- | ----- |
| `is_control_person`               | [].disclosures | {{<hint info>}}Optional{{</hint>}} |       |
| `is_affiliated_exchange_or_finra` | [].disclosures | {{<hint info>}}Optional{{</hint>}} |       |
| `is_politically_exposed`          | [].disclosures | {{<hint info>}}Optional{{</hint>}} |       |
| `immediate_family_exposed`        | [].disclosures | {{<hint info>}}Optional{{</hint>}} |       |
| `employment_status`               | [].disclosures | {{<hint info>}}Optional{{</hint>}} |       |
| `employer_name`                   | [].disclosures | {{<hint info>}}Optional{{</hint>}} |       |
| `employer_address`                | [].disclosures | {{<hint info>}}Optional{{</hint>}} |       |
| `employment_position`             | [].disclosures | {{<hint info>}}Optional{{</hint>}} |       |

**Trusted Contact**

You can change the name of the trusted contact if you want.

| Attribute     | Type   | Required                             | Notes      |
| ------------- | ------ | ------------------------------------ | ---------- |
| `given_name`  | string | {{<hint danger>}}Required{{</hint>}} | First name |
| `family_name` | string | {{<hint danger>}}Required{{</hint>}} | Last name  |

In addition, you can also change the way to reach the trusted contact by updating the following.
Only one of `email_address`, `phone_number` or `streets_address` (with the other parameters) is required

| Attribute        | Type   | Required                           | Notes                         |
| ---------------- | ------ | ---------------------------------- | ----------------------------- |
| `email_address`  | string | {{<hint info>}}Optional{{</hint>}} |                               |
| `phone_number`   | string | {{<hint info>}}Optional{{</hint>}} |                               |
| `street_address` | string | {{<hint info>}}Optional{{</hint>}} |                               |
| `city`           | string | {{<hint info>}}Optional{{</hint>}} | If `street_address` is chosen |
| `state`          | string | {{<hint info>}}Optional{{</hint>}} | If `street_address` is chosen |
| `postal_code`    | string | {{<hint info>}}Optional{{</hint>}} | If `street_address` is chosen |
| `country`        | string | {{<hint info>}}Optional{{</hint>}} | If `street_address` is chosen |

### Response

If all parameters are valid and updates have been made, it returns with status code `200`. The response is the account model.

#### Error Codes

{{<hint danger>}}
400 - Bad Request

​ _The body in the request is not valid_
{{</hint>}}

{{<hint danger>}}
422 - Unprocessable Entity

​ _The request body contains an attribute that is not permitted to be updated._
{{</hint>}}

{{<hint danger>}}
500 - Internal Server Error​

_Some server error occurred. Please contact Alpaca._
{{</hint>}}

---

## **Deleting an Account**

`DELETE /v1/accounts/{account_id}`

You can request to close/delete an account.

### Request

##### Parameters

N/A

### Response

Will return a response code, either in success or failure.

---
