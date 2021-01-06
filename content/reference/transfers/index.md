## Transfers

Transfers allow you to transfer money/balance into your end customers' account (deposits) or out (withdrawal).

### The Transfer Model

### Available Endpoints

---
#### `GET /v1/accounts/{account_id}/transfers`

You can query a list of transfers for an account. 

###### Request

`direction` enum.TransferDirection (optional)

`INCOMING` enum.TransferDirection (optional)

`OUTGOING` enum.TransferDirection (optional)

`limit` int (optional)

​`offset` int (optional)

###### Response

​`id` - string, UUID

​`account_id` - string, UUID

​`type` - enum.TransferType

​`ach` - ACH transfer

​`wire` - Wire transfer

​`status` - enum.TransferStatus
- `QUEUED` - Transaction is queued, amount will not reflect in the account balance
- ​`PENDING` - Transaction is pending approval
- `REJECTED` - Transaction is rejected
- `APPROVED` - Transaction has been completed successfully

​`amount` - decimal (>0)

​`direction` - enum.TransferDirection
- `INCOMING` - (optional)
- `OUTGOING`  - (optional)

​`created_at` - string <timestamp>

​`updated_at` - string <timestamp>

---

#### `DELETE /v1/accounts/{account_id}/transfers/{transfer_id}`

---

#### `POST /v1/accounts/{account_id}/transfers`

This method allows you to virtually transfer to an account.

Create a new transfer on an account to fund it. In the sandbox, you can instantly deposit to or withdraw from an account with a virtual money amount. In the production, this endpoint is used only for requesting an outgoing (withdrawal) wire transfer at this moment. For the wire transfer (in production), you need to create a bank resource first using the Bank API. 


###### Request

​`amount` - decimal (>0)

​`direction` - enum.TransferDirection
- `INCOMING` - transfers going into an account
- `OUTGOING` - transfers going out of an account

​`timing` - string <timestamp>
- `immediate` 

###### Response