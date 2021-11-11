---
bookHidden: false
weight: 8
summary: Open brokerage accounts, enable commission-free trading, and manage the ongoing user experience with Alpaca Broker API
title: Just in Time
---

# Just in Time

Just in Time (JIT) Funding enables users to trade without having cash in the account at the time of the trade. Instead, money will be transferred by the day of settlement. There are two different implementations of JIT funding that are available in this offering: net settlement and gross settlement. With JIT net settlement, the money to be wired by settlement is determined through netting cash inflows with cash outflows, which results in lower capital requirements and reduced FX conversion fees. While net settlement is recommended, please reach out to discuss details around gross settlement should that implementation be preferred. 

---

## **The Reports Object**
`GET /v1/transfers/jit/reports`

### Request

##### Parameters

| Attribute       | Type               | Requirement   |Notes                                                                                |
| --------------- | ------------------ | ------------- | ------------------------------------------------------------------------------------ |
| `report_type`   | string             | {{<hint danger>}}Required{{</hint>}} | [ENUM.ReportType]({{< relref "#report-type" >}}) |
| `system_date`   | date               | {{<hint danger>}}Required{{</hint>}} | Must be in YYYY-MM-DD format   |

### Enums

#### Report Type
| Attribute             | Naming Convention   | Notes                                                                                |
| --------------------- | ------------------ | ------------------------------------------------------------------------------------ |
| `detail`              | CORR-YYYY-MM-DD-detail.csv | Displays all activity across accounts that is factored into the final wire amounts. |
| `net_summary`         | CORR-YYYY-MM-DD-summary.csv | Contains 3 columns, T0, T1, and T2, which specify the net amount due for each trading day. |
| `gross_summary`       | CORR-YYYY-MM-DD-summary.csv | Contains 6 columns, T0, T1, and T2 for 'in' and 'out' amounts respectively which specify the gross amounts due for each trading day. |
| `net_payment`         | CORR-YYYY-MM-DD-payment.pdf | Specifies the net wire amount to be transfered on T+2 as well as the recipient of the wire.  |
| `gross_payment`       | CORR-YYYY-MM-DD-payment.pdf | Specifies the wire amount to be transfered to Alpaca on T+2.  |
| `net_payment_final`   | CORR-YYYY-MM-DD-payment-final.pdf | Shows the final net money movement that accounts for T1 activities that settle T+0 or T+1. |
| `gross_payment_final` | CORR-YYYY-MM-DD-payment-final.pdf | Shows the final gross money movement due to Alpaca that accounts for T1 activities that settle T+0 and T+1.  |

The detail, summary, and payment reports will be generated after market hours on trade date, however, the payment final report will be made available after market hours on T+1. Please note the file naming convention where `<CORR>` is to be replaced with the unique four character alphanumeric code for the correspondent. 


## **The Limits Object**
`GET /v1/tranfers/jit/limits`

### Request

##### Parameters
No request parameters

### Sample Limits Reponse
```json
{
  "daily_net_limit_in_use": 150000,
  "daily_net_limit": 2000000
}
```

### Response

##### Parameters

| Attribute                | Type      | Notes             |
| ------------------------ | --------- | ----------------- |
| `daily_net_limit_in_use` | decimal   | The realtime net value of cash inflows (buy trades, etc.) with cash outflows (sell trades, dividends, etc). This will be dynamic throughout the day based on user activity, with executed orders being reset at the start of the next trading day. |
| `daily_net_limit`        | decimal   | The net buying limit that can be reached before further cash outflow trading activity is restricted. Please reach out to learn more about how this limit is determined. |


### Response Codes

{{<hint good>}}**`204`** - Success (No Content){{</hint>}}
{{<hint warning>}}**`400`** - Bad Request _The body in the request is not valid_{{</hint>}}