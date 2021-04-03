---
bookHidden: false
weight: 2
title: Alpaca's API
---

# Alpaca API Overview

## Audience

This document is written primarily about our Broker API built for developers and product owners who build investment products and brokerage services. If you are a retail or institutional trader who aims to invest your own fund, please read the [Trading API documentation](https://alpaca.markets/docs/).

## Why API

Alpaca’s features to access financial markets are provided primarily via API. We believe API is the means to interact with services such as ours and innovate your business. Our API is designed to fit your needs and we continue to build that you need.

## REST, SSE and Websockets

Our API is primarily built in the REST style. It is a simple and powerful way to integrate with our services.

In addition to the REST API which replies synchronous communication, our API includes asynchronous event API which is based on WebSocket and SSE, or Server-Sent Events. As many types of events occur in the financial markets (orders fill based on the market movement, cash settles after some time, etc), this event-based API helps you get updates instantly and provide the best user experiences to your customers.

## Architecture

Alpaca’s platform consists of APIs, Web dashboards, trade simulator, sandbox environment, authentication services, order management system, trading routing, back office accounting and clearing system, and all of these components are built in-house from ground up with the modern architecture.

The main system of Alpaca platform is currently hosted in Google Cloud Platform in the us-east4 region. The site is connected with dedicated fiber lines to a data center in Secaucus, NJ, to cross-connect with various market venues.

Under the hood, Alpaca works with various third parties. We work with Velox Clearing for trade clearing and settlement on DTCC. Cash transfers and custody are primarily provided by First Republic Bank. Citadel Securities, Virtu America, Clearstreet, Wolverine Trading and other execution providers provide execution services for our customer orders. We integrate with ICE Data Services for various kinds of market data.

## What is Broker-Dealer

A broker-dealer is a person or a firm that trades securities on behalf of its customers and/or for itself.

### Business Model

Securities brokers traditionally generate revenue in multiple ways including charging trading commissions, marking up margin lending rates and stock loan, keeping interest on cash deposits, receiving payment for order flow by routing orders to market makers, and marking up the data feed subscription.
Although we do not charge commissions, Alpaca may generate revenue in some of the same ways as traditional online brokerages. These include:

- Interest on cash deposits
- Payment for order flow (“PFOF”) - Alpaca receives remuneration for routing your orders to market makers and exchanges. PFOF helps us offset the expense that occurs when clearing and executing our customers’ trades. You can read more about PFOF in our Medium post here. For Alpaca Securities SEC Rule 606 disclosures, please click here. It is important to note that our customers are not charged.
- Margin financing - Alpaca may charge interest for margin loans.
- Stock loan - Alpaca may charge stock loan fees for users who want to borrow stock to short sell.
