---
bookHidden: false
weight: 10
title: Setups
---

## Overview

When you integrate with Alpaca Broker API, you may want to check about
the status of your business. There are several cases as follows.

- Fully-disclosed broker dealer
- RIA (Registered Investment Advisor)
- Non-financial institution / technology provider
- Non-disclosed broker dealer
- Omnibus

Depending on the type of the setup, the API methods you want to use could
vary. For example, the Omnibus setup never uses API to open a customer account
since the trading accounts are created upfront and you will submit orders
to them, and manage your end customer accounting on your end.

### Fully-disclosed broker dealer

The fully-disclosed broker dealer means your end customers are introduced
to Alpaca on the individual basis, and we need to see each customer's
information to provide our service.

If you are a broker dealer under some juristiction, you can own end-to-end
user experiences from account opening to reporting. You are responsible
for KYC and AML, and Alpaca relies on your process after we review it,
to meet our regulatory requirements.

In this setup, you will use most of the API methods such as the Account,
Transfer and Trading API. In addition, you can move the cash and securities
between your firm account and end-customer accounts using the Journal API
to implement features such as reward program.

You can 