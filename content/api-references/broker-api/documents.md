---
weight: 5
summary: Open brokerage accounts, enable commission-free trading, and manage the ongoing user experience with Alpaca Broker API
---

# Documents

The documents endpoint allows you to view and download any documents that fit the parameters passed. Types of documents generated from Alpaca can be _Account Monthly Statements_ and _Trade Confirmations_.

---

## **The Document Object**

### Sample Object

```json
{
  "id": "11d5a814-9a71-4161-82a5-18e8ee0bed17",
  "name": "",
  "type": "trade_confirmation",
  "sub_type": "",
  "date": "2022-02-16"
}
```

#### Attributes

| Attribute  | Type                                                    | Notes                                                             |
|------------|---------------------------------------------------------|-------------------------------------------------------------------|
| `id`       | string/UUID                                             | The UUID of the document                                          |
| `name`     | string                                                  | The title of the document (if applicable)                         |
| `type`     | [ENUM.DocumentType]({{< relref "#enumdocumenttype" >}}) |                                                                   |
| `sub_type` | string                                                  | ENUM: either empty string `""`, `1099-Comp`, `1042-S`, or `480.6` |
| `date`     | string/date                                             | format: "2020-01-01"                                              |

### ENUM.DocumentType
| Value                        | Description                                           |
|------------------------------|-------------------------------------------------------|
| `account_statement`          | Document is an account statement                      |
| `trade_confirmation`         | Document is a confirmation that a trade has completed |
| `tax_statement`              | Document is a generated tax statement                 |

_For accounts with older documents the following **legacy** values might also be seen_

| Value                  |
|------------------------|
| `tax_1099_b_details`   |
| `tax_1099_b_form`      |
| `tax_1099_div_details` |
| `tax_1099_div_form`    |
| `tax_1099_int_details` |
| `tax_1099_int_form`    |
| `tax_w8`               |

---

## **Uploading a Document**

`POST /v1/accounts/{account_id}/documents/upload`

Upload one or more (up to 10) documents to be attached to an account. 

Documents are binary objects whose contents are encoded in base64. Each encoded content size is limited to 10MB if you use Alpaca for KYCaaS. If you perform your own KYC there are no document size limitations.

### Request

#### Sample Request

```json
[
  {
    "document_type": "cip_result",
    "content": "JVBERi0K",
    "mime_type": "application/pdf"
  },
  {
    "document_type": "identity_verification",
    "document_sub_type": "passport",
    "content": "/9j/Cg==",
    "mime_type": "image/jpeg"
  }
]
```

##### Path Parameters

| Attribute    | Type        | Required                             | Notes                                                                     |
|--------------|-------------|--------------------------------------|---------------------------------------------------------------------------|
| `account_id` | string/UUID | {{<hint danger>}}Required{{</hint>}} | The id for the related [Account]({{< relref "./accounts/accounts.md" >}}) |

#### Parameters

The main payload body is an array of data representing the documents to upload.

**Note** These are **not** the same as the [Document object]({{< relref "#the-document-object">}}) and it is not an error that the field names are different.

| Attribute           | Type                                                                      | Required                             | Notes                                                                                                                                                                                         |
|---------------------|---------------------------------------------------------------------------|--------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `document_type`     | [ENUM.UploadDocumentType]({{< relref "#enumuploaddocumenttype" >}})       | {{<hint danger>}}Required{{</hint>}} |                                                                                                                                                                                               |
| `document_sub_type` | [ENUM.UploadDocumentSubType]({{< relref "#enumuploaddocumentsubtype" >}}) | {{<hint info>}}Optional{{</hint>}}   |                                                                                                                                                                                               |
| `content`           | string                                                                    | {{<hint info>}}Optional{{</hint>}}   | A string containing Base64 encoded data to upload. This field is **Required** if `document_type` is anything other than `w8ben` or if it is `w8ben` and `content_type` is **not** specified.  |
| `content_data`      | [W8BenDocumentUpload]({{< relref "#w8bendocumentupload-type" >}})         | {{<hint info>}}Optional{{</hint>}}   | This field is **Required** if `content` is **not** specified. It is also only available when `document_type` is `w8ben`                                                                       |
| `mime_type`         | string                                                                    | {{<hint info>}}Optional{{</hint>}}   | This field is **Required** if `content` is specified. ENUM: `application/pdf`, `image/png`, or `image/jpeg`.<br/><br/> If `document_type` is `w8ben` then `application/json` is also accepted |

### ENUM.UploadDocumentType
| Value                           | Notes                                                                                                                                      |
|---------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------|
| `identity_verification`         |                                                                                                                                            |
| `address_verification`          |                                                                                                                                            |
| `date_of_birth_verification`    |                                                                                                                                            |
| `tax_id_verification`           |                                                                                                                                            |
| `account_approval_letter`       |                                                                                                                                            |
| `cip_result`                    | This is only available for clients not using our KYC process. Attempting to upload one when you are using our KYC will result in an error. |
| `limited_trading_authorization` |                                                                                                                                            |
| `w8ben`                         |                                                                                                                                            |

