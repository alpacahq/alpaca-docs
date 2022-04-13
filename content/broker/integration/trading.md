---
weight: 7
title: Trading
summary: Open brokerage accounts, enable commission-free trading, and manage the ongoing user experience with Alpaca Broker API
---

# Trading

All the functionality from Alpaca Trading API for direct users is supported
under Broker API. Please read the [documentation](https://alpaca.markets/docs)
for more details.

There are additional capabilities for Trading API in the broker setup.

## **Fractional Shares**

Under the correspondent authentication, Trading API is extended for fractional shares trading.

### Asset API

Asset entity has an extra field named `fractionable` with type boolean, it is set to true if the asset is marked for fractional trading. Check out more about our Assets API [here]({{< relref "../../../api-references/broker-api/assets.md" >}}).

### Order API

The POST method (to submit order) has an extra parameter called `notional` to denote the dollar amount to buy. This parameter is mutually exclusive to the `qty` parameter. You can also specify the “qty” parameter with fractional quantity. Note that the fractional shares trading is currently supported only for market day orders and any other type of orders will result in API error. You can submit such fractional share orders in the night to execute at the next market open.

The order entity includes the `notional` value if the order was submitted with the notional value. In this case, the order entity omits the `qty` field.

### Account Configuration API

Account configuration API adds another configuration key called “fractional_trading” and defaults to true. If you want to disable fractional trading for a specific account for any reason, you can set this to false.

## **Commissions**

You have the option to charge the
commission for each order. You will need to contact Alpaca first to set up the
commission structure, but once it’s set up, you can submit customer orders with
a `commission` parameter indicating the dollar amount to charge. The respective
field is attached in the order entity in the API response.

## **Order Sub-tagging (Omnibus)**

If you are an omnibus setup, we ask you to submit a “sub-tag” value in each
order. This is for us to understand the order flow better from the trade
surveillance requirements. In case you fail to attach proper sub-tags, we may
need to reject all of the order flows coming from you as we may not be able to
segregate particular malicious activities.

&nbsp;
