---
weight: 5
bookFlatSection: true
bookCollapseSection: true
title: Broker API
summary: Open brokerage accounts, enable trading, and manage the ongoing user experience with Alpaca Broker API
---

# Broker API Reference

Alpaca Broker API consists of different APIs that help you build your investment services and products depending on your needs. Here we describe some of the common features that can give you a high level idea about where to start.

## **Endpoints**

| Environment | URL                                        |
| ----------- | ------------------------------------------ |
| Sandbox     | https://broker-api.sandbox.alpaca.markets/ |
| Production  | https://broker-api.alpaca.markets/         |

## **Authentication and Rate Limit**

Broker API must authenticate using HTTP Basic authentication. Use your
correspondent API key ID and secret as the username and password. The format is
`key_id:secret`. Encode the string with base-64 encoding, and you can pass it as
an authentication header.

**Example:**

```
Authorization: Basic Y2xpZW50X2lkOmNsaWVudF9zZWNyZXQ=
```

If you are using `curl` command line tool, you can use the `-u` option.

```
$ curl -u $KEY_ID:$SECRET https://broker-api.alpaca.markets/v1/accounts
```

API keys are different in each environment. Please make sure you are using the right API key with the right endpoint URL.

Broker API has a rate limit of 1,000 calls per minute. For endpoints that are scoped with an account uuid (i.e: [POST /v1/trading/accounts/**{account_id}**/orders]({{< relref "/api-references/broker-api/trading/orders.md#creating-an-order" >}})), the rate limit is per account and will not impact API calls that pertain to another account.

The rate limits are described in the HTTP response with the following fields.

| Environment           | URL                                               |
| --------------------- | ------------------------------------------------- |
| x-ratelimit-limit     | The API call limit                                |
| x-ratelimit-remaining | The remaining quota until reset                   |
| x-ratelimit-reset     | The UNIX epoch in seconds when the quota is reset |

## **General Rules**

### Data Types

Unless specified in the documents, the timestamp fields are encoded in RFC3339 string. The timezone offset is typically UTC (“Z suffix”) but you should assume any time offset value.

Most of the numbers are defined as decimal which also comes as a JSON string field, instead of a JSON number.

### Compatibility and Versioning

All endpoints are mapped under an API version path, such as “v1” as in `/v1/accounts`. We keep API compatibility within the same API version and our definition of API compatibility is as follows.

- Addition of a new endpoint
- Addition of a new JSON field in the response
- Addition of a new input parameter
- Expansion of an input parameter limit

A new version will be released when breaking changes are made to the API.

In addition to the API version path, we sometimes introduce a local version on a specific endpoint method, suffixed by the version string. For example, a new local version of the Journal API might be introduced as `/v1/journals.v2`

## **Client Library**

