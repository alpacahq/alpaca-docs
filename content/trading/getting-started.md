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
position. To see more involved examples of placing orders, visit [Understand
Orders](../../trading/orders) or
[Order Type ABCs with Alpaca Trade API](https://colab.research.google.com/drive/1ofIXDspe4LNXH7CXfArxOZuIOoAg1Uak?usp=sharing).

{{< tabs "historical-data" >}}
{{< tab "Python" >}}

### Setup and Getting Account Information

The first step in using the SDK is to import it and instantiate it. In addition
to the API keys obtained from the previous section, we'll pass in `BASE_URL` to enable paper trading.

```py
# Importing the API and instantiating the REST client according to our keys
import alpaca_trade_api as api

API_KEY = "<Your API Key>"
API_SECRET = "<Your Secret Key>"
BASE_URL = "https://paper-api.alpaca.markets"

alpaca = api.REST(API_KEY, API_SECRET, BASE_URL)
```

The SDK is now ready to go. To start off, before placing our orders let's
make sure that we have sufficient buying power. Buying power can be found
inside one's account information. Use the `get_account` method on the REST
client and print the result to show your account information.

```py
# Getting account information and printing it
account = alpaca.get_account()
print(account)
```

```sh
Account({
    'account_blocked': False,
    'account_number': 'PA3717PJAYWN',
    'accrued_fees': '0',
    'buying_power': '1645434.1767681126',
    'cash': '742009.3924890563',
    'created_at': '2022-04-19T17:46:03.68585Z',
    'crypto_status': 'ACTIVE',
    'currency': 'USD',
    'daytrade_count': 1,
    'daytrading_buying_power': '0',
    'equity': '903424.7842790563',
    'id': 'ee302827-4ced-4321-b5fb-71080392d828',
    'initial_margin': '80707.695895',
    'last_equity': '916328.80490268234',
    'last_maintenance_margin': '3317.19',
    'long_market_value': '161415.39179',
    'maintenance_margin': '161415.39179',
    'multiplier': '2',
    'non_marginable_buying_power': '742009.39',
    'pattern_day_trader': False,
    'pending_transfer_in': '0',
    'portfolio_value': '903424.7842790563',
    'regt_buying_power': '1645434.1767681126',
    'short_market_value': '0',
    'shorting_enabled': True,
    'sma': '818449.81',
    'status': 'ACTIVE',
    'trade_suspended_by_user': False,
    'trading_blocked': False,
    'transfers_blocked': False
})
```

The [Trading Account docs](../../api-references/trading-api/account) outline the property descriptions of the `Account` object.
Now that we're certain our buying power is sufficient to place trades, let's
send a market buy order.

### Placing a Buy Order

Before placing an order, you should define the parameters for it. For a market
buy order, the only variables necessary to set are `symbol` and `qty`.

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

The order has now been submitted and your trading dashboard will update
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
submit your order. This time we'll save the return value of `submit_order` and
print out the resulting `Order` object.

```py
# Submitting a market sell order by quantity of units to sell
sell_order = alpaca.submit_order(symbol, qty=qty, side=side)
print(sell_order)
```

```sh
Order({
    'asset_class': 'crypto',
    'asset_id': '64bbff51-59d6-4b3c-9351-13ad85e3c752',
    'canceled_at': None,
    'client_order_id': 'b17a7226-6f40-4dfe-8ebe-a2095a1cbc4d',
    'commission': '6.0315',
    'created_at': '2022-06-22T20:01:29.083647486Z',
    'expired_at': None,
    'extended_hours': False,
    'failed_at': None,
    'filled_at': None,
    'filled_avg_price': None,
    'filled_qty': '0',
    'hwm': None,
    'id': 'eccb675d-52b6-422d-bccb-b193d1d8ca77',
    'legs': None,
    'limit_price': None,
    'notional': None,
    'order_class': '',
    'order_type': 'market',
    'qty': '0.1',
    'replaced_at': None,
    'replaced_by': None,
    'replaces': None,
    'side': 'sell',
    'source': None,
    'status': 'pending_new',
    'stop_price': None,
    'submitted_at': '2022-06-22T20:01:29.081972126Z',
    'subtag': None,
    'symbol': 'BTCUSD',
    'time_in_force': 'day',
    'trail_percent': None,
    'trail_price': None,
    'type': 'market',
    'updated_at': '2022-06-22T20:01:29.083717496Z'
})
```

To understand the properties of this `Order` object better, visit the [Trading API docs](../../api-references/trading-api/orders/#order-entity)
to read the property descriptions.

You're now equipped with the basics of placing trades with Alpaca's SDK. Good
luck coding and have fun with your new capabilities!

{{< /tab >}}
{{< tab "JavaScript" >}}

### Setup and Getting Account Information

Now that the SDK is installed and you have your API keys, import the Alpaca
module.

```js
// Import the Alpaca module
const Alpaca = require("@alpacahq/alpaca-trade-api");
```

Instantiate the API with an object containing your account's API
credentials. This guide submits orders through paper trading instead of live
trading, so in our object we'll set `paper` to `true`.

```js
// Instantiate the API with configuration options
const options = {
  keyId: "<Your API Key>",
  secretKey: "<Your Secret Key>",
  paper: true,
};
const alpaca = new Alpaca(options);
```

Now that an instance of the API is available, we can start using the methods
that are implemented inside the SDK. Firstly, check the details of your
account to ensure that you have the buying power to send orders. The
`getAccount` method returns a promise of an object containing important account
related info. Therefore, let's call this method and print the result to find
the buying power of our account.

```js
// Get account information and print it
alpaca.getAccount().then((account) => {
  console.log("Current Account:", account);
});
```

```sh
Current Account: {
  id: 'ee302827-4ced-4321-b5fb-71080392d828',
  account_number: 'PA3717PJAYWN',
  status: 'ACTIVE',
  crypto_status: 'ACTIVE',
  currency: 'USD',
  buying_power: '1727736.5973198506',
  regt_buying_power: '1727736.5973198506',
  daytrading_buying_power: '0',
  non_marginable_buying_power: '810684.72',
  cash: '810684.724',
  accrued_fees: '0',
  pending_transfer_in: '0',
  portfolio_value: '917051.8733198506',
  pattern_day_trader: false,
  trading_blocked: false,
  transfers_blocked: false,
  account_blocked: false,
  created_at: '2022-04-19T17:46:03.68585Z',
  trade_suspended_by_user: false,
  multiplier: '2',
  shorting_enabled: true,
  equity: '917051.8733198506',
  last_equity: '916328.80490268234',
  long_market_value: '106367.1493198506',
  short_market_value: '0',
  initial_margin: '53183.5746599253',
  maintenance_margin: '98556.65836595518',
  last_maintenance_margin: '3317.19',
  sma: '818449.81',
  daytrade_count: 1
}
```

The [Trading Account docs](../../api-references/trading-api/account) outline the property descriptions of the `Account` object.
Now that we're certain our buying power is sufficient to place trades, let's
send a market buy order.

### Placing a Buy Order

In the JavaScript SDK, orders can be sent with the `createOrder` method. The
exact parameters allowed in this function are outlined [on GitHub](https://github.com/alpacahq/alpaca-trade-api-js#orders-api).
This function returns a promise of an order object, `Promise<Order>`.

For our order, we'll need to set `symbol`, `qty`, `side`, `type`, and `time_in_force`.
Respectively, these variables determine what asset we order, how many units to exchange,
whether the order is buy-side or sell-side, the type of order, and how long our order
should be active for. Create an object with these parameters and call
`createOrder` with this object to send your first order!

```js
// Defining our order parameters and sending the order
const buyParams = {
  symbol: "BTCUSD",
  qty: 0.1,
  side: "buy",
  type: "market",
  time_in_force: "day",
};

alpaca.createOrder(buyParams);
```

### Placing a Sell Order

Sending a market sell order is very similar to a market buy order. The same
function and parameters are used, but we need to change the `side` parameter
to `sell`. This ensures that your order will be a sell-side order.

Create an object exactly the same as before but changing `side` as discussed.
Then, to place your market sell order, call the `createOrder` method with this
newly created object. After the order is sent, let's print the resulting `Promise<Order>`.

```js
// Defining our order parameters and sending the order
const sellParams = {
  symbol: "BTCUSD",
  qty: 0.1,
  side: "sell",
  type: "market",
  time_in_force: "day",
};
alpaca.createOrder(sellParams).then((order) => {
  console.log("Order details: ", order);
});
```

```sh
Order details:  {
  id: 'c58bcf8e-6341-4964-95ab-2491d1929588',
  client_order_id: 'db1963e6-bfe2-4cb9-9498-238ffcc89754',
  created_at: '2022-06-22T15:46:19.550401393Z',
  updated_at: '2022-06-22T15:46:19.550452723Z',
  submitted_at: '2022-06-22T15:46:19.548721863Z',
  filled_at: null,
  expired_at: null,
  canceled_at: null,
  failed_at: null,
  replaced_at: null,
  replaced_by: null,
  replaces: null,
  asset_id: '64bbff51-59d6-4b3c-9351-13ad85e3c752',
  symbol: 'BTCUSD',
  asset_class: 'crypto',
  notional: null,
  qty: '0.1',
  filled_qty: '0',
  filled_avg_price: null,
  order_class: '',
  order_type: 'market',
  type: 'market',
  side: 'sell',
  time_in_force: 'day',
  limit_price: null,
  stop_price: null,
  status: 'pending_new',
  extended_hours: false,
  legs: null,
  trail_percent: null,
  trail_price: null,
  hwm: null,
  commission: '6.063',
  subtag: null,
  source: null
}
```

To understand the properties of this `Order` object better, visit the [Trading API docs](../../api-references/trading-api/orders/#order-entity)
to read the property descriptions.

You're now equipped with the basics of placing trades with Alpaca's SDK. Good
luck coding and have fun with your new capabilities!

{{< /tab >}}
{{< /tabs >}}
