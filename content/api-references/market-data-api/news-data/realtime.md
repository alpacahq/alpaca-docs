---
weight: 100
bookFlatSection: false
bookCollapseSection: false
title: Real-time News
summary: Access Alpaca's historical and real-time stock market and crypto news through REST API and WebSocket.
---

# Real-time News

## **Stream endpoint**

`wss://stream.data.tradetalk.us/v1beta1/news`



## **Client to server**

Below are possible actions the client may send to the server.

### Authentication

`{"action":"auth","key":"<KEY>","secret":"<SECRET>"}`

### Subscribe

`{"action":"subscribe","news":["*"]}`

### Unsubscribe

`{"action":"unsubscribe","news":["*"]}`


## **News Data**

### Example News Object

```json
{
    "T": "n",
    "id": 24918784,
    "headline": "Corsair Reports Purchase Of Majority Ownership In iDisplay, No Terms Disclosed",
    "summary": "Corsair Gaming, Inc. (NASDAQ:CRSR) (“Corsair”), a leading global provider and innovator of high-performance gear for gamers and content creators, today announced that it acquired a 51% stake in iDisplay",
    "author": "Benzinga Newsdesk",
    "created_at": "2022-01-05T22:00:37Z",
    "updated_at": "2022-01-05T22:00:38Z",
    "url": "https://www.benzinga.com/m-a/22/01/24918784/corsair-reports-purchase-of-majority-ownership-in-idisplay-no-terms-disclosed",
    "content": "\u003cp\u003eCorsair Gaming, Inc. (NASDAQ:\u003ca class=\"ticker\" href=\"https://www.benzinga.com/stock/CRSR#NASDAQ\"\u003eCRSR\u003c/a\u003e) (\u0026ldquo;Corsair\u0026rdquo;), a leading global ...",
    "symbols": ["CRSR"],
    "source": "benzinga"
}
```

### Properties

| Attribute     | Type  | Notes                                                        |
| ------------ | ------ | -------------------------------------------------------------|
| `headline`   | string | Headline or title of the article                             |
| `created_at` | string (RFC 3339) | Date article was created                          |
| `updated_at` | string (RFC 3339) | Date article was updated                          |
| `author`     | string | Original auther of news article                              |
| `summary`    | string | Summary text for article (may be first sentence of content)  |
| `content`    | string | Content of news article (might contain HTML)                 |
| `url`        | string | URL of article (if applicable)                               |
| `symbols`    | string[] | List of related or mentioned symbols                       |
| `source`     | string | Source where the news originated from (e.g. Benzinga)        |
| `id`         | int | News article ID                                                 |
