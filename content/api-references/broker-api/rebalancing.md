---
bookHidden: false
weight: 8
summary: Create weighted portfolios for users via API, automate portfolio rebalancing operations
title: Rebalancing
---

# Rebalancing API

Rebalancing API enables brokers to create weighted portfolios and automatically have these configured to be rebalanced given certain conditions.

## Portfolio Model

| Attribute               | Type               | Notes                                |
| ---------------------   | ------------------ | ------------------------------------ |
| `id`                    | string <<UUID>>    | Portfolio ID                         |
| `name`                  | string             | Name of portfolio                    |
| `status`                | string             | Current status of portfolio                    |
| `description`           | string             | Text to describe portfolio           |
| `weights`               | array[[Weights]({{<relref "#weights-model">}})] | Weight configuration to portfolio. Sum of “percent” values in the weights array must be 100.00  |
| `cooldown_days`         | number             | Count of calendar days following a rebalance before a subscription is eligible to trigger another rebalance |
| `rebalancing_conditions` | array[[RebalancingConditions]({{<relref "#rebalancing-conditions-model">}})] | Rebalancing conditions for portfolio |
| `created_at`            | timestamp          | Portfolio creation timestamp      |
| `updated_at`            | timestamp          | Portfolio updated timestamp       |

## Subscription Model

Subscription is a mapping of an account which will follow a portfolio to be rebalanced.

| Attribute               | Type               | Notes                                |
| ---------------------   | ------------------ | ------------------------------------ |
| `id`                    | string <<UUID>>    | Subscription ID                      |
| `account_id`            | string <<UUID>>    | Account ID subscribing to portfoli   |
| `portfolio_id`          | string <<UUID>>    | Portfolio ID for subscription        |
| `created_at`            | timestamp          | Subscription creation timestamp      |
| `updated_at`            | timestamp          | Subscription updated timestamp       |
| `last_rebalanced_at`    | timestamp(nullable)| Last rebalancing event for this subscription |

## Run Model

| Attribute               | Type               | Notes                                |
| ---------------------   | ------------------ | ------------------------------------ |
| `id`                    | string <<UUID>>    | Run ID                               |
| `account_id`            | string <<UUID>>    | Account ID for given run             |
| `portfolio_id`          | string <<UUID>>    | Portfolio ID for given run |
| `type`                  | string             | `full_rebalance` or `partial_liquidation` |
| `initiated_by`          | string             | `system` or `api` | `created_at`              |string<<timestamp>>  | RFC3339 format |
| `updated_at`            | string<<timestamp>>  | RFC3339 format |                              |
| `completed_at`          | string<<timestamp>>  | RFC3339 format                           |
| `canceled_at`           | string<<timestamp>> | RFC3339 format |
| `status`                | string    |QUEUED, SELLS_IN_PROGRESS BUYS_IN_PROGRESS, CANCELED, CANCELED_MID_RUN, COMPLETED_SUCCESS, COMPLETED_ADJUSTED |
| `reason`                | string    | Explainer text in case of failed runs   |
| `weights`               | array[[Weights]({{<relref "#weights-model">}})]   | Considered weighting for this run |
| `orders`                | array[[Orders]({{<relref "./trading/orders.md#the-order-object">}})]    | Array of executed orders for this run |

## Weights Model

Specifies weight configurations of a given asset or cash within a portfolio.

| Attribute               | Type               | Notes                                |
| ---------------------   | ------------------ | ------------------------------------ |
| `type`                  | string             | Possible values of `cash` or `asset` |
| `symbol`                  | string             | Must be fractionable asset. Only provided if type = “asset” |
| `percent`                  | string             | Must be a positive value, up to two decimal places |


## Rebalancing Conditions Model

