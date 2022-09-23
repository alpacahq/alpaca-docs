---
title: Assets
weight: 40
type: docs
bookToc: true
---

# Assets

The assets API serves as the master list of coins and tokens available for trade and data consumption from Alpaca. Assets are sorted by asset class, exchange and symbol. 

{{< rest-endpoint resource="assets" method="GET" path="/v2/assets" >}}
{{< rest-endpoint resource="assets" method="GET" path="/v2/assets/{symbol_or_asset_id}" >}}

## Asset Entity

Currently, two classes of assets exist: `us_equity` and `crypto`.

### Equity Example
{{< rest-entity-example name="asset-v2">}}

### Crypto Example
{{< rest-entity-example name="asset-crypto-v2">}}

### Properties
{{< rest-entity-desc name="asset-crypto-v2" >}}
