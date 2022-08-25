---
bookHidden: false
weight: 1
title: "Account"
summary: Open crypto and brokerage accounts, enable crypto and stock trading, and manage the ongoing user experience with Alpaca Broker API
---

# Accounts

The Accounts API allows you to create and manage the accounts under your brokerage and crypto account.

## **Allowed Setups**

{{<hint good>}}**Fully-Disclosed:** Brokers with an FD setup can access the Accounts API{{</hint>}}

{{<hint danger>}}**Omnibus:** Brokers with an Omnibus setup cannot access the Accounts API{{</hint>}}

---

## **The Account Model**

### Sample Account Object

```json
{
    "id": "7ccfd029-9b91-40d0-9b4c-f928385af666",
    "account_number": "808971365",
    "status": "SUBMITTED",
    "crypto_status": "SUBMITTED",
    "currency": "USD",
    "last_equity": "0",
    "created_at": "2022-08-16T20:19:20.547306Z",
    "contact": {
        "email_address": "alpacad@example.com",
        "phone_number": "555-666-7788",
        "street_address": [
            "20 N San Mateo Dr"
        ],
        "city": "San Mateo",
        "state": "CA",
        "postal_code": "94401"
    },
    "identity": {
        "given_name": "John",
        "family_name": "Doe",
        "date_of_birth": "1990-01-01",
        "tax_id_type": "USA_SSN",
        "country_of_citizenship": "USA",
        "country_of_birth": "USA",
        "country_of_tax_residence": "USA",
        "funding_source": [
            "employment_income"
        ],
        "visa_type": null,
        "visa_expiration_date": null,
        "date_of_departure_from_usa": null,
        "permanent_resident": null
    },
    "disclosures": {
        "is_control_person": false,
        "is_affiliated_exchange_or_finra": false,
        "is_politically_exposed": false,
        "immediate_family_exposed": false,
        "is_discretionary": false
    },
    "agreements": [
        {
            "agreement": "customer_agreement",
            "signed_at": "2020-09-11T18:13:44Z",
            "ip_address": "185.13.21.99",
            "revision": "19.2022.02"
        },
        {
            "agreement": "crypto_agreement",
            "signed_at": "2020-09-11T18:13:44Z",
            "ip_address": "185.13.21.99",
            "revision": "04.2021.10"
        }
    ],
    "documents": [
        {
            "document_type": "identity_verification",
            "document_sub_type": "passport",
            "id": "91098d44-c384-4388-a410-24616ce1c6e4",
            "content": "https://s3.amazonaws.com/stg.alpaca.markets/documents/accounts/7ccfd029-9b91-40d0-9b4c-f928385af666/af49b170-a4ba-4592-8036-db43964756c0.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAJLDF4SCWSL6HUQKA%2F20220816%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220816T202138Z&X-Amz-Expires=900&X-Amz-SignedHeaders=host&X-Amz-Signature=a22b2eb92e373fd4146d10a4707765d35042f3cbd7c319341a718d9d823f5350",
            "created_at": "2022-08-16T20:19:21.333788Z"
        }
    ],
    "trusted_contact": {
        "given_name": "Jane",
        "family_name": "Doe",
        "email_address": "jane.doe@example.com"
    },
    "account_type": "trading",
    "trading_configurations": null,
    "enabled_assets": [
        "us_equity",
        "crypto"
    ]
}
```

### Attributes

{{<hint info>}}
**Helpful Hint**

Here we outline a comprehensive overview of a full Account model attributes. To receive such an extended object of an account use [Retrieve An Account (By ID)]({{< relref "#retrieving-an-account-brokerage" >}}), other Account APIs might return a more simplified version of the Account model.
{{</hint>}}

| Attribute         |       Type       | Notes                                                                                            |
| ----------------- | ---------------- | ------------------------------------------------------------------------------------------------ |
| `id`              | string (UUID)    | Account Identifier                                                                               |
| `account_number`  | string           | A human-readable account number that can be shown to the end user           |
| `status`          | string<[ENUM.AccountStatus]({{< relref "#account-status" >}})> | Status of account equity trading                       |
| `crypto_status`   | string<[ENUM.CryptoStatus]({{< relref "#crypto-status" >}})>  | Status of account crypto trading                        |
| `currency`        | string           | Currency associated to account (By default and typically `USD`) |
| `last_equity`     | string           |  End of day (EOD) equity calculation (cash + long market value + short market value) |
| `account_type`    | string <[ENUM.AccountType]({{< relref "#account-type" >}})> | Type of account  |
| `trading_configurations` | object <<[TradingConfigurations]({{< relref "../trading/trading-configurations" >}})>>| Trading configurations associated to account. Field is nullable.    |
| `created_at`      | string <<timestamp>> | Timestamp (RFC3339) of account creation.   |
| `kyc_results`     | object <<KYCResult>>  | KYC results associated to user account  |
| `enabled_assets`  | array<<[ENUM.EnabledAssets]({{< relref "#enabled-assets" >}})>> |Assets the user has enabled and is able to trade once `status` and/or `crypto_status` are ACTIVE |
| `contact`         | object<<[Contact]({{< relref "#contact" >}})>> | Contact information about the user                                                               |
| `identity`        | object <<[Identity]({{< relref "#identity" >}})>> | KYC information about the user                                                                   |
| `disclosures`     | object <<[Disclosures]({{< relref "#disclosures" >}})>> | Required disclosures about the user                                                              |
| `documents`       | array <<[Documents]({{< relref "#documents" >}})>> | Any documents that need to be uploaded (eg. passport, visa, ...)                                 |
| `agreements`      | array <<[Agreements]({{< relref "#agreements" >}})>> | Agreements required to be signed by the user to open their account                                 |
| `trusted_contact` | object<<[TrustedContact]({{< relref "#trusted-contact" >}})>> |The contact information of a trusted contact to the user in case account recovery is needed.     |




#### **Enabled Assets**
| Attribute        | Type                                                      |
| ---------------- | --------------------------------------------------------- |
| `enabled_assets` | array of [ENUM.AssetClass]({{< relref "#asset-class" >}}) |

#### **Contact**

| Attribute        | Type   |
| ---------------- | ------ |
| `email_address`  | string |
| `phone_number`   | string |
| `street_address` | array  |
| `unit`           | string |
| `city`           | string |
| `state`          | string |
| `postal_code`    | string |

#### **Identity**

| Attribute                  | Type                                                            |
| -------------------------- | --------------------------------------------------------------- |
| `given_name`               | string                                                          |
| `middle_name`              | string                                                          |
| `family_name`              | string                                                          |
| `date_of_birth`            | date                                                            |
| `tax_id`                   | string                                                          |
| `tax_id_type`              | [ENUM.TaxIdType]({{< relref "#tax-id-type" >}})                 |
| `country_of_citizenship`   | string                                                          |
| `country_of_birth`         | string                                                          |
| `country_of_tax_residence` | string                                                          |
| `visa_type`                | [ENUM.VisaType]({{< relref "#visa-type" >}})                    |
| `visa_expiration_date`     | date                                                            |
| `date_of_departure_from_usa` | date                                                          |
| `permanent_resident`       | boolean                                                         |
| `funding_source`           | array of [ENUM.FundingSource]({{< relref "#funding-source" >}}) |
| `annual_income_min`        | string/number                                                   |
| `annual_income_max`        | string/number                                                   |
| `liquid_net_worth_min`     | string/number                                                   |
| `liquid_net_worth_max`     | string/number                                                   |
| `total_net_worth_min`      | string/number                                                   |
| `total_net_worth_max`      | string/number                                                   |
| `extra`                    | object                                                          |

#### **Disclosures**

It is your responsibility as the service provider to denote if the account owner falls under each category defined by FINRA rules. We recommend asking these questions at any point of the onboarding process of each account owner in the form of Y/N and Radio Buttons.

| Attribute                         | Type                                                         |
| --------------------------------- | ------------------------------------------------------------ |
| `is_control_person`               | boolean                                                      |
| `is_affiliated_exchange_or_finra` | boolean                                                      |
| `is_politically_exposed`          | boolean                                                      |
| `immediate_family_exposed`        | boolean                                                      |
| `context`                         | DisclosureContext                                                      |
| `employment_status`               | [ENUM.EmploymentStatus]({{< relref "#employment-status" >}}) |
| `employer_name`                   | string                                                       |
| `employer_address`                | string                                                       |
| `employment_position`             | string                                                       |

**Agreements**

In order to comply with Alpaca's terms of service, each account owner must be presented the following agreements.

