---
title: Portfolio History
weight: 80
---

# Portfolio History

The portfolio history API returns the timeseries data for equity and profit loss information of the account.

{{<hint danger>}}
**Known issue with Portfolio History calculations**

We have received feedback and are aware issues regarding data calculated with Portfolio History API which could lead to incorrect values for `equity`, `profit_loss`, and `profit_loss_pct`.

Please validate results for Portfolio History API and make sure values are consistent for your use case.

We will be revamping Portfolio History API soon and will be updated in the documentation accordingly.

{{</hint>}}

{{< rest-endpoint resource="portfolio-history" method="GET" path="/v2/account/portfolio/history" >}}

## PortfolioHistory Entity

### Example

{{< rest-entity-example name="portfolio-history-v2">}}

### Properties

{{< rest-entity-desc name="portfolio-history-v2">}}
