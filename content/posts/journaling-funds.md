---
date: 2021-04-03
linktitle: Journaling Funds Between Accounts
menu:
  main:
    parent: tutorials
title: Journaling Funds Between Accounts
weight: 4
---

If you wish and are eligible, you can send customer deposits in a bulk to your firm account first and reconcile later using Journal API.

Journaling funds to funds your customer is subject to approval in production, as you may need a local license to implement this process.

## 1: Creating the Journal Request

### `POST /v1/journals`

Each journal transaction involves a

- `from_account`: the originator of the funds
- `to_account`: the destination of the funds
- `entry_type`: the type of journal - cash (JNLC) or securities (JNLS)
- the requirements of the `entry_type` selected

```json
{
  "from_account": "c94bu7rn-4483-4199-840f-6c5fe0b7ca24",
  "entry_type": "JNLC",
  "to_account": "fn68sbrk-6f2a-433c-8c33-17b66b8941fa",
  "amount": "51"
}
```

This transaction will move $51 from the `from_account` to the `to_account`

## 2: Successful Response

If the request is well formed, and the funds are available you will receive an async response with the status = `pending`.

All sandbox accounts have a $50 journal limit set by default that you can request to change when you move to production. If the journal amount is below the limit, the transaction will be executed almost immediately. If the transaction is above the limit it will go into pending, until the end of day where it will get rejected.

A successful response would look like this

```json
{
  "id": "h7h5g33f-ef01-4458-9a4b-9598727a406f",
  "to_account": "fn68sbrk-6f2a-433c-8c33-17b66b8941fa",
  "entry_type": "JNLC",
  "status": "executed",
  "from_account": "c94bu7rn-4483-4199-840f-6c5fe0b7ca24",
  "settle_date": "2021-04-03",
  "system_date": "2021-04-03",
  "net_amount": "51",
  "description": "this is a test journal"
}
```

For more information on journals such as deleting and listing previous journal head over to [Journals API]({{< relref "../api-references/journals-v2" >}})
