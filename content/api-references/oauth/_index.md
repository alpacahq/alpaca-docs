---
bookHidden: false
bookFlatSection: true
weight: 10
title: OAuth
summary: Open brokerage accounts, enable commission-free trading, and manage the ongoing user experience with Alpaca Broker API
---

# OAuth

Allow Alpaca users to connect their accounts to your application using OAuth2.

{{< hint info >}}
**For Broker API Partners**  
If your looking to enable OAuth app access (e.g. TradingView) for your users [see
Broker API OAuth reference](/docs/api-references/broker-api/oauth/).
{{< /hint >}}


---

## **Retrieve a `client_id`**

`GET /v1/oauth/clients/{client_id}`

### Request

#### Sample Request

```json
{
  "response_type": "token",
  "redirect_uri": "www.example.com/oauth_redirect",
  "scope": "general"
}
```

#### Parameters

| Attribute       | Type   | Notes                              |
| --------------- | ------ | ---------------------------------- |
| `response_type` | string | ENUM: `code` or `token`            |
| `redirect_uri`  | string | Redirect URI of the OAuth flow     |
| `scope`         | string | Requested scopes by the OAuth flow |

### Response

#### Sample Response

```json
{
  "client_id": "7a3c52a910e1dc2abbb14da2b6b8e711",
  "name": "TradingApp",
  "description": "Sample description",
  "url": "http://test.com",
  "terms_of_use": "",
  "privacy_policy": "",
  "status": "ACTIVE",
  "redirect_uri": ["http://localhost"],
  "live_trading_approved": false
}
```

#### Parameters

| Attribute               | Type    | Notes                        |
| ----------------------- | ------- | ---------------------------- |
| `client_id`             | string  | OAuth client id              |
| `name`                  | string  | Broker name (your name)      |
| `description`           | string  |                              |
| `url`                   | string  |                              |
| `terms_of_use`          | string  | URL of ToS                   |
| `privacy_policy`        | string  | URL of PP                    |
| `status`                | string  | ENUM: `ACTIVE` or `DISABLED` |
| `redirect_uri`          | string  |                              |
| `live_trading_approved` | boolean |                              |

#### Error Codes

{{<hint warning>}}**`401`** - Unauthorized

_Client does not exist, or you do not have access to the client_
{{</hint>}}

{{<hint warning>}}**`500`** - Internal Server Error

_Some server error occurred. Please contact Alpaca._
{{</hint>}}

---

## **Create an OAuth Token**

`POST /v1/oauth/token`

### Request

#### Sample Request

#### Parameters

| Attribute       | Type           | Requirement                           | Notes                          |
| --------------- | -------------- | ------------------------------------- | ------------------------------ |
| `client_id`     | string         | {{<hint danger>}}Required {{</hint>}} | OAuth `client_id`              |
| `client_secret` | string         | {{<hint danger>}}Required {{</hint>}} | OAuth `client_secret`          |
| `redirect_uri`  | string         | {{<hint danger>}}Required {{</hint>}} | Redirect URI of OAuth flow     |
| `scope`         | string/numeric | {{<hint danger>}}Required {{</hint>}} | Requested scopes by OAuth flow |
| `account_id`    | string         | {{<hint danger>}}Required {{</hint>}} | UUID of end user               |

### Response

#### Sample Response

```json
{
  "access_token": "87586f14-c3f4-4912-b107-f75bc17ff87a",
  "token_type": "Bearer"
}
```

#### Parameters

| Attribute      | Type   | Notes           |
| -------------- | ------ | --------------- |
| `access_token` | string | OAuth token     |
| `token_type`   | string | Always `Bearer` |
| `scope`        | string | Token's scope   |

##### Error Codes

{{<hint warning>}}**`401`** - Unauthorized

_Client does not exist, or you do not have access to the client, or `client_secret` is incorrect._
{{</hint>}}

{{<hint warning>}}**`422`** - Unprocessable Entity

_Redirect URI or scope is invalid_
{{</hint>}}

{{<hint warning>}}**`500`** - Internal Server Error

_Some server error occurred. Please contact Alpaca._
{{</hint>}}

---

## **Authorize an OAuth Token**

`POST /v1/oauth/authorize`

### Request

#### Parameters

| Attribute       | Type           | Requirement                           | Notes                          |
| --------------- | -------------- | ------------------------------------- | ------------------------------ |
| `client_id`     | string         | {{<hint danger>}}Required {{</hint>}} | OAuth `client_id`              |
| `client_secret` | string         | {{<hint danger>}}Required {{</hint>}} | OAuth `client_secret`          |
| `redirect_uri`  | string         | {{<hint danger>}}Required {{</hint>}} | Redirect URI of OAuth flow     |
| `scope`         | string/numeric | {{<hint danger>}}Required {{</hint>}} | Requested scopes by OAuth flow |
| `account_id`    | string         | {{<hint danger>}}Required {{</hint>}} | UUID of end user               |

### Response

#### Sample Response

```json
{
  "code": "912b5502-c983-40f7-a01d-6a66f13a754d",
  "client_id": "7a3c52a910e1dc2abbb14da2b6b8e711",
  "redirect_uri": "http://localhost",
  "scope": ""
}
```

#### Parameters

| Attribute      | Type   | Notes                             |
| -------------- | ------ | --------------------------------- |
| `code`         | string | OAuth code to exchange with token |
| `client_id`    | string | OAuth `client_id`                 |
| `redirect_uri` | string | Redirect URI of OAuth flow        |
| `scope`        | string | Granted scopes                    |

#### Error Codes

{{<hint warning>}}**`401`** - Unauthorized

_Client does not exist, or you do not have access to the client, or `client_secret` is incorrect._
{{</hint>}}

{{<hint warning>}}**`422`** - Unprocessable Entity

_Redirect URI or scope is invalid_
{{</hint>}}

{{<hint warning>}}**`500`** - Internal Server Error

_Some server error occurred. Please contact Alpaca._
{{</hint>}}

---

## **Delete a Token**

`DELETE /v1/oauth/token/{token_id}`

### Request

N/A

### Response

{{<hint good>}}
**`204`** - No Content

_The token was revoked successfully._
{{</hint>}}

&nbsp;
