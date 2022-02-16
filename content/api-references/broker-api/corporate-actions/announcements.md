---
bookHidden: false
weight: 1
title: "Announcements"
summary: Open brokerage accounts, enable commission-free trading, and manage the ongoing user experience with Alpaca Broker API
---

# Announcements

The announcements endpoint contains public information on previous and upcoming dividends, mergers, spinoffs, and stock splits. 

Announcement data is made available through the API as soon as it is ingested by Alpaca, which is typically the following trading day after the declaration date. This provides insight into future account stock position and cash balance changes that will take effect on an announcement’s payable date. Additionally, viewing previous announcement details can improve bookkeeping and reconciling previous account cash and position changes. 

---

## **The Announcement Object**

### Attributes

| Attribute                   | Type                     | Nullable | Notes                       |
| --------------------------- | ------------------------ | -------- | --------------------------- |
| `id`                        | string/UUID              | No       | ID that is specific to a single announcement. |
| `corporate_action_id`       | string                   | No       | ID that remains consistent across all announcements for the same corporate action. Unlike ‘id’, this can be used to connect multiple announcements to see how the terms have changed throughout the lifecycle of the corporate action event. |
| `ca_type`                   | [ENUM.CorporateActionType]({{< relref "#enumcorporateactiontype" >}}) | No       |              |
| `ca_sub_type`               | [ENUM.CorporateActionType]({{< relref "#enumcorporateactiontype" >}}) | No       |              |
| `initiating_symbol`         | string                   | No       | Symbol of the company initiating the announcement.     |
| `initiating_original_cusip` | string                   | No       | CUSIP of the company initiating the announcement.      |
| `target_symbol`             | string                   | Yes      | Symbol of the child company involved in the announcement.|
| `target_original_cusip`     | string                   | Yes      | CUSIP of the child company involved in the announcement. |
| `declaration_date`          | string                   | No       | Date the corporate action or subsequent terms update was announced.      |
| `ex_date`                   | string                   | Yes      | The first date that purchasing a security will not result in a corporate action entitlement.             |
| `record_date`               | string                   | Yes      | The date an account must hold a settled position in the security in order to receive the corporate action entitlement.             |
| `payable_date`              | string                   | No       | The date the announcement will take effect. On this date, account stock and cash balances are expected to be processed accordingly.  |
| `cash`                      | decimal                  | Yes      | The amount of cash to be paid per share held by an account on the record date.  |
| `old_rate`                  | decimal                  | Yes      | The denominator to determine any quantity change ratios in positions. |
| `new_rate`                  | decimal                  | Yes      | The numerator to determine any quantity change ratios in positions.   |

### ENUM.CorporateActionType

| Attribute  | Subtype             | Description                       |
| ---------  | ------------------- | --------------------------------- |
| `dividend` | `cash`              | A cash payment based on the number of shares the account holds on the record date. |
| `dividend` | `stock`             | A stock payment based on the number of shares the account holds on the record date. |
| `merger`   | `merger_update`     | An update to the terms of an upcoming merger. This can happen any number of times before the merger is completed and can be tracked by using the `id` parameter. |
| `merger`   | `merger_completion` | A final update in the terms of the merger in which the `intiating_symbol` will acquire the `target_symbol`. Any previous terms updates for this announcement will have the same `id` value. |
| `spinoff`  | `spinoff`           | A disbursement of a newly tradable security when the `intiating_symbol` creates the `target_symbol`. |
| `split`    | `stock_split`       | An increase in the number of shares outstanding with a decrease in the dollar value of each share. The `new_rate` and `old_rate` parameters will be returned in order to derive the ratio of the split. |
| `split`    | `unit_split`        | An increase in the number of shares outstanding with a decrease in the dollar value of each share. The `new_rate` and `old_rate` parameters will be returned in order to derive the ratio of the split. |
| `split`    | `reverse_split`     | A decrease in the number of shares outstanding with an increase in the dollar value of each share. The `new_rate` and `old_rate` parameters will be returned in order to derive the ratio of the split. |
| `split`    | `recapitalization`  | A stock recapitalization, typically used by a company to adjust debt and equity ratios. |

### ENUM.DateType

