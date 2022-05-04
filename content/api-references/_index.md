---
bookFlatSection: false
bookCollapseSection: false
title: "API References"
weight: 20
---

# API Reference

{{< section >}}

## API Updates & Upgrades

In an effort to continuously provide value to our developers, Alpaca frequently performs updates and upgrades to our API that are important to understand and make sure as a developer you know what to expect, when to expect and how to properly handle certain scenarios.

## Backwards Compatible Changes

We consider any change to our API as updates when these are backwards compatible updates. For backwards compatibility, you as a developer with Alpaca can expect the following: 

- Adding new or similarly named APIs
- Adding new fields to already defined models and objects (API return objects, nested objects, etc.)
- Adding new items to a defined set (statuses, etc.)
- Enhancing ordering on how certain lists get returned

Generally, as a rule of thumb, any append or addition operation is considered a backwards compatible update and does not need an upfront communication. These updates should be backwards compatible with existing interfaces and not cause any disruption to any clients calling our APIs.

## Breaking changes

When and if Alpaca decides to perform breaking changes to our APIs the following should be expected:

- Upfront communication with sufficient time to allow developers to be able to react to new upcoming changes
- Our APIs are versioned, if breaking changes are intended we will generally bump the API version


{{<hint warning>}}
**Unexpected breaking changes**

We strive to avoid breaking changes without upfront planning and communication, however these can slip through in exceptional circumstances.

In the event a change occurs and you consider it a breaking change please reach out to support@alpaca.markets and we will do our best to work with you through the change.

{{</hint>}}