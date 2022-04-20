---
title: Streaming
weight: 90
---

# Streaming

Alpaca’s API offers WebSocket streaming for trade, account, and order updates which
follows the [RFC6455 WebSocket protocol](https://datatracker.ietf.org/doc/html/rfc6455).

To connect to the WebSocket follow the standard opening handshake as defined by the RFC specification to
`wss://paper-api.alpaca.markets/stream` or `wss://api.alpaca.markets/stream`. Alpaca’s streaming service
supports both JSON and MessagePack codecs.

Once the connection is authorized, the client can listen to the `trade_updates` stream to get updates on
trade, account, and order changes.

Note: The `trade_updates` stream coming from `wss://paper-api.alpaca.markets/stream` uses binary frames,
which differs from the text frames that comes from the `wss://data.alpaca.markets/stream` stream.

In order to listen to streams, the client sends a `listen` message to the server as follows:

```json
{
  "action": "listen",
  "data": {
    "streams": ["trade_updates"]
  }
}
```

The server acknowledges by replying a message in the listening stream.

```json
{
  "stream": "listening",
  "data": {
    "streams": ["trade_updates"]
  }
}
```

If any of the requested streams are not available, they will not appear in the streams list in the
acknowledgement. Note that the streams field in the listen message is to tell the set of streams
to listen, so if you want to stop receiving updates from the stream, you must send an empty list of
streams values as a listen message. Similarly, if you want to add more streams to get updates in
addition to the ones you are already doing so, you must send all the stream names, not only the new ones.

Subscribing to real-time trade updates ensures that a user always has the most up-to-date picture of
their account actvivity.

Note: to request with MessagePack, add the header: `Content-Type: application/msgpack`.

## Authentication

The WebSocket client can be authenticated using the same API key when making HTTP requests.
Upon connecting to the WebSocket, client must send an authentication message over the
WebSocket connection with the API key and secret key as its payload.

```json
{
  "action": "authenticate",
  "data": {
    "key_id": "{YOUR_API_KEY_ID}",
    "secret_key": "{YOUR_API_SECRET_KEY}"
  }
}
```

The server will then authorize the connection and respond with either an authorized (successful)
response

```json
{
  "stream": "authorization",
  "data": {
    "status": "authorized",
    "action": "authenticate"
  }
}
```

or an unauthorized (unsuccessful) response:

```json
{
  "stream": "authorization",
  "data": {
    "status": "unauthorized",
    "action": "authenticate"
  }
}
```

In the case that the socket connection is not authorized yet, a new message under the authorization
stream is issued in response to the listen request.

```json
{
  "stream": "authorization",
  "data": {
    "status": "unauthorized",
    "action": "listen"
  }
}
```

## Trade Updates

With regards to the account associated with the authorized API keys, updates for orders placed
at Alpaca are dispatched over the WebSocket connection under the event `trade_updates`. These messages
include any data pertaining to orders that are executed with Alpaca. This includes order fills,
partial fills, cancellations and rejections of orders. Clients may listen to this stream by sending
a listen message:

```json
{
  "action": "listen",
  "data": {
    "streams": ["trade_updates"]
  }
}
```

Any listen messages received by the server will be acknowledged via a message on the
`listening` stream. The message’s data payload will include the list of streams the client
is currently listening to:

```json
{
  "stream": "listening",
  "data": {
    "streams": ["trade_updates"]
  }
}
```

The fields present in a message sent over the `trade_updates` stream depend on the type of event
they are communicating. All messages contain an `event` type and an `order` field, which is the same
as the [order object](../orders/#order-entity)
that is returned from the REST API. Potential event types and additional fields that will be
in their messages are listed below.

### Common Events

These are the events that are the expected results of actions you may have taken by sending API requests.

- `new`: Sent when an order has been routed to exchanges for execution.
- `fill`: Sent when an order has been completely filled.
  - _timestamp_: The time at which the order was filled.
  - _price_: The average price per share at which the order was filled.
  - _position_qty_: The total size of your position after this event, in shares. Positive for long positions, negative for short positions.
- `partial_fill`: Sent when a number of shares less than the total remaining quantity on your order has been filled.
  - _timestamp_: The time at which the order was partially filled.
  - _price_: The average price per share at which the order was filled.
  - _position_qty_: The total size of your position after this event, in shares. Positive for long positions, negative for short positions.
- `canceled`: Sent when your requested cancelation of an order is processed.
  - _timestamp_: The time at which the order was canceled.
- `expired`: Sent when an order has reached the end of its lifespan, as determined by the order’s time in force value.
  - _timestamp_: The time at which the order was expired.
- `done_for_day`: Sent when the order is done executing for the day, and will not receive further updates until the next trading day.
- `replaced`: Sent when your requested replacement of an order is processed.
  - _timestamp_: The time at which the order was replaced.

### Less Common Events

These are events that may rarely be sent due to uncommon circumstances on the exchanges. It is unlikely
you will need to design your code around them, but you may still wish to account for the possibility that
they can occur.

- `rejected`: Sent when your order has been rejected.
  - _timestamp_: The time at which the order was rejected.
- `pending_new`: Sent when the order has been received by Alpaca and routed to the exchanges, but has not yet been accepted for execution.
- `stopped`: Sent when your order has been stopped, and a trade is guaranteed for the order, usually at a stated price or better, but has not yet occurred.
- `pending_cancel`: Sent when the order is awaiting cancelation. Most cancelations will occur without the order entering this state.
- `pending_replace`: Sent when the order is awaiting replacement.
- `calculated`: Sent when the order has been completed for the day - it is either “filled” or “done_for_day” - but remaining settlement calculations are still pending.
- `suspended`: Sent when the order has been suspended and is not eligible for trading.
- `order_replace_rejected`: Sent when the order replace has been rejected.
- `order_cancel_rejected`: Sent when the order cancel has been rejected.

## Example

An example of a message sent over the `trade_updates` stream looks like:

```json
{
  "stream": "trade_updates",
  "data": {
    "event": "fill",
    "execution_id": "2f63ea93-423d-4169-b3f6-3fdafc10c418",
    "order": {
      "asset_class": "crypto",
      "asset_id": "1cf35270-99ee-44e2-a77f-6fab902c7f80",
      "cancel_requested_at": null,
      "canceled_at": null,
      "client_order_id": "4642fd68-d59a-47d7-a9ac-e22f536828d1",
      "created_at": "2022-04-19T13:45:04.981350886-04:00",
      "expired_at": null,
      "extended_hours": false,
      "failed_at": null,
      "filled_at": "2022-04-19T17:45:05.024916716Z",
      "filled_avg_price": "105.8988475",
      "filled_qty": "1790.86",
      "hwm": null,
      "id": "a5be8f5e-fdfa-41f5-a644-7a74fe947a8f",
      "legs": null,
      "limit_price": null,
      "notional": null,
      "order_class": "",
      "order_type": "market",
      "qty": "1790.86",
      "replaced_at": null,
      "replaced_by": null,
      "replaces": null,
      "side": "sell",
      "status": "filled",
      "stop_price": null,
      "submitted_at": "2022-04-19T13:45:04.980944666-04:00",
      "symbol": "SOLUSD",
      "time_in_force": "gtc",
      "trail_percent": null,
      "trail_price": null,
      "type": "market",
      "updated_at": "2022-04-19T13:45:05.027690731-04:00"
    },
    "position_qty": "0",
    "price": "105.8988475",
    "qty": "1790.86",
    "timestamp": "2022-04-19T17:45:05.024916716Z"
  }
}
```
