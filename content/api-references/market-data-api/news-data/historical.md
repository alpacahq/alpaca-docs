---
weight: 100
bookFlatSection: false
bookCollapseSection: false
title: Historical News
summary: Access 6+ years of historical stock market and crypto news through a REST API.
---

# Historical News

 Access 6+ years of historical stock market and crypto news through a REST API.

## **Get News**


`GET /v1beta1/news`
\
Returns latest news articles across stocks and crypto. By default returns latest 10 news articles.

### Parameters

#### Query Parameters

| Attribute | Type   | Requirement                           | Notes                   |
| --------- | ------ | ------------------------------------- | ----------------------- |
| `symbols`| string | {{<hint info>}}Optional {{</hint>}} | List of symbols to obtain news |
| `start`  | timestamp (RFC 3339) | {{<hint info>}}Optional {{</hint>}} | (Default: 01-01-2015) Start date to obtain news |
| `end`    | timestamp (RFC 3339)  | {{<hint info>}}Optional {{</hint>}} | (Default: now) End date to obtain news |
| `limit`  | string | {{<hint info>}}Optional {{</hint>}} | (Default: 10, Max: 50) Limit of news items to be returned for given page |
| `sort`  | string | {{<hint info>}}Optional {{</hint>}} | (Default: `DESC`)  Sort articles by updated date. Options: `DESC`, `ASC` |
| `include_content`  | boolean | {{<hint info>}}Optional {{</hint>}} | (Default: false) Boolean whether to include content for news articles |
| `exclude_contentless`  | boolean | {{<hint info>}}Optional {{</hint>}} | (Default: false) Exclude news articles that do not contain content (just headline and summary) |
| `page_token`  | string | {{<hint info>}}Optional {{</hint>}} | Pagination token to continue to next page |

### Request

#### Example request

```
curl --location --request GET 'https://data.alpaca.markets/v1beta1/news?start=2021-12-28T00:00:00Z&end=2021-12-31T11:59:59Z&symbols=AAPL,TSLA' \
--header 'Apca-Api-Key-Id: <KEY>' \
--header 'Apca-Api-Secret-Key: <SECRET>'
```

### Response

{{<hint good>}}
A list news objects.
{{</hint>}}

#### Example response

```
{
    "news": [
        {
            "id": 24843171,
            "headline": "Apple Leader in Phone Sales in China for Second Straight Month in November With 23.6% Share, According to Market Research Data",
            "author": "Charles Gross",
            "created_at": "2021-12-31T11:08:42Z",
            "updated_at": "2021-12-31T11:08:43Z",
            "summary": "",
            "url": "https://www.benzinga.com/news/21/12/24843171/apple-leader-in-phone-sales-in-china-for-second-straight-month-in-november-with-23-6-share-according",
            "images": [],
            "symbols": [
                "AAPL"
            ],
            "source": "benzinga"
        }
    ],
    "next_page_token": "MTY0MDk0ODkyMzAwMDAwMDAwMHwyNDg0MzE3MQ=="
}
```

### Errors

{{<hint warning>}}
403 - Forbidden

​ _Unauthorized_
{{</hint>}}

{{<hint warning>}}
422 - Bad Request

​ _Unprocessable Entity_
{{</hint>}}

{{<hint warning>}}
429 - Too many requests

​ _Rate limit exceeded_
{{</hint>}}


## **News Model**

### Example news object

```json
        {
            "id": 24803233,
            "headline": "Benzinga's Top 5 Articles For 2021 — Or 'Who Let The Dog Out?'",
            "author": "Sue Strachan",
            "created_at": "2021-12-29T15:11:03Z",
            "updated_at": "2021-12-30T20:37:41Z",
            "summary": "2021 may have been the Year of the Ox in the Chinese calendar, but for Benzinga, it was the Year of the Dog, or should we say, Year of the Dogecoin (CRYPTO: DOGE).",
            "content": "<p>2021 may have been the Year of the Ox in the Chinese calendar, but for Benzinga, it was the Year of the Dog, or should we say, Year of the <strong>Dogecoin</strong> (CRYPTO: <a class=\"ticker\" href=\"https://www.benzinga.com/quote/doge/usd\">DOGE</a>).</p>\r\n\r\n<p>The memecoin created in 2013....",
            "images": [
                {
                    "size": "large",
                    "url": "https://cdn.benzinga.com/files/imagecache/2048x1536xUP/images/story/2012/doge_12.jpg"
                },
                {
                    "size": "small",
                    "url": "https://cdn.benzinga.com/files/imagecache/1024x768xUP/images/story/2012/doge_12.jpg"
                },
                {
                    "size": "thumb",
                    "url": "https://cdn.benzinga.com/files/imagecache/250x187xUP/images/story/2012/doge_12.jpg"
                }
            ],
            "symbols": [
                "AMZN",
                "BTCUSD",
                "COIN",
                "DOGEUSD",
                "SPCE",
                "TSLA",
                "TWTR"
            ],
            "source": "benzinga"
        }
```

### Properties

| Attribute    | Type              | Notes                                                        |
| ------------ | ----------------- | -------------------------------------------------------------|
| `headline`   | string            | Headline or title of the article                             |
| `created_at` | string (RFC 3339) | Date article was created                                     |
| `updated_at` | string (RFC 3339) | Date article was updated                                     |
| `author`     | string            | Original author of news article                              |
| `summary`    | string            | Summary text for the article (may be first sentence of content)  |
| `content`    | string            | Content of the news article (might contain HTML)             |
| `images`     | object            | List of images (URLs) related to given article (may be empty)|
| `url`        | string            | URL of article (if applicable)                               |
| `symbols`    | string[]          | List of related or mentioned symbols                         |
| `source`     | string            | Source where the news originated from (e.g. Benzinga)        |
| `id`         | int               | News article ID                                              |

If object contains images, this will be an object of three items with the `size` of the image and a URL. Possible values for `size` are `thumb`, `small` and `large`.