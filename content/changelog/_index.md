---
bookFlatSection: true
weight: 32
title: Changelog
summary: Open brokerage accounts, enable commission-free trading, and manage the ongoing user experience with Alpaca Broker API
---

# Changelog

{{<hint danger>}}Breaking Changes{{</hint>}}

{{<hint warning>}}Non-Breaking Changes{{</hint>}}

{{<hint info>}}New Features {{</hint>}}

---

### **2021-05-18**

{{<hint info>}}New Features {{</hint>}}

- Added the ability to liquidate positions based on [percentage]({{< relref "../api-references/trading/positions/#closing-a-position" >}}).
- Introduced MFA to Broker Dashboard

### **2021-05-12**

{{<hint warning>}}Non-Breaking Changes{{</hint>}}

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
