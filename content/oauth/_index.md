---
weight: 10
bookFlatSection: true
bookCollapseSection: true
title: OAuth Apps
summary: Open brokerage accounts, enable commission-free trading, and manage the ongoing user experience with Alpaca Broker API
isTopNav: true
topNavTitle: OAuth
topNavOrder: 4
---

## OAuth Apps

Develop applications on Alpaca's platform using OAuth2. Alpaca's OAuth allows you to seamlessly integrate financial markets into your application and expand your audience to the over 100K brokerage accounts on Alpaca's platform. Read [Register Your App]({{< relref "registration" >}}) to learn how you can register your app. In addition, you can visit [OAuth Integration Guide]({{< relref "guide" >}}) to learn more about using OAuth to connect your applications with Alpaca. 

## Broker Partners

Broker partners are able to create their own OAuth service. Allow your end users to use OAuth apps like TradingView through your Broker API application. Learn more about OAuth with Broker API in the [Broker API reference]({{< relref "../api-references/broker-api/oauth.md" >}})

## Terms of Access and Use

* You must read the terms and register in order to connect and use Alpaca's APIs
* All API clients must authenticate with OAuth 2.0
* You may not imply that the app was developed by Alpaca.
* If you are building a commercial application that makes money (including ads, in-app purchases, etc), you must disclose it in the registration form and receive written approval.
* To allow live trading for other users, the app needs to be approved by Alpaca. Please contact partnership@alpaca.markets.
* Live trading is allowed for the app developer user without approval.

*This is not an offer, solicitation of an offer, or advice to open a brokerage account. https://alpaca.markets/#disclosures*

## FAQs



- **Q: What can an OAuth app do?**
- A: OAuth allows you to manage your end-user's Alpaca brokerage account on their behalf. This means you can create many types of financial services including automated investing, portfolio analytics and much more. 


----

- **Q: Should I use OAuth or Broker API?**
- A: OAuth allows you to expand your audience to users with Alpaca brokerage accounts. On the otherhand, Broker API allows you to build an application fully within your environment. Users sign up for a brokerage account under your application. If you want to create your own brokerage, automated investment app, or any app where you want to own your users, use the Broker API. If you want to build your trading service on Alpaca's platform, use OAuth.

----

- **Q: How secure is OAuth?**
- A: OAuth2 itself is very secure. However you must make sure to follow good practices in how you handle tokens. Make sure to never publicly expose your client secret and access tokens. Learn more in the [API reference](../api-references/oauth-api/_index.md). 

----

- **Q: How to get OAuth App live?**
- A: You will need to register your app in the OAuth apps section of the dashboard. Learn more about [Register Your App](./registration.md). 

----

- **Q: I’m developing an app/service targeting non-US users. Can we integrate with Alpaca’s OAuth API?** 
- A: Alpaca's platform supports brokerage accounts for international users. When you build an app on OAuth, all users on Alpaca's platform will be able to use your service, including international users. 
  

  