There is currently no official language binding for Broker API while we are collecting the feedback from the initial users. 
We do, however, provide Open API [YAML](https://github.com/alpacahq/alpaca-docs/blob/master/oas/broker/openapi.yaml) file so that you can generate the client code for your language.

## **APIs**

### Account API

[Account API]({{< relref "/api-references/broker-api/accounts/accounts.md" >}}) allows
you to get a list of your customer accounts as well as firm accounts if they are
set up. This API is also for opening a new account of your customer with KYC
information if you are fully-disclosed, RIA or trading apps. If you choose the
non-disclosed model, you will use this API to create a new non-disclosed account
under your master account.

It's important to display to the end users about the transaction history in the
account. [Account Activity API]({{< relref "/api-references/broker-api/accounts/account-activities.md" >}}) can pull it for each
account or across accounts.

#### Onfido SDK Integration
For broker setups that utilize Alpaca’s KYC as a service for opening brokerage accounts we offer the ability to [integrate the Onfido SDK](https://alpaca.markets/learn/how-to-integrate-the-onfido-sdk-into-your-brokerage-app/) directly into your application. The [Onfido SDK](https://documentation.onfido.com/sdk/ios/) provides the ability to upload identifying documents and selfies with real-time validation to ensure that end users can only submit clear, valid documents. We’ll handle all of the direct communication with Onfido but you’ll need to integrate the SDK UI into your app. We introduced two new API requests to support this, one for [getting the SDK token](/docs/api-references/broker-api/accounts/accounts/#retrieving-an-onfido-sdk-token) and one for [patching the outcome of SDK flow](/docs/api-references/broker-api/accounts/accounts/#updating-the-onfido-sdk-outcome) so that we can initiate KYC upon completion. The integration will only be available for end users whose country of tax residence is outside of the United States and your onboarding process should follow the flow outlined below. Please note that this feature has to be enabled for you to begin testing it. Reach out to support@alpaca.markets to have this feature enabled.

![image](https://user-images.githubusercontent.com/24945583/153307201-0fc77821-799a-4724-af30-710890c8c636.png)

### Funding API (Bank + Transfer API)

Once an account is created, you need to fund the account to start trading. There
are many different funding methods Alpaca supports, and depending on where your
funding sources and methods are, the integration can differ. While you are
working in the sandbox environment, you can simulate the funding quickly by the
POST method, which would immediately credit or debit the account and make it
available for trading.

Alpaca supports various types of funding integration. We will discuss details when you go live but these are common cases.

- ACH funding with Plaid integration
- International wire transfers
- International Instant Deposits
- ACH bulk funding
- Pooled accounts
- Broker cash settlement

[Funding API]({{< relref "/api-references/broker-api/funding/transfers.md" >}}) can be
used to instruct direct customer funding as well as bulk transfer at your firm
level.

### Trading API

[Trading API]({{< relref "/api-references/broker-api/trading/orders.md" >}}) supports
the full functionality of Alpaca’s trading service. The endpoints are mapped
under the Broker API URL, but almost all endpoints are available and work the
same way as Trading API for traders.

Alpaca supports margin and short trading as well as fractional shares under Trading API. There is also commission model support under Broker API if you opt in.

Assets, Clock and Calendars API are mapped to the Broker API root endpoint, which allows you to use these endpoints without having a trading account ID.

### Journal API

[Journal API]({{< relref "/api-references/broker-api/journals" >}}) can move
cash and securities from a client account to another. A client account can be
your firm account, too. This allows you to implement features such as a cash
reward program by pooling your reward fund in your firm account and moving
appropriate amounts to the newly-signed up customer account. Journal API also
helps you design efficient funding operations if you are to transfer the
customer funds in bulk and book an individual amount to each customer account.

Journal API is to move cash and securities within Alpaca. For depositing and withdrawing the money into and out of Alpaca, you will use Transfer API. Note, there is a pre-configured amount of journal limit for each transaction and the journal and the request goes into pending-approval status if the amount exceeds the threshold. Otherwise, the transaction becomes effective immediately.

### Documents API

Alpaca generates important documents such as monthly statements and daily trade
confirmations, and we are required to make sure these are delivered to our end
customers. If you are a fully-disclosed setup, RIA, or technology partner, you
have to integrate with [Documents API]({{< relref
"/api-references/broker-api/documents/_index.md" >}}) to deliver these documents to
your end users. But the actual delivery method (whether you send them in email
or make it available in the mobile app UI) is up to you.

Voluntary corporate actions, proxies and prospectus are automatically sent via email to the end customer as needed. If you wish to change this method as well, please contact us.

### Events API

Alpaca Broker API provides replayable and real-time event streams via
[Server-Sent Event
(SSE)](https://html.spec.whatwg.org/multipage/server-sent-events.html). The SSE
protocol is a simple yet powerful protocol to satisfy a lot of your needs to
build flawless user experience. Each endpoint can be queried by the event
timestamp or monotonically incremental integer ID to seamlessly subscribe from
the past point-in-time event to the real-time pushes with a simple HTTP request.
While all SSE endpoints follow the same JSON object model as other REST
endpoints, SSE protocol is a lightweight addition on top of the basic HTTP
protocol which is a bit different from REST protocol. Please make sure your
client program handles the SSE protocol correctly.

Currently, [Events API]({{< relref "/api-references/broker-api/events/_index.md" >}})
supports various events such as account, trade, journal, activity events.

### OAuth API

Alpaca platform integrates with various trading platforms via OAuth, such as TradingView. If you want to leverage these platforms, you can use OAuth API to harness your own authentication into Alpaca’s OAuth architecture. As we do need to pre-configure the setup before you start integrating with OAuth API, please let us know beforehand.

&nbsp;
