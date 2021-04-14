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

### `POST /v1/trading/accounts/{account_id}/orders`

When making an order API request, make sure that the correct `account_id` is passed in the request URL.

There are a lot of attributes that you can pass in the Order request body, found [here]({{< relref "../api-references/trading/orders" >}}), however the following are the **minumum** required attributes for a n order to be successfully accepted by Alpaca

```JSON
{
 "symbol": "AAPL",
 "qty": 4,
 "side": "buy",
 "type": "market",
 "time_in_force": "day"
}
```

## 2: Successful Response

In the case of a successful order being passed to Alpaca, you will receive an order object in the response.

```json
{
  "id": "61e69015-8549-4bfd-b9c3-01e75843f47d",
  "client_order_id": "eb9e2aaa-f71a-4f51-b5b4-52a6c565dad4",
  "created_at": "2021-03-16T18:38:01.942282Z",
  "updated_at": "2021-03-16T18:38:01.942282Z",
  "submitted_at": "2021-03-16T18:38:01.937734Z",
  "filled_at": null,
  "expired_at": null,
  "canceled_at": null,
  "failed_at": null,
  "replaced_at": null,
  "replaced_by": null,
  "replaces": null,
  "asset_id": "b0b6dd9d-8b9b-48a9-ba46-b9d54906e415",
  "symbol": "AAPL",
  "asset_class": "us_equity",
  "notional": "500",
  "qty": null,
  "filled_qty": "0",
  "filled_avg_price": null,
  "order_class": "",
  "order_type": "market",
  "type": "market",
  "side": "buy",
  "time_in_force": "day",
  "limit_price": null,
  "stop_price": null,
  "status": "accepted",
  "extended_hours": false,
  "legs": null,
  "trail_percent": null,
  "trail_price": null,
  "hwm": null,
  "commission": 1.25
}
```

For more information on orders, please check out more our API References on orders [here]({{< relref "../api-references/trading/orders" >}}).
