---
bookFlatSection: true
weight: 2
title: Alpaca API Platform
---

# Alpaca API Platform

## Why API?

Alpaca’s features to access financial markets are provided primarily via API. We
believe API is the means to interact with services such as ours and innovate
your business. Our API is designed to fit your needs and we continue to build
what you need.

## REST, SSE and websockets

Our API is primarily built in the REST style. It is a simple and powerful way to
integrate with our services.

In addition to the REST API which replies synchronous communication, our API
includes asynchronous event API which is based on WebSocket and SSE, or
Server-Sent Events. As many types of events occur in the financial markets
(orders fill based on the market movement, cash settles after some time, etc),
this event-based API helps you get updates instantly and provide the best user
experiences to your customers.

## FIX API

The FIX (Financial Information Exchange) protocol for the user API support is on
the roadmap. If you have needs for this support, please contact us so that we
can assess the priority.

## Architecture

Alpaca’s platform consists of APIs, Web dashboards, trade simulator, sandbox
environment, authentication services, order management system, trading routing,
back office accounting and clearing system, and all of these components are
built in-house from ground up with the modern architecture.

The Alpaca platform is currently hosted on the Google Cloud Platform in the
us-east4 region. The site is connected with dedicated fiber lines to a data
center in Secaucus, NJ, to cross-connect with various market venues.

Under the hood, Alpaca works with various third parties. We work with Velox
Clearing for trade clearing and settlement on DTCC. Cash transfers and custody
are primarily provided by First Republic Bank. Citadel Securities, Virtu
America, Clearstreet, Wolverine Trading and other execution providers provide
execution services for our customer orders. We integrate with ICE Data Services
for various kinds of market data.

&nbsp;
