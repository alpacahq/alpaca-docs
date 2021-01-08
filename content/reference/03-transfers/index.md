# Transfers

Transfers allow you to transfer money/balance into your end customers' account (deposits) or out (withdrawal).

## The Transfer Model

| Attribute    | Type    | Notes                                       |
| ------------ | ------- | ------------------------------------------- |
| `id`         | string  | UUID                                        |
| `account_id` | string  | UUID                                        |
| `type`       | ENUM    | `ach` or `wire`                             |
| `status`     | ENUM    | `QUEUED`, `PENDING`, `REJECTED`, `APPROVED` |
| `amount`     | decimal | Must be > 0                                 |
| `direction`  | ENUM    | `INCOMING`, `OUTGOING`                      |
| `created_at` | decimal | Must be > 0                                 |
| `updated_at` | ENUM    | `INCOMING`, `OUTGOING`                      |

## Available Endpoints

---
### `GET /v1/accounts/{account_id}/transfers`

You can query a list of transfers for an account. 

#### Request

##### Parameters

| Attribute   | Type | Notes                             |
| ----------- | ---- | --------------------------------- |
| `direction` | ENUM | Optional - `INCOMING`, `OUTGOING` |
| `limit`     | int  | Optional                          |
| `offset`    | int  | Optional                          |

##### Sample Request Body

```
Sample Request Body
```


#### Response

Returns a list of transfer entities ordered by `created_at`.

##### Parameters

Refer to transfer model.


---

### `DELETE /v1/accounts/{account_id}/transfers/{transfer_id}`

#### Request

##### Parameters

No parameters

##### Sample Request Body

#### Response

Returns a `204: Sucess (No Content)`

##### Codes

**404** Transfer not found



---

### `POST /v1/accounts/{account_id}/transfers`

Create a new transfer to an account to fund it. In the sandbox, you can instantly deposit to or withdraw from an account with a virtual money amount. In the production, this endpoint is used only for requesting an outgoing (withdrawal) wire transfer at this moment. For the wire transfer (in production), you need to create a bank resource first using the Bank API. 

#### Request

##### Parameters

| Attribute       | Type                   | Notes                               |
| --------------- | ---------------------- | ----------------------------------- |
| `transfer_type` | ENUM.TransferType      | Required - `ach`, `wire`            |
| `bank_id`       | string                 | Required - UUID                     |
| `amount`        | int                    | Required. Must be >0                |
| `direction`     | ENUM.TransferDirection | Required - `INCOMING` or `OUTGOING` |
| `timing`        | ENUM.TransferTiming    | Required - `immediate`              |

##### Sample Resquest Body

#### Response

If succesfull, will return a newly Transfer Entity. 
