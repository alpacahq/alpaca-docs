---
bookFlatSection: false
bookCollapseSection: false
title: "API References"
weight: 20
---

# API Reference

{{< section >}}

## API Updates & Upgrades

In an effort to continously provide value to our developers, Alpaca frequently performs updates and upgrades to our API that are important to understand and make sure as a developer you know what to expect, when to expect and how to properly handle certain scenarios.

## Backwards Compatible Changes

We consider any changes to our our API as updates when these are backwards compatible updates. Backwards compatible you as a developer with Alpaca can expect are the following: 

- Adding new or similarly named APIs
- Adding new fields to already defined models and objects (API return objects, nested objects, etc.)
- Adding new items to a defined set (statuses, etc.)
- Enhancing ordering on how certain lists get returned

Generally, as a rule of thumb, any append or addition operation is considered a backwards compatible update and does not need a upfront communication. These updates should be backwards compatible with existing interfaces and not cause any disruption to any clients calling our APIs.

## Breaking changes

When and if Alpaca decides to perform breaking changes to our APIs the following should be expected:

- Upfront communication with sufficient time for our developers to be able to react to new upcoming changes
- Our APIs are versioned, if breaking changes are intended we will generally bump the API version


{{<hint warning>}}
**Unexpected breaking changes**

While we strive to avoid breaking changes without upfront planning, these can and might slip through.

In the event a change occurs and you consider it a breaking change please reach out to support@alpaca.markets.

{{</hint>}}