| Attribute          | Description                                                                                                         |
| -----------------  | ------------------------------------------------------------------------------------------------------------------- |
| `declaration_date` | The date of the preliminary announcement details or the date that any subsequent term updates took place.           |
| `ex_date`          | The date on which any security purchasing activity will not result in a corporate action entitlement. Any selling activity that takes place on or after this date will result in a corporate action entitlement. |
| `record_date`      | The date the company checks its records to determine who is shareholder in order to allocate entitlements. |
| `payable_date`     | The date that the stock and cash positions will update according to the account positions as of the record date.    |

---

## **Retrieving Announcements**

`GET /v1/corporate_actions/announcements`

This enables searching for an array of corporate action announcements based on criteria.

### Request

#### Parameters

| Parameter   | Type                                            | Required                                | Notes      |
| ----------- | ----------------------------------------------- | --------------------------------------- | ---------- |
| `ca_types`   | string                                          | {{<hint danger>}}Required {{</hint>}}   | A comma-delimited list of ENUM.CorporateActionType values |
| `since`     | string                                          | {{<hint danger>}}Required {{</hint>}}   | The start (inclusive) of the date range when searching corporate action announcements. This should follow the YYYY-MM-DD format. The date range is limited to 90 days. |
| `until`     | string                                          | {{<hint danger>}}Required {{</hint>}}   | The end (inclusive) of the date range when searching corporate action announcements. This should follow the YYYY-MM-DD format. The date range is limited to 90 days. |
| `symbol`    | string                                          | {{<hint info>}}Optional {{</hint>}}     | The symbol of the company initiating the announcement. |
| `cusip`     | string                                          | {{<hint info>}}Optional {{</hint>}}     | The CUSIP of the company initiating the announcement. |
| `date_type` | [ENUM.DateType]({{< relref "#enumdatetype" >}}) | {{<hint info>}}Optional {{</hint>}}     |  |

### Response

An array of Announcement objects. 

#### Sample Response

```json
[
  {
    "id": "3d41ba44-54ca-4c9d-86b2-f9574a723e73",
    "corporate_action_id": "060505104_AD21",
    "ca_type": "Dividend",
    "ca_sub_type": "cash",
    "initiating_symbol": "BAC",
    "initiating_original_cusip": "628855108",
    "target_symbol": "BAC",
    "target_original_cusip": "628855108",
    "declaration_date": "2021-10-19",
    "ex_date": "2021-12-02",
    "record_date": "2021-12-03",
    "payable_date": "2021-12-31",
    "cash": "0.21",
    "old_rate": "1",
    "new_rate": "1"
  },
  {
    "id": "8fe59e58-0181-4dfb-8acf-f6c3451d82e1",
    "corporate_action_id": "48251W104_AD21",
    "ca_type": "Dividend",
    "ca_sub_type": "cash",
    "initiating_symbol": "KKR",
    "initiating_original_cusip": "G52830109",
    "target_symbol": "KKR",
    "target_original_cusip": "G52830109",
    "declaration_date": "2021-11-01",
    "ex_date": "2021-11-12",
    "record_date": "2021-11-15",
    "payable_date": "2021-11-30",
    "cash": "0.145",
    "old_rate": "1",
    "new_rate": "1"
  }
]
```

## **Retrieving a Specific Announcement**

`GET /v1/corporate_actions/announcements/{id}`

This enables searching for a specific corporate action announcement.

### Request

In the `id` path parameter, provide the `id` of the corporate action announcement to be returned.

### Response

An Announcement object.

#### Sample Response

```json
{
  "id": "3fa6553a-4211-4018-85b9-d34d4d744c06",
  "corporate_action_id": "037833100_AD21",
  "ca_type": "Dividend",
  "ca_sub_type": "cash",
  "initiating_symbol": "AAPL",
  "initiating_original_cusip": "037833100",
  "target_symbol": "AAPL",
  "target_original_cusip": "037833100",
  "declaration_date": "2021-10-28",
  "ex_date": "2021-11-05",
  "record_date": "2021-11-08",
  "payable_date": "2021-11-11",
  "cash": "0.22",
  "old_rate": "1",
  "new_rate": "1"
}
```

#### Error Codes

{{<hint warning>}}
400 - Bad Request

​ _The body in the request is not valid_
{{</hint>}}

{{<hint warning>}}
422 - Unprocessable Entity

​ _Invalid input value._
{{</hint>}}

{{<hint warning>}}
500 - Internal Server Error​

_A server error occurred. Please contact Alpaca._
{{</hint>}}

&nbsp;