---
date: 2021-04-03
linktitle: Funding Your First Account
menu:
  main:
    parent: tutorials
title: Funding Your First Account
weight: 2
---

Now that you have an account set up for you user inside Alpaca, you should fund the account to allow the user to trade in the stock market.

## 1: Funding an Account in Sandbox

`POST /v1/accounts/{account_id}/transfers`

Each transfer request needs to include the `account_id` in the URL.

Funding an account in sandbox is as simple as passing an amount through the `POST /v1/accounts/{account_id}/transfers` endpoint while making sure of the `direction` and `amount`.

Here is a working JSON sample request body to fund an existing account suing the above endpoint:

```json
{
  "transfer_type": "wire",
  "amount": "1000",
  "direction": "INCOMING",
  "additional_information": "my additional wire info details"
}
```

Here we are 'virtually' funding an account with $1,000 - this user in sandbox is now allowed to trade immediately.

## 2: Successful Request

```JSON
{
 "id": "18a97668-b376-4277-a7bc-0fec28ca06a9",
 "account_id": "fb17c119-7249-4b56-a55c-46bc18b96da6",
 "type": "wire",
 "status": "COMPLETE",
 "amount": "5000",
 "direction": "INCOMING",
 "created_at": "2021-02-24T14:12:04.834258706Z",
 "updated_at": "2021-02-24T14:12:05.008472291Z",
 "expires_at": "2021-03-03T14:12:04.833688899Z",
 "additional_information": "my additional wire info details"
}
```

This is the Transfer Model that will be returned in `GET` requests as well.

Great! Now, moving forward here are some important points to remember:

- In Sandbox Environment you can instantly deposit and withdraw from an account with a virtual money amount, however, for wire transfers in production, you would need to create the bank resource first using the Bank API.
- One can query a list of transfers for an account, specified by an `account_id`, using the following API call: `GET /v1/accounts/{account_id}/transfers`
- Some Enums to be aware of:
  - `TransferDirection`: `INCOMING` (Deposits) or `OUTGOING` (Withdrawals)
  - `TransferType`: `ach` (ACH Transfer) or `wire` (Wire Transfers)
  - `TransferStatus`: `QUEUED`, `PENDING`, `REJECTED`, and `APPROVED` with the respective qualifications of each status found here in the [Transfers Resource](/docs/resources/funding/transfers/)
