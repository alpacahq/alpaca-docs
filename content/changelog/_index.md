---
bookFlatSection: true
weight: 32
title: Changelog
summary: Open brokerage accounts, enable commission-free trading, and manage the ongoing user experience with Alpaca Broker API
---

# Changelog

### **2021-07-01**

{{<hint info>}}New Features {{</hint>}}

- Added [Portfolio History]({{< relref "../api-references/trading/portfolio-history" >}}) API

### **2021-06-22**

{{<hint info>}}New Features {{</hint>}}

- Added [Transfers API]({{< relref "../api-references/events/#transfer-events" >}}) and [Account NTAs]({{< relref "../api-references/events/#non-trading-activities-events" >}}) to SSE Events stream

### **2021-06-14**

{{<hint warning>}}Non-Breaking Changes{{</hint>}}

- Added a new field `execution_id` in SSE for trades updates ({{< relref "../api-references//events/#trade-updates" >}}).

### **2021-05-21**

{{<hint warning>}}Non-Breaking Changes{{</hint>}}

- Added a new field, "reason", to the [Transfer object]({{< relref "../api-references//funding/transfers/#the-transfer-object" >}}).

### **2021-05-18**

{{<hint info>}}New Features {{</hint>}}

- Added the ability to liquidate positions based on [percentage]({{< relref "../api-references/trading/positions/#closing-a-position" >}}).
- Introduced MFA to Broker Dashboard

### **2021-05-12**

{{<hint danger>}} Breaking Changes{{</hint>}}

- Imposed status check on `from_account` and `to_account` when performing a JNLC and JNLS.

### **2021-04-09**

{{<hint info>}}New Features {{</hint>}}

- Added new endpoint `POST /v1/accounts/{account_id}/documents/upload` to allow you to add documents to an existing account.

### **2021-03-19**

{{<hint info>}}New Features {{</hint>}}

- Added `PATCH` to accounts endpoint to allow you to edit account after creating them. Note that not all fields are patchable, for more info please click [here]({{< relref "../api-references/accounts/accounts/#updating-an-account" >}}).

{{<hint warning>}}Non-Breaking Changes{{</hint>}}

- Added new [fields]({{< relref "../api-references/accounts/accounts/#retrieving-an-account-trading-settings" >}}) to the response of `GET /v1/trading/accounts/{account_id}/account` endpoint.

### **2021-02-25**

{{<hint info>}}New Features {{</hint>}}

- Added support to [Assets]({{< relref "../api-references/assets" >}}), [Calendar]({{< relref "../api-references/clock" >}}) and [Clock]({{< relref "../api-references/calendar" >}}) API through Broker API endpoint.

### **2021-01-20**

{{<hint info>}}New Features {{</hint>}}

- Added support for [commissions]({{< relref "../api-references/trading/orders/#passing-commissions" >}}) on each order sent.

---

### **Legend**

{{<hint danger>}}### Breaking Changes{{</hint>}}

A breaking change is a change that would require you to go back to your integration with Alpaca and make some changes to ensure the continuity of service to your users.

We will all do all that is possible to make sure that we do not push any breaking changes. In all cases, we will communicate those changes before they take effect.

Example of breaking changes can be, but not limited to:

- Changes to required parameters
- New ENUM values

{{<hint warning>}}### Non-Breaking Changes{{</hint>}}

Non breaking changes are soft changes to existing functionality. Those changes have been tested against the current version of Broker API and has been cleared for release.

We will likely communicate those changes after they're made.

Some examples to those can be:

- New optional parameters to API endpoints
- Removal of optional parameters to API endpoints
- Addition of new fields to existing endpoints

{{<hint info>}}### New Features {{</hint>}}

Those are considered to be completely new functionality enabled by Broker API.

---
