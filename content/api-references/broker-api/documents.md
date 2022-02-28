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
  "id": "904837e3-3b76-47ec-b432-046db621571b",
  "type": "account_statement",
  "date": "2020-01-15"
}
```

#### Attributes

| Attribute  | Type                                                    | Notes                                     |
|------------|---------------------------------------------------------|-------------------------------------------|
| `id`       | string/UUID                                             | The UUID of the document                  |
| `name`     | string                                                  | The title of the document (if applicable) |
| `type`     | [ENUM.DocumentType]({{< relref "#enumdocumenttype" >}}) |                                           |
| `sub_type` | string                                                  | ENUM: `1099-Comp` or `1042-S` or `480.6`  |
| `date`     | string/date                                             | format: "2020-01-01"                      |

### ENUM.DocumentType

| Value                        | Description                                           |
|------------------------------|-------------------------------------------------------|
| `account_statement`          | Document is an account statement                      |
| `trade_confirmation`         | Document is a confirmation that a trade has completed |
| `tax_statement`              |                                                       |
| `cta_agreement`              |                                                       |
| `utp_agreement`              |                                                       |
| `tax_1099_b_details`         |                                                       |
| `tax_1099_b_form`            |                                                       |
| `tax_1099_div_details`       |                                                       |
| `tax_1099_div_form`          |                                                       |
| `tax_1099_int_details`       |                                                       |
| `tax_1099_int_form`          |                                                       |
| `tax_w8`                     |                                                       |
| `account_dump`               |                                                       |
| `esign_agreement`            |                                                       |
| `trulioo_transaction_record` |                                                       |
| `onfido_cip`                 |                                                       |
| `non_solicitation_form`      |                                                       |

---




## **Uploading a Document**

`POST /v1/accounts/{account_id}/documents/upload`

Upload a document to be attached to an account.

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

#### Parameters

| Key               | Value                 | Requirement                          |
|-------------------|-----------------------|--------------------------------------|
| `document_upload` | models.DocumentUpload | {{<hint danger>}}Required{{</hint>}} |

### Response

{{<hint good>}}
204 - No Content

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

## **Retrieving Documents for One Account**

`GET /v1/accounts/{account_id}/documents`

This endpoint allows you to query all the documents that belong to a certain account. You can filter by date, or type of document.

### Request

#### Query Parameters

| Attribute  | Type   | Requirement                         | Notes                                             |
|------------|--------|-------------------------------------|---------------------------------------------------|
| `start`    | string | {{<hint info>}}Optional {{</hint>}} | format: 2020-01-01                                |
| `end`      | string | {{<hint info>}}Optional {{</hint>}} | format: 2020-01-01                                |
| `type`     | string | {{<hint info>}}Optional {{</hint>}} | ENUM: `account_statement` or `trade_confirmation` |

### Response

Returns the document model.

#### Error Codes

{{<hint warning>}}**`401`** - Not Authorized: Invalid Credentials {{</hint>}}

---

## **Downloading a Document**

`GET /v1/accounts/{account_id}/documents/{document_id}/download`

This endpoint allows you to download a document identified by the `document_id` passed in the header. The returned document is in PDF format.

### Request

N/A

### Response

{{<hint good>}}**`301`** - Redirects to a presigned download link for the document PDF.{{</hint>}}

#### Errors

{{<hint warning>}}**`404`** - Document Not Found {{</hint>}}

---

## **Retrieving a Document by ID**

`GET /v1/accounts/{account_id}/documents/{document_id}`

This endpoint allows you to call for a specific document and returns the document model.

### Request

N/A

### Response

Returns the document model.

#### Errors

{{<hint warning>}}**`404`** - Document Not Found {{</hint>}}

&nbsp;
