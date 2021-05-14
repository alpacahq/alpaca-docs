---
bookFlatSection: true
weight: 31
title: Get Started!
summary: Open brokerage accounts, enable commission-free trading, and manage the ongoing user experience with Alpaca Broker API
---

# Get Started!

This guide is going to help to set everything up in a sandbox environment and get you up and running in no time.

## **0. Setting Up Broker API**

### API Keys

When you sign up for an account at Alpaca you will receive an `API_KEY` and `API_SECRET`, please make sure you store those somewhere safe.

Broker API must authenticate using HTTP Basic authentication. Use your
correspondent `API_KEY` and `API_SECRET` as the username and password. The format is
`key:secret`. Encode the string with base-64 encoding, and you can pass it as
an authentication header.

### Live Environment

We have provided in our dashboard an API tool that uses your API key credentials to send requests and receive responses straight from your browser.

Simply navigate to **API/Devs > Live Testing** and try out our APIs.

### Making Your First Request

At this point we can assume that you haven't created any accounts yet, so one of the very few APIs you can make is `GET /v1/assets`, which doesn't require a request body and will give you all the assets available at Alpaca.

The response would contain an array of assets, with the first one being _Agilent Technologies Inc._:

```json
[
	{
		"id": "7595a8d2-68a6-46d7-910c-6b1958491f5c",
		"class": "us_equity",
		"exchange": "NYSE",
		"symbol": "A",
		"name": "Agilent Technologies Inc.",
		"status": "active",
		"tradable": true,
		"marginable": true,
		"shortable": true,
		"easy_to_borrow": true,
		"fractionable": true
	},

```

## **1. Create an Account**

One of the first things you would need to do using Broker API is to create an account for your end user. Depending on the type of setup you have with Alpaca ([Fully-Disclosed]({{< relref "../use-cases/#fully-disclosed" >}}), [Non-Disclosed]({{< relref "../use-cases/#non-disclosed" >}}), [Omnibus]({{< relref "../use-cases/#omnibus" >}}) or [RIA]({{< relref "../use-cases/#registered-investment-advisor-ria" >}})) the requirements might differ.

Below is a sample request to create an account for a _Fully-Disclosed_ setup:

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
    "given_name": "John",
    "family_name": "Doe",
    "date_of_birth": "1990-01-01",
    "country_of_citizenship": "USA",
    "country_of_birth": "USA",
    "country_of_tax_residence": "USA",
    "funding_source": ["employment_income"]
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
    "given_name": "Jane",
    "family_name": "Doe",
    "email_address": "jane.doe@example.com"
  }
}
```

## **2. Fund an Account via ACH**

### Creating an ACH Relationship

In order to virtually fund an account via ACH we must first establish the ACH Relationship with the account. We will be using the following endpoint `POST /v1/accounts/{account_id}/ach_relationships` along with this request body:

```json
{
  "account_owner_name": "Cool Alpaca",
  "bank_account_type": "CHECKING",
  "bank_account_number": "32131231abc",
  "bank_routing_number": "121000358",
  "nickname": "Bank of America Checking"
}
```

Please make sure that the formatting for `bank_account_number` and `bank_routing_number` are in the correct format.

If successful you will receive an `ach_relationship` object like this:

```json
{
  "id": "794c3c51-71a8-4186-b5d0-247b6fb4045e",
  "account_id": "9d587d7a-7b2c-494f-8ad8-5796bfca0866",
  "created_at": "2021-04-08T23:01:53.35743328Z",
  "updated_at": "2021-04-08T23:01:53.35743328Z",
  "status": "QUEUED",
  "account_owner_name": "John Doe",
  "bank_account_type": "CHECKING",
  "bank_account_number": "123456789abc",
  "bank_routing_number": "121000358",
  "nickname": "Bank of America Checking"
}
```

Initially you will receive a `status = QUEUED`. However, if you make a `GET/v1/accounts/{account_id}/ach_relationships` after ~1 minute you should see `status = APPROVED`.

### Making a Virtual ACH Transfer

Now that you have an existing ACH relationship between the account and their bank, you can fund the account via ACH using the following endpoint `POST/v1/accounts/{account_id}/transfers` using the `relationship_id` we got in the response of the previous section.

```json
{
  "transfer_type": "ach",
  "relationship_id": "794c3c51-71a8-4186-b5d0-247b6fb4045e",
  "amount": "500",
  "direction": "INCOMING"
}
```

After around 10-30 minutes (to simulate ACH delay) the transfer should reflect on the user's balance via a cash deposit activity (CSD) viewed via this endpoint `GET v1/accounts/activities/CSD\?account_id\={account_id}`

## **3. Journaling Between Accounts**

In addition to transfer and funding via ACH and wire, we have enabled organizations to directly fund their _Firm Accounts_ and then journal from those to user's accounts in order to simulate near instantaneous funding.

### Introducing the Firm Account

Each team will come with a firm account in sandbox that is pre-funded for $50,000. You can use this account to simulate funding to your users or use it for rewards programs to fuel your app's growth.

### Journaling Cash

In the case of a signup, or funding an account choosing a JNLC is the fastest way to get your user to trade using your app. You can simply pass in a `request` with `entry_type = JNLC` and choose the `amount` you want to journal to the user.

```json
{
  "from_account": "c94bu7rn-4483-4199-840f-6c5fe0b7ca24",
  "entry_type": "JNLC",
  "to_account": "fn68sbrk-6f2a-433c-8c33-17b66b8941fa",
  "amount": "42"
}
```

### Journaling Securities

## **4. Passing an Order**

## **5. Events (SSE)**

&nbsp;
