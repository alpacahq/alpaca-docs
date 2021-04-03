---
bookFlatSection: true
weight: 7
title: Trading
---

# Trading

All the functionality from Alpaca Trading API for direct users is supported
under Broker API. Please read the [documentation](https://alpaca.markets/docs)
for more details.

There are additional capabilities for Trading API in the broker setup.

## Commission

While Alpaca is a commission-free broker, you have the option to charge the
commission for each order. You will need to contact Alpaca first to set up the
commission structure, but once it’s set up, you can submit customer orders with
a `commission` parameter indicating the dollar amount to charge. The respective
field is attached in the order entity in the API response.

## Order Sub-tagging (Omnibus)

If you are an omnibus setup, we ask you to submit a “sub-tag” value in each
order. This is for us to understand the order flow better from the trade
surveillance requirements. In case you fail to attach proper sub-tags, we may
need to reject all of the order flows coming from you as we may not be able to
segregate particular malicious activities.
