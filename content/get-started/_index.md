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

### Live Environment

We have provided in our dashboard an API tool that uses your API key credentials to send request and receive responses all from your browser.

Simply navigate to **API/Devs > Live Testing** and try out our APIs.

### Making Your First Request

At this point we can assume that you haven't created any account yet, so one of the very few APIs you can make is `GET /v1/assets/AAPL`, which doesn't require a request body and will give you all the asset details you need about `AAPL`.

The response would look like:

```json
{
  "id": "b0b6dd9d-8b9b-48a9-ba46-b9d54906e415",
  "class": "us_equity",
  "exchange": "NASDAQ",
  "symbol": "AAPL",
  "name": "Apple Inc. Common Stock",
  "status": "active",
  "tradable": true,
  "marginable": true,
  "shortable": true,
  "easy_to_borrow": true,
  "fractionable": true
}
```

## **1. Creating an Account**

One of the first things you would need to do using Broker API is to create an account for your end user. Depending on the type of setup you have with Alpaca (Fully-Disclosed, Non-Disclosed, Omnibus or RIA) the requirements might differ.

Below is a sample request for a Fully-Disclosed setup.

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

## **2. Funding an Account via ACH**

### Creating an ACH Relationship

### Making a Virtual ACH Transfer

## **3. Journaling Between Accounts**

In addition to transfer and funding via ACH and wire, we have enabled organizations to directly fund their _Firm Accounts_ and then journal from those to user's accounts in order to simualte near instantaneous funding.

### Introducing the Firm Account

### Journaling Cash

### Journaling Securities

## **4. Passing an Order**

&nbsp;
