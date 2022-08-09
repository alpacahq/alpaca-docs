---
weight: 8
title: Portfolio Rebalancing
summary: Create weighted portfolios for users via API, automate portfolio rebalancing operations
---

# Portfolio Rebalancing

[Rebalancing API]({{<relref "../../api-references/broker-api/rebalancing.md">}}) offers investment advisors a way to easily create investment portfolios that are automatically updated to the specified cash, stock symbol percentage weights, rebalance conditions, and triggers selected. Some helpful definitions before an overview of the rebalancing flow:
- **Portfolios**:  An allocation containing securities and/or cash with specific weights and conditions to be met
- **Subscriptions**: Accounts can be subscribed to a created portfolio and follow rebalancing events to ensure the account if kept in sync with the target portgolio
- **Runs**: A run is a set of orders that will be sent for execution to achieve a goal (liquidating a specified amount to set it aside for withdrawal or doing a full rebalance to the target allocation)

{{<hint info>}}
**Rebalancing API Resources**

- [Postman Collection](https://www.postman.com/alpacamarkets/workspace/alpaca-public-workspace/folder/19455863-8fea51d0-40bf-4680-9da2-b0de1a7c8b18?ctx=documentation)
- [How to Get Started with Rebalancing API](https://alpaca.markets/learn/p/7de9ef6b-b514-428f-ae84-cdc994798b76/)
- [Rebalancing API Reference]({{<relref "../../api-references/broker-api/rebalancing.md">}})

{{</hint>}}
## Types of Rebalancing

Rebalancing API offers to types of revalancing conditions:

- **Drift band**: When a portfolio breaches a certain threshold, irrespective of the time period elapsed, the portfolio is adjusted. For instance, if we put a +/- 10% band on a portfolio, we would automatically adjust the entire portfolio when we reach the threshold for one of the holdings
- **Calendar**: At the desired period, the state of the portfolio is analyzed and the portfolio is rebalanced to the default portfolio. For example, on April 1st our 50:50 AAPL TLT portfolio is not 55:45, so we would need to liquidate TLT and buy more AAPL to return to the desired state of exposure of 50:50.

## Create a Portfolio

To create a portfolio use the [`Create Portfolio`]({{<relref "../../api-references/broker-api/rebalancing.md#create-portfolio">}}) POST endpoint. Below see example payload to create a portfolio with a mix of cash and securities:

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

Once exeuted, you can find the portfolio ID in the response payload similar to the one below. In our case our newly created portfolio ID is `2d49d00e-ab1c-4014-89d8-70c5f64df2fc`. This will be needed to be able to subscribe an account to follow this new portfolio.

```json
{
    "id": "2d49d00e-ab1c-4014-89d8-70c5f64df2fc",
    "name": "Balanced Two",
    "description": "A balanced portfolio of stocks and bonds",
    "status": "active",
    "cooldown_days": 7,
    "created_at": "2022-08-07T14:56:45.116867815-04:00",
    "updated_at": "2022-08-07T14:56:45.196857944-04:00",
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
You can also list all your created portfolios with the [`List All Portfolios`]({{<relref "../../api-references/broker-api/rebalancing.md#list-all-portfolios">}}) endpoint.

## Subscribe Account to a Portfolio

Once you have a portfolio created, the next step is to subscribe a given account to follow a portfolio. This will ensure that when rebalancing conditions are found the accounts is subscribed to have the needed orders executed.

To subscribe an account to our newly created portfolio and its rebalancing conditions we create a new subscription. For example, to subscribe account ID `bf2b0f93-f296-4276-a9cf-288586cf4fb7` to our newly created portfolio from before, we use the [`Create Subscriptions`]({{<relref "../../api-references/broker-api/rebalancing.md#create-subscription">}}) endpoint with the following JSON payload, 

```json
{
    "account_id": "bf2b0f93-f296-4276-a9cf-288586cf4fb7",
    "portfolio_id": "57d4ec79-9658-4916-9eb1-7c672be97e3e"
}
```

## Check Rebalancing Events

Once an account is subscribed to a portfolio, we need to wait for the first rebalancing event to happen. We can check completed rebalancing events for all our accounts by using the [`List All Runs`]({{<relref "../../api-references/broker-api/rebalancing.md#list-all-runs">}}) endpoint.

```bash
curl --location --request GET '{{HOST}}/v1/beta/rebalancing/runs?status=COMPLETED_SUCCESS' \
--header 'Authorization: Basic <TOKEN>' \
--data-raw ''
```

See example payload of a succesful run,

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


{{<hint info>}}
**Note**: Cash inflows to the account (deposits, cash journals, etc.) will trigger buy trades to reduce drift.
{{</hint>}}

## Manually Trigger Rebalancing Event (Run)

Rebalancing API will automatically configure systems to watch for portfolio rebalancing
conditions and execute necessary orders. However, if you need to execute a rebalancing run see reference of [`Create Run`]({{<relref "../../api-references/broker-api/rebalancing.md#list-all-runs">}}) endpoint.

{{<hint warning>}}
Manually executing a run is currently only allowed for accounts who do not have an active subscription.
{{</hint>}}