| Attribute               | Type               | Notes                                |
| ---------------------   | ------------------ | ------------------------------------ |
| `type`                  | string             | Possible values of `drift_band` or `calendar` |
| `sub_type`                  | string             | For `type` = `drift_band`: `absolute` or `relative`. For `type` = `calendar`: `weekly`,`monthly`,  `quarterly` or `annually` |
| `percent`                  | string             | Must be a positive value, up to two decimal places. Only permitted and required for `type` = `drift_band`. This is the max allowable drift percent from any target weight (+/-) |
| `day`                   | string             | Used to specify the rebalancing day for conditions of `type` = `calendar`. Only permitted and required for `type` = `calendar`. In scenarios when the specified `day` aligns to a non-trading day, the rebalance will be triggered on the preceding trading day. For `type`= `annually`, the value must be passed in `MM-DD` format. If `02-29` is specified and the current year is not a leap year, the rebalance will occur on the trading day preceding 2/29. For `type`= `quarterly` and `monthly` the value must be an integer between 1 and 31 inclusive. This represents the day of month. For quarterly, rebalancing will trigger on this day in January, March, June, and December. If the specified day is non-existent for the month then the rebalancing will trigger on the preceding trading day. For `type` = `weekly`, permitted values are `Monday`, `Tuesday`, `Wednesday`, `Thursday`, `Friday`. |

## Create Portfolio

`POST /v1/beta/rebalancing/portfolios`

Creates a portfolio allocation containing securities and/or cash. Having no rebalancing conditions is allowed but the rebalance event would beed to be triggered manually. Portfolios created with API may have multiple `rebalance_conditions`, but only one of type `calendar`.

### Request

#### Sample Request

```json
{
    "name": "Balanced",
    "description": "A balanced portfolio of stocks and bonds",
    "weights": [
        {
            "type": "cash",
            "percent": "5"
        },
        {
            "type": "asset",
            "symbol": "SPY",
            "percent": "60"
        },
        {
            "type": "asset",
            "symbol": "TLT",
            "percent": "35"
        }
    ],
    "cooldown_days": 7,
    "rebalance_conditions": [
        {
            "type": "drift_band",
            "sub_type": "absolute",
            "percent": "5"
        },
        {
            "type": "drift_band",
            "sub_type": "relative",
            "percent": "20"
        }
    ]
}
```

### Response

{{<hint good>}}
200 Success

{{</hint>}}

{{<hint warning>}}
422 Unprocessable Entity

{{</hint>}}

```json
{
    "id": "6819ecd2-db92-4688-821d-8fac2a8f4744",
    "name": "Balanced",
    "description": "A balanced portfolio of stocks and bonds",
    "status": "active",
    "cooldown_days": 7,
    "created_at": "2022-08-06T19:12:13.555858187-04:00",
    "updated_at": "2022-08-06T19:12:13.628551899-04:00",
    "weights": [
        {
            "type": "cash",
            "symbol": null,
            "percent": "5"
        },
        {
            "type": "asset",
            "symbol": "SPY",
            "percent": "60"
        },
        {
            "type": "asset",
            "symbol": "TLT",
            "percent": "35"
        }
    ],
    "rebalance_conditions": [
        {
            "type": "drift_band",
            "sub_type": "absolute",
            "percent": "5",
            "day": null
        },
        {
            "type": "drift_band",
            "sub_type": "relative",
            "percent": "20",
            "day": null
        }
    ]
}
```

## List All Portfolios

`GET /v1/beta/rebalancing/portfolios`

Lists portfolios.

### Request

#### Query Parameters

 When more than one query parameter is passed, only portfolios meeting all provided values will be returned (logical AND between parameter values).

| Parameter                | Type               | Description                          |
| ---------------------   | ------------------ | ------------------------------------ |
| `name`                  | string             | Name of portfolio                    |
| `description`           | string             | Description of portfolio             |
| `symbol`                | string             | Symbol included in portfolio         |
| `portfolio_id`          | string             | Portfolio ID                         |
| `status`                | string             | Portfolio status                     |

### Response

{{<hint good>}}
200 Success - Array[[Portfolio]({{<relref "#portfolio-model">}})]
{{</hint>}}

#### Example Response

