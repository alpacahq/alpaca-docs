---
title: Get Started
type: docs
description: First steps to build something awesome with Alpaca.
---

## API Key

In order to get started with Broker API, you need to obtain API key.
API key is a pair of ID and secret which serves the similar purpose
as user name and password. In fact, the HTTP requests are authenticated
with HTTP Basic Authentication with the user name being your key ID and
password being your key secret.  Below is the example of how you use
the API key to make an HTTP request for an API endpoint.

```sh
$ curl -u $KEY_ID:$KEY_SCRET https://broker-api.sandbox.alpaca.markets/v1/accounts
```

Note you pass the `-u` switch to pass the Basic Authentication user name
and password.
