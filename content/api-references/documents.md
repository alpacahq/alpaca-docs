---
bookHidden: false
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

| Attribute       | Type        | Notes                                             |
| --------------- | ----------- | ------------------------------------------------- |
| `id`   | string.UUID | The UUID of the document                          |
| `type` | string      | ENUM: `account_statement` or `trade_confirmation` |
| `date` | string.date | format: "2020-01-01"                              |

---

## **Uploading a Document**

`POST /v1/accounts/{account_id}/documents/upload`

Upload a document to be attached to an account.

Documents are binary objects whose contents are encoded in base64. Each encoded content size is limited to 10MB.

### Request

#### Sample Request

```json
[
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
]
```

#### Parameters

| Key               | Value                 | Requirement                          |
| ----------------- | --------------------- | ------------------------------------ |
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

| Attribute       | Type   | Requirement                         | Notes                                             |
| --------------- | ------ | ----------------------------------- | ------------------------------------------------- |
| `start`    | string | {{<hint info>}}Optional {{</hint>}} | format: 2020-01-01                                |
| `end`      | string | {{<hint info>}}Optional {{</hint>}} | format: 2020-01-01                                |
| `type` | string | {{<hint info>}}Optional {{</hint>}} | ENUM: `account_statement` or `trade_confirmation` |

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