| Attribute       | Type                                              |
| --------------- | ------------------------------------------------- |
| `[].agreement`  | [ENUM.DocumentType]({{< relref "#agreements" >}}) |
| `[].signed_at`  | string (timestamp)                                |
| `[].ip_address` | string                                            |
| `[].revision`   | string                                            |

#### **Documents**

1. **​`DocumentUpload`**

   This model consists of a series of documents based on the KYC and international taxation requirements. Documents are binary objects whose contents are encoded in base64. Each encoded content size is limited to 10MB if you use Alpaca for KYCaaS. If you perform your own KYC there are no document size limitations. The only exception is the W-8BEN form which we accept in multiple formats.

   | Attribute           | Type                                                 |
   | ------------------- | ---------------------------------------------------- |
   | `document_type`     | [ENUM.DocumentType]({{< relref "#document-type" >}}) |
   | `document_sub_type` | string                                               |
   | `content`           | base64 string                                        |
   | `mime_type`         | string                                               |

2. **`Document`**

   To add an additional document after submission, please use the `Document` model below to replace any `DocumentUpload`

   | Attribute           | Type                                                 |
   | ------------------- | ---------------------------------------------------- |
   | `document_type`     | [ENUM.DocumentType]({{< relref "#document-type" >}}) |
   | `document_sub_type` | string                                               |
   | `id`                | UUID                                                 |
   | `mime_type`         | string                                               |
   | `created_at`        | timestamp string                                     |

#### **Trusted Contact**

