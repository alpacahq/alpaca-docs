---
title: Getting Started
weight: 40
aliases:
  - /getting-started.md
---

# Getting Started

This is a quick guide on how to start consuming market data via
APIs. Starting from beginning to end, this section outlines how to install
Alpaca's software development kit (SDK), create a free alpaca account, locate
your API keys, and how to request both historical and real-time data.

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

Also note that we do not limit the version of the websockets library, but we
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

## How to Place Orders Through the SDK

In this section, we'll run through an example of placing a market buy for 0.1 units of Bitcoin and then a market sell order for that purchased Bitcoin, closing our
position. To see more involved examples of placing orders, visit
[Order Type ABCs with Alpaca Trade API](https://colab.research.google.com/drive/1ofIXDspe4LNXH7CXfArxOZuIOoAg1Uak?usp=sharing).

{{< tabs "historical-data" >}}
{{< tab "Python" >}}

### Placing a Buy Order

The first step in using the SDK is to import it and instantiate it. In addition
to the API keys obtained from the previous section, we'll pass in `BASE_URL` to enable paper trading.

```py
# Importing the api and instantiating the rest client according to our keys
import alpaca_trade_api as api

API_KEY = "<Your API Key>"
API_SECRET = "<Your Secret Key>"
BASE_URL = "https://paper-api.alpaca.markets"

alpaca = api.REST(API_KEY, API_SECRET, BASE_URL)
```

The SDK is now ready to go. Before placing the buy order for Bitcoin, you
should define the parameters for the order. For a market buy order, the only
variables necessary to set are `symbol` and `qty`.

```py
# Setting parameters for our buy order
symbol = "BTCUSD"
qty = 0.1
```

After this, use the REST client's method, `submit_order`, to submit your order. Pass in
the variables from the previous step and run your code to submit the order.

```py
# Submitting a market buy order by quantity of units to buy
alpaca.submit_order(symbol, qty=qty)
```

The order has now been submitted and you will see your trading dashboard update
accordingly. This
function call returns an `Order` object that shows all the details of your order.
The parameters available for `submit_order` and the properties of its `Order` response
can be found in the [Trading API docs](../../api-references/trading-api/orders).

### Placing a Sell Order

Placing a sell order is similar to submitting a buy order. Since our REST
object is still instantiated from earlier, we'll start off by defining the
parameters of our order. This will be the same as in the buy order, except
now we'll define a variable, `side`, denoting that this is a sell-side order.

```py
# Setting parameters for our sell order
symbol = "BTCUSD"
qty = 0.1
side = "sell"
```

Now that we have the order's parameters defined, we can submit it with
`submit_order`. Pass your parameters into the function and run your code to
submit your order.

```py
# Submitting a market sell order by quantity of units to sell
alpaca.submit_order(symbol, qty=qty, side=side)
```

{{< /tab >}}
{{< tab "JavaScript" >}}

### Placing a Buy Order

send a buy order here

### Placing a Sell Order

sell

{{< /tab >}}
{{< /tabs >}}