```json
[
    {
        "id": "57d4ec79-9658-4916-9eb1-7c672be97e3e",
        "name": "My Portfolio",
        "description": "Some description",
        "status": "active",
        "cooldown_days": 2,
        "created_at": "2022-07-28T20:33:59.665962Z",
        "updated_at": "2022-07-28T20:33:59.786528Z",
        "weights": [
            {
                "type": "asset",
                "symbol": "AAPL",
                "percent": "35"
            },
            {
                "type": "asset",
                "symbol": "TSLA",
                "percent": "20"
            },
            {
                "type": "asset",
                "symbol": "SPY",
                "percent": "45"
            }
        ],
        "rebalance_conditions": [
            {
                "type": "drift_band",
                "sub_type": "absolute",
                "percent": "5",
                "day": null
            },
            {
                "type": "drift_band",
                "sub_type": "relative",
                "percent": "20",
                "day": null
            }
        ]
    },
    {
        "id": "6819ecd2-db92-4688-821d-8fac2a8f4744",
        "name": "Balanced",
        "description": "A balanced portfolio of stocks and bonds",
        "status": "active",
        "cooldown_days": 7,
        "created_at": "2022-08-06T23:12:13.555858Z",
        "updated_at": "2022-08-06T23:12:13.628551Z",
        "weights": [
            {
                "type": "cash",
                "symbol": null,
                "percent": "5"
            },
            {
                "type": "asset",
                "symbol": "SPY",
                "percent": "60"
            },
            {
                "type": "asset",
                "symbol": "TLT",
                "percent": "35"
            }
        ],
        "rebalance_conditions": [
            {
                "type": "drift_band",
                "sub_type": "absolute",
                "percent": "5",
                "day": null
            },
            {
                "type": "drift_band",
                "sub_type": "relative",
                "percent": "20",
                "day": null
            }
        ]
    },
    {
        "id": "2d49d00e-ab1c-4014-89d8-70c5f64df2fc",
        "name": "Balanced Two",
        "description": "A balanced portfolio of stocks and bonds",
        "status": "active",
        "cooldown_days": 7,
        "created_at": "2022-08-07T18:56:45.116867Z",
        "updated_at": "2022-08-07T18:56:45.196857Z",
        "weights": [
            {
                "type": "cash",
                "symbol": null,
                "percent": "5"
            },
            {
                "type": "asset",
                "symbol": "SPY",
                "percent": "60"
            },
            {
                "type": "asset",
                "symbol": "TLT",
                "percent": "35"
            }
        ],
        "rebalance_conditions": [
            {
                "type": "drift_band",
                "sub_type": "absolute",
                "percent": "5",
                "day": null
            },
            {
                "type": "drift_band",
                "sub_type": "relative",
                "percent": "20",
                "day": null
            }
        ]
    }
]
```

## Get Portfolio by ID

`GET /v1/beta/rebalancing/portfolios/{portfolio_id}`

Get a portfolio by its ID.

### Request

No query or body parameters.

### Response

{{<hint good>}}
200 Success - [Portfolio]({{<relref "#portfolio-model">}})

{{</hint>}}

{{<hint warning>}}
422 Unprocessable Entity

{{</hint>}}

## Update Portfolio by ID

`PATCH /v1/beta/rebalancing/portfolios/{portfolio_id}`

Updates a portfolio. If weights or conditions are changed, all subscribed accounts will be evaluated for rebalancing at the next opportunity (normal market hours) even if they are in an active cooldown period.

### Request

#### Sample Request

```json
{
    "weights": [
        {
            "type": "cash",
            "percent": "10"
        },
        {
            "type": "asset",
            "symbol": "GOOG",
            "percent": "90"
        }
    ]
}
```

### Response

{{<hint good>}}
200 Success - [Portfolio]({{<relref "#portfolio-model">}})

{{</hint>}}

{{<hint warning>}}
422 Unprocessable 
{{</hint>}}


## Inactivate Portfolio By ID

`DELETE /v1/beta/rebalancing/portfolios/{portfolio_id}`

Sets a portfolio to "inactive", so it can be filtered out of the list request. Only permitted if there are no active subscriptions to this portfolio and this portfolio is not a listed in the weights of any active portfolios.

Inactive portfolios cannot be linked in new subscriptions or added as weights to new portfolios.

### Request

No query or body parameters.

### Response

{{<hint good>}}
204 No Content

{{</hint>}}

{{<hint warning>}}
422 Unprocessable

{{</hint>}}



## Create Subscription

`POST /v1/beta/rebalancing/subscriptions`

Creates a subscription between an account and a portfolio.

### Request

| Parameter               | Type               | Description                          |
| ---------------------   | ------------------ | ------------------------------------ |
| `account_id`            | string <<UUID>>    | Account ID. Account must be active and the account must not have any active subscriptions already (only 1 is permitted at a time) |
| `portfolio_id`           | string <<UUID>>            | Portfolio ID. Portfolio must be `active` |

#### Sample Request Object

```json
{
    "account_id": "bf2b0f93-f296-4276-a9cf-288586cf4fb7",
    "portfolio_id": "57d4ec79-9658-4916-9eb1-7c672be97e3e"
}
```

