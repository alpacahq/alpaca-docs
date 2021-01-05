---
title: Accounts API
type: docs
---

{{< api-endpoint "/accounts" GET >}}

An `account` object defines the end customer interacting with the US stock market through your app. Once created, each account is given a unique `UUID` and a unique `account_number`.

##### The Account Object

`contact` - _required_

`identity ` - _required_

`disclosures` - _required_

`agreements` - _required_

`documents` - _required_

`trusted_contact` - _required_

##### Available Endpoints

##### `POST /v1/accounts`

###### Request

All attributes are required unless otherwise mentioned.

`contact`

​ **`email_address`** string

​ **`phone_number`** string

​ _Phone number should include the country code, format: "+11234567890"_

​ **`street_address`** string

​ **`city`** string

​ **`sate`** string (optional - required if the account is based in USA)

​ **`postal_code`** string (optional)

`identity`

The `identity` model provides all sorts of information on the identity of the account owner.

​ **`given_name`** string

​ **`family_name`** string

​ **`date_of_birth`** date

​ **`tax_id`** string

​ **`tax_id_type`** enum

​ **`USA_SSN`** string

​ **`AUS_TFN`** string

​ **`AUS_ABN`** string

​ **`SGP_NRIC`** string

​ **`SGP_FIN`** string

​ **`SGP_ASGD`** string

​ **`SGP_ITR`** string

​ **`OTHER`** string

​ **`country_of_citizenship`** string (3 letter country code acceptable) (optional)

​ **`country_of_birth`** string (3 letter country code acceptable) (optional)

​ **`country_of_tax_residency`** string (3 letter country code acceptable)

​ **`funding_source`** enum.FundingSource

​ **`employment_income`** string

​ **`investments`** string

​ **`inheritance`** string

​ **`business_income`** string

​ **`savings`** string

​ **`family`** string

​ **`annual_income_min`** number (optional)

​ **`annual_income_max`** number (optional)

​ **`liquid_net_worth_min`** number (optional)

​ **`liquid_net_worth_max`** number (optional)

​ **`total_net_worth_min`** number (optional)

​ **`total_net_worth_max`** number (optional)

​ **`extra`** object

​ _any additional information used for KYC purposes_

`disclosures`

It is your responsibility as the service provider to denote if the account owner falls under each category defined by FINRA rules. We recommend asking these questions at any point of the onboarding process of each account owner in the form of Y/N and Radio Buttons.

​ **`is_control_person`** boolean

​ **`is_affiliated_exchange_or_finra`** boolean

​ **`is_politically_exposed`** boolean

​ **`immediate_family_exposed`** boolean

​ **`employment_status`** enum (optional)

​ **`unemployed`** string

​ **`employed`** string

​ **`student`** string

​ **`retired`** string

​ **`employer_name`** string (optional)

​ **`employer_address`** string (optional)

​ **`employment_position`** string (optional)

`agreements`

In order to comply with Alpaca's terms of service, each account owner must be presented the following agreements.

​ **`[].agreement`** enum

​ **`margin_agreement`** string

​ **`account_agreement`** string

​ **`customer_agreement`** string

​ **`[].signed_at`** string<timestamp>

​ **`[].ip_address`** string

`documents`

​ `DocumentUpload`

​ **`document_type`** enum.DocumentType

​ **`identity_verification`**

​ **`address_verification`**

​ **`date_of_birth_verification`**

​ **`tax_id_verification`**

​ **`account_approval_letter`**

​ **`cip_result`**

​ **`document_sub_type`** string (optional)

​ **`content`** base64 string

​ **`mime_type`** string

​ To add an additional document after submission, please use the `Document` model below to replace any `DocumentUpload`

​ `Documents`

​ **`document_type`** enum.DocumentType

​ **`identity_verification`**

​ **`address_verification`**

​ **`date_of_birth_verification`**

​ **`tax_id_verification`**

​ **`account_approval_letter`**

​ **`cip_result`**

​ **`document_sub_type`** string (optional)

​ **`id`** uuid

​ **`mime_type`** string

​ **`created_at`** time<timestamp>

`trusted_contact` (optional model)

​ **`given_name`** string

​ **`family_name`** string

​ one of the following is required

​ **`email_address`** string

​ **`phone_number`** string

​ **`street_address`** string

​ The following are required if you are choosing `street_address`

​ **`city`** string

​ **`state`** string

​ **`postal_code`** string

​ **`country`** string (3 letter country code acceptable)

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

###### Response

If all parameters are valid and the application is accepted, you should receive a status code `200` with the following response model.

​ **`id`**

​ UUID that identifies the account for later reference

​ **`account_number`**

​ A human-readable account number that can be shown to the end user.

​ **`status`** enum

​ **`SUBMITTED`** application has been submitted and in process of review.

​ **`ACTION_REQUIRED`** application requires manual action

​ **`APPROVAL_PENDING`** initial value. Application approval process is in process.

​ **`APPROVED`** Account application has been approved, waiting to be `ACTIVE`

​ **`REJECTED`** Account application is rejected.

​ **`ACTIVE`** Account is fully active.

​ Trading and funding can only be processed if an account is `ACTIVE`

​ **`DISABLED`** Account is disabled, comes after `ACTIVE`

​ **`ACCOUNT_CLOSED`** Account is closed.

​ **`currency`** always "USD"

​ **`created_at`** timestamp value for account creation

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

**Error Codes**

400 - Bad Request

​ _The body in the request is not valid_

409 - Conflict

​ _There is already an existing account registered with the same email address_

422 - Unprocessable Entity

​ _Invalid input value_

500 - Internal Server Error

​ _Server error. Please contact Alpaca support._
