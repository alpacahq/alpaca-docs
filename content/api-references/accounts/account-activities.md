---
bookHidden: false
weight: 2
title: "Account Activities"
---

# Account Activities

The account activities API provides access to a historical record of transaction activities that have impacted any accounts you’ve created. Trade execution activities and non-trade activities, such as dividend payments, are both reported through this endpoint.

---

## Getting Account Activities

`GET /v1/accounts/activities`

### Request

#### Parameters

| Attribute       | Type              | Requirement                           | Notes                                                     |
| --------------- | ----------------- | ------------------------------------- | --------------------------------------------------------- |
| `activity_type` | ENUM.ActivityType | {{<hint danger>}}Required {{</hint>}} |                                                           |
| `date`          | date              | {{<hint danger>}}Required {{</hint>}} |                                                           |
| `until`         | date              | {{<hint danger>}}Required {{</hint>}} | _Cannot be used with date._                               |
| `after`         | date              | {{<hint danger>}}Required {{</hint>}} | _Cannot be used with date._                               |
| `direction`     | string.UUID       | {{<hint info>}}Optional {{</hint>}}   | _Defaults to `desc`_                                      |
| `account_id`    | string            | {{<hint info>}}Optional {{</hint>}}   |                                                           |
| `page_size`     | int               | {{<hint info>}}Optional {{</hint>}}   | _The maximum number of entries to return in the response_ |
| `page_token`    | int               | {{<hint info>}}Optional {{</hint>}}   | _The ID of the end of your current page of results_       |

Notes:

- Pagination is handled using the `page_token` and `page_size` parameters.
- `page_token` represents the ID of the end of your current page of results.
- If specified with a direction of `desc`, for example, the results will end before the activity with the specified ID.
- If specified with a direction of `asc`, results will begin with the activity immediately after the one specified.
- `page_size` is the maximum number of entries to return in the response.
- If `date` is not specified, the default and maximum value is 100.
- If `date` is specified, the default behavior is to return all results, and there is no maximum page size.

### Response

#### Parameters

| key             | value               |
| --------------- | ------------------- |
| `id`            | string.UUID         |
| `account_id`    | string.UUID         |
| `activity_type` | ENUM.ActivityType   |
| `date`          | date                |
| `net_amount`    | string.number       |
| `description`   | string              |
| `status`        | ENUM.ActivityStatus |

#### Sample Response

```json
{
  "id": "20210108000000000::07c15370-2d0e-48ca-9f9f-c11303ea0bdf",
  "account_id": "6722da2e-5ca9-4c0a-aae6-dd105132e860",
  "activity_type": "JNLC",
  "date": "2021-01-08",
  "net_amount": "15",
  "description": "ID: 1a774682-ca46-4441-bcdf-6edace58208e - ",
  "status": "executed"
}
```

---

## Getting Account Activities by Type

`GET /v1/accounts/activities/{activity_type}`

### Request

#### Parameters

| Attribute       | Type              | Requirement                           | Notes                                                     |
| --------------- | ----------------- | ------------------------------------- | --------------------------------------------------------- |
| `activity_type` | ENUM.ActivityType | {{<hint danger>}}Required {{</hint>}} |                                                           |
| `date`          | date              | {{<hint danger>}}Required {{</hint>}} |                                                           |
| `until`         | date              | {{<hint danger>}}Required {{</hint>}} | _Cannot be used with date._                               |
| `after`         | date              | {{<hint danger>}}Required {{</hint>}} | _Cannot be used with date._                               |
| `direction`     | string.UUID       | {{<hint info>}}Optional {{</hint>}}   | _Defaults to `desc`_                                      |
| `account_id`    | string            | {{<hint info>}}Optional {{</hint>}}   |                                                           |
| `page_size`     | int               | {{<hint info>}}Optional {{</hint>}}   | _The maximum number of entries to return in the response_ |
| `page_token`    | int               | {{<hint info>}}Optional {{</hint>}}   | _The ID of the end of your current page of results_       |

### Response

#### Parameters

| key             | value               |
| --------------- | ------------------- |
| `id`            | string.UUID         |
| `account_id`    | string.UUID         |
| `activity_type` | ENUM.ActivityType   |
| `date`          | date                |
| `net_amount`    | string.number       |
| `description`   | string              |
| `status`        | ENUM.ActivityStatus |

#### Sample Response

```json
{
  "activity_type": "DIV",
  "id": "20190801011955195::5f596936-6f23-4cef-bdf1-3806aae57dbf",
  "date": "2019-08-01",
  "net_amount": "1.02",
  "symbol": "T",
  "qty": "2",
  "per_share_amount": "0.51",
  "status": "executed"
}
```

## Enum.ActivityTypes

| Activity Type                                                                                                                                                             | Description                                                                                                                                                     |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `FILL`                                                                                                                                                                    | Order fills (both partial and full fills)                                                                                                                       |
| `ACATC`                                                                                                                                                                   | ACATS IN/OUT (Cash)                                                                                                                                             |
| `ACATS`                                                                                                                                                                   | ACATS IN/OUT (Securities)                                                                                                                                       |
| `CSD`                                                                                                                                                                     | Cash disbursement (+)                                                                                                                                           |
| `CSR`                                                                                                                                                                     | Cash receipt (-)                                                                                                                                                |
| `CSW`                                                                                                                                                                     | Cash withdrawable                                                                                                                                               |
| `DIV`                                                                                                                                                                     | Dividend                                                                                                                                                        |
| `DIVCGL`                                                                                                                                                                  | Dividend (capital gain long term)                                                                                                                               |
| `DIVCGS`                                                                                                                                                                  | Dividend (capital gain short term) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |
| `DIVNRA`                                                                                                                                                                  | Dividend adjusted (NRA Withheld)                                                                                                                                |
| `DIVROC`                                                                                                                                                                  | Dividend return of capital                                                                                                                                      |
| `DIVTXEX`&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | Dividend (tax exempt)                                                                                                                                           |
| `INT`                                                                                                                                                                     | Interest (credit/margin)                                                                                                                                        |
| `JNLC`                                                                                                                                                                    | Journal entry (cash)                                                                                                                                            |
| `JNLS`                                                                                                                                                                    | Journal entry (stock)                                                                                                                                           |
| `MA`                                                                                                                                                                      | Merger/Acquisition                                                                                                                                              |
| `NC`                                                                                                                                                                      | Name change                                                                                                                                                     |
| `PTC`                                                                                                                                                                     | Pass thru change                                                                                                                                                |
| `REORG`                                                                                                                                                                   | Reorg CA                                                                                                                                                        |
| `SSO`                                                                                                                                                                     | Stock spinoff                                                                                                                                                   |
| `SSP`                                                                                                                                                                     | Stock split                                                                                                                                                     |

&nbsp;