### Response

```json
{
    "id": "2ded098b-ee17-4f48-9496-f8b66e3627aa",
    "account_id": "bf2b0f93-f296-4276-a9cf-288586cf4fb7",
    "portfolio_id": "57d4ec79-9658-4916-9eb1-7c672be97e3e",
    "last_rebalanced_at": null,
    "created_at": "2022-08-06T19:34:43.428080852-04:00"
}
```

## List All Subscriptions

`GET /v1/beta/rebalancing/subscriptions`

Lists subscriptions.

### Request

#### Query Parameters

| Parameter                | Type               | Description                          |
| ---------------------   | ------------------ | ------------------------------------ |
| `account_id`              | string        | Any subscriptions for this `account_id` will be returned |
| `portfolio_id`           | string             | Portfolio ID                         |
| `page_token`             | string             | Pagination token                     |
| `limit`                  | string             | Max number of subscriptions to return per page  |


### Response

{{<hint good>}}
200 Success - Array[[Subscription]({{<relref "#subscription-model">}})]
{{</hint>}}

#### Sample Response

```json
{
    "subscriptions": [
        {
            "id": "9341be15-8786-4d23-ba1a-fc10ef4f90f4",
            "account_id": "bf2b0f93-f296-4276-a9cf-288586cf4fb7",
            "portfolio_id": "57d4ec79-9658-4916-9eb1-7c672be97e3e",
            "last_rebalanced_at": null,
            "created_at": "2022-08-07T23:52:05.942964Z"
        }
    ],
    "next_page_token": null
}
```

## Get Subscription by ID

`GET /v1/beta/rebalancing/subscriptions/{subscription_id}`

Get a subscription by its ID.

### Request

No query or body parameters.

### Response

{{<hint good>}}
200 Success - [Subscription]({{<relref "#subscription-model">}})
{{</hint>}}

#### Sample Repsonse

```json
{
    "id": "9341be15-8786-4d23-ba1a-fc10ef4f90f4",
    "account_id": "bf2b0f93-f296-4276-a9cf-288586cf4fb7",
    "portfolio_id": "57d4ec79-9658-4916-9eb1-7c672be97e3e",
    "last_rebalanced_at": null,
    "created_at": "2022-08-07T23:52:05.942964Z"
}
```


## Unsubscribe Account (Delete Subscription)

`DELETE /v1/beta/rebalancing/subscriptions/{subscription_id}`

Deletes the subscription which stops the rebalancing of an account.

### Request

No query or body parameters.

### Response

{{<hint good>}}
204 - No Content

{{</hint>}}

{{<hint warning>}}
422 - Unprocessible

{{</hint>}}


## Create run (Manual rebalancing event)

`POST /v1/beta/rebalancing/runs`

Manually creates a run.

The determination of a run’s orders and the execution of a run take place during normal market hours

Runs can be initiated either by the system (when the system evaluates the rebalance conditions specified at the portfolio level) or by API call (manual run creation using `POST /v1/rebalancing/runs`). Runs can be initiated manually outside of the normal market hours but will remain in the QUEUED status until normal market hours

Only 1 run in a non-terminal status is allowed at any time.

{{<hint warning>}}
Manually executing a run is currently only allowed for accounts who do not have an active subscription.
{{</hint>}}

### Request

#### Sample Request

```json
{
    "account_id": "bf2b0f93-f296-4276-a9cf-288586cf4fb7",
    "type": "full_rebalance",
    "weights": [
            {
                "type": "asset",
                "symbol": "AAPL",
                "percent": "35"
            },
            {
                "type": "asset",
                "symbol": "TSLA",
                "percent": "20"
            },
            {
                "type": "asset",
                "symbol": "SPY",
                "percent": "45"
            }
        ]
}

```

### Response

#### Sample Response

```json
{
    "account_id": "bf2b0f93-f296-4276-a9cf-288586cf4fb7",
    "type": "full_rebalance",
    "weights": [
            {
                "type": "asset",
                "symbol": "AAPL",
                "percent": "35"
            },
            {
                "type": "asset",
                "symbol": "TSLA",
                "percent": "20"
            },
            {
                "type": "asset",
                "symbol": "SPY",
                "percent": "45"
            }
        ]
}
```


## List All Runs

`GET /v1/beta/rebalancing/runs`

Lists runs.

### Request

#### Query Parameters

