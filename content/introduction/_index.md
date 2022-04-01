---
bookFlatSection: true
title: Overview
weight: 1
summary:
---

# Overview

## **Who is Alpaca?**

### A little bit of history of the company and founders

Alpaca is a technology company headquartered in Silicon Valley that builds
commission-free stock trading through API (Brokerage services are provided by
Alpaca Securities LLC, a member of
[FINRA](https://finra.org)/[SIPC](https://sipc.org)). We are a team of diverse
background individuals with deep financial and technology expertise, backed by
some of the top investors in the industry globally. We are proud to be supported
by the love of enthusiastic community members on [various
platforms](https://alpaca.markets/community).

Alpaca’s globally distributed team consists of developers, traders, and brokerage business specialists, who collectively have decades of financial services and technology industry experience at organizations such as FINRA, Apple, Wealthfront, Robinhood, EMC, Cloudera, JP Morgan, and Lehman Brothers. Alpaca is co-founded and led by [Yoshi Yokokawa](https://www.linkedin.com/in/yoshiyokokawa/) (CEO) and [Hitoshi Harada](https://www.linkedin.com/in/hitoshi-harada-02b01425/) (CTO/CPO). Our investors include a group of well-capitalized investors including Portage Ventures, Spark Capital, Tribe Capital, Social Leverage, Horizons Ventures, Elderidge, and Y Combinator as well as highly experienced industry angel investors such as Joshua S. Levine (former CTO/COO of ETRADE), Nate Rodland (former COO of Robinhood & GP of Elefund), Patrick O’Shaughnessy (“Invest Like the Best” podcast host & Partner of Positive Sum), Jacqueline Reses (former Executive Chairman of Square Financial Services), Asiff Hirjii (former President/COO of Coinbase), Aaron Levie (CEO of Box), and founders of leading Fintech companies including Plaid and Wealthsimple.

### Vision

Our vision is to allow the 7 billion people on the planet to access financial
markets. We are committed to providing a secure, reliable and compliant platform
for anyone who wants to build their own trading strategies, asset management
automation, trading and robo-advisor apps, new brokerage services, investment
advisory services and investment products. It is important for us to have a
variety of developers who build exciting things using our API.

### What services does Alpaca provide?

Alpaca provides trading and clearing services for US equities under its
subsidiary Alpaca Securities LLC. We currently support stocks, ETFs listed in
the US public exchanges (NMS stocks) and cryptocurrencies. Support for other asset classes, such as
options, futures, FX, private equities, and international
equities are on our roadmap.

We work with retail traders and institutional investors directly, and also work
with app developers, broker-dealers globally, investment advisors and fintech
companies that offer US stock investing features to their end customers, both in
and out of the United States.

To serve our customers, we provide Web API, Web dashboards, market data, paper
trading simulation, API sandbox environment, and community platforms.

## **Audience**

This document is written primarily about our API-first products built for developers and product owners who build trading apps, investment products, and brokerage services. Alpaca products cater both individuals and businesses.

## API Platform

### **Why API?**

Alpaca’s features to access financial markets are provided primarily via API. We
believe API is the means to interact with services such as ours and innovate
your business. Our API is designed to fit your needs and we continue to build
what you need.

### **REST, SSE and Websockets**

Our API is primarily built in the REST style. It is a simple and powerful way to
integrate with our services.

In addition to the REST API which replies via synchronous communication, our API
includes an asynchronous event API which is based on WebSocket and SSE, or
[Server-Sent
Events](https://html.spec.whatwg.org/multipage/server-sent-events.html).
As many types of events occur in the financial markets (orders fill based on the
market movement, cash settles after some time, etc), this event-based API helps
you get updates instantly and provide the best user experiences to your
customers.

### **FIX API**

The FIX (Financial Information Exchange) protocol for the user API support is on
the roadmap. If you have needs for this support, please contact us so that we
can assess the priority.

### **Architecture**

Alpaca’s platform consists of APIs, Web dashboards, trade simulator, sandbox
environment, authentication services, order management system, trading routing,
back office accounting and clearing system, and all of these components are
built in-house from the ground up with modern architecture.

The Alpaca platform is currently hosted on the Google Cloud Platform in the
us-east4 region. The site is connected with dedicated fiber lines to a data
center in Secaucus, NJ, to cross-connect with various market venues.

Under the hood, Alpaca works with various third parties. We work with Velox Clearing and Vision Financial for equities trade clearing and settlement on DTCC. Cash transfers and custody are primarily provided by BMO Harris and Silicon Valley Bank. Citadel Securities, Virtu America, Jane Street, UBS, and other execution providers provide execution services for our customer orders. We integrate with ICE Data Services for various kinds of market data.


&nbsp;



&nbsp;
