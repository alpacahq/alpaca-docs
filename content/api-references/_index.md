---
bookFlatSection: false
bookCollapseSection: false
title: "API References"
weight: 20
---

# API Reference

{{< section >}}

## API Updates & Upgrades

In an effort to continuously provide value to our developers, Alpaca frequently performs updates and upgrades to our API.

We've added the following sections to our docs in order to help make sure that as a developer you know what to expect, when to expect, and how to properly handle certain scenarios .

### Backwards Compatible Changes

You should expect any of the following kind of changes that we make to our API to be considered a backwards compatible change:

- Adding new or similarly named APIs
- Adding new fields to already defined models and objects such as API return objects, nested objects, etc. (Example: adding a new `code` field to error payloads)
- Adding new items to defined sets or enumerations such as statuses, supported assets, etc. (Example: adding new account status to a set of all possiv`)
- Enhancing ordering on how certain lists get returned
- Supporting new HTTP versions (HTTP2, QUIC)
- Adding new HTTP method(s) for an existing endpoint
- Expecting new HTTP request headers (eg. new authentication)
- Sending new HTTP headers (eg. HTTP caching headers, gzip encoding, etc.)
- Increasing HTTP limits (eg. Nginx large-client-header-buffers)
- Increasing rate limits
- Supporting additional SSL/TLS versions

Generally, as a rule of thumb, any append or addition operation is considered a backwards compatible update and does not need an upfront communication. These updates should be backwards compatible with existing interfaces and not cause any disruption to any clients calling our APIs.

### Breaking Changes

When and if Alpaca decides to perform breaking changes to our APIs the following should be expected:

- Upfront communication with sufficient time to allow developers to be able to react to new upcoming changes
- Our APIs are versioned, if breaking changes are intended we will generally bump the API version. IE a route might go from being `/v1/accounts/{account_id}` to `/v2/accounts/{account_id}` if we had to make a breaking change to either the parameters it can take or its return structure


{{<hint warning>}}
**Unexpected breaking changes**

We strive to avoid breaking changes without upfront planning and communication, however these can slip through in exceptional circumstances.

In the event a change occurs and you consider it a breaking change please reach out to support@alpaca.markets and we will do our best to work with you through the change.

{{</hint>}}
