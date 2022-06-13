# Getting Started

This is a quick guide on how to start consuming market data using Alpaca's
market data APIs. Starting from beginning to end, we outline how to install our
software development kit (SDK), create a free alpaca account, locate your API keys,
and how to request both historical and real-time data.

## Installing Alpaca's Client SDK

In this guide, we'll be making use of the SDKs
provided by Alpaca. Alpaca maintains SDKs in four languages: [Python](https://github.com/alpacahq/alpaca-trade-api-python), [JavaScript](https://github.com/alpacahq/alpaca-trade-api-js),
[C#](https://github.com/alpacahq/alpaca-trade-api-csharp), and [Go](https://github.com/alpacahq/alpaca-trade-api-go). Follow the steps in the installation guide below to install the SDK of your choice before proceeding to the next section.

{{< tabs "installation-guide" >}}
{{< tab "Python" >}}

Alpaca supports Python >= 3.7. If you want to work with Python 3.6, please note that these package dropped support for Python <3.7 for the following versions:

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

Navigate inside of your project and run

```sh
dotnet add package Alpaca.Markets
```

{{< /tab >}}
{{< tab "Go" >}}

Installation using go get:

```sh
go get -u github.com/alpacahq/alpaca-trade-api-go/v2/alpaca
```

{{< /tab >}}
{{< /tabs >}}

## Creating an Alpaca Account and Finding Your API Keys

To request data from Alpaca, you'll need to include your API keys in your
requests. This section outlines how one can create an account and generate
the keys necessary to start querying for market data.

1. Navigate to [Alpaca's Website](https://alpaca.markets)
2. Sign up for a free account using the sign up button

   insert image here
   ![Alpaca homepage](../../static/alpaca_homepage.png)

3. After confirming your account and logging in, navigate to your paper
   trading dashboard

   insert image here
   ![Paper trading link](../../static/paper_dashboard_link.png)

4. On the dashboard, click the button to view your API keys

   insert image here
   ![view keys](../../static/paper_dashboard_link.png)

5. After expanding your API keys section, generate new keys

   insert image here
   ![generate keys](../../static/paper_dashboard_link.png)

6. After your keys have been generated, securely save them for future use

   insert image here
   ![copy keys](../../static/paper_dashboard_link.png)

## How to Request Market Data Through the SDK

With the SDK installed and our API keys ready, we can start requesting market
data. Alpaca offers many options for both historical and real-time data, so to
keep this guide succint, we'll go through how to obtain historical and real-time
[bar](content/api-references/market-data-api/stock-pricing-data/historical.md) data.
(FIX THE BAR LINK LATER)

### Querying for Historical Data

{{< tabs "historical-data" >}}
{{< tab "Python" >}}

To start using the SDK in Python, let's import it and instantiate the REST
client. We'll instantiate the client using our API keys and Alpaca's paper
trading endpoint.

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
`get_crypto_bars`. Additionally, we'll access a `.df` property which returns
a pandas DataFrame of bars response. Then using the DataFrame we can print the
first 5 rows of Bitcoins bar data.

```py
# Retrieve daily bars for Bitcoin in a dataframe and printing the first 5 rows
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

It's important to note that when querying for stocks you'll need to use a
different method, `get_bars`.

{{< /tab >}}
{{< tab "JavaScript" >}}

js stuff

{{< /tab >}}
{{< tab "C#" >}}

c# stuff
{{< /tab >}}
{{< tab "Go" >}}
go stuff

{{< /tab >}}
{{< /tabs >}}

### Streaming Real-Time Data

asdfasdf

{{< tabs "realtime-data" >}}
{{< tab "Python" >}}

python stuff

{{< /tab >}}
{{< tab "JavaScript" >}}

js stuff

{{< /tab >}}
{{< tab "C#" >}}

c# stuff
{{< /tab >}}
{{< tab "Go" >}}
go stuff

{{< /tab >}}
{{< /tabs >}}

## Link to further docs?

should I include links to place someone would want to go from here?
