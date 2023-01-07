---
title: Getting Started
weight: 50
aliases:
  - /getting-started.md
---

# Getting Started

This is a quick guide on how to start consuming market data via
APIs. Starting from beginning to end, this section outlines how to install Alpaca's
software development kit (SDK), create a free alpaca account, locate your API keys,
and how to request both historical and real-time data.

## Installing Alpaca's Client SDK

In this guide, we'll be making use of the SDKs
provided by Alpaca. Alpaca maintains SDKs in four languages: [Python](https://github.com/alpacahq/alpaca-py),
[JavaScript](https://github.com/alpacahq/alpaca-trade-api-js),
[C#](https://github.com/alpacahq/alpaca-trade-api-csharp),
and [Go](https://github.com/alpacahq/alpaca-trade-api-go). Follow the steps in the
installation guide below to install the SDK of your choice before proceeding to the next section.

{{< tabs "installation-guide" >}}
{{< tab "Python" >}}

Alpaca requires Python >= 3.7. To install the Python client SDK, Alpaca-py, use pip:

```sh
pip install alpaca-py
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

Navigate to inside of your .NET application folder and run:

```sh
dotnet add package Alpaca.Markets
```

{{< /tab >}}
{{< tab "Go" >}}

Install the Go SDK by running the command:

```sh
go get -u github.com/alpacahq/alpaca-trade-api-go/v2/alpaca
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

With the SDK installed and our API keys ready, you can start requesting market
data. Alpaca offers many options for both historical and real-time data, so to
keep this guide succint, these examples are on obtaining historical and real-time
[bar](../../api-references/market-data-api/stock-pricing-data/historical/#bar) data.
Information on what other data is available can be found in the [Market Data API reference](../../api-references/market-data-api).

### Querying for Historical Data

{{< tabs "historical-data" >}}
{{< tab "Python" >}}

To start using the SDK for historical data, import the SDK and
instantiate the crypto historical data client. It's not required for this
client to pass in API keys or a paper URL.

```py
from alpaca.data.historical import CryptoHistoricalDataClient

# No keys required for crypto data
client = CryptoHistoricalDataClient()
```

Next we'll define the parameters for our request. Import the request class
for crypto bars, `CryptoBarsRequest` and TimeFrame class to access time frame units
more easily. This example queries for historical daily bar data of Bitcoin in the
first week of September 2022.

```py
from datetime import datetime

from alpaca.data.requests import CryptoBarsRequest
from alpaca.data.timeframe import TimeFrame

# Creating request object
request_params = CryptoBarsRequest(
                        symbol_or_symbols=["BTC/USD"],
                        timeframe=TimeFrame.Day,
                        start=datetime.strptime("2022-09-01", "%Y-%m-%d"),
                        end=datetime.strptime("2022-09-07", "%Y-%m-%d")
                        )
```

Finally, send the request using the client's built-in method,
`get_crypto_bars`. Additionally, we'll access the `.df` property which returns
a pandas DataFrame of the response.

```py
# Retrieve daily bars for Bitcoin in a DataFrame and printing it
btc_bars = client.get_crypto_bars(request_params)

# Convert to dataframe
btc_bars.df
```

```sh
		open	high	low	close	volume	trade_count	vwap
symbol	timestamp							
BTC/USD	
        2022-09-01 05:00:00+00:00	20049.0	20285.0	19555.0	20160.0	2396.3504	18060.0	19920.278135
        2022-09-02 05:00:00+00:00	20159.0	20438.0	19746.0	19924.0	1688.0641	16730.0	20045.987764
        2022-09-03 05:00:00+00:00	19924.0	19963.0	19661.0	19802.0	624.1013	9853.0	19794.111057
        2022-09-04 05:00:00+00:00	19801.0	20060.0	19599.0	19892.0	1361.6668	8489.0	19885.445568
        2022-09-05 05:00:00+00:00	19892.0	20173.0	19640.0	19762.0	2105.0539	11900.0	19814.853546
        2022-09-06 05:00:00+00:00	19763.0	20025.0	18539.0	18720.0	3291.1657	19591.0	19272.505607
        2022-09-07 05:00:00+00:00	18723.0	19459.0	18678.0	19351.0	2259.2351	16204.0	19123.487500
```

{{< /tab >}}
{{< tab "JavaScript" >}}

To enable access to the tools in the SDK, first load the module that was
installed previously.

```js
const Alpaca = require("@alpacahq/alpaca-trade-api");
```

Next, instantiate the Alpaca class and define the
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

```sh
{
  Symbol: 'BTCUSD',
  Timestamp: '2022-07-07T05:00:00Z',
  Exchange: 'CBSE',
  Open: 20400.28,
  High: 20445.5,
  Low: 20224.8,
  Close: 20404.32,
  Volume: 1029.86433895,
  TradeCount: 43372,
  VWAP: 20350.5220346576
}
{
  Symbol: 'BTCUSD',
  Timestamp: '2022-07-07T05:00:00Z',
  Exchange: 'ERSX',
  Open: 20303.8,
  High: 20439.4,
  Low: 20254.9,
  Close: 20404.3,
  Volume: 2.759,
  TradeCount: 26,
  VWAP: 20292.1438274737
}
{
  Symbol: 'BTCUSD',
  Timestamp: '2022-07-07T05:00:00Z',
  Exchange: 'FTXU',
  Open: 20398,
  High: 20443,
  Low: 20236,
  Close: 20405,
  Volume: 99.3202,
  TradeCount: 512,
  VWAP: 20352.1984752346
}
```

{{< /tab >}}
{{< tab "C#" >}}

Create a new .NET application to work with by running this command:

```sh
dotnet new console -o MyApp -f net6.0
```

Then, navigate to the new directory that you'll be working inside:

```sh
cd MyApp
```

Open the `Program.cs` main file in your editor and set it up as follows:

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

This setup adds the necessary namespaces used to code this example. Next, create
constants for your API authentication information and use them to instantiate
the Alpaca Crypto Data Client. Instantiate the paper client using
the special extension method of the IEnvironment interface,
`GetAlpacaCryptoDataClient`. If you'd like to use the live client, replace
`Paper` with `Live`.

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

With an instance of the client now available, we can access its methods to make
queries. Let's get the historical daily bar data of Bitcoin in the last 24 hours.
This type of request needs 4 parameters: the symbol of the
desired asset, the start of the time interval from which you'd like data from,
the end of the time interval from which you'd like data from, and the timeframe
on which you'd like your data to be aggregated.

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

Use the client's method, `ListHistoricalBarsAsync`, to make the request and
print the result to see Bitcoin's latest bar data.

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

The output shows 3 bars for Bitcoin in the last day. Each of these bars come
from one of Alpaca's crypto exchange partners, ErisX, Coinbase, and FTX.

{{< /tab >}}
{{< tab "Go" >}}

After installing the SDK, import it along with the other libraries necessary
to run this example.

```go
package main

import (
	"fmt"
	"time"

	"github.com/alpacahq/alpaca-trade-api-go/v2/marketdata"
)

func main() {

}
```

Instantiate the Alpaca data client with the method `marketdata.NewClient`,
which takes a client options object (`ClientOpts`) as a parameter.
Pass your API credentials into the client options constructor, and that resulting
object into `marketdata.NewClient`.

```go
// Alternatively, you can set your API key and secret using environment
// variables named APCA_API_KEY_ID and APCA_API_SECRET_KEY respectively
apiKey := "<Your API Key>"
apiSecret := "<Your Secret Key>"

// Instantiating new Alpaca data client
dataClient := marketdata.NewClient(marketdata.ClientOpts{
  ApiKey:     apiKey,
  ApiSecret:  apiSecret,
})
```

Next, define the parameters for the request. This example will query for the
daily bars of Bitcoin in the last 24 hours.

```go
// Request parameters
symbol := "BTCUSD"
timeframe := marketdata.OneDay			    // Daily bars
start := time.Now().Add(-24*time.Hour)	// Exactly one day ago
end := time.Now()	                      // Current time
```

Use the data client's method `GetCryptoBars` to query for crypto bars. This function
takes two parameters: the asset as a `string` and a `GetCryptoBarsParams` object. Pass
the request parameters into the `GetCryptoBarsParams` constructor, and the resulting object
into `GetCryptoBars` to make the request. The result wil be a `[]CryptoBar`, so we'll
print each bar upon a sucessful request.

```go
// Sending GET request for crypto bars
bars, err := dataClient.GetCryptoBars(symbol, marketdata.GetCryptoBarsParams{
  TimeFrame: 	timeframe,
  Start: 	  	start,
  End: 		    end,
}); if err != nil {
  // Print error
  fmt.Printf("Failed to get bars: %v\n", err)
} else {
  // Print each bar with its index
  for idx, bar := range bars {
    fmt.Printf("Bar %v: %+v\n", idx, bar)
  }
}
```

```sh
Bar 0: {Timestamp:2022-07-07 05:00:00 +0000 UTC Exchange:CBSE Open:20400.28 High:20445.5 Low:20224.8 Close:20427.28 Volume:990.65565169 TradeCount:41454 VWAP:20348.0875811236}
Bar 1: {Timestamp:2022-07-07 05:00:00 +0000 UTC Exchange:ERSX Open:20303.8 High:20439.4 Low:20254.9 Close:20431.1 Volume:2.7154 TradeCount:24 VWAP:20290.3038521028}
Bar 2: {Timestamp:2022-07-07 05:00:00 +0000 UTC Exchange:FTXU Open:20398 High:20443 Low:20236 Close:20430 Volume:87.2949 TradeCount:458 VWAP:20342.856462405}
```

{{< /tab >}}
{{< /tabs >}}

### Streaming Real-Time Data

After installing the SDK and securing API keys, you can start streaming
real-time data. Similar to our historical data example, we'll stream
bar data for one cryptocurrency, Bitcoin. To learn more about what data are available for
streaming, visit the docs for [real-time stocks data](../../api-references/market-data-api/stock-pricing-data/realtime)
and [real-time crypto data](../../api-references/market-data-api/crypto-pricing-data/realtime).

{{< tabs "realtime-data" >}}`
{{< tab "Python" >}}

To start streaming real-time data, first import the `CryptoDataStream` class from the SDK.

```py
from alpaca.data.live import CryptoDataStream
```

Now instantiate the streaming class using your API keys.

```py
API_KEY = "<Your API Key>"
SECRET_KEY = "<Your Secret Key>"

# Initiate class
crypto_stream = CryptoDataStream(API_KEY, SECRET_KEY)
```

Next, define a simple callback function that will print the bar upon
receiving it. Then, define the symbol and subscribe to that symbol's
bars. The Stream class includes a method for subscribing to bars,
`subscribe_bars`, that takes a callback function and symbol as
parameters. After calling that method, run the stream and wait for the
callback function to print bars.

```py
async def bar_callback(bar):
    for property_name, value in bar:
        print(f"\"{property_name}\": {value}")

# Subscribing to bar event 
symbol = "BTC/USD"
crypto_stream.subscribe_bars(bar_callback, symbol)

crypto_stream.run()
```

```sh
"symbol": BTC/USD
"timestamp": 2022-09-09 12:33:00+00:00
"open": 21087.0
"high": 21122.0
"low": 21087.0
"close": 21114.0
"volume": 1.5202
"trade_count": 28.0
"vwap": 21104.0542691751
"symbol": BTC/USD
"timestamp": 2022-09-09 12:34:00+00:00
"open": 21115.0
"high": 21115.0
"low": 21095.0
"close": 21107.0
"volume": 1.8952
"trade_count": 23.0
"vwap": 21103.6209898691
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

Now we'll modify [the stock example](https://github.com/alpacahq/alpaca-trade-api-js/blob/master/examples/websocket_example_datav2.js).
To simplify this example, remove all socket methods except
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

Finally, instantiate the `DataStream` class we've created and wait for the
bars to be printed.

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
```

{{< /tab >}}
{{< tab "C#" >}}

Create a new .NET application to work with by running this command:

```sh
dotnet new console -o MyApp -f net6.0
```

Then, navigate to the new directory that you'll be working inside:

```sh
cd MyApp
```

Open the `Program.cs` main file in your editor and set it up as follows:

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

This setup adds the namespaces used to code this example. Next, create
constants for your API authentication information and use them to instantiate
the Alpaca Crypto Streaming Client. Instantiate the paper client using
the special extension method of the IEnvironment interface,
`GetAlpacaCryptoStreamingClient`. If you'd like to use the live client, replace
`Paper` with `Live`. After instantiation, connect and authenticate
your streaming client via its method, `ConnectAndAuthenticateAsync`.

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

After establishing a connection, your client is ready to subscribe to events. Let's
subscribe to Bitcoin's daily bars and print them as they come in. To subscribe
to an event, you'll need to create an `IAlpacaDataSubscription` object configured
to your use case.
Creating minute-bar subscriptions can be done with the method `GetMinuteBarSubscription`.
It requires the asset's symbol as a parameter and the returned object will be used
to subscribe to the asset's minute bars.
You can define what to do upon receiving the subscription using one of its
properties, `Received`.

Putting these ideas together, define the symbol you'd like to subscribe to,
create a subscription for its minute bars, and write the callback functionality.

```cs
public static async Task Main()
{
    var client = Environments.Paper.GetAlpacaCryptoStreamingClient(new SecretKey(API_KEY, API_SECRET));

    await client.ConnectAndAuthenticateAsync();

    String symbol = "BTCUSD";

    var barSubscription = client.GetMinuteBarSubscription(symbol);
    barSubscription.Received += (bar) =>
    {
        Console.WriteLine(bar);
    };
}
```

Finally, subscribe to Bitcoin's minute bars by passing your subscription object
into the streaming client's subscription method, `SubscribeAsync`. This example
will run indefinitely, printing bars as they're received.

```cs
public static async Task Main()
{
    var client = Environments.Paper.GetAlpacaCryptoStreamingClient(new SecretKey(API_KEY, API_SECRET));

    await client.ConnectAndAuthenticateAsync();

    String symbol = "BTCUSD";

    var barSubscription = client.GetMinuteBarSubscription(symbol);
    barSubscription.Received += (bar) =>
    {
        Console.WriteLine(bar);
    };

    await client.SubscribeAsync(barSubscription);
    while(true);
}
```

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

{{< /tab >}}
{{< tab "Go" >}}

To start streaming real-time data, we'll first import the SDK and the necessary
libraries for this example.

```go
package main

import (
	"context"
	"fmt"
	"log"

	"github.com/alpacahq/alpaca-trade-api-go/v2/marketdata/stream"
)

func main() {

}
```

Instantiate the Alpaca crypto streaming client with the method `stream.NewCryptoClient`,
which takes `...CryptoOption` as a parameter. The only option we'll configure is our
API credentials. This option's constructor is `stream.WithCredentials`. Pass your
credentials into this constructor, and its return value into `stream.NewCryptoClient`.

We'll also use `WithCancel` to allow for safe cancellation of our WebSocket connection.

```go
// Necessary for safe cancellation
ctx, cancel := context.WithCancel(context.Background())
defer cancel()

// Alternatively, you can set your API key and secret using environment
// variables named APCA_API_KEY_ID and APCA_API_SECRET_KEY respectively
apiKey := "<Your API Key>"
apiSecret := "<Your Secret Key>"

// Instantiating a new Alpaca crypto data streaming client
streamClient := stream.NewCryptoClient(stream.WithCredentials(apiKey, apiSecret))
```

With our streaming client instantiated, let's connect it to Alpaca. Do this with
the client's method, `Connect`.

```go
// Establishing WebSocket connection
if err := streamClient.Connect(ctx); err != nil {
  log.Fatalf("Failed to connect to the marketdata stream: %v\n", err)
}
```

After connecting, we can subscribe to events. This example will subscribe to Bitcoin's
1-minute bars and print them as they come in.

First let's define the callback function to be executed upon receiving the event.

```go
// Callback function to print streamed bars
func onBar(bar stream.CryptoBar) {
	fmt.Printf("Bar received: %+v\n", bar)
}
```

To subscribe to bars, use the client's method, `SubscribeToBars`. This function takes
two parameters: the callback function and the asset's symbol to subscribe to.
This example will run indefinitely, printing bars as they're received.

```go
symbol := "BTCUSD"

// Subscribing to our symbol's bars with a callback function
if err := streamClient.SubscribeToBars(onBar, symbol); err != nil {
  log.Fatalf("Failed to subscribe to the bars stream: %v\n", err)
}

// Loop indefinitely
for (true) {
}
```

```sh
Bar received: {Symbol:BTCUSD Exchange:CBSE Open:20429.36 High:20437.28 Low:20423.62 Close:20436.74 Volume:3.20785062 Timestamp:2022-07-07 02:13:00 -0600 MDT TradeCount:192 VWAP:20432.6125707711}
```

{{< /tab >}}
{{< /tabs >}}