| Parameter                | Type               | Description                          |
| ---------------------   | ------------------ | ------------------------------------ |
| `account_id`              | string        | Any subscriptions for this `account_id` will be returned |
| `type`           | string             | Portfolio ID                         |
| `page_token`             | string             | Pagination token                     |
| `limit`                  | string             | Max number of subscriptions to return per page  |


### Response

{{<hint good>}}
200 Success - Array[[Run]({{<relref "#run-model">}})]
{{</hint>}}

{{<hint warning>}}
422 Unprocessable - run cannot be canceled
{{</hint>}}

#### Sample Response

```json
{
    "runs": [
        {
            "id": "36699e7f-56a0-4b87-8e03-968363f4b6df",
            "type": "full_rebalance",
            "amount": null,
            "initiated_from": "system",
            "status": "COMPLETED_SUCCESS",
            "reason": null,
            "account_id": "b3130eeb-1219-46f3-8bfb-7715f00d736b",
            "portfolio_id": "4ad7d634-a60d-4e6e-955f-3c68ee24d285",
            "weights": [
                {
                    "type": "cash",
                    "symbol": null,
                    "percent": "5"
                },
                {
                    "type": "asset",
                    "symbol": "SPY",
                    "percent": "60"
                },
                {
                    "type": "asset",
                    "symbol": "TLT",
                    "percent": "35"
                }
            ],
            "orders": [
                {
                    "id": "c29dd94b-eaaf-4681-9d1f-4fd47571804b",
                    "client_order_id": "cb2d1ff5-8355-4c92-84d7-dfff43f44cb2",
                    "created_at": "2022-03-08T16:51:07.442125Z",
                    "updated_at": "2022-03-08T16:51:07.525039Z",
                    "submitted_at": "2022-03-08T16:51:07.438495Z",
                    "filled_at": "2022-03-08T16:51:07.520169Z",
                    "expired_at": null,
                    "canceled_at": null,
                    "failed_at": null,
                    "replaced_at": null,
                    "replaced_by": null,
                    "replaces": null,
                    "asset_id": "3b64361a-1960-421a-9464-a484544193df",
                    "symbol": "SPY",
                    "asset_class": "us_equity",
                    "notional": "30443.177578017",
                    "qty": null,
                    "filled_qty": "72.865432211",
                    "filled_avg_price": "417.8",
                    "order_class": "",
                    "order_type": "market",
                    "type": "market",
                    "side": "buy",
                    "time_in_force": "day",
                    "limit_price": null,
                    "stop_price": null,
                    "status": "filled",
                    "extended_hours": false,
                    "legs": null,
                    "trail_percent": null,
                    "trail_price": null,
                    "hwm": null,
                    "subtag": null,
                    "source": null
                },
                {
                    "id": "ab772dcb-b67c-4173-a5b5-e31b9ad236b5",
                    "client_order_id": "d6278f6c-3010-45ce-aaee-6e64136deec0",
                    "created_at": "2022-03-08T16:51:07.883352Z",
                    "updated_at": "2022-03-08T16:51:07.934602Z",
                    "submitted_at": "2022-03-08T16:51:07.877726Z",
                    "filled_at": "2022-03-08T16:51:07.928907Z",
                    "expired_at": null,
                    "canceled_at": null,
                    "failed_at": null,
                    "replaced_at": null,
                    "replaced_by": null,
                    "replaces": null,
                    "asset_id": "a106d0ef-e6f2-4736-8750-5dee1cadf75b",
                    "symbol": "TLT",
                    "asset_class": "us_equity",
                    "notional": "17121.076868834",
                    "qty": null,
                    "filled_qty": "124.408348124",
                    "filled_avg_price": "137.62",
                    "order_class": "",
                    "order_type": "market",
                    "type": "market",
                    "side": "buy",
                    "time_in_force": "day",
                    "limit_price": null,
                    "stop_price": null,
                    "status": "filled",
                    "extended_hours": false,
                    "legs": null,
                    "trail_percent": null,
                    "trail_price": null,
                    "hwm": null,
                    "subtag": null,
                    "source": null
                }
            ],
            "completed_at": null,
            "canceled_at": null,
            "created_at": "2022-03-08T16:36:07.053482Z",
            "updated_at": "2022-03-08T16:51:08.53806Z"
        },
        ...
    ],
    "next_page_token": 100
}   
```

## Get Run by ID