This model input is optional. However, the client should make reasonable effort to obtain the trusted contact information. See more details in [FINRA Notice 17-11](https://www.finra.org/sites/default/files/Regulatory-Notice-17-11.pdf)

| Attribute     | Type   | Notes      |
| ------------- | ------ | ---------- |
| `given_name`  | string | First name |
| `family_name` | string | Last name  |

In addition, only one of the following is **required**,

| Attribute        | Type   |
| ---------------- | ------ |
| `email_address`  | string |
| `phone_number`   | string |
| `street_address` | string |
| `city`           | string |
| `state`          | string |
| `postal_code`    | string |
| `country`        | string |

### Enums

#### Asset Class

| Attribute    | Description      |
| ------------ | ---------------- |
| `us_equity`  | U.S. Equities    |
| `crypto`     | Cryptocurrencies |

#### Account Type

| Attribute                  | Description          |
| -------------------------- | -------------------- |
| `trading`                  | Typical brokerage account |
| `custodial`                | Trading account opened on behalf of a minor and ownership will be transferred to the minor when they reach the age of majority |
| `donor_advised`            | Trading account established at a public charity which allows donors to receive tax benefits from their charitable contributions |

#### Tax ID Type

| Attribute       | Description                            |
| --------------- | -------------------------------------- |
| `USA_SSN`       | USA Social Security Number             |
| `ARG_AR_CUIT`   | Argentina CUIT                         |
| `AUS_TFN`       | Australian Tax File Number             |
| `AUS_ABN`       | Australian Business Number             |
| `BOL_NIT`       | Bolivia NIT                            |
| `BRA_CPF`       | Brazil CPF                             |
| `CHL_RUT`       | Chile RUT                              |
| `COL_NIT`       | Colombia NIT                           |
| `CRI_NITE`      | Costa Rica NITE                        |
| `DEU_TAX_ID`    | Germany Tax ID (Identifikationsnummer) |
| `DOM_RNC`       | Dominican Republic RNC                 |
| `ECU_RUC`       | Ecuador RUC                            |
| `FRA_SPI`       | France SPI (Reference Tax Number)      |
| `GBR_UTR`       | UK UTR (Unique Taxpayer Reference)     |
| `GBR_NINO`      | UK NINO (National Insurance Number)    |
| `GTM_NIT`       | Guatemala NIT                          |
| `HND_RTN`       | Honduras RTN                           |
| `HUN_TIN`       | Hungary TIN Number                     |
| `IDN_KTP`       | Indonesia KTP                          |
| `IND_PAN`       | India PAN Number                       |
| `ISR_TAX_ID`    | Israel Tax ID (Teudat Zehut)           |
| `ITA_TAX_ID`    | Italy Tax ID (Codice Fiscale)          |
| `JPN_TAX_ID`    | Japan Tax ID (Koijin Bango)            |
| `MEX_RFC`       | Mexico RFC                             |
| `NIC_RUC`       | Nicaragua RUC                          |
| `NLD_TIN`       | Netherlands TIN Number                 |
| `PAN_RUC`       | Panama RUC                             |
| `PER_RUC`       | Peru RUC                               |
| `PRY_RUC`       | Paraguay RUC                           |
| `SGP_NRIC`      | Singapore NRIC                         |
| `SGP_FIN`       | Singapore FIN                          |
| `SGP_ASGD`      | Singapore ASGD                         |
| `SGP_ITR`       | Singapore ITR                          |
| `SLV_NIT`       | El Salvador NIT                        |
| `SWE_TAX_ID`    | Sweden Tax ID (Personnummer)           |
| `URY_RUT`       | Uruguay RUT                            |
| `VEN_RIF`       | Venezuela RIF                          |
| `NOT_SPECIFIED` | Other Tax IDs                          |

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

#### Visa Type
In addition to the following USA visa categories, we accept any sub visas of the list below. Sub visas must be passed in according to their parent category. Note that United States green card holders are considered permanent residents and should not pass in a visa type. 

| Attribute | Description                 |
|-----------|-----------------------------|
| `B1`      | USA Visa Category B-1       |
| `B2`      | USA Visa Category B-2       |
| `DACA`    | USA Visa Category DACA      |
| `E1`      | USA Visa Category E-1       |
| `E2`      | USA Visa Category E-2       |
| `E3`      | USA Visa Category E-3       |
| `F1`      | USA Visa Category F-1       |
| `G4`      | USA Visa Category G-4       |
| `H1B`     | USA Visa Category H-1B      |
| `J1`      | USA Visa Category J-1       |
| `L1`      | USA Visa Category L-1       |
| `OTHER`   | Any other USA Visa Category |
| `O1`      | USA Visa Category O-1       |
| `TN1`     | USA Visa Category TN-1      |


#### Employment Status

| Attribute    | Description |
| ------------ | ----------- |
| `unemployed` | Unemployed  |
| `employed`   | Employed    |
| `student`    | Student     |
| `retired`    | Retired     |

#### Context Type

| Attribute                     | Description                                                                         |
| ----------------------------- | ----------------------------------------------------------------------------------- |
| `CONTROLLED_FIRM`             | Controlled firm. Recommened to use when `is_control_person = true`                  |
| `AFFILIATE_FIRM`              | Affiliated firm. Recommened to use when `is_affiliated_exchange_or_finra = true`    |
| `IMMEDIATE_FAMILY_EXPOSED`    | Immediate family exposed. Recommended to use when `immediate_family_exposed = true` |

#### Agreements

| Attribute            | Description        |
| -------------------- | ------------------ |
| `margin_agreement`   | Margin agreement   |
| `account_agreement`  | Account agreement  |
| `customer_agreement` | Customer agreement |
| `crypto_agreement`   | Crypto agreement   |

#### Document Type

| Attribute                    | Description                |
| ---------------------------- | -------------------------- |
| `identity_verification`      | Identity verification      |
| `address_verification`       | Address verification       |
| `date_of_birth_verification` | Date of birth verification |
| `tax_id_verification`        | Tax ID verification        |
| `account_approval_letter`    | 407 approval letter        |
| `w8ben`                      | W-8 BEN tax form           |

#### Account Status

| Attribute           | Description                                                                                   |
| ------------------- | --------------------------------------------------------------------------------------------- |
| `INACTIVE`          | Account not enabled to trade equities                                                         |
| `ONBOARDING`        | The account has been created but we haven't performed KYC yet. This is only used with Onfido. |
| `SUBMITTED`         | Application has been submitted and in process of review                                       |
| `ACTION_REQUIRED`   | Application requires manual action                                                            |
| `EDITED`            | Application was edited (e.g. to match info from uploaded docs). This is a transient status.   |
| `APPROVAL_PENDING`  | Initial value. Application approval process is in process                                     |
| `APPROVED`          | Account application has been approved, waiting to be `ACTIVE`                                 |
| `REJECTED`          | Account application is rejected                                                               |
| `ACTIVE`            | Equities account is fully active and can start trading                                        |
| `SUBMISSION_FAILED` | Account submissions has failed                                                                |
| `DISABLED`          | Account is disabled, comes after `ACTIVE`                                                     |
| `ACCOUNT_CLOSED`    | Account is closed                                                                             |

#### Crypto Status

| Attribute           | Description                                                                                   |
|---------------------|-----------------------------------------------------------------------------------------------|
| `INACTIVE`          | Account not enabled to trade crypto                                                      |
| `ONBOARDING`        | The account has been created but we haven't performed KYC yet. This is only used with Onfido. |
| `SUBMITTED`         | Application has been submitted and in process of review                                       |
| `ACTION_REQUIRED`   | Application requires manual action                                                            |
| `EDITED`            | Application was edited (e.g. to match info from uploaded docs). This is a transient status.   |
| `APPROVAL_PENDING`  | Initial value. Application approval process is in process                                     |
| `APPROVED`          | Account application has been approved, waiting to be `ACTIVE`                                 |
| `REJECTED`          | Account application is rejected                                                               |
| `ACTIVE`            | Crypto account is active and can start trading                                                |
| `SUBMISSION_FAILED` | Account submissions has failed                                                                |
| `DISABLED`          | Account is disabled, comes after `ACTIVE`                                                     |
| `ACCOUNT_CLOSED`    | Account is closed                                                                             |


---

## Fixtures

Accounts API supports fixtures in Sandbox Environment. You can pass the desired account status in the optional parameter `additional_information` when creating an account. Note that this parameter is not listed above in the account model as it is only to be used in the Sandbox Environment for testing purposes.

| Attribute          | Description                                   |
| ------------------ | --------------------------------------------- |
| `SUBMITTED`        | `/fixtures/status=SUBMITTED/fixtures/`        |
| `ACTION_REQUIRED`  | `/fixtures/status=ACTION_REQUIRED/fixtures/`  |
| `APPROVAL_PENDING` | `/fixtures/status=APPROVAL_PENDING/fixtures/` |
| `APPROVED`         | `/fixtures/status=APPROVED/fixtures/`         |
| `REJECTED`         | `/fixtures/status=REJECTED/fixtures/`         |
| `ACTIVE`           | `/fixtures/status=ACTIVE/fixtures/`           |
| `DISABLED`         | `/fixtures/status=DISABLED/fixtures/`         |
| `ACCOUNT_CLOSED`   | `/fixtures/status=ACCOUNT_CLOSED/fixtures/`   |

#### Sample Fixture

Simulating a rejected account. 

```json
{
  "additional_information": "/fixtures/status=REJECTED/fixtures/"
}
```

---

## **Creating an Account**

`POST /v1/accounts`

Submit an account application with KYC information. This will create a trading account for the end user. The account status may or may not be ACTIVE immediately and you will receive account status updates on the event API.

### Request

##### Sample Request Model

```json
{
  "enabled_assets": ["us_equity", "crypto"],
  "contact": {
    "email_address": "cool_alpaca@example.com",
    "phone_number": "555-666-7788",
    "street_address": ["20 N San Mateo Dr"],
    "unit": "Apt 1A",
    "city": "San Mateo",
    "state": "CA",
    "postal_code": "94401",
    "country": "USA"
  },
  "identity": {
    "given_name": "John",
    "middle_name": "Smith",
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
    "is_affiliated_exchange_or_finra": true,
    "is_politically_exposed": false,
    "immediate_family_exposed": false,
    "context": [
      {
        "context_type": "AFFILIATE_FIRM",
        "company_name": "Finra",
        "company_street_address": ["1735 K Street, NW"],
        "company_city": "Washington",
        "company_state": "DC",
        "company_country": "USA",
        "company_compliance_email": "compliance@finra.org"
      }
    ]
  },
  "agreements": [
    {
      "agreement": "customer_agreement",
      "signed_at": "2020-09-11T18:13:44Z",
      "ip_address": "185.13.21.99",
      "revision": "19.2022.02"
    },
    {
      "agreement": "crypto_agreement",
      "signed_at": "2020-09-11T18:13:44Z",
      "ip_address": "185.13.21.99",
      "revision": "04.2021.10"
    }
  ],
  "documents": [
    {
      "document_type": "identity_verification",
      "document_sub_type": "passport",
      "content": "/9j/Cg==",
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
| `enabled_assets`  | {{<hint info>}}Optional {{</hint>}}   |
| `contact`         | {{<hint danger>}}Required {{</hint>}} |
| `identity`        | {{<hint danger>}}Required {{</hint>}} |
| `disclosures`     | {{<hint danger>}}Required {{</hint>}} |
| `documents`       | {{<hint info>}}Optional {{</hint>}}   |
| `trusted_contact` | {{<hint info>}}Optional {{</hint>}}   |

**Enabled Assets**
| Attribute        | Type                                                        | Requirement                           | Notes                                                                                         |
| ---------------- | ----------------------------------------------------------- | ------------------------------------- | --------------------------------------------------------------------------------------------- |
| `enabled_assets` | array of [ENUM.AssetClass]({{< relref "#asset-class" >}})   | {{<hint info>}}Optional {{</hint>}}   | Will default to `us_equity`. Alpaca has the ability to update the default value upon request. |

**Contact**

| Attribute        | Type   | Requirement                           | Notes                                                                                                  |
| ---------------- | ------ | ------------------------------------- |--------------------------------------------------------------------------------------------------------|
| `email_address`  | string | {{<hint danger>}}Required {{</hint>}} |                                                                                                        |
| `phone_number`   | string | {{<hint danger>}}Required {{</hint>}} | _Phone number should include the country code, format: "+15555555555"_                                 |
| `street_address` | string | {{<hint danger>}}Required {{</hint>}} |                                                                                                        |
| `unit`           | string | {{<hint info>}}Optional {{</hint>}}   |                                                                                                        |
| `city`           | string | {{<hint danger>}}Required {{</hint>}} |                                                                                                        |
| `state`          | string | {{<hint info>}}Optional{{</hint>}}    | {{<hint danger>}}required if `country_of_tax_residence` in identity model (below) is ‘USA’ {{</hint>}} |
| `postal_code`    | string | {{<hint info>}}Optional {{</hint>}}   |                                                                                                        |

**Identity**

| Attribute                  | Type                                                   | Requirement                           | Notes                                            |
| -------------------------- | ------------------------------------------------------ | ------------------------------------- | ------------------------------------------------ |
| `given_name`               | string                                                 | {{<hint danger>}}Required {{</hint>}} |                                                  |
| `middle_name`              | string                                                 | {{<hint info>}}Optional {{</hint>}}   |                                                  |
| `family_name`              | string                                                 | {{<hint danger>}}Required {{</hint>}} |                                                  |
| `date_of_birth`            | date                                                   | {{<hint danger>}}Required {{</hint>}} |                                                  |
| `tax_id`                   | string                                                 | {{<hint info>}}Optional {{</hint>}}   | Required if `tax_id_type` is set.                |
| `tax_id_type`              | [ENUM.TaxIdType]({{< relref "#tax-id-type" >}})        | {{<hint info>}}Optional {{</hint>}}   | Required if `tax_id` is set.                     |
| `country_of_citizenship`   | string                                                 | {{<hint info>}}Optional {{</hint>}}   | 3 letter country code acceptable                 |
| `country_of_birth`         | string                                                 | {{<hint info>}}Optional {{</hint>}}   | 3 letter country code acceptable                 |
| `country_of_tax_residence` | string                                                 | {{<hint danger>}}Required {{</hint>}} | 3 letter country code acceptable                 |
| `visa_type`                | [ENUM.VisaType]({{< relref "#visa-type" >}})           | {{<hint info>}}Optional {{</hint>}}   | Only used to collect visa types for users residing in the USA. |
| `visa_expiration_date`     | date                                                   | {{<hint info>}}Optional {{</hint>}}   | Required if `visa_type` is set.                  |
| `date_of_departure_from_usa` | date                                                 | {{<hint info>}}Optional {{</hint>}}   | Required if `visa_type` = `B1` or `B2`           |
| `permanent_resident`       | boolean                                                | {{<hint info>}}Optional {{</hint>}}   | Only used to collect permanent residence status in the USA. |
| `funding_source`           | [ENUM.FundingSource]({{< relref "#funding-source" >}}) | {{<hint danger>}}Required {{</hint>}} |                                                  |
| `annual_income_min`        | string/number                                          | {{<hint info>}}Optional {{</hint>}}   |                                                  |
| `annual_income_max`        | string/number                                          | {{<hint info>}}Optional {{</hint>}}   |                                                  |
| `liquid_net_worth_min`     | string/number                                          | {{<hint info>}}Optional {{</hint>}}   |                                                  |
| `liquid_net_worth_max`     | string/number                                          | {{<hint info>}}Optional {{</hint>}}   |                                                  |
| `total_net_worth_min`      | string/number                                          | {{<hint info>}}Optional {{</hint>}}   |                                                  |
| `total_net_worth_max`      | string/number                                          | {{<hint info>}}Optional {{</hint>}}   |                                                  |
| `extra`                    | object                                                 | {{<hint info>}}Optional {{</hint>}}   | Any additional information used for KYC purposes |

**Disclosures**

It is your responsibility as the service provider to denote if the account owner falls under each category defined by FINRA rules. We recommend asking these questions at any point of the onboarding process of each account owner in the form of Y/N and Radio Buttons.

| Attribute                         | Type                                                         | Requirement                           | Notes                                                                                                                                                                 |
| --------------------------------- | ------------------------------------------------------------ | ------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `is_control_person`               | boolean                                                      | {{<hint danger>}}Required {{</hint>}} | Whether user holds a controlling position in a publicly traded company, member of the board of directors or has policy making abilities in a publicly traded company. |
| `is_affiliated_exchange_or_finra` | boolean                                                      | {{<hint danger>}}Required {{</hint>}} |                                                                                                                                                                       |
| `is_politically_exposed`          | boolean                                                      | {{<hint danger>}}Required {{</hint>}} |                                                                                                                                                                       |
| `immediate_family_exposed`        | boolean                                                      | {{<hint danger>}}Required {{</hint>}} | If your user’s immediate family member (sibling, husband/wife, child, parent) is either politically exposed or holds a control position.                              |
| `context`                         | DisclosureContext                                                       | {{<hint info>}}Optional {{</hint>}}   | Information relevant to the user's disclosure selection should be sent through this object.                                                                           |
| `employment_status`               | [ENUM.EmploymentStatus]({{< relref "#employment-status" >}}) | {{<hint info>}}Optional {{</hint>}}   |                                                                                                                                                                       |
| `employer_name`                   | string                                                       | {{<hint info>}}Optional {{</hint>}}   |                                                                                                                                                                       |
| `employer_address`                | string                                                       | {{<hint info>}}Optional {{</hint>}}   |                                                                                                                                                                       |
| `employment_position`             | string                                                       | {{<hint info>}}Optional {{</hint>}}   |                                                                                                                                                                       |

**DisclosureContext**

If you utilize Alpaca for KYCaaS, additional information will need to be submitted if the user identifies with any of the disclosures before the account can be approved. This information can be sent through the context object to speed up the time to approve their account.

| Attribute                  | Type                                               | Requirement                                                                                     | Notes                               |
| -------------------------- | -------------------------------------------------- | ----------------------------------------------------------------------------------------------- | ----------------------------------- |
| `context_type`             | [ENUM.ContextType]({{< relref "#context-type" >}}) | {{<hint danger>}}Required {{</hint>}}                                                           |                                     |
| `company_name`             | string                                             | {{<hint danger>}}Required {{</hint>}} if `context_type` = `AFFILIATE_FIRM` or `CONTROLLED_FIRM` |                                     |
| `company_street_address`   | string                                             | {{<hint danger>}}Required {{</hint>}} if `context_type` = `AFFILIATE_FIRM` or `CONTROLLED_FIRM` |                                     |
| `company_city`             | string                                             | {{<hint danger>}}Required {{</hint>}} if `context_type` = `AFFILIATE_FIRM` or `CONTROLLED_FIRM` |                                     |
| `company_state`            | string                                             | {{<hint danger>}}Required {{</hint>}} if `company_country` = `USA`                              |                                     |
| `company_country`          | string                                             | {{<hint danger>}}Required {{</hint>}} if `context_type` = `AFFILIATE_FIRM` or `CONTROLLED_FIRM` |                                     |
| `company_compliance_email` | string                                             | {{<hint danger>}}Required {{</hint>}} if `context_type` = `AFFILIATE_FIRM` or `CONTROLLED_FIRM` |                                     |
| `given_name`               | string                                             | {{<hint danger>}}Required {{</hint>}} if `context_type` = `IMMEDIATE_FAMILY_EXPOSED`            |                                     |
| `family_name`              | string                                             | {{<hint danger>}}Required {{</hint>}} if `context_type` = `IMMEDIATE_FAMILY_EXPOSED`            |                                     |

**Agreements**

In order to comply with Alpaca's terms of service, each account owner must be presented the following agreements.

| Attribute       | Type                                              | Requirement                           |
| --------------- | ------------------------------------------------- | ------------------------------------- |
| `[].agreement`  | [ENUM.DocumentType]({{< relref "#agreements" >}}) | {{<hint danger>}}Required {{</hint>}} |
| `[].signed_at`  | string (timestamp)                                | {{<hint danger>}}Required {{</hint>}} |
| `[].ip_address` | string                                            | {{<hint danger>}}Required {{</hint>}} |
| `[].revision`   | string                                            | {{<hint danger>}}Optional {{</hint>}} |

**Documents**

1. **​`DocumentUpload`**

   This model consists of a series of documents based on the KYC requirements. Documents are binary objects whose contents are encoded in base64. Each encoded content size is limited to 10MB if you use Alpaca for KYCaaS. If you perform your own KYC there are no document size limitations.

   | Attribute           | Type                                                 | Required                              |
   | ------------------- | ---------------------------------------------------- | ------------------------------------- |
   | `document_type`     | [ENUM.DocumentType]({{< relref "#document-type" >}}) | {{<hint danger>}}Required{{</hint>}}  |
   | `document_sub_type` | string                                               | {{<hint info>}}Optional {{</hint>}}   |
   | `content`           | base64 string                                        | {{<hint danger>}}Required {{</hint>}} |
   | `mime_type`         | string                                               | {{<hint danger>}}Required {{</hint>}} |

2. **`Document`**

   To add an additional document after submission, please use the `Document` model below to replace any `DocumentUpload`

   | Attribute           | Type                                                 | Required                             |
   | ------------------- | ---------------------------------------------------- | ------------------------------------ |
   | `document_type`     | [ENUM.DocumentType]({{< relref "#document-type" >}}) | {{<hint danger>}}Required{{</hint>}} |
   | `document_sub_type` | string                                               | {{<hint info>}}Optional {{</hint>}}  |
   | `id`                | UUID                                                 | {{<hint danger>}}Required{{</hint>}} |
   | `mime_type`         | string                                               | {{<hint danger>}}Required{{</hint>}} |
   | `created_at`        | timestamp string                                     | {{<hint danger>}}Required{{</hint>}} |

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

| Attribute        | Type               | Notes                                                                  |
| ---------------- | ------------------ | ---------------------------------------------------------------------- |
| `id`             | UUID               | UUID that identifies the account for later reference                   |
| `account_number` | string             | A human-readable account number that can be shown to the end user      |
| `account_type`    | string <[ENUM.AccountType]({{< relref "#account-type" >}})> | Type of account  |
| `status`         | enum.AccountStatus | [ENUM.AccountStatus]({{< relref "#account-status" >}})                 |
| `crypto_status`         | enum.CryptoStatus | [ENUM.CryptoStatus]({{< relref "#crypto-status" >}})                 |
| `currency`       | string             | Always USD                                                             |
| `last_equity`    | string             | EOD equity calculation (cash + long market value + short market value) |
| `created_at`      | string <<timestamp>> | Timestamp (RFC3339) of account creation.   |
| `enabled_assets`  | array<<[ENUM.EnabledAssets]({{< relref "#enabled-assets" >}})>> |Assets the user has enabled and is able to trade once `status` and/or `crypto_status` are ACTIVE |
| `contact`         | object<<[Contact]({{< relref "#contact" >}})>> | Contact information about the user                                                               |
| `identity`        | object <<[Identity]({{< relref "#identity" >}})>> | KYC information about the user                                                                   |
| `disclosures`     | object <<[Disclosures]({{< relref "#disclosures" >}})>> | Required disclosures about the user                                                              |
| `documents`       | array <<[Documents]({{< relref "#documents" >}})>> | Any documents that need to be uploaded (eg. passport, visa, ...)                                 |
| `agreements`      | array <<[Agreements]({{< relref "#agreements" >}})>> | Agreements required to be signed by the user to open their account                           |
| `trusted_contact` | object<<[TrustedContact]({{< relref "#trusted-contact" >}})>> |The contact information of a trusted contact to the user in case account recovery is needed.     |

#### Sample Response Body

```json
{
    "id": "de9d0029-e0a0-4a2f-b630-265a32dd00c4",
    "account_number": "808333970",
    "status": "SUBMITTED",
    "crypto_status": "SUBMITTED",
    "currency": "USD",
    "last_equity": "0",
    "created_at": "2022-08-16T20:36:07.514367Z",
    "contact": {
        "email_address": "cool_alpacaa@example.com",
        "phone_number": "555-666-7788",
        "street_address": [
            "20 N San Mateo Dr"
        ],
        "unit": "Apt 1A",
        "city": "San Mateo",
        "state": "CA",
        "postal_code": "94401"
    },
    "identity": {
        "given_name": "John",
        "family_name": "Doe",
        "middle_name": "Smith",
        "date_of_birth": "1990-01-01",
        "tax_id_type": "USA_SSN",
        "country_of_citizenship": "USA",
        "country_of_birth": "USA",
        "country_of_tax_residence": "USA",
        "funding_source": [
            "employment_income"
        ],
        "visa_type": null,
        "visa_expiration_date": null,
        "date_of_departure_from_usa": null,
        "permanent_resident": null
    },
    "disclosures": {
        "is_control_person": false,
        "is_affiliated_exchange_or_finra": true,
        "is_politically_exposed": false,
        "immediate_family_exposed": false,
        "is_discretionary": false
    },
    "agreements": [
      {
        "agreement": "customer_agreement",
        "signed_at": "2020-09-11T18:13:44Z",
        "ip_address": "185.13.21.99",
        "revision": "19.2022.02"
      },
      {
        "agreement": "crypto_agreement",
        "signed_at": "2020-09-11T18:13:44Z",
        "ip_address": "185.13.21.99",
        "revision": "04.2021.10"
      }
    ],
    "trusted_contact": {
        "given_name": "Jane",
        "family_name": "Doe",
        "email_address": "jane.doe@example.com"
    },
    "account_type": "trading",
    "trading_configurations": null,
    "enabled_assets": [
        "us_equity",
        "crypto"
    ]
}
```

#### Error Codes

{{<hint warning>}}
400 - Bad Request

​ _The body in the request is not valid_
{{</hint>}}

{{<hint warning>}}
409 - Conflict

​ _There is already an existing account registered with the same email address._
{{</hint>}}

{{<hint warning>}}
422 - Unprocessable Entity

​ _Invalid input value._
{{</hint>}}

{{<hint warning>}}
500 - Internal Server Error​

_Some server error occurred. Please contact Alpaca._
{{</hint>}}

---

## **Retrieving an Onfido SDK Token**
`GET /v1/accounts/{account_id}/onfido/sdk/tokens/`

Get an SDK token to activate the [Onfido SDK](/docs/api-references/broker-api/#onfido-sdk-integration) flow within your app. You will have to keep track of the SDK token so you can pass it back when you upload the SDK outcome. We recommend storing the token in memory rather than persistent storage to reduce any unnecessary overhead in your app.

### Request

#### Parameters

| Attribute  | Type               | Requirement                         | Notes                                                                                                                          |
|------------|--------------------|-------------------------------------|--------------------------------------------------------------------------------------------------------------------------------|
| `referrer` | URI encoded string | {{<hint info>}}Optional {{</hint>}} | The referrer URL of your web app or the application ID of your mobile app. If not passed in, will default to the `*` wildcard  |
| `platform` | ENUM.Platform      | {{<hint info>}}Optional {{</hint>}} | Required if `referrer` provided. Enum values are either `mobile` or `web`                                                        |

### Response
```json
{
  "token": "header.payload.signature"
}
```

#### Error Codes

{{<hint warning>}}
422 - Unprocessable Entity

​ _Onfido applicant not yet created for account. If you haven't already contacted Alapca to enable Onfido, please do so._
{{</hint>}}

{{<hint warning>}}
500 - Internal Server Error​

_Some server error occurred. Please contact Alpaca._
{{</hint>}}

---

## **Updating the Onfido SDK Outcome**
`PATCH /v1/accounts/{account_id}/onfido/sdk/`

This request allows you to send Alpaca the result of the Onfido SDK flow in your app. A notification of a successful outcome is required for Alpaca to continue the KYC process.

### Request

#### Sample Request Body
```json
{
  "outcome": "USER_EXITED",
  "reason": "User denied consent",
  "token": "header.payload.signature"
}
```

#### Parameters

| Attribute | Type         | Requirement                         | Notes                                                                        |
|-----------|--------------|-------------------------------------|------------------------------------------------------------------------------|
| `outcome` | ENUM.Outcome | {{<hint danger>}}Required {{</hint>}} | The result of the SDK flow                                                   |
| `reason`  | string       | {{<hint info>}}Optional {{</hint>}} | Any additional information related to the outcome                            |
| `token`   | string/JWT   | {{<hint danger>}}Required {{</hint>}} | The SDK token associated with the SDK flow you are updating the outcome for  |

#### Enums

##### Outcome

| Attribute        | Description                                                                                              |
|------------------|----------------------------------------------------------------------------------------------------------|
| `NOT_STARTED`    | The user has not started the SDK flow yet. `outcome` is set to this default value upon token generation  |
| `USER_EXITED`    | The user exited the SDK flow                                                                             |
| `SDK_ERROR`      | An error occurred in the SDK flow                                                                        |
| `USER_COMPLETED` | The user completed the SDK flow                                                                          |

### Response
If all parameters are valid and updates have been made, it returns with status code 200.

#### Error Codes

{{<hint warning>}}
404 - Account Not Found​

{{</hint>}}

{{<hint warning>}}
422 - Unprocessable Entity

​ _Invalid input value for outcome._
{{</hint>}}

{{<hint warning>}}
500 - Internal Server Error​

_Some server error occurred. Please contact Alpaca._
{{</hint>}}

--- 

## **Uploading CIP information**

`POST /v1/accounts/{account_id}/cip`

The customer identification program (CIP) API allows you to submit the CIP results received from your KYC provider.

Financial institutions and other obliged entities must have reasonable procedures to gather and maintain information on customers’ identities, along with running watchlist checks on them.

The minimum requirements to open an individual financial account are delimited and you must verify the true identity of the account holder at account opening:

- Name
- Date of birth
- Address
- Identification number (for a U.S. citizen, a taxpayer identification number)

Procedures for identity verification include documents (for example, driver’s licenses and passports), non-documentary methods (for example, data sources like credit bureaus and government databases), or a combination of both.

### Request

#### Sample Request Body

```json
{
  "provider_name": ["onfido"],
  "kyc": {
    "id": "CBDAD1C4-1047-450E-BAE5-B6C406F509B4",
    "risk_level": "LOW",
    "applicant_name": "John Doe",
    "email_address": "johndoe@example.com",
    "nationality": "American",
    "id_number": "jd0000123456789",
    "date_of_birth": "1970-12-01",
    "address": "42 Faux St",
    "postal_code": "94401",
    "country_of_residency": "USA",
    "kyc_completed_at": "2021-06-10T15:37:03Z",
    "ip_address": "127.0.0.1",
    "check_initiated_at": "2021-06-10T15:37:03Z",
    "check_completed_at": "2021-06-10T15:37:03Z",
    "approval_status": "approved",
    "approved_by": "Jane Doe",
    "approved_at": "2021-06-10T15:38:03Z"
  },
  "document": {
    "id": "55B9931A-3BE6-4BC0-9BDD-0B954E4A4632",
    "result": "clear",
    "status": "complete",
    "created_at": "2021-06-10T15:37:03Z",
    "image_integrity": "clear"
  },
  "photo": {
    "id": "0DD13020-F0FD-4B5A-B58F-BC1885E90A6D",
    "result": "clear",
    "status": "complete",
    "created_at": "2021-06-10T15:37:03Z",
    "face_comparison": "clear"
  },
  "identity": {
    "id": "28E1CCE8-1B1A-4472-9AD4-C6C5B7C3A6AF",
    "result": "clear",
    "status": "complete",
    "created_at": "2021-06-10T15:37:03Z",
    "sources": "clear",
    "address": "clear",
    "date_of_birth": "clear"
  },
  "watchlist": {
    "id": "7572B870-EB4C-46A2-8B88-509194CCEE7E",
    "result": "clear",
    "status": "complete",
    "created_at": "2021-06-10T15:37:03Z",
    "politically_exposed_person": "clear",
    "sanction": "clear",
    "adverse_media": "clear",
    "monitored_lists": "clear"
  }
}
```

#### Parameters

| Attribute   | Requirement                         |
| ----------- | ----------------------------------- |
| `provider`  | {{<hint info>}}Optional {{</hint>}} |
| `kyc`       | {{<hint info>}}Optional {{</hint>}} |
| `document`  | {{<hint info>}}Optional {{</hint>}} |
| `photo`     | {{<hint info>}}Optional {{</hint>}} |
| `identity`  | {{<hint info>}}Optional {{</hint>}} |
| `watchlist` | {{<hint info>}}Optional {{</hint>}} |

**KYC**

| Attribute              | Type                   | Notes                                                                |
| ---------------------- | ---------------------- | -------------------------------------------------------------------- |
| `id`                   | string/UUID            | Your internal ID of check                                            |
| `risk_score`           | int                    | Overall risk score returned by KYC provider or assessed              |
| `risk_level`           | string                 | Overall risk level returned by KYC provider or assessed              |
| `risk_categories`      | string                 | The list of risk categories returned by the KYC provider or assessed |
| `applicant_name`       | string                 | Given and family name of applicant                                   |
| `email_address`        | string                 |                                                                      |
| `nationality`          | string                 |                                                                      |
| `id_number`            | string                 | Government issued ID number of applicant                             |
| `date_of_birth`        | date                   |                                                                      |
| `address`              | string                 | Concatenated street address, city, state and country of applicant    |
| `postal_code`          | string                 |                                                                      |
| `country_of_residency` | string                 |                                                                      |
| `kyc_completed_at`     | timestamp              |                                                                      |
| `ip_address`           | string                 |                                                                      |
| `check_initiated_at`   | timestamp              |                                                                      |
| `check_completed_at`   | timestamp              |                                                                      |
| `approval_status`      | enum.CIPApprovalStatus | ENUM: `approved` or `rejected`                                       |
| `approved_by`          | string                 |                                                                      |
| `approved_reason`      | string                 |                                                                      |
| `approved_at`          | timestamp              |                                                                      |

**Document**

| Attribute                   | Type           | Notes                                                                                                                                                                                                                                                                                              |
| --------------------------- | -------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `id`                        | string/UUID    | Your internal ID of check                                                                                                                                                                                                                                                                          |
| `result`                    | enum.CIPResult | Overall result of specific check                                                                                                                                                                                                                                                                   |
| `status`                    | enum.CIPStatus | Overall status of specific check                                                                                                                                                                                                                                                                   |
| `created_at`                | timestamp      |                                                                                                                                                                                                                                                                                                    |
| `date_of_birth`             | date           |                                                                                                                                                                                                                                                                                                    |
| `date_of_expiry`            | date           |                                                                                                                                                                                                                                                                                                    |
| `document_numbers`          | array          | Number of the document that was checked                                                                                                                                                                                                                                                            |
| `document_type`             | string         | Type of the document that was checked                                                                                                                                                                                                                                                              |
| `first_name`                | string         | First name extracted from the document                                                                                                                                                                                                                                                             |
| `last_name`                 | string         | Last name extracted from the document                                                                                                                                                                                                                                                              |
| `gender`                    | string         |                                                                                                                                                                                                                                                                                                    |
| `issuing_country`           | string         |                                                                                                                                                                                                                                                                                                    |
| `nationality`               | string         |                                                                                                                                                                                                                                                                                                    |
| `age_validation`            | enum.CIPResult | Checks whether the age calculated from the document’s date of birth data point is greater than or equal to the minimum accepted age set at account level                                                                                                                                           |
| `compromised_document`      | enum.CIPResult | Checks whether the image of the document has been found in our internal database of compromised documents                                                                                                                                                                                          |
| `police_record `            | enum.CIPStatus | Checks whether the document has been identified as lost, stolen or otherwise compromised                                                                                                                                                                                                           |
| `data_comparison`           | enum.CIPResult | Checks whether data on the document is consistent with data provided when creating an applicant through the API                                                                                                                                                                                    |
| `data_comparison_breakdown` | object         | example: {"date_of_birth": "clear", "date_of_expiry": "clear" "document_numbers": "clear", "document_type": "clear", "first_name": "clear", "gender": "clear", "issuing_country": "clear", "last_name": "clear"}                                                                                   |
| `image_integrity`           | enum.CIPResult | Checks whether the document was of sufficient quality to verify                                                                                                                                                                                                                                    |
| `image_integrity_breakdown` | object         | example: {"colour_picture": "clear", "conclusive_document_quality": "clear", "image_quality": "clear", "supported_document": "clear"}                                                                                                                                                              |
| `visual_authenticity`       | object         | Checks whether visual (non-textual) elements are correct given the document type. Example: {"digital_tampering": "clear", "face_detection": "clear", "fonts": "clear", "original_document_present": "clear", "picture_face_integrity": "clear", "security_features": "clear", "template": "clear"} |

**Photo**

| Attribute                       | Type           | Notes                                                                                                       |
| ------------------------------- | -------------- | ----------------------------------------------------------------------------------------------------------- |
| `id`                            | string/UUID    | Your internal ID of check                                                                                   |
| `result`                        | enum.CIPResult | Overall result of specific check                                                                            |
| `status`                        | enum.CIPStatus | Overall status of specific check                                                                            |
| `created_at`                    | timestamp      |                                                                                                             |
| `face_comparison`               | enum.CIPResult | Checks whether the face in the document matches the face in the live photo                                  |
| `face_comparison_breakdown`     | object         | {"face_match":{"result": "clear","properties":{"score": "80"}}}                                             |
| `image_integrity`               | enum.CIPResult | Checks whether the quality and integrity of the uploaded files were sufficient to perform a face comparison |
| `image_integrity_breakdown`     | string         | example: {"face_detected":{"result": "clear"},"source_integrity": {"result": "clear"}}                      |
| `visual_authenticity`           | enum.CIPResult | Checks whether the person in the live photo is real (not a spoof)                                           |
| `visual_authenticity_breakdown` | string         | {"spoofing_detection": {"result": "clear","properties": {"score": "26"}}}}                                  |

**Identity**

| Attribute                 | Type           | Notes                                                                                          |
| ------------------------- | -------------- | ---------------------------------------------------------------------------------------------- |
| `id`                      | string/UUID    | Your internal ID of check                                                                      |
| `result`                  | enum.CIPResult | Overall result of specific check                                                               |
| `status`                  | enum.CIPStatus | Overall status of specific check                                                               |
| `created_at`              | timestamp      |                                                                                                |
| `matched_address`         | enum.CIPResult | Represents the matched address for the applicant                                               |
| `matched_addresses`       | object         | example: [{"id": "19099121","match_types":["credit_agencies","voting_register"]}]              |
| `sources`                 | enum.CIPResult | Shows the total number of sources found for applicant's identity                               |
| `sources_breakdown`       | object         | example: {"total_sources": {"result": "clear","properties": {"total_number_of_sources": "3"}}} |
| `address`                 | enum.CIPResult | Result if it was cleared against a data source                                                 |
| `address_breakdown`       | object         | example: {"credit_agencies": {"result": "clear","properties":{"number_of_matches":"1"}}        |
| `date_of_birth`           | enum.CIPResult | Result if it was cleared against a data source                                                 |
| `date_of_birth_breakdown` | object         | example: {"credit_agencies":{"result": "clear","properties": {"number_of_matches": "1"}}       |

**Watchlist**

| Attribute                    | Type           | Notes                            |
| ---------------------------- | -------------- | -------------------------------- |
| `id`                         | string/UUID    | Your internal ID of check        |
| `result`                     | enum.CIPResult | Overall result of specific check |
| `status`                     | enum.CIPStatus | Overall status of specific check |
| `created_at`                 | timestamp      |                                  |
| `records`                    | object         | [{"text": "Record info"}]        |
| `politically_exposed_person` | enum.CIPResult |                                  |
| `sanction`                   | enum.CIPResult |                                  |
| `adverse_media`              | enum.CIPResult |                                  |
| `monitored_lists`            | enum.CIPResult |                                  |

### Enums

#### CIP Result

| Attribute  | Description                                                                              |
| ---------- | ---------------------------------------------------------------------------------------- |
| `clear`    | If all underlying verifications pass, the result is clear                                |
| `consider` | If the check has returned information that needs to be evaluated, the result is consider |

#### CIP Status

| Attribute   | Description              |
| ----------- | ------------------------ |
| `complete`  | Check is done            |
| `withdrawn` | Check has been cancelled |

#### CIP Provider

This list contains the KYC providers that have been whitelisted by Alpaca. In case you

| Attribute | Description |
| --------- | ----------- |
| `trulioo` |             |
| `onfido`  |             |
| `veriff`  |             |
| `jumio`   |             |
| `getmati` |             |
| `alloy`   |             |

---

## **Retrieving CIP information**

`GET /v1/accounts/{account_id}/cip`

You can retrieve the CIP information you've submitted for a given account.

### Request

N/A

### Response

It will return the CIP ID generated on submission, `account_id`, and CIP data if it exists otherwise will throw an error.

---

## **International Accounts**

### W-8 BEN

For certain individuals, a W-8 BEN form should be submitted at onboarding. If the individual is not a registered U.S. taxpayer (not subject to a W-9), the W-8 BEN form may need to be submitted. The IRS explains [here](https://www.irs.gov/instructions/iw8ben) which individuals this applies to and provides instructions on completing the form. Every three years, in addition to the calendar year it was signed, a new W-8 BEN form must be submitted.

The form can be submitted in JSON, JSONC, PNG, JPEG or PDF. If submitting it in JSON, please see the W-8 BEN completed with the corresponding field names for the API [here](https://github.com/alpacahq/bkdocs/files/7756721/W-8Ben_Example_Broker_Docs.pdf).

Note: The dates collected on the form are in a slightly different format than how they need to be submitted via Accounts API. It is requested by the user on the form in MM-DD-YYYY, but should be submitted as YYYY-MM-DD.

#### Sample Request Body

Note: This W-8 BEN sample is document object that will be included in the documents parameter of the account object. 

```json
{
  "document_type": "w8ben",
  "content_data": {
    "additional_conditions": "None",
    "country_citizen": "Australia",
    "date": "2021-06-14",
    "date_of_birth": "1970-01-01",
    "foreign_tax_id": "123 456 789",
    "ftin_not_required": false,
    "full_name": "John Doe",
    "ip_address": "127.0.0.1",
    "mailing_address_city_state": "Adelaide",
    "mailing_address_country": "Australia",
    "mailing_address_street": "51 Main St",
    "paragraph_number": "15",
    "percent_rate_withholding": 5.0,
    "permanent_address_city_state": "Adelaide",
    "permanent_address_country": "Australia",
    "permanent_address_street": "20 Main St",
    "reference_number": "abc123",
    "residency": "Australia",
    "revision": "10-2021",
    "tax_id_ssn": "123-00-456",
    "timestamp": "2021-06-14T09:31:05Z",
    "income_type": "interest",
    "signer_full_name": "Mr. Signing User"
  }
}
```

#### Parameters

| Attribute                      | Type               | Requirement                           | Notes                                                            |
| ------------------------------ | ------------------ | ------------------------------------- | ---------------------------------------------------------------- |
| `additional_conditions`        | string             | {{<hint info>}}Optional {{</hint>}}   |                                                                  |
| `capacity_acting`              | string             | {{<hint info>}}Optional {{</hint>}}   | _Unique to revision "7-2017"_                                                |
| `country_citizen`              | string             | {{<hint danger>}}Required {{</hint>}} |                                                                  |
| `date`                         | date               | {{<hint danger>}}Required {{</hint>}} | _Format YYYY-MM-DD_                                              |
| `date_of_birth`                | date               | {{<hint danger>}}Required{{</hint>}}  | _Format YYYY-MM-DD_                                              |
| `foreign_tax_id`               | string             | {{<hint info>}}Optional {{</hint>}}   |                                                                  |
| `ftin_not_required`            | boolean            | {{<hint info>}}Optional {{</hint>}}   | _Required if `foreign_tax_id` and `tax_id_ssn` are empty_        |
| `full_name`                    | string             | {{<hint danger>}}Required {{</hint>}} |                                                                  |
| `income_type`                  | string             | {{<hint info>}}Optional {{</hint>}}   |                                                                  |
| `ip_address`                   | string             | {{<hint danger>}}Required {{</hint>}} |                                                                  |
| `mailing_address_city_state`   | string             | {{<hint info>}}Optional {{</hint>}}   |                                                                  |
| `mailing_address_country`      | string             | {{<hint info>}}Optional {{</hint>}}   |                                                                  |
| `mailing_address_street`       | string             | {{<hint info>}}Optional {{</hint>}}   |                                                                  |
| `paragraph_number`             | string             | {{<hint info>}}Optional {{</hint>}}   |                                                                  |
| `percent_rate_withholding`     | string (decimal)   | {{<hint info>}}Optional {{</hint>}}   |                                                                  |
| `permanent_address_city_state` | string             | {{<hint danger>}}Required {{</hint>}} |                                                                  |
| `permanent_address_country`    | string             | {{<hint danger>}}Required {{</hint>}} |                                                                  |
| `permanent_address_street`     | string             | {{<hint danger>}}Required {{</hint>}} |                                                                  |
| `reference_number`             | string             | {{<hint info>}}Optional {{</hint>}}   |                                                                  |
| `residency`                    | string             | {{<hint info>}}Optional {{</hint>}}   |                                                                  |
| `revision`                     | string             | {{<hint danger>}}Required {{</hint>}} | _"10-2021" until the IRS releases an updated version of the form_ |
| `signer_full_name`             | string             | {{<hint danger>}}Required {{</hint>}} |                                                                  |
| `tax_id_ssn`                   | string             | {{<hint info>}}Optional {{</hint>}}   |                                                                  |
| `timestamp`                    | string (timestamp) | {{<hint danger>}}Required {{</hint>}} |                                                                  |

---

## **Listing All Accounts**

`GET /v1/accounts`

You can query a list of all the accounts that you submitted to Alpaca. You can tweak the query to return a list of accounts that fulfill certain conditions passed.

### Request

##### Parameters

| Attribute        | Type               | Required                           | Notes                                                                                                                                                                                                                                                       |
| ---------------- | ------------------ | ---------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `query`          | string             | {{<hint info>}}Optional{{</hint>}} | Pass space-delimited tokens. The response will contain accounts that match with each of the tokens (logical AND). A match means the token is present in either the account’s associated account number, phone number, name, or e-mail address (logical OR). |
| `created_after`  | string, timestamp  | {{<hint info>}}Optional{{</hint>}} |
| `created_before` | string, timestamp  | {{<hint info>}}Optional{{</hint>}} |
| `status`         | ENUM.AccountStatus | {{<hint info>}}Optional{{</hint>}} | [ENUM.AccountStatus]({{< relref "#account-status" >}})                                                                                                                                                                                                      |
| `sort`           | string             | {{<hint info>}}Optional{{</hint>}} | `asc` or `desc`. Defaults to `desc`                                                                                                                                                                                                                         |
| `entities`       | string             | {{<hint info>}}Optional{{</hint>}} | Comma-delimited entity names to include in the response                                                                                                                                                                                                     |

### Response

Up to 1,000 items per query, ordered by `created_at`.

---

## **Retrieving an Account (Brokerage)**

`GET /v1/accounts/{account_id}`

You can query a specific account that you submitted to Alpaca by passing into the query the `account_id` associated with the account you're retrieving.

### Request

N/A

### Response

Will return an account if account with `account_id` exists, otherwise will throw an error.

---

## **Retrieving an Account (Trading)**

`GET /v1/trading/accounts/{account_id}/account`

As a broker you can view more trading details about your users.

### Request

N/A

### Response

#### Sample Response

The response is a much more expanded account object found here in [Trading API](https://alpaca.markets/docs/api-documentation/api-v2/account/#account-entity)

```json
{
  "id": "c8f1ef5d-edc0-4f23-9ee4-378f19cb92a4",
  "account_number": "927584925",
  "status": "ACTIVE",
  "crypto_status": "ACTIVE",
  "currency": "USD",
  "buying_power": "103556.8572572922",
  "regt_buying_power": "52921.2982330664",
  "daytrading_buying_power": "103556.8572572922",
  "cash": "24861.91",
  "cash_withdrawable": "17861.91",
  "cash_transferable": "24861.91",
  "accrued_fees": "0",
  "pending_transfer_out": "0",
  "portfolio_value": "28059.3882330664",
  "pattern_day_trader": true,
  "trading_blocked": false,
  "transfers_blocked": false,
  "account_blocked": false,
  "created_at": "2021-03-01T13:28:49.270232Z",
  "trade_suspended_by_user": false,
  "multiplier": "4",
  "shorting_enabled": true,
  "equity": "28059.3882330664",
  "last_equity": "26977.323677655",
  "long_market_value": "3197.4782330664",
  "short_market_value": "0",
  "initial_margin": "1598.7391165332",
  "maintenance_margin": "959.24346991992",
  "last_maintenance_margin": "934.6241032965",
  "sma": "26758.0590204615",
  "daytrade_count": 0,
  "previous_close": "2021-04-01T19:00:00-04:00",
  "last_long_market_value": "3115.413677655",
  "last_short_market_value": "0",
  "last_cash": "23861.91",
  "last_initial_margin": "1557.7068388275",
  "last_regt_buying_power": "50839.233677655",
  "last_daytrading_buying_power": "104433.9158860662",
  "last_buying_power": "104433.9158860662",
  "last_daytrade_count": 0,
  "clearing_broker": "VELOX"
}
```

#### Attributes

| Attribute                      | Type               | Notes                                                                                                                                                                |
| ------------------------------ | ------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `id`                           | string/uuid        | The account ID                                                                                                                                                       |
| `account_number`               | string             | The account number                                                                                                                                                   |
| `status`                       | ENUM.AccountStatus | The current status of the account                                                                                                                                    |
| `crypto_status`                       | ENUM.CryptoStatus | The current status of the crypto enablement                                                                                                                                    |
| `currency`                     | string             | Always `USD`                                                                                                                                                         |
| `buying_power`                 | string/number      | Current available cash buying power. If multiplier = 2 then `buying_power` = max(`equity`-`initial_margin`(0) \* 2). If multiplier = 1 then `buying_power` = `cash`. |
| `regt_buying_power`            | string/number      | User’s buying power under Regulation T (excess equity - (equity - margin value) - \* margin multiplier)                                                              |
| `daytrading_buying_power`      | string/number      | Your buying power for day trades (continuously updated value)                                                                                                        |
| `cash`                         | string/number      | Cash balance                                                                                                                                                         |
| `cash_withdrawable`            | string/number      | Cash available for withdrawal                                                                                                                                        |
| `cash_transferable`            | string/number      | Cash available for transfer (JNLC)                                                                                                                                   |
| `pending_transfer_out`         | string/number      | Cash pending transfer out                                                                                                                                            |
| `portfolio_value`              | string/number      | Total value of cash + holding positions. (This field is deprecated. It is equivalent to the equity field.)                                                           |
| `pattern_day_trader`           | boolean            | Whether account is flagged as pattern day trader or not.                                                                                                             |
| `trading_blocked`              | boolean            | If true, the account is not allowed to place orders.                                                                                                                 |
| `transfers_blocked`            | boolean            | If true, the account is not allowed to request money transfers.                                                                                                      |
| `account_blocked`              | boolean            | If true, the account activity by user is prohibited.                                                                                                                 |
| `created_at`                   | boolean            | Timestamp this account was created at                                                                                                                                |
| `trade_suspended_by_user`      | string/number      | If true, the account is not allowed to place orders.                                                                                                                 |
| `multiplier`                   | string/number      | "1" or "2"                                                                                                                                                           |
| `shorting_enabled`             | boolean            | Flag to denote whether or not the account is permitted to short                                                                                                      |
| `equity`                       | string/number      | `cash` + `long_market_value` + `short_market_value`                                                                                                                  |
| `last_equity`                  | string/number      | Equity as of previous trading day at 16:00:00 ET                                                                                                                     |
| `long_market_value`            | string/number      | Real-time MtM value of all long positions held in the account                                                                                                        |
| `short_market_value`           | string/number      | Real-time MtM value of all short positions held in the account                                                                                                       |
| `initial_margin`               | string/number      | Reg T initial margin requirement (continuously updated value)                                                                                                        |
| `maintenance_margin`           | string/number      | Maintenance margin requirement (continuously updated value)                                                                                                          |
| `last_maintenance_margin`      | string/number      | Maintenance margin requirement on the previous trading day                                                                                                           |
| `sma`                          | string/number      | Value of **Special Memorandum Account** (will be used at a later date to provide additional buying_power)                                                            |
| `daytrade_count`               | number             | The current number of daytrades that have been made in the last 5 trading days (inclusive of today)                                                                  |
| `previous_close`               | string/timedate    | Previous sessions close time                                                                                                                                         |
| `last_long_market_value`       | string/number      | Value of all long positions as of previous trading day at 16:00:00 ET                                                                                                |
| `last_short_market_value`      | string/number      | Value of all short positions as of previous trading day at 16:00:00 ET                                                                                               |
| `last_cash`                    | string/number      | Value of all cash as of previous trading day at 16:00:00 ET                                                                                                          |
| `last_initial_margin`          | string/number      | Value of Reg T margin as of previous trading day at 16:00:00 ET                                                                                                      |
| `last_regt_buying_power`       | string/number      | Value of Reg T buying power as of previous trading day at 16:00:00 ET                                                                                                |
| `last_daytrading_buying_power` | string/number      | Value of daytrading buying power as of previous trading day at 16:00:00 ET                                                                                           |
| `last_daytrade_count`          | string/number      | Value of daytrade count as of previous trading day at 16:00:00 ET                                                                                                    |
| `clearing_broker`              | string/number      | Clearing broker                                                                                                                                                      |

---

## **Updating an Account**

`PATCH /v1/accounts/{account_id}`

This operation updates account information. The following attribute are modifiable.

### Request

##### Parameters

**Enabled Assets**
| Attribute        | Type                                                        | Requirement                        | Notes                                                                                                                                    |
| ---------------- | ----------------------------------------------------------- | ---------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| `enabled_assets` | array of [ENUM.AssetClass]({{< relref "#asset-class" >}})   | {{<hint info>}}Optional{{</hint>}} | Must patch `["us_equity", "crypto"]` along with the crypto agreement to enable crypto for an existing user with access only to equities. |

**Contact**

| Attribute        | Key        | Required                           | Notes                                                                           |
| ---------------- | ---------- | ---------------------------------- | ------------------------------------------------------------------------------- |
| `email_address`  | [].contact | {{<hint info>}}Optional{{</hint>}} | Email addresses should be verified prior to using this operation to update them |
| `phone_number`   | [].contact | {{<hint info>}}Optional{{</hint>}} |                                                                                 |
| `street_address` | [].contact | {{<hint info>}}Optional{{</hint>}} |                                                                                 |
| `unit`           | [].contact | {{<hint info>}}Optional{{</hint>}} |                                                                                 |
| `city`           | [].contact | {{<hint info>}}Optional{{</hint>}} |                                                                                 |
| `state`          | [].contact | {{<hint info>}}Optional{{</hint>}} |                                                                                 |
| `postal_code`    | [].contact | {{<hint info>}}Optional{{</hint>}} |                                                                                 |

- Partners are responsible for submitting updated documents as required by the updates being made
- Guidance for Form W-8 BEN on changes in circumstance can be found [here](https://www.irs.gov/instructions/iw8ben)
- Letters sent to customers on address changes should blind carbon copy (bcc) support@alpaca.markets

**Identity**
| Attribute                    | Key         | Required                           | Notes                                                          |
| ---------------------------- | ----------- | ---------------------------------- | -------------------------------------------------------------- |
| `given_name`                 | [].identity | {{<hint info>}}Optional{{</hint>}} | Name can only be updated once via API request.                 |
| `middle_name`                | [].identity | {{<hint info>}}Optional{{</hint>}} | Name can only be updated once via API request.                 |
| `family_name`                | [].identity | {{<hint info>}}Optional{{</hint>}} | Name can only be updated once via API request.                 |
| `visa_type`                  | [].identity | {{<hint info>}}Optional{{</hint>}} | Only used to collect visa types for users residing in the USA. |
| `visa_expiration_date`       | [].identity | {{<hint info>}}Optional{{</hint>}} | Required if `visa_type` is set.                                |
| `date_of_departure_from_usa` | [].identity | {{<hint info>}}Optional{{</hint>}} | Required if `visa_type` = `B1` or `B2`                         |
| `permanent_resident`         | [].identity | {{<hint info>}}Optional{{</hint>}} | Only used to collect permanent residence status in the USA.    |
| `funding_source`             | [].identity | {{<hint info>}}Optional{{</hint>}} |                                                                |
| `annual_income_min`          | [].identity | {{<hint info>}}Optional{{</hint>}} |                                                                |
| `annual_income_max`          | [].identity | {{<hint info>}}Optional{{</hint>}} |                                                                |
| `liquid_net_worth_min`       | [].identity | {{<hint info>}}Optional{{</hint>}} |                                                                |
| `liquid_net_worth_max`       | [].identity | {{<hint info>}}Optional{{</hint>}} |                                                                |
| `total_net_worth_min`        | [].identity | {{<hint info>}}Optional{{</hint>}} |                                                                |
| `total_net_worth_max`        | [].identity | {{<hint info>}}Optional{{</hint>}} |                                                                |

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

{{<hint warning>}}
400 - Bad Request

​ _The body in the request is not valid_
{{</hint>}}

{{<hint warning>}}
422 - Unprocessable Entity

​ _The request body contains an attribute that is not permitted to be updated._
{{</hint>}}

{{<hint warning>}}
500 - Internal Server Error​

_Some server error occurred. Please contact Alpaca._
{{</hint>}}

---

## **Close an Account**

`DELETE /v1/accounts/{account_id}`

This operation closes an active account. The underlying records and information of the account are not deleted by this operation.

### Request

In the `account_id` path parameter, provide the `id` of the account to be closed.

### Response

{{<hint good>}}
204 - No Content

{{</hint>}}

{{<hint warning>}}
403 - Forbidden

{{</hint>}}

{{<hint warning>}}
404 - Account Not Found​

{{</hint>}}

{{<hint warning>}}
422 - Unprocessable Entity

{{</hint>}}

&nbsp;
