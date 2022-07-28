---
bookHidden: false
weight: 3
summary: Open brokerage accounts, enable trading, and manage the ongoing user experience with Alpaca Broker API
---

# Just-In-Time Securities Funding

Alpaca offers Just-In-Time (JIT) Securities funding which can be configured for partners upon request. When a partner is JIT enabled, Alpaca’s system calculates the difference between inflow and outflow account activity and assesses a single wire amount. Inflows to Alpaca typically consist of executed buy trades, while outflows to the partner are made up of executed sell trades and dividend payments. Should the inflows exceed the outflows across your account base, you will be responsible for sending the funds to Alpaca in time for settlement. If the opposite is true, Alpaca will initiate the wire on the morning of settlement equal to the difference between the outflows and the inflows.

{{<hint info>}}
**Working on JIT Funding?**

See [Get Started with Just-In-Time Funding for Broker API
](https://alpaca.markets/learn/get-started-with-just-in-time-funding-for-broker-api/) for a walkthrough of JIT and the APIs involved in the integration.

{{</hint>}}

---

## **JIT Reports**

JIT Securities reports are made available through the API and can be accessed within the hour after 11:30 PM EST on the trade date (T+0). The reports communicate transaction-level details as well as overall settlement amounts, transfer direction, and payment timing.

| Parameter           | Data Type                        | Notes                                                         |
| ------------------- | -------------------------------- | ------------------------------------------------------------- |
| `detail`            | content-type = `application/csv` | Contains all activities that impact cash throughout the trading session including executed trades, trading fees, and corporate actions that involve cash allocations.                           |
| `net_summary`       | content-type = `application/csv` | Consists of three columns and a single row, which lists the net money movement to or from Alpaca for T0, T1, and T2.                                                      |
| `net_payment`       | content-type = `application/pdf` | Highlights the net amount due to Alpaca by settlement or to the partner on the date of settlement in a formalized invoice format.                                                  |
| `net_payment_final` | content-type = `application/pdf` | Includes additional information to account for T+0 and T+1 settling activity to clarify settlement journaling reconciliation. This report is generated after trading session close on T+1.         |

## **Retrieving JIT Reports**

`GET /v1/transfers/jit/reports`

### Request

#### Sample Request

```json
{
  "report_type": "net_summary.csv",
  "system_date": "07-15-2021"
}
```

#### Parameters

| Parameter     | Type                                                | Required                              | Notes                                  |
| ------------- | --------------------------------------------------- | ------------------------------------- | -------------------------------------- |
| `report_type` | [ENUM.ReportType]({{< relref "#enumreporttype" >}}) | {{<hint danger>}}Required {{</hint>}} |                                        |
| `system_date` | string/date                                         | {{<hint danger>}}Required {{</hint>}} | Date of file generation                |

### Response

A JIT Securities report in the form of the appropriate content type.

### ENUM.ReportType

| Name                | Description                                                               |
| ------------------- | ------------------------------------------------------------------------- |
| `detail`            | Detail report, content-type = `application/csv`                           |
| `net_summary`       | Summary report, content-type = `application/csv`                          |
| `net_payment`       | Payment report, content-type = `application/pdf`                          |
| `net_payment_final` | Payment Final report, content-type = `application/pdf`                    |

### Detail.CSV
| Attribute           | Type        | Requirement                           | Notes                                          |
| ------------------- | ----------- | ------------------------------------- | ---------------------------------------------- |
| trns_id             | string/UUID | {{<hint danger>}}Required {{</hint>}} | The transaction ID |
| external_id         | string/UUID | {{<hint danger>}}Required {{</hint>}} | The partner's transaction ID |
| summary_categrory   | [ENUM.SummaryCategoryType]({{< relref "#enumsummarycategorytype" >}})      | {{<hint danger>}}Required {{</hint>}} | Assigning the transaction to the corresponding settlement date money movement  |
| account_id          | string/UUID | {{<hint danger>}}Required {{</hint>}} | The account ID  |
| account_no          | string      | {{<hint danger>}}Required {{</hint>}} | The account number  |
| symbol              | string      | {{<hint danger>}}Required {{</hint>}} | Symbol or asset ID to identify the asset to trade |
| system_date         | string/date | {{<hint danger>}}Required {{</hint>}} | The date the transaction was recorded or updated  |
| trade_date          | string/date | {{<hint danger>}}Required {{</hint>}} | The trade date  |
| settle_date         | string/date | {{<hint danger>}}Required {{</hint>}} | The settlement date  |
| entry_type          | [ENUM.EntryType]({{< relref "#enumentrytype" >}})      | {{<hint danger>}}Required {{</hint>}} |   |
| side                | string      | {{<hint danger>}}Required {{</hint>}} | `buy` or `sell` for trading activity |
| qty                 | decimal     | {{<hint danger>}}Required {{</hint>}} | Quantity of securities in the transaction |
| price               | decimal     | {{<hint danger>}}Required {{</hint>}} | Price of the security in the transaction |
| gross_amt           | decimal     | {{<hint danger>}}Required {{</hint>}} | Gross payment amount |
| commission          | decimal     | {{<hint danger>}}Required {{</hint>}} | Commission on the transaction |
| net_amt             | decimal     | {{<hint danger>}}Required {{</hint>}} | The gross payment less the commission for a transaction |
| description         | string      | {{<hint danger>}}Required {{</hint>}} | Description of the transaction |
| status              | [ENUM.StatusType]({{< relref "#enumstatustype" >}})      | {{<hint danger>}}Required {{</hint>}} |  |
| order_id            | string/UUID | {{<hint danger>}}Required {{</hint>}} | The order ID |
| client_order_id     | string/UUID | {{<hint danger>}}Required {{</hint>}} | The partner's order ID  |

### Net_Summary.CSV
| Attribute | Type    | Requirement                           | Notes                                                                                         |
| --------- | ------- | ------------------------------------- | --------------------------------------------------------------------------------------------- |
| t0        | decimal | {{<hint danger>}}Required {{</hint>}} | Net amount due for t0 settling activity where a negative value represents money due to Alpaca |
| t1        | decimal | {{<hint danger>}}Required {{</hint>}} | Net amount due for t1 settling activity where a negative value represents money due to Alpaca |
| t2        | decimal | {{<hint danger>}}Required {{</hint>}} | Net amount due for t2 settling activity where a negative value represents money due to Alpaca |

### ENUM.SummaryCategoryType

| Name          | Description                                                                                |
| ------------- | ------------------------------------------------------------------------------------------ |
| `in_t0`       | A T+0 settling transaction that results in money due to Alpaca                             |
| `in_t1`       | A T+1 settling transaction that results in money due to Alpaca                             |
| `in_t2`       | A T+2 settling transaction that results in money due to Alpaca                             |
| `out_t0`      | A T+0 settling transaction that results in money due to the partner                        |
| `out_t1`      | A T+1 settling transaction that results in money due to the partner                        |
| `out_t2`      | A T+2 settling transaction that results in money due to the partner                        |
| `jit_journal` | Journal entries generated by the JIT journaling job to flatten customer debits and credits |

### ENUM.EntryType

| Name     | Description                      |
| -------- | -------------------------------- |
| `CSD`    | Cash Disbursement (+)            |
| `DIV`    | Dividend                         |
| `DIVNRA` | Dividend Adjusted (NRA Withheld) |
| `FEE`    | Trading related fees             |
| `INT`    | Interest (Credit/Margin)         |
| `JNLC`   | Journal Entry (Cash)             |
| `MA`     | Merger/Acquisition               |
| `REORG`  | Reorg Coporate Action            |
| `TRD`    | Trade                            |

### ENUM.StatusType

| Name       | Description                      |
| ---------- | -------------------------------- |
| `executed` | The order has been filled, and no further updates will occur for the order.                            |
| `canceled` | The order has been canceled, and no further updates will occur for the order. This can be either due to a cancel request by the user, or the order has been canceled by the exchanges due to its time-in-force.                              |
| `correct`  | The order has been corrected, and no further updates will occur for the order.                       |

---

## **Daily Trading Limit Object**

The JIT Securities daily trading limit is set at the correspondent level and is used as the limit for the total amount due to Alpaca on the date of settlement. The limit in use returns the real time usage of this limit and is calculated by taking the net of trade and non-trade activity inflows and outflows. If the limit in use reaches the daily net limit, further purchasing activity will be halted, however, the limit can be adjusted by reaching out to Alpaca with the proposed new limit and the reason for the change.

```json
{
  "daily_net_limit_in_use": "150804",
  "daily_net_limit": "1000000"
}
```

### Attributes

| Attribute                | Type           | Notes                          |
| ------------------------ | -------------- | ------------------------------ |
| `daily_net_limit_in_use` | string/decimal | The real time net value of cash inflows (buy trades, etc.) with cash outflows (sell trades, dividends, etc). This will be dynamic throughout the day based on user activity, with executed orders being reset at the start of the next trading day.                                                             |
| `daily_net_limit`        | string/decimal | The net buying limit that can be reached before further cash outflow trading activity is restricted. Please reach out to learn more about how this limit is determined. |

## **Retrieving Daily Trading Limits**

`GET /v1/transfers/jit/limits`

### Request

No request parameters

### Response

Returns the JIT Securities [Daily Trading Limit Object]({{< relref "#daily-trading-limit-object">}}) based off of real time calculations.
