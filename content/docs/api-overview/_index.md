---
weight: 2
bookFlatSection: true
title: "API Overview"
---

# API Overview

Alpaca Broker API consists of different APIs that help you build your investment services and products depending on your needs. Here we describe some of the common features that can give you a high level idea about where to start.

## Endpoints

| Environment | URL                                        |
| ----------- | ------------------------------------------ |
| Sandbox     | https://broker-api.sandbox.alpaca.markets/ |
| Production  | https://broker-api.alpaca.markets/         |

---

## Authentication and Rate Limit

Broker API must authenticate using HTTP Basic authentication. Use your correspondent API key ID and secret as the username and password. The format is key_id:secret. Encode the string with base-64 encoding, and you can pass it as an authentication header.

**Example**

```
Authorization: Basic Y2xpZW50X2lkOmNsaWVudF9zZWNyZXQ=
```

API keys are different in each environment. Please make sure you are using the right API key with the right endpoint URL.

Broker API has a rate limit of 1,000 calls per minute. The rate limits are described in the HTTP response with the following fields.

| Header Field          | Value                                             |
| --------------------- | ------------------------------------------------- |
| x-ratelimit-limit     | The API call limit                                |
| x-ratelimit-remaining | The remaining quota until reset                   |
| x-ratelimit-reset     | The UNIX epoch in seconds when the quota is reset |

---

## General Rules

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

### Client Library

There is currently no official language binding for Broker API while we are collecting the feedback from the initial users. We do, however, provide Open API YAML file so that you can generate the client code for your language.
