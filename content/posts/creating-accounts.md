---
author: "Michael Henderson"
date: 2021-04-03
linktitle: Creating Your First Account
menu:
  main:
    parent: tutorials
title: Creating Your First Account
weight: 1
---

Depending on the type of setup you have, the type of KYC information required to be collected can change. Below is a tutorial for a fully-disclosed broker dealer setup.

Make sure that you are passing the correct set of `API_KEY` and `API_SECRET` that was provided to you in the [Broker Dashboard](https://broker-app.alpaca.markets) upon signing up.

Always make sure that the information being passed is coming from your server to prevent customer manipulation from the client.

## 1: Passing Collected KYC Information

`POST /v1/accounts`

Note the required models are `contact`, `identity`, `disclosures`, `agreements`, and `documents` whereas the `trusted_contact` model is optional.

It is important to realize that within each model there are required and optional fields. Take the contact model where `email_address` and `city` are required but `postal_code` is optional as an example.

Here is a working JSON sample of an account:

```json
{
  "contact": {
    "email_address": "cool_alpaca@example.com",
    "phone_number": "555-666-7788",
    "street_address": ["20 N San Mateo Dr"],
    "city": "San Mateo",
    "state": "CA",
    "postal_code": "94401",
    "country": "USA"
  },
  "identity": {
    "given_name": "Al",
    "family_name": "Paca",
    "date_of_birth": "1999-12-31",
    "country_of_tax_residence": "USA",
    "funding_source": ["savings"]
  },
  "disclosures": {
    "is_control_person": false,
    "is_affiliated_exchange_or_finra": false,
    "is_politically_exposed": false,
    "immediate_family_exposed": false
  },
  "agreements": [
    {
      "agreement": "margin_agreement",
      "signed_at": "2020-09-11T18:09:33Z",
      "ip_address": "185.13.21.99"
    },
    {
      "agreement": "account_agreement",
      "signed_at": "2020-09-11T18:13:44Z",
      "ip_address": "185.13.21.99"
    },
    {
      "agreement": "customer_agreement",
      "signed_at": "2020-09-11T18:13:44Z",
      "ip_address": "185.13.21.99"
    }
  ],
  "documents": [
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
  ],
  "trusted_contact": {
    "given_name": "Mama",
    "family_name": "Alpaca",
    "email_address": "cooler_alpaca@example.com"
  }
}
```

This information must be collected and sent to Alpaca before funding an account, to enable the user to trade.

## 2: Successful Response

Congratulations! If the object passed in the `POST` request is accepted by Alpaca you will receive a `200` status along with a response body that would look like this

```json
{
  "id": "a3c0bc7a-86c9-4995-b4d8-691fe2ac20cb",
  "account_number": "927048240",
  "status": "APPROVED",
  "currency": "USD",
  "last_equity": "0",
  "created_at": "2021-04-04T00:04:24.449501Z"
}
```

This is the Account Model that will be returned in `GET` and `PATCH` requests as well.

The account has been created, returned with both a UUID and unique `account_number`.

Use the `account_id` in the path to fund a user's brokerage account, send trade orders (`BUY` & `SELL`), journal funds to and from the user's brokerage account and many more!

- Accounts can instantly be created in the Sandbox Environment provided all of the parameters were submitted correctly.
- After submitting all of the information in the Production Environment the account status may or may not be `ACTIVE` immediately and you will receive account status updates on the [Events API](/docs/resources/events/#account-status).
- You can query the list of accounts with conditions using the endpoint: `GET /v1/accounts` or retrieve an account, specified by `account_id`, using the following endpoint: `GET /v1/accounts/{account_id}`

For more information on updating and managing existing accounts head over to [Account API](/docs/resources/accounts/accounts).

**Check out**

> [Streaming](/docs/resources/events/#account-status) - For receiving account status updates

> [Account Activities](/docs/resources/accounts/account-activities) - For retrieving all activities related to funding & transfers, trades and non trade activities
