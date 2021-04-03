---
bookHidden: false
weight: 5
---

# Documents

&nbsp;

The documents endpoint allows you to view and download any documents that fit the parameters passed. Types of documents generated from Alpaca can be _Account Monthly Statements_ and _Trade Confirmations_.

---

## **Retrieving Documents for One Account**

`GET /v1/accounts/{account_id}/documents`

This endpoint allows you to query all the documents that belong to a certain account. You can filter by date, or type of document.

### Request

#### Sample Request

```json
{
  "start_date": "2020-01-01",
  "end_date": "2020-01-31",
  "document_type": "account_statement"
}
```

#### Parameters

| Attribute       | Type   | Requirement                         | Notes                                             |
| --------------- | ------ | ----------------------------------- | ------------------------------------------------- |
| `start_date`    | string | {{<hint info>}}Optional {{</hint>}} | format: 2020-01-01                                |
| `end_date`      | string | {{<hint info>}}Optional {{</hint>}} | format: 2020-01-01                                |
| `document_type` | string | {{<hint info>}}Optional {{</hint>}} | ENUM: `account_statement` or `trade_confirmation` |

### Response

Returns the document model.

#### Sample Response

```json
{
  "document_id": "904837e3-3b76-47ec-b432-046db621571b",
  "document_type": "account_statement",
  "document_date": "2020-01-15"
}
```

#### Properties

| Attribute       | Type        | Notes                                             |
| --------------- | ----------- | ------------------------------------------------- |
| `document_id`   | string.UUID | The UUID of the document                          |
| `document_type` | string      | ENUM: `account_statement` or `trade_confirmation` |
| `document_date` | string.date | format: "2020-01-01"                              |

#### Error Codes

{{<hint warning>}}**`401`** - Not Authorized: Invalid Credentials {{</hint>}}

---

## **Downloading a Document**

`GET /v1/accounts/{account_id}/documents/{document_id}/download`

This endpoint allows you to download a document identified by the `document_id` passed in the header. The returned document is in PDF format.

### Request

N/A

### Response

- **`301`** - Redirects to a presigned download link for the document PDF.

#### Errors

{{<hint warning>}}**`404`** - Document Not Found {{</hint>}}

---

## **Retrieving a Document by ID**

`GET /v1/documents/{document_id}`

This endpoint allows you to call for a specific document and returns the document model.

### Request

N/A

### Response

Returns the document model.

#### Errors

{{<hint warning>}}**`404`** - Document Not Found {{</hint>}}
