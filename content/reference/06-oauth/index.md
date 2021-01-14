# OAuth

Allow users to access Trading View and other apps using OAuth.

## The OAuth Model

---

## Available Endpoints

---

### `GET /v1/oauth/clients/{client_id}

#### Request

##### Parameters

| Attribute       | Type   | Notes                              |
| --------------- | ------ | ---------------------------------- |
| `response_type` | string | `code` or `token`                  |
| `redirect_uri`  | string | Redirect URI of the OAuth flow     |
| `scope`         | string | Requested scopes by the OAuth flow |

#### Response

##### Parameters

| Attribute               | Type    | Notes                  |
| ----------------------- | ------- | ---------------------- |
| `client_id`             | string  | OAuth client id        |
| `name`                  | string  | Client/Broker name     |
| `description`           | string  |                        |
| `url`                   | string  |                        |
| `terms_of_use`          | string  | URL of ToS             |
| `privacy_policy`        | string  | URL of PP              |
| `status`                | string  | `ACTIVE` or `DISABLED` |
| `redirect_uri`          | string  |                        |
| `live_trading_approved` | Boolean |                        |

##### Sample Response

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

##### Error Codes

401 - Unauthorized
​ _Client does not exist, or you do not have access to the client_

500 - Internal Server Error
​ _Some server error occured. Please contact Alpaca._

---

### `POST /v1/oauth/token`

Creating a new OAuth token.

#### Request

##### Parameters

| Attribute       | Type   | Notes                          |
| --------------- | ------ | ------------------------------ |
| `client_id`     | string | OAuth client id                |
| `client_secret` | string | OAuth client id                |
| `redirect_uri`  | string | Redirect URI of OAuth flow     |
| `scope`         | string | Requested scopes by OAuth flow |
| `account_id`    | string | End-user Account ID            |

#### Response

##### Parameters

| Attribute      | Type   | Notes           |
| -------------- | ------ | --------------- |
| `access_token` | string | OAuth token     |
| `token_type`   | string | Always "Bearer" |
| `scope`        | string | Token's scope   |

##### Sample Response

```json
{
  "access_token": "87586f14-c3f4-4912-b107-f75bc17ff87a",
  "token_type": "Bearer"
}
```

##### Error Codes

401 - Unauthorized
​ _Client does not exist, or you do not have access to the client, or `client_secret` is incorrect._

422 - Unprocessable Entity
​ _Redirect URI or scope is invalid_

500 - Internal Server Error
​ _Some server error occured. Please contact Alpaca._

---

### `POST /v1/oauth/authorize`

Authorizing a new OAuth token.

#### Request

##### Parameters

| Attribute       | Type   | Notes                          |
| --------------- | ------ | ------------------------------ |
| `client_id`     | string | OAuth client id                |
| `client_secret` | string | OAuth client id                |
| `redirect_uri`  | string | Redirect URI of OAuth flow     |
| `scope`         | string | Requested scopes by OAuth flow |
| `account_id`    | string | End-user Account ID            |

#### Response

##### Parameters

| Attribute      | Type   | Notes                             |
| -------------- | ------ | --------------------------------- |
| `code`         | string | OAuth code to exchange with token |
| `redirect_uri` | string | Redirect URI of OAuth flow        |
| `scope`        | string | Granted scopes                    |

##### Sample Response

```json
{
  "code": "912b5502-c983-40f7-a01d-6a66f13a754d",
  "client_id": "7a3c52a910e1dc2abbb14da2b6b8e711",
  "redirect_uri": "http://localhost",
  "scope": ""
}
```

##### Error Codes

401 - Unauthorized
​ _Client does not exist, or you do not have access to the client, or `client_secret` is incorrect._

422 - Unprocessable Entity
​ _Redirect URI or scope is invalid_

500 - Internal Server Error
​ _Some server error occured. Please contact Alpaca._

### `DELETE /v1/oauth/authorize`

Deleting a token

#### Request

N/A

#### Response

204 - Success (No Content)
​ _The token was revoked succesfully._
