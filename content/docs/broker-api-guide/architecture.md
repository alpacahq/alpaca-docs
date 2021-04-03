---
bookHidden: false
weight: 3
title: Architecture
---

# Architecture

Alpaca’s platform consists of APIs, Web dashboards, trade simulator, sandbox environment, authentication services, order management system, trading routing, back office accounting and clearing system, and all of these components are built in-house from ground up with the modern architecture.

The Alpaca platform is currently hosted on the Google Cloud Platform in the us-east4 region. The site is connected with dedicated fiber lines to a data center in Secaucus, NJ, to cross-connect with various market venues.

Under the hood, Alpaca works with various third parties. We work with Velox Clearing for trade clearing and settlement on DTCC. Cash transfers and custody are primarily provided by First Republic Bank. Citadel Securities, Virtu America, Clearstreet, Wolverine Trading and other execution providers provide execution services for our customer orders. We integrate with ICE Data Services for various kinds of market data.
