# Documents


## The Document Object

The documents endpoint allows you to view and download any documents that fit the parameters passed. Types of documents generated from Alpaca can be *Account Monthly Statements* and *Trade Confirmations*.

##### Parametes

| Attribute | Notes |
| --------- | ----- |
| Attribute | Notes |

##### Sample Object

```
Full Sample Object
```


## Available Endpoints

---
### `GET /v1/accounts/{account_id}/documents`

This endpoint allows you to query all the documents that belong to a certain account. You can filter by date, or type of document.

#### Request

##### Parameters

| Attribute     | Notes                                          |
| ------------- | ---------------------------------------------- |
| start_date    | optional - format: 2020-01-01                  |
| end_date      | optional - format: 2020-01-01                  |
| document_type | ENUM (account_statement OR trade_confirmation) |

##### Sample Request
```
Sample Request Body
```

#### Response

##### Parameters

| Attribute     | Notes                                                  |
| ------------- | ------------------------------------------------------ |
| document_id   | string - UUID                                          |
| document_type | string - ENUM (account_statement OR trade_confirmation |
| document_date | date - format: 2020-01-01                              |

##### Sample Response
```
Sample Response Body
```

##### Errors

---
### `GET /v1/accounts/{account_id}/documents/{document_id}/download`

This endpoint allows you to download a document identied by the `document_id` passed in the header. The returned document is in PDF format. 

#### Request

No parameters.

#### Response

**301** Redirects to a presigned download link for the document PDF. 


##### Errors

**404** Document not found

---
### `GET /v1/documents/{document_id}`

This allows you to call for a specific document and returns the document model. 

#### Request

##### Parameters

No parameters

##### Sample Request
```
Sample Request
```


#### Response

Returns the document model. 

##### Errors

- **404** Document not found