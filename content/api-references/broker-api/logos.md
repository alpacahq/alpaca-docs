---
bookHidden: false
weight: 8
summary: Open brokerage accounts, enable crypto and stock trading, and manage the ongoing user experience with Alpaca Broker API
title: Logos
---

# Logos

Alpaca’s Logo API serves uniform logo images for select stock and crypto symbols.

## **Get Logo**

`GET /v1beta1/logos/{symbol}`

### Path Parameters

| Attribute     | Type   | Required                            | Notes                                 |
| ------------- | ------ | ----------------------------------- | ------------------------------------- |
| `symbol`      | string | {{<hint danger>}}Required {{</hint>}} | Stock or crypto symbol (e.g. AAPL, BTCUSD, etc.) |


### Query Parameters

| Attribute     | Type   | Required                            | Notes                                 |
| ------------- | ------ | ----------------------------------- | ------------------------------------- |
| `placeholder`      | string | {{<hint info>}}Optional {{</hint>}} | True by default, will return sample placeholder images with the first letter of the asset symbol. If false, 404 will be returned for symbols which do not contain an image. |


### Sample Request

```
curl --location --request GET 'https://data.alpaca.markets/v1beta1/logos/BTCUSD' \
--header 'APCA-API-KEY-ID: <KEY>' \
--header 'APCA-API-SECRET-KEY: <SECRET>' 
```

**Note**: The endpoint requires authentication to return images files

For crypto symbols append USD at the end, such as `BTCUSD` or `ETHUSD`.


### Sample Response

![sample-logo](../images/btc.png)

**Note**: The API response will return the raw image as a binary


## **Logo Image Specification**

All logo images served follow the following specs:
- PNG format
- Square 300 x 300 pixels

### Placeholder images

Not all stock tickers have a proper logo, for which we provide simple placeholder images. See sample below.

![sample-placeholder](../images/a.png)

By default Logo API will always serve a placeholder image for those that don't exist. If you would rather have the endpoint return a 404 when the resource does not exist you can use the placeholder query parameter.

```
curl --location --request GET 'https://data.alpaca.markets/v1beta1/logos/ABCD?placeholder=false'
```