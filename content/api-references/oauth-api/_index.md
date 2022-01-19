---
weight: 10
bookFlatSection: true
bookCollapseSection: true
title: OAuth API
summary: Develop applications on Alpaca’s platform using OAuth2.
---

# OAuth API Reference

The OAuth API allows you to request market data and manage portfolios on behalf of your end-users. For further details on the OAuth functionality, please see the [OAuth documentation]({{< ref path= "../../../../oauth/_index.md" >}}).

{{<hint info>}}***Note:*** Each endpoint may have different base URLs.{{</hint>}}

{{< rest-endpoint resource="oauth" method="GET" path="/oauth/authorize" >}}
#### Allowed Scopes

| Attribute         | Notes                                                                                        |
| ----------------- | -------------------------------------------------------------------------------------------- |
| `account:write`   | Write access for account configurations and watchlists.                                      |
| `trading`         | Place, cancel or modify orders.                                                              |
| `data`            | Access to the Data API.                                                                      |



{{< rest-endpoint resource="oauth" method="POST" path="/oauth/token" >}}


{{<hint danger>}}***Note:*** this request should take place behind-the-scenes from your backend server and shouldn’t be visible to the end users for security purposes.{{</hint>}}

{{<hint info>}}The content type must be `application/x-www-form-urlencoded` as defined in RFC.{{</hint>}}

#### Example Response
```json
{
    "access_token": "79500537-5796-4230-9661-7f7108877c60",
    "token_type": "bearer",
    "scope": "account:write trading"
}
```

