---
weight: 100
bookFlatSection: false
bookCollapseSection: false
title: News API
summary: Access Alpaca's historical and real-time stock market and crypto news through REST API and WebSocket.
---

# News API (Stocks & Crypto)

In partnership with Benzinga, Alpaca offers 6+ years of historical news data through a REST API and access to real-time through WebSockets.

{{< hint info >}}
**Free News API while in Beta**  
We're currenly offering News API in a limited time beta for free. While pricing might change in the
near future we will provide an update well in advance for anyone using the API.
{{< /hint >}}

## **Use Cases**

News API can be used for a variety of different use cases, whether your building an app with Broker API or want to automate trading with Trading API.

> **News Widgets**

If you're building a web or mobile app, with News API you can create visual news widgets to allow your users to view latest news for any stock or crypto symbol. News API includes different sized images to
give a visual appeal to your app.

> **News sentiment analysis**

With News API, you can use historical data to train models to determine sentiment for a given headline or news content.

> **Real-time trading on news**

Using real-time News over websockets, you can enable your trading algorithms to react to latest news across any stock of 



## **Historical (REST)**

Historical news data is provided starting from 2015. You can expect to receive approximately 130+ news articles daily. Currently, all news data is directly provided by Benzinga.

With a single endpoint, you can request news for both stocks and crypto tickers. For a more complete reference of News API, [see API reference]({{< relref "../api-references/market-data-api/news-data/historical" >}}).

### Get latest news

By calling the news API with all default (e.g. no query parameters) you will get the latest 10 news articles accross all symbols.

```bash
curl --location --request GET 'https://data.alpaca.markets/v1beta1/news' \
--header 'Apca-Api-Key-Id: <KEY>' \
--header 'Apca-Api-Secret-Key: <SECRET>'
```

See example response below for the above call,

```json
{
    "news": [
        {
            "id": 24919570,
            "headline": "Rumble Announces 'Exclusive' Content From AMC Ape Matt Kohrs And Rand Paul, Record Site Numbers Revealed",
            "author": "Chris Katje",
            "created_at": "2022-01-05T22:51:39Z",
            "updated_at": "2022-01-05T23:31:19Z",
            "summary": "Video platform Rumble shared several company updates Wednesday, including new user metrics.",
            "url": "https://www.benzinga.com/news/22/01/24919570/rumble-announces-amc-ape-matt-kohrs-and-rand-paul-joining-record-site-numbers-revealed",
            "images": [
                {
                    "size": "large",
                    "url": "https://cdn.benzinga.com/files/imagecache/2048x1536xUP/images/story/2012/mattkohrsonrumble.png"
                },
                {
                    "size": "small",
                    "url": "https://cdn.benzinga.com/files/imagecache/1024x768xUP/images/story/2012/mattkohrsonrumble.png"
                },
                {
                    "size": "thumb",
                    "url": "https://cdn.benzinga.com/files/imagecache/250x187xUP/images/story/2012/mattkohrsonrumble.png"
                }
            ],
            "symbols": [
                "AMC",
                "AMZN",
                "CFVI",
                "GME",
                "GOOG",
                "GOOGL",
                "TWTR"
            ],
            "source": "benzinga"
        },
        {...}
    ],
    "next_page_token": "MTY0MTQyMjU0OTAwMDAwMDAwMHwyNDkxNzQzNw=="
}
```

### Get news for multiple symbols

For multiple stock or crypto symbols you can provide a comma-separate list of symbols. Below example shows getting news articles for both Coinbase (`COIN`) and bitcoin (`BTCUSD`).

```bash
curl --location --request GET 'https://data.alpaca.markets/v1beta1/news?symbols=COIN,BTCUSD' \
--header 'Apca-Api-Key-Id: <KEY>' \
--header 'Apca-Api-Secret-Key: <SECRET>'
```

```json
        {
            "id": 24899683,
            "headline": "Investment Firm Offers Diversified Exposure To Crypto Innovations: Bitcoin, Solana, Avalanche And More",
            "author": "Renato Capelj",
            "created_at": "2022-01-05T20:11:10Z",
            "updated_at": "2022-01-05T20:23:40Z",
            "summary": "It takes time for innovations to penetrate their target markets. The rate of adoption is best characterized by the s-curve, a mathematical graph that plots growth against time.\n\nAt the outset, growth is slow in relation to the time that passes. With time, however, growth accelerates rapidly as the majority adopt the innovation.",
            "url": "https://www.benzinga.com/fintech/22/01/24899683/investment-firm-offers-diversified-exposure-to-crypto-innovations-bitcoin-solana-avalanche-and-more",
            "images": [
                {
                    "size": "large",
                    "url": "https://cdn.benzinga.com/files/imagecache/2048x1536xUP/images/story/2012/cover_photo_66.png"
                },
                {
                    "size": "small",
                    "url": "https://cdn.benzinga.com/files/imagecache/1024x768xUP/images/story/2012/cover_photo_66.png"
                },
                {
                    "size": "thumb",
                    "url": "https://cdn.benzinga.com/files/imagecache/250x187xUP/images/story/2012/cover_photo_66.png"
                }
            ],
            "symbols": [
                "AVAXUSD",
                "BTCUSD",
                "BX",
                "COIN",
                "ETHUSD",
                "SOLUSD"
            ],
            "source": "benzinga"
        }
```

### Content-related queries

{{< hint warning >}}
**Note**: Not all news contains content.
{{< /hint >}}

If you want to receive only news articles that contain content, use the `exclude_contentless=true` query parameter.

Additionally, by default we do not deliver content in the request, if your use case requires content make use of the `include_content=true` query parameter.

## **Real-time (Streaming)**

With real-time news streaming you can expect to receive a range of 600 to 900 news articles or headlines per day.

Note that not all news articles over the stream might contain content. So be prepared to handle that scenario if your use case depends on content.

For further reference on real-time news, [see real-time news reference]({{< relref "../api-references/market-data-api/news-data/realtime" >}})

### Connect to real-time news stream

You can use `wscat` or `websocat` in a terminal to test a connection to the news stream. In the example below, you can see an example that authenticated with the server and subcribes to news for
any symbol.

```bash
wscat -c wss://stream.data.tradetalk.us/v1beta1/news
Connected (press CTRL+C to quit)
< [{"T":"success","msg":"connected"}]

> {"action":"auth","key":"<KEY>","secret":"<SECRET>"}
< [{"T":"success","msg":"authenticated"}]

> {"action":"subscribe","news":["*"]}
< [{"T":"subscription","news":["*"]}]

<[{"T":"n","id":24919710,"headline":"Granite Wins $90M Construction Manager/General Contractor Project In Northern California","summary":"Granite (NYSE:GVA) announced today that it has been selected by the California Department of Transportation (Caltrans) as the Construction Manager/General Contractor (CM/GC) for the approximately $90 million State Route","author":"Benzinga Newsdesk","created_at":"2022-01-05T22:30:29Z","updated_at":"2022-01-05T22:30:30Z","url":"https://www.benzinga.com/news/22/01/24919710/granite-wins-90m-construction-managergeneral-contractor-project-in-northern-california","content":"\u003cp\u003eGranite (NYSE:...","symbols":["GVA"],"source":"benzinga"}]

``` 

#### Subscribe to all symbols

`{"action":"subscribe","news":["*"]}`

#### Subscribe to specific symbols

`{"action":"subscribe","news":["AAPL", "TSLA", "BTCUSD"]}`

#### Unsubscribe to all symbols

`{"action":"unsubscribe","news":["*"]}`