### ENUM.UploadDocumentSubType
| Value                 | 
|-----------------------|
| `onfido`              |
| `trulioo_idv`         |
| `trulioo_docv`        |
| `CIP`                 |
| `Account Application` |
| `Form W-8BEN`         |
| `passport`            |

### Response

{{<hint good>}}
202 - Accepted

{{</hint>}}

#### Error Codes

{{<hint warning>}}
400 - Bad Request

​ _The body in the request is not valid_
{{</hint>}}

{{<hint warning>}}
404 - Not Found

​ _No account was for this account_id_
{{</hint>}}

---

## **W8BenDocumentUpload Type**
This type represents the fields needed to upload a W-8 BEN document via the [Upload documents route]({{< relref "#uploading-a-document" >}}) 

It has been separated out into its own section in favour of readability.

### Attributes

| Attribute                        | Type             | Notes               |
|----------------------------------|------------------|---------------------|
| `country_citizen`                | string           |                     |
| `date`                           | string/Date      | `YYYY-MM-DD` format |
| `date_of_birth`                  | string/Date      | `YYYY-MM-DD` format |
| `full_name`                      | string           |                     |
| `ip_address`                     | string           |                     |
| `permanent_address_city_state`   | string           |                     |
| `permanent_address_city_country` | string           |                     |
| `permanent_address_city_street`  | string           |                     |    
| `revision`                       | string           |                     |
| `signer_full_name`               | string           |                     |
| `timestamp`                      | string/timestamp |                     |
| `additional_conditions`          | string/null      |                     |
| `capacity_acting`                | string/null      |                     |
| `foreign_tax_id`                 | string/null      |                     |
| `income_type`                    | string/null      |                     |
| `mailing_address_city_state`     | string/null      |                     |
| `mailing_address_country`        | string/null      |                     |
| `mailing_address_street`         | string/null      |                     |
| `paragraph_number`               | string/null      |                     |
| `percent_rate_withholding`       | number/null      |                     |
| `reference_number`               | string/null      |                     |
| `residency`                      | string/null      |                     |
| `tax_id_ssn`                     | string/null      |                     |
| `ftin_not_required`              | bool/null        |                     |


---

## **Retrieving Documents for One Account**

`GET /v1/accounts/{account_id}/documents`

This endpoint allows you to query all the documents that belong to a certain account. You can filter by date, or type of document.

### Request

##### Path Parameters

| Attribute    | Type        | Required                             | Notes                                                                     |
|--------------|-------------|--------------------------------------|---------------------------------------------------------------------------|
| `account_id` | string/UUID | {{<hint danger>}}Required{{</hint>}} | The id for the related [Account]({{< relref "./accounts/accounts.md" >}}) |

#### Query Parameters

| Attribute  | Type        | Requirement                         | Notes                                             |
|------------|-------------|-------------------------------------|---------------------------------------------------|
| `start`    | string/date | {{<hint info>}}Optional {{</hint>}} | format: 2020-01-01                                |
| `end`      | string/date | {{<hint info>}}Optional {{</hint>}} | format: 2020-01-01                                |
| `type`     | string      | {{<hint info>}}Optional {{</hint>}} | ENUM: `account_statement` or `trade_confirmation` |

### Response

Returns an array of [document]({{< relref "#the-document-object" >}}) models.

#### Error Codes

{{<hint warning>}}**`401`** - Not Authorized: Invalid Credentials {{</hint>}}

---

## **Downloading a Document**

`GET /v1/accounts/{account_id}/documents/{document_id}/download`

This endpoint allows you to download a document identified by the `document_id` passed in the header. The returned document is in PDF format.

### Request

##### Path Parameters

| Attribute     | Type        | Required                             | Notes                                                                                 |
|---------------|-------------|--------------------------------------|---------------------------------------------------------------------------------------|
| `account_id`  | string/UUID | {{<hint danger>}}Required{{</hint>}} | The id for the related [Account]({{< relref "./accounts/accounts.md" >}})             |
| `document_id` | string/UUID | {{<hint danger>}}Required{{</hint>}} | The id for the [Document]({{< relref "#the-document-object" >}}) you wish to download |

### Response

{{<hint good>}}**`301`** - Redirects to a presigned download link for the document PDF.{{</hint>}}

#### Errors

{{<hint warning>}}**`404`** - Document Not Found {{</hint>}}

---

## **Retrieving a Document by ID**

`GET /v1/accounts/{account_id}/documents/{document_id}`

This endpoint allows you to call for a specific document and returns the document model.

### Request

##### Path Parameters

| Attribute     | Type        | Required                             | Notes                                                                                 |
|---------------|-------------|--------------------------------------|---------------------------------------------------------------------------------------|
| `account_id`  | string/UUID | {{<hint danger>}}Required{{</hint>}} | The id for the related [Account]({{< relref "./accounts/accounts.md" >}})             |
| `document_id` | string/UUID | {{<hint danger>}}Required{{</hint>}} | The id for the [Document]({{< relref "#the-document-object" >}}) you wish to retrieve |


### Response

Returns the [document]({{< relref "#the-document-object" >}}) model.

#### Errors

{{<hint warning>}}**`404`** - Document Not Found {{</hint>}}

&nbsp;
