---
bookHidden: false
weight: 5
---

# Trading Configurations

## The Configuration Object

### Sample Object

```json
{
  "dtbp_check": "entry",
  "fractional_trading": true,
  "max_margin_multiplier": "1",
  "no_shorting": false,
  "pdt_check": "entry",
  "suspend_trade": false,
  "trade_confirm_email": "all"
}
```

## Attributes

| Attribute               | Type          | Notes                                                                       |
| ----------------------- | ------------- | --------------------------------------------------------------------------- |
| `dtbp_check`            | string        | `both`, `entry`, or `exit`. Controls Day Trading Margin Call (DTMC) checks. |
| `fractional_trading`    | boolean       | If true, account is able to participate in fractional trading               |
| `max_margin_multiplier` | string/number | Can be `1` or `2`                                                           |
| `no_shorting`           | boolean       | If true, account becomes long-only mode.                                    |
| `pdt_check`             | string        |                                                                             |
| `suspend_trade`         | boolean       | If true, new orders are blocked.                                            |
| `trade_confirm_email`   | string        | `all` or `none`. If `none`, emails for order fills are not sent.            |

---

## Setting Margin Multiplier

You can also set the margin settings for your users’ account by passing a PATCH request. By default any account with funds under $2,000 is set a margin multiplier of 1.0, and accounts with over $2,000 are set to 2.0.

`PATCH/v1/trading/accounts/{account_id}/account/configurations`

### Request

#### Sample Request

```json
{
  "max_margin_multiplier": 1.0
}
```

### Response

Response will contain the account configuration settings for the account.

&nbsp;
