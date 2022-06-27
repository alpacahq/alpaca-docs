---
title: Getting Started
weight: 50
aliases:
  - /getting-started.md
---

# Getting Started

This is a quick guide on how to start consuming market data via
APIs. Starting from beginning to end, this section outlines how to install Alpaca's software development kit (SDK), create a free alpaca account, locate your API keys,
and how to request both historical and real-time data.

## Installing Alpaca's Client SDK

In this guide, we'll be making use of the SDKs
provided by Alpaca. Alpaca maintains SDKs in four languages: [Python](https://github.com/alpacahq/alpaca-trade-api-python), [JavaScript](https://github.com/alpacahq/alpaca-trade-api-js),
[C#](https://github.com/alpacahq/alpaca-trade-api-csharp), and [Go](https://github.com/alpacahq/alpaca-trade-api-go). Follow the steps in the installation guide below to install the SDK of your choice before proceeding to the next section.

{{< tabs "installation-guide" >}}
{{< tab "Python" >}}

Alpaca requires Python >= 3.7. If you want to work with Python 3.6, please note
that these package dropped support for Python <3.7 for the following versions:

```sh
pandas >= 1.2.0
numpy >= 1.20.0
scipy >= 1.6.0
```

The solution is to manually install these package before installing alpaca-trade-api. e.g:

```sh
pip install pandas==1.1.5 numpy==1.19.4 scipy==1.5.4
```

Also note that we do not limit the version of the websockes library, but we
advise using

```sh
websockets>=9.0
```

To install the Python client SDK, use pip:

```sh
$pip3 install alpaca-trade-api
```

{{< /tab >}}
{{< tab "JavaScript" >}}

Install the JavaScript client SDK using npm:

```sh
npm install --save @alpacahq/alpaca-trade-api
```

Please note the following runtime dependencies:

- Node.js v14.x or newer
- npm version 6 and above

{{< /tab >}}
{{< tab "C#" >}}

Navigate inside of your project folder and run:

```sh
dotnet add package Alpaca.Markets
```

{{< /tab >}}
{{< /tabs >}}

## Creating an Alpaca Account and Finding Your API Keys

To request data from Alpaca you'll need to include your API keys in your
requests. This section outlines how one can create an account and generate
the keys necessary to start querying for market data.

1. Navigate to [Alpaca's Website](https://alpaca.markets)
2. Sign up for a free account using the sign up button

   ![Alpaca homepage](../images/alpaca_homepage.png)

3. After confirming your account and logging in, navigate to your paper
   trading dashboard

   ![Paper trading link](../images/paper_dashboard.png)

4. On the dashboard, click the button to view your API keys

   ![view keys](../images/view_keys.png)

5. After expanding your API keys section, generate new keys

   ![generate keys](../images/generate_keys.png)

6. After your keys have been generated, securely save them for future use

   ![copy keys](../images/copy_keys.png)

## How to Request Market Data Through the SDK

With the SDK installed and our API keys ready, we can start requesting market
data. Alpaca offers many options for both historical and real-time data, so to
keep this guide succint, these examples are on obtaining historical and real-time
[bar](../../api-references/market-data-api/stock-pricing-data/historical/#bar) data. Information on what other data is available can be found in the [Market Data API reference](../../api-references/market-data-api).

### Querying for Historical Data

{{< tabs "historical-data" >}}
{{< tab "Python" >}}

To start using the SDK for historical data, let's import the SDK and
instantiate the REST client. We'll instantiate the client using our API keys
and Alpaca's paper trading URL.

```py
# Importing the api and instantiating the rest client according to our keys
import alpaca_trade_api as api

API_KEY = "<Your API Key>"
API_SECRET = "<Your Secret Key>"
BASE_URL = "https://paper-api.alpaca.markets"

alpaca_client = api.REST(API_KEY, API_SECRET, BASE_URL)
```

Next we'll define the parameters for our request. This example will query for
historical daily bar data of Bitcoin during the first month of 2022.

```py
# Setting parameters before making request
symbol = "BTCUSD"
timeframe = "1Day"
start = "2022-01-01"
end = "2022-01-31"
```

Finally, we'll make the request using the client's built-in method,
`get_crypto_bars`. Additionally, we'll access the `.df` property which returns
a pandas DataFrame of the response. Then, using the DataFrame, we can print the first 5 rows of Bitcoin's bar data.

```py
# Retrieve daily bars for Bitcoin in a DataFrame and printing the first 5 rows
btc_bars = alpaca_client.get_crypto_bars(symbol, timeframe, start, end).df
print(btc_bars.head())
```

```sh
                          exchange      open      high       low     close  \
timestamp
2022-01-01 06:00:00+00:00     CBSE  47188.00  47951.21  46690.00  47093.40
2022-01-01 06:00:00+00:00     ERSX  47004.40  47832.30  46823.80  46904.50
2022-01-01 06:00:00+00:00     FTXU  47218.00  47933.00  46733.00  47033.00
2022-01-02 06:00:00+00:00     CBSE  47095.58  47960.12  46714.91  47090.32
2022-01-02 06:00:00+00:00     ERSX  47212.70  47929.70  46737.90  47079.20

                                volume  trade_count          vwap
timestamp
2022-01-01 06:00:00+00:00  6118.650421       298030  47295.920139
2022-01-01 06:00:00+00:00    16.900700           40  47429.231828
2022-01-01 06:00:00+00:00   654.701300         3435  47287.231933
2022-01-02 06:00:00+00:00  5247.180306       273283  47139.189247
2022-01-02 06:00:00+00:00    87.372500           84  46998.245299
```

It's important to note that when querying bars for stocks you'll need to use a
different method, `get_bars`.

{{< /tab >}}
{{< tab "JavaScript" >}}

To enable access to the tools in the SDK, first load the module that was
installed previously.

```js
const Alpaca = require("@alpacahq/alpaca-trade-api");
```

Next, instantiate an instance of the Alpaca class and define the
parameters that go along with it. These are the API key, API secret key, and
a boolean indicating whether the keys belong to a paid data plan or not.

```js
API_KEY = "<Your API Key>";
API_SECRET = "<Your Secret Key>";

const alpaca = new Alpaca({
  keyId: API_KEY,
  secretKey: API_SECRET,
  paper: true,
});
```

Now define an object that parameterizes the options for the request. If one
wants the most recent daily bar for Bitcoin, then they can define the object as
below. Two parameters that aren't set here are `limit` and `exchanges`.

```js
const options = {
  start: new Date(new Date().setDate(new Date().getDate() - 1)), // 1 day ago
  end: new Date(), // Current date
  timeframe: "1Day",
};
```

The Alpaca class instantiated has a method, `getCryptoBars`, that is used
for getting crypto bars. Place this method inside an asynchronous
function that pushes the bars into an array as they come, returning the final
array. After that, define the symbol to query data for and print each of the
bars in the resulting array.

```js
async function getHistoricalBars(symbol) {
  let bars = [];
  let resp = alpaca.getCryptoBars(symbol, options);
  for await (let bar of resp) {
    bars.push(bar);
  }
  return bars;
}

symbol = "BTCUSD";
barsPromise = getHistoricalBars(symbol);
barsPromise.then((bars) =>
  bars.forEach((bar) => {
    console.log(bar);
  })
);
```

{{< /tab >}}
{{< tab "C#" >}}

ADD TEXT to this LATER!

Initial setup:

```cs
using System;
using Alpaca.Markets;
using System.Threading.Tasks;

namespace AlpacaExample
{
    internal sealed class Program
    {
        public static async Task Main()
        {

        }
    }
}
```

API keys and instantiation:

```cs
internal sealed class Program
{
    private const String API_KEY = "<Your API Key>";

    private const String API_SECRET = "<Your Secret Key>";

    public static async Task Main()
    {
        var client = Environments.Paper.GetAlpacaCryptoDataClient(new SecretKey(API_KEY, API_SECRET));
    }
}
```

Setting parameters for query:

```cs
public static async Task Main()
{
    var client = Environments.Paper.GetAlpacaCryptoDataClient(new SecretKey(API_KEY, API_SECRET));

    String symbol = "BTCUSD";
    DateTime start = DateTime.Today.AddDays(-1);  // Yesterday
    DateTime end = DateTime.Today;                // Today
    var timeframe = BarTimeFrame.Day;             // Denotes daily bars
}
```

Making query and printing resulting bar:

```cs
public static async Task Main()
{
    var client = Environments.Paper.GetAlpacaCryptoDataClient(new SecretKey(API_KEY, API_SECRET));

    String symbol = "BTCUSD";
    DateTime start = DateTime.Today.AddDays(-1);  // Yesterday
    DateTime end = DateTime.Today;                // Today
    var timeframe = BarTimeFrame.Day;             // Denotes daily bars

    var bars = await client.ListHistoricalBarsAsync(
        new HistoricalCryptoBarsRequest(symbol, start, end, timeframe));

    Console.WriteLine(bars);
}
```

formatted output:

```sh
{
   "bars":[
      {
         "o":21237.19,
         "c":20871.47,
         "l":20500.0,
         "h":21520.0,
         "v":11881.7097405,
         "t":"2022-06-27T05:00:00Z",
         "vw":20972.0411669989,
         "n":349271
      },
      {
         "o":21229.7,
         "c":20843.1,
         "l":20505.3,
         "h":21465.6,
         "v":133.191979,
         "t":"2022-06-27T05:00:00Z",
         "vw":20800.918343989,
         "n":689
      },
      {
         "o":21231.0,
         "c":20864.0,
         "l":20476.0,
         "h":21539.0,
         "v":1091.384,
         "t":"2022-06-27T05:00:00Z",
         "vw":20896.2606985259,
         "n":4876
      }
   ],
   "symbol":"BTCUSD",
   "next_page_token":null
}
```

{{< /tab >}}
{{< /tabs >}}

### Streaming Real-Time Data

After installing the SDK and securing API keys, you can start streaming
real-time data right away. Similar to our historical data example, we'll stream
bar data for one symbol (BTCUSD). To learn more about what data are available for
streaming, visit the docs for [real-time stocks data](../../api-references/market-data-api/stock-pricing-data/realtime) and [real-time crypto data](../../api-references/market-data-api/crypto-pricing-data/realtime).

{{< tabs "realtime-data" >}}
{{< tab "Python" >}}

To start streaming real-time data, first import the Stream class from the SDK.

```py
from alpaca_trade_api.stream import Stream
```

After that, define the parameters used to instantiate an instance of the
class. These are the API key and secret, base url, and data feed. Then, pass
these parameters into the Stream constructor and we'll be ready to stream data.

```py
API_KEY = "<Your API Key>"
API_SECRET = "<Your Secret Key>"
base_url = "https://paper-api.alpaca.markets"
data_feed = "iex" # Change to "sip" if using paid subscription

# Instantiate Stream class
stream = Stream(API_KEY,
                API_SECRET,
                base_url=base_url,
                data_feed=data_feed)
```

Next, define a simple callback function that will print the bar upon
receiving it. Then, define the symbol and subscribe to that symbol's
bars. The Stream class includes a method for subscribing to crypto bars,
`subscribe_crypto_bars`, that takes a callback function and symbol as
parameters. After calling that method, run the stream and wait for the
callback function to print bars.

```py
async def bar_callback(b):
    print(b)

# Subscribing to bar event
symbol = "BTCUSD"
stream.subscribe_crypto_bars(bar_callback, symbol)

stream.run()
```

```sh
Bar({
    'close': 22153.0,
    'exchange': 'FTXU',
    'high': 22164.0,
    'low': 22153.0,
    'open': 22164.0,
    'symbol': 'BTCUSD',
    'timestamp': 1655217720000000000,
    'trade_count': 3,
    'volume': 0.3636,
    'vwap': 22157.5924092409})
```

{{< /tab >}}
{{< tab "JavaScript" >}}

This section is based off of the [working stock example](https://github.com/alpacahq/alpaca-trade-api-js/blob/master/examples/websocket_example_datav2.js)
that can be found on the official GitHub repository for the JavaScript SDK.
As usual, the first step is to load the Alpaca module.

```js
const Alpaca = require("@alpacahq/alpaca-trade-api");
```

Next, define our options that parameterize our data stream. These are the API
key, API key secret, data feed, and symbol.

```js
API_KEY = "<Your API Key>";
API_SECRET = "<Your Secret Key>";
const feed = "iex"; // Change to "sip" if on a paid plan
const symbol = "BTCUSD";
```

Now we'll modify [the stock example](https://github.com/alpacahq/alpaca-trade-api-js/blob/master/examples/websocket_example_datav2.js). To simplify this example, remove all socket methods except
for `onConnect`, `onError`, `onDisconnect`, and `connect`. Add `symbol` to the
`DataStream` constructor to give us access to the symbol, change the socket to
`crypto_stream_v2` so we can stream crypto, and add the method `onCryptoBar`
which handles crypto bar events.

```js
class DataStream {
  constructor({ apiKey, secretKey, feed, symbol }) {
    this.alpaca = new Alpaca({
      keyId: apiKey,
      secretKey,
      feed,
    });

    const socket = this.alpaca.crypto_stream_v2;

    socket.onConnect(function () {
      console.log("Connected");
      socket.subscribeForBars([symbol]);
    });

    socket.onError((err) => {
      console.log(err);
    });

    socket.onCryptoBar((bar) => {
      console.log(bar);
    });

    socket.onDisconnect(() => {
      console.log("Disconnected");
    });

    socket.connect();
  }
}
```

Finally, instantiate the `DataStream` class we've created and watch the
bars come in.

```js
let stream = new DataStream({
  apiKey: API_KEY,
  secretKey: API_SECRET,
  feed: feed,
  symbol: symbol,
  paper: true,
});
```

```sh
{
  T: 'b',
  Symbol: 'BTCUSD',
  Exchange: 'ERSX',
  Open: 21569.4,
  High: 21569.4,
  Low: 21543,
  Close: 21543,
  Volume: 0.465657,
  Timestamp: 2022-06-15T13:57:00.000Z,
  TradeCount: 2,
  VWAP: 21543.0850411354
}
...
```

{{< /tab >}}
{{< tab "C#" >}}

ADD TEXT to this LATER!

Initial setup:

```cs
using System;
using Alpaca.Markets;
using System.Threading.Tasks;

namespace AlpacaExample
{
    internal sealed class Program
    {
        public static async Task Main()
        {

        }
    }
}
```

API keys, instantiation, and connection:

```cs
internal sealed class Program
{
    private const String API_KEY = "<Your API Key>";

    private const String API_SECRET = "<Your Secret Key>";

    public static async Task Main()
    {
        var client = Environments.Paper.GetAlpacaCryptoStreamingClient(new SecretKey(API_KEY, API_SECRET));

        await client.ConnectAndAuthenticateAsync();
    }
}
```

Creating wait objs, symbol, creating subscription:

```cs
public static async Task Main()
{
    var client = Environments.Paper.GetAlpacaCryptoStreamingClient(new SecretKey(API_KEY, API_SECRET));

    await client.ConnectAndAuthenticateAsync();

    var waitObjects = new []
    {
        new System.Threading.AutoResetEvent(false),
    };

    String symbol = "BTCUSD";

    var barSubscription = client.GetMinuteBarSubscription(symbol);
    barSubscription.Received += (bar) =>
    {
        Console.WriteLine(bar);
        waitObjects[0].Set();
    };
}
```

Subscribing to bars and waiting for the event:

```cs
public static async Task Main()
{
    var client = Environments.Paper.GetAlpacaCryptoStreamingClient(new SecretKey(API_KEY, API_SECRET));

    await client.ConnectAndAuthenticateAsync();

    var waitObjects = new []
    {
        new System.Threading.AutoResetEvent(false),
    };

    String symbol = "BTCUSD";

    var barSubscription = client.GetMinuteBarSubscription(symbol);
    barSubscription.Received += (bar) =>
    {
        Console.WriteLine(bar);
        waitObjects[0].Set();
    };

    await client.SubscribeAsync(barSubscription);
    System.Threading.WaitHandle.WaitAll(waitObjects, TimeSpan.FromSeconds(61));
}
```

output bar:

```sh
{
   "o":20840.4,
   "h":20840.4,
   "l":20840.4,
   "c":20840.4,
   "v":0.719755,
   "vw":20840.4,
   "n":1,
   "T":"b",
   "S":"BTCUSD",
   "t":"2022-06-27T19:55:00Z"
}
```

closing

{{< /tab >}}
{{< /tabs >}}