`GET /v1/beta/rebalancing/runs/{run_id}`

### Request

No body or query parameters.

### Response

{{<hint good>}}
200 Success - [Run]({{<relref "#run-model">}})
{{</hint>}}

{{<hint warning>}}
422 Unprocessable - run cannot be canceled

{{</hint>}}

#### Sample Response

```json
{
    "id": "36699e7f-56a0-4b87-8e03-968363f4b6df",
    "type": "full_rebalance",
    "amount": null,
    "initiated_from": "system",
    "status": "COMPLETED_SUCCESS",
    "reason": null,
    "account_id": "b3130eeb-1219-46f3-8bfb-7715f00d736b",
    "portfolio_id": "4ad7d634-a60d-4e6e-955f-3c68ee24d285",
    "weights": [
        {
            "type": "cash",
            "symbol": null,
            "percent": "5"
        },
        {
            "type": "asset",
            "symbol": "SPY",
            "percent": "60"
        },
        {
            "type": "asset",
            "symbol": "TLT",
            "percent": "35"
        }
    ],
    "orders": [
        {
            "id": "ab772dcb-b67c-4173-a5b5-e31b9ad236b5",
            "client_order_id": "d6278f6c-3010-45ce-aaee-6e64136deec0",
            "created_at": "2022-03-08T16:51:07.883352Z",
            "updated_at": "2022-03-08T16:51:07.934602Z",
            "submitted_at": "2022-03-08T16:51:07.877726Z",
            "filled_at": "2022-03-08T16:51:07.928907Z",
            "expired_at": null,
            "canceled_at": null,
            "failed_at": null,
            "replaced_at": null,
            "replaced_by": null,
            "replaces": null,
            "asset_id": "a106d0ef-e6f2-4736-8750-5dee1cadf75b",
            "symbol": "TLT",
            "asset_class": "us_equity",
            "notional": "17121.076868834",
            "qty": null,
            "filled_qty": "124.408348124",
            "filled_avg_price": "137.62",
            "order_class": "",
            "order_type": "market",
            "type": "market",
            "side": "buy",
            "time_in_force": "day",
            "limit_price": null,
            "stop_price": null,
            "status": "filled",
            "extended_hours": false,
            "legs": null,
            "trail_percent": null,
            "trail_price": null,
            "hwm": null,
            "subtag": null,
            "source": null
        },
        {
            "id": "c29dd94b-eaaf-4681-9d1f-4fd47571804b",
            "client_order_id": "cb2d1ff5-8355-4c92-84d7-dfff43f44cb2",
            "created_at": "2022-03-08T16:51:07.442125Z",
            "updated_at": "2022-03-08T16:51:07.525039Z",
            "submitted_at": "2022-03-08T16:51:07.438495Z",
            "filled_at": "2022-03-08T16:51:07.520169Z",
            "expired_at": null,
            "canceled_at": null,
            "failed_at": null,
            "replaced_at": null,
            "replaced_by": null,
            "replaces": null,
            "asset_id": "3b64361a-1960-421a-9464-a484544193df",
            "symbol": "SPY",
            "asset_class": "us_equity",
            "notional": "30443.177578017",
            "qty": null,
            "filled_qty": "72.865432211",
            "filled_avg_price": "417.8",
            "order_class": "",
            "order_type": "market",
            "type": "market",
            "side": "buy",
            "time_in_force": "day",
            "limit_price": null,
            "stop_price": null,
            "status": "filled",
            "extended_hours": false,
            "legs": null,
            "trail_percent": null,
            "trail_price": null,
            "hwm": null,
            "subtag": null,
            "source": null
        }
    ],
    "completed_at": null,
    "canceled_at": null,
    "created_at": "2022-03-08T16:36:07.053482Z",
    "updated_at": "2022-03-08T16:51:08.53806Z"
}
```


## Cancel Run by ID

`DELETE /v1/beta/rebalancing/runs/{run_id}`

Cancels a run. Only runs within certain statuses (QUEUED, CANCELED, SELLS_IN_PROGRESS, BUYS_IN_PROGRESS) are cancelable. If this endpoint is called after orders have been submitted, we’ll attempt to cancel the orders.

### Request
No body or query parameters

### Response

{{<hint good>}}
204 No Content - run has been successfully canceled

{{</hint>}}

{{<hint warning>}}
422 Unprocessable - run cannot be canceled

{{</hint>}}