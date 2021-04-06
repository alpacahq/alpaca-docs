---
date: 2021-04-03
linktitle: Passing Your First Order
menu:
  main:
    parent: tutorials
title: Passing Your First Order
weight: 3
---

We designed passing order on Alpaca to be easier than ever.

Let’s create a raw request to pass an order on behalf of the end-user below. In this tutorial, we will be placing a market order to buy 4 shares of AAPL with time in force = day. As we want to pass an order for one of our end users we need to specify the account_id in our endpoint: v1/trading/accounts/{account_id}/orders

It is worth noting that the Trading API (for Broker API) works the same way as the public Trading API, but the path differs to include the account id, and the request is authenticated using the broker API key.

## 1: Passing the Request Body

`POST /v1/trading/accounts/{account_id}/orders`

When making an order API request, make sure that the correct `account_id` is passed in the request URL.

There are a lot of attributes that you can pass in the Order request body, found [here](/docs/resources/trading/orders), however the following are the **minumum** required attributes for a n order to be successfully accepted by Alpaca

```JSON
{
 "symbol": "AAPL",
 "qty": 4,
 "side": "buy",
 "type": "market",
 "time_in_force": "day"
}
```
