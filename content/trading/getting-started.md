---
title: Getting Started
weight: 2
aliases:
  - /getting-started.md
---

# Getting Started

This is a quick guide on how to start submitting orders via
APIs. Starting from beginning to end, this section outlines how to install
Alpaca's software development kit (SDK), create a free alpaca account, locate
your API keys, and how to submit orders applicable for both stocks and crypto.

## Installing Alpaca's Client SDK

In this guide, we'll be making use of the SDKs
provided by Alpaca. Alpaca maintains SDKs in four languages: [Python](https://github.com/alpacahq/alpaca-trade-api-python),
[JavaScript](https://github.com/alpacahq/alpaca-trade-api-js),
[C#](https://github.com/alpacahq/alpaca-trade-api-csharp),
and [Go](https://github.com/alpacahq/alpaca-trade-api-go).
Follow the steps in the installation guide below to install the SDK of your
choice before proceeding to the next section.

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
the keys necessary to submit orders.

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

In this section, we'll run through an example of placing a market buy for Bitcoin
and view our open positions through the SDK. To see more involved examples of placing orders, visit [Understand Orders](../../trading/orders) or
[Order Type ABCs with Alpaca Trade API](https://colab.research.google.com/drive/1ofIXDspe4LNXH7CXfArxOZuIOoAg1Uak?usp=sharing).

{{< tabs "historical-data" >}}
{{< tab "Python" >}}

### Setup and Getting Account Information

The first step in using the SDK is to import it and instantiate it. In addition
to the API keys obtained from the previous section, we'll pass in `BASE_URL` to
enable paper trading.

```py
# Importing the API and instantiating the REST client according to our keys
import alpaca_trade_api as api

API_KEY = "<Your API Key>"
API_SECRET = "<Your Secret Key>"
BASE_URL = "https://paper-api.alpaca.markets"

alpaca = api.REST(API_KEY, API_SECRET, BASE_URL)
```

The SDK is now ready to go. To start off, let's
make sure that we have sufficient buying power to place orders. Buying power can be found
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

The [Trading Account docs](../../api-references/trading-api/account) outline the
property descriptions of the `Account` entity.
Now that we're certain our buying power is sufficient to place trades, let's
send a market buy order.

### Placing a Buy Order

Before placing an order, you should define the parameters for it. For a market
buy order, the only variables necessary to set are `symbol` and `qty`.

```py
# Setting parameters for the buy order
symbol = "BTC/USD"
qty = 1
```

Use the REST client's method, `submit_order`, to submit your order.
This function call returns an `Order` object that shows all the details of your order.
Pass the variables from the previous step into `submit_order` and run your code to
submit the order. Print the returning `Order` object to see the details of the order.

```py
# Submitting a market buy order by quantity of units to buy
order = alpaca.submit_order(symbol, qty=qty)
print(order)
```

```sh
Order({
    'asset_class': 'crypto',
    'asset_id': '64bbff51-59d6-4b3c-9351-13ad85e3c752',
    'canceled_at': None,
    'client_order_id': '4bb3ad77-6f62-4cfb-9cac-001f1458e39c',
    'commission': '60.264',
    'created_at': '2022-06-29T19:20:20.809126584Z',
    'expired_at': None,
    'extended_hours': False,
    'failed_at': None,
    'filled_at': None,
    'filled_avg_price': None,
    'filled_qty': '0',
    'hwm': None,
    'id': 'c1ec6bc9-a346-4c29-9e7e-054a86c1b9f9',
    'legs': None,
    'limit_price': None,
    'notional': None,
    'order_class': '',
    'order_type': 'market',
    'qty': '1',
    'replaced_at': None,
    'replaced_by': None,
    'replaces': None,
    'side': 'buy',
    'source': None,
    'status': 'pending_new',
    'stop_price': None,
    'submitted_at': '2022-06-29T19:20:20.808309584Z',
    'subtag': None,
    'symbol': 'BTC/USD',
    'time_in_force': 'day',
    'trail_percent': None,
    'trail_price': None,
    'type': 'market',
    'updated_at': '2022-06-29T19:20:20.809254364Z'
})
```

The order has now been submitted and your trading dashboard will update
accordingly. The parameters available for `submit_order` and the properties of
its `Order` response can be found in the [Trading API docs](../../api-references/trading-api/orders).

### Viewing open positions

Viewing one's open positions is key in understanding your current holdings.
This can be done through the SDK very quickly. The client implements
a method, `list_positions` that returns a `List[Position]`.

To view your open positions, call `list_positions` and print each element
in the resulting list.

```py
# Get all open positions and print each of them
positions = alpaca.list_positions()
for position in positions:
    print(position)
```

```sh
Position({
    'asset_class': 'crypto',
    'asset_id': '64bbff51-59d6-4b3c-9351-13ad85e3c752',
    'asset_marginable': False,
    'avg_entry_price': '20088',
    'change_today': '-0.0120470079166052',
    'cost_basis': '20088',
    'current_price': '20092',
    'exchange': 'FTXU',
    'lastday_price': '20337',
    'market_value': '20092',
    'qty': '1',
    'qty_available': '1',
    'side': 'long',
    'symbol': 'BTC/USD',
    'unrealized_intraday_pl': '4',
    'unrealized_intraday_plpc': '0.0001991238550378',
    'unrealized_pl': '4',
    'unrealized_plpc': '0.0001991238550378'
})
```

The output shows that we have a long position for 1 unit of Bitcoin. Visit
the [Positions docs](../../api-references/trading-api/positions/#position-entity)
to view the property descriptions of a `Position` entity.

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
that are implemented in the SDK. Firstly, check the details of your
account to ensure that you have the buying power to send orders. The
`getAccount` method returns a promise (Promise\<Account\>) containing your account's
information. Call this method and print the result to find
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

The [Trading Account docs](../../api-references/trading-api/account) outline the
property descriptions of the `Account` object. Now that we're certain our buying
power is sufficient to place trades, let's send a market buy order.

### Placing a Buy Order

In the JavaScript SDK, orders can be sent with the `createOrder` method. The
exact parameters allowed in this function are outlined [on GitHub](https://github.com/alpacahq/alpaca-trade-api-js#orders-api).
This function returns a promise of an order object, `Promise<Order>`.

For our order, we'll need to set `symbol`, `qty`, `side`, `type`, and `time_in_force`.
Respectively, these variables determine what asset we order, how many units to exchange,
whether the order is buy-side or sell-side, the type of order, and how long our order
should be active for. Create an object with these parameters and call
`createOrder` with this object to send your first order! In addition to sending
the order, we'll print the resulting order object associated with it.

```js
// Defining our order parameters and sending the order
const buyParams = {
  symbol: "BTC/USD",
  qty: 1,
  side: "buy",
  type: "market",
  time_in_force: "day",
};

alpaca.createOrder(buyParams).then((order) => {
  console.log("Order details: ", order);
});
```

```sh
Order details:  {
  id: '8c3e8644-2b3b-41cb-a473-3c338328a14b',
  client_order_id: '78d6e6ad-0688-43c0-8985-e0f0c8abdffc',
  created_at: '2022-06-29T19:10:04.542145557Z',
  updated_at: '2022-06-29T19:10:04.542252617Z',
  submitted_at: '2022-06-29T19:10:04.540006118Z',
  filled_at: null,
  expired_at: null,
  canceled_at: null,
  failed_at: null,
  replaced_at: null,
  replaced_by: null,
  replaces: null,
  asset_id: '64bbff51-59d6-4b3c-9351-13ad85e3c752',
  symbol: 'BTC/USD',
  asset_class: 'crypto',
  notional: null,
  qty: '1',
  filled_qty: '0',
  filled_avg_price: null,
  order_class: '',
  order_type: 'market',
  type: 'market',
  side: 'buy',
  time_in_force: 'day',
  limit_price: null,
  stop_price: null,
  status: 'pending_new',
  extended_hours: false,
  legs: null,
  trail_percent: null,
  trail_price: null,
  hwm: null,
  commission: '60.183',
  subtag: null,
  source: null
}
```

The order has now been submitted and your trading dashboard will have updated accordingly.
To understand the properties of this `Order` object better, visit the [Trading API docs](../../api-references/trading-api/orders/#order-entity)
to read the property descriptions.

### Viewing open positions

Viewing one's open positions is key in understanding your current holdings.
This can be done through the SDK very quickly. The client implements
a method, `getPositions` that returns a `Promise<Position[]>`.

To view your open positions, call `getPositions` and print each element
in the resulting promise.

```js
// Request all open positions and print each of them
alpaca.getPositions().then((positions) => {
  positions.forEach((position) => console.log(position));
});
```

```sh
{
  asset_id: '64bbff51-59d6-4b3c-9351-13ad85e3c752',
  symbol: 'BTC/USD',
  exchange: 'FTXU',
  asset_class: 'crypto',
  asset_marginable: false,
  qty: '1',
  avg_entry_price: '20061',
  side: 'long',
  market_value: '20087',
  cost_basis: '20061',
  unrealized_pl: '26',
  unrealized_plpc: '0.0012960470564777',
  unrealized_intraday_pl: '26',
  unrealized_intraday_plpc: '0.0012960470564777',
  current_price: '20087',
  lastday_price: '20337',
  change_today: '-0.0122928652210257',
  qty_available: '1'
}
```

The output shows that we have a long position for 1 unit of Bitcoin. Visit
the [Positions docs](../../api-references/trading-api/positions/#position-entity)
to view the descriptions of a `Position` entity.

You're now equipped with the basics of placing trades with Alpaca's SDK. Good
luck coding and have fun with your new capabilities!

{{< /tab >}}
{{< tab "C#" >}}

### Setup and Getting Account Information

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
the Alpaca Trading Client. Instantiate the paper client using
the special extension method of the IEnvironment interface,
`GetAlpacaTradingClient`. If you'd like to use the live client, replace
`Paper` with `Live`.

```cs
internal sealed class ExampleProgram
{
    private const String KEY_ID = "<Your API Key>";

    private const String SECRET_KEY = "<Your Secret Key>";

    public static async Task Main()
    {
        var client = Environments.Paper
            .GetAlpacaTradingClient(new SecretKey(KEY_ID, SECRET_KEY));
    }
}
```

With an instance of the client ready to send orders, let's first make sure that
our account has sufficient buying power to place our orders. Buying power can be
found inside one's account information. Use the method `GetAccountAsync` that is
implemented by the client to return this information and print it.

```cs
public static async Task Main()
{
    var client = Environments.Paper
        .GetAlpacaTradingClient(new SecretKey(KEY_ID, SECRET_KEY));

    var account = await client.GetAccountAsync();
    Console.WriteLine(account.ToString());
}
```

```sh
{
   "id":"ee302827-4ced-4321-b5fb-71080392d828",
   "account_number":"PA3717PJAYWN",
   "status":"ACTIVE",
   "currency":"USD",
   "cash":662724.752,
   "pattern_day_trader":false,
   "trading_blocked":false,
   "transfers_blocked":false,
   "account_blocked":false,
   "trade_suspended_by_user":false,
   "shorting_enabled":true,
   "multiplier":2,
   "buying_power":1586187.102115,
   "daytrading_buying_power":0.0,
   "regt_buying_power":1586187.102115,
   "long_market_value":260737.598115,
   "short_market_value":0.0,
   "equity":923462.350115,
   "last_equity":928918.75442,
   "initial_margin":130368.7990575,
   "maintenance_margin":260737.598115,
   "last_maintenance_margin":0.0,
   "daytrade_count":1,
   "sma":747651.12,
   "created_at":"2022-04-19T17:46:03.6858500Z"
}
```

The [Trading Account docs](../../api-references/trading-api/account) outline the
property descriptions of the above `Account` object. Now that we're certain our
buying power is sufficient to place trades, let's send a market buy order.

### Placing a Buy Order

Before placing your order, it's good practice to define the paramters for it.
For a market buy order, the necessary parameters to set are the ticker's symbol
and the number of units you'd like to buy.

```cs
public static async Task Main()
{
    var client = Environments.Paper
        .GetAlpacaTradingClient(new SecretKey(KEY_ID, SECRET_KEY));

    var account = await client.GetAccountAsync();
    Console.WriteLine(account.ToString());

    // Set order parameters
    String symbol = "BTC/USD";
    Int64 quantity = 1;
}
```

Finally, we can send the order using the method `PostOrderAsync`. In order to
post orders using this method, we must create a `NewOrderRequest` with our order's
parameters and pass that object into `PostOrderAsync`. Market buy order requests can be
created with the `OrderSide.Buy.Market` function, and market sell order requests can be
created with `OrderSide.Sell.Market`.

Create an order request, pass it into `PostOrderAsync`, and store the result. This
variable will contain an `Order` object. Print the order and run your code to submit
the order.

```cs
public static async Task Main()
{
    var client = Environments.Paper
        .GetAlpacaTradingClient(new SecretKey(KEY_ID, SECRET_KEY));

    var account = await client.GetAccountAsync();
    Console.WriteLine(account.ToString());

    // Set order parameters
    String symbol = "BTC/USD";
    Int64 quantity = 1;

    // Placing buy order
    var buyOrder = await client.PostOrderAsync(OrderSide.Buy.Market(symbol, quantity));
    Console.WriteLine(buyOrder);
}
```

```sh
{
   "id":"55ad4add-b4b5-4fd8-821f-8495f0ba3ef0",
   "client_order_id":"ea42b23a-24b0-48d6-980d-57c55634e20b",
   "created_at":"2022-06-29T17:20:02.1396817Z",
   "updated_at":"2022-06-29T17:20:02.1397192Z",
   "submitted_at":"2022-06-29T17:20:02.1383039Z",
   "filled_at":null,
   "expired_at ":null,
   "canceled_at":null,
   "failed_at":null,
   "replaced_at":null,
   "asset_id":"64bbff51-59d6-4b3c-9351-13ad85e3c752",
   "symbol":"BTC/USD",
   "asset_class":"crypto",
   "notional":null,
   "qty":1.0,
   "filled_qty":0.0,
   "type":"market",
   "order_class":"simple",
   "side":"buy",
   "time_in_force":"day",
   "limit_price":null,
   "stop_price":null,
   "trail_price":null,
   "trail_percent":null,
   "hwm":null,
   "filled_avg_price":null,
   "status":"pending_new",
   "replaced_by":null,
   "replaces":null,
   "legs":null
}
```

The order has now been submitted and your trading dashboard will have updated accordingly.
To understand the properties of this `Order` object better, visit the [Trading API docs](../../api-references/trading-api/orders/#order-entity)
to read the property descriptions.

### Viewing open positions

Viewing one's open positions is key in understanding your current holdings.
This can be done through the SDK very quickly. The trading client implements
a method, `ListPositionsAsync` that returns a list of `Position` objects.

To view your open positions, call `ListPositionsAsync` and print each element
in the resulting list.

```cs
public static async Task Main()
{
    var client = Environments.Paper
        .GetAlpacaTradingClient(new SecretKey(KEY_ID, SECRET_KEY));

    // Get account information and print
    var account = await client.GetAccountAsync();
    Console.WriteLine(account.ToString());

    // Set order parameters
    String symbol = "BTC/USD";
    Int64 quantity = 1;

    // Placing buy order
    var buyOrder = await client.PostOrderAsync(OrderSide.Buy.Market(symbol, quantity));
    Console.WriteLine(buyOrder);

    // Get open positions and print each one
    var positions = await client.ListPositionsAsync();
    foreach(var position in positions)
    {
        Console.WriteLine(position);
    }
}
```

```sh
{
   "asset_id":"64bbff51-59d6-4b3c-9351-13ad85e3c752",
   "symbol":"BTC/USD",
   "exchange":"UNKNOWN",
   "asset_class":"crypto",
   "avg_entry_price":20078.0,
   "qty":1.0,
   "side":"long",
   "market_value":20077.0,
   "cost_basis":20078.0,
   "unrealized_pl":-1.0,
   "unrealized_plpc":-0.0000498057575456,
   "unrealized_intraday_pl":-1.0,
   "unrealized_intraday_plpc":-0.0000498057575456,
   "current_price":20077.0,
   "lastday_price":20337.0,
   "change_today":-0.0127845798298667
}
```

The output shows that we have a long position for 1 unit of Bitcoin. Visit
the [Positions docs](../../api-references/trading-api/positions/#position-entity)
to view the descriptions of a `Position` entity.

You're now equipped with the basics of placing trades with Alpaca's SDK. Good
luck coding and have fun with your new capabilities!

{{< /tab >}}
{{< tab "Go" >}}

### Setup and Getting Account Information

After installing the SDK, import it along with libraries for printing and
data types.

```go
package main

import (
	"fmt" // Used for Printf

	"github.com/alpacahq/alpaca-trade-api-go/v2/alpaca"
	"github.com/shopspring/decimal"	// Used for decimal type
)

func main() {

}
```

From now on, we'll be writing all our code inside `main`. Instantiate the Alpaca trading
client with your API keys using `alpaca.NewClient`. This example will be
submitting paper trades instead of live trades, so we'll also pass in a `BaseURL`
to route our requests accordingly.

```go
apiKey := "<Your API Key>"
apiSecret:= "<Your Secret Key>"
baseURL:= "https://paper-api.alpaca.markets"

// Instantiating new Alpaca paper trading client
client := alpaca.NewClient(alpaca.ClientOpts{
  // Alternatively, you can set your API key and secret using environment
  // variables named APCA_API_KEY_ID and APCA_API_SECRET_KEY respectively
  ApiKey:    apiKey,
  ApiSecret: apiSecret,
  BaseURL:   baseURL,		// Remove for live trading
})
```

The trading client is now ready to make requests. To start off, make sure that
your account has sufficient buying power to place orders. Buying power can be
found inside one's account information. This can be queried by the client's method,
`GetAccount`. Call this function and print the result to view your account's
information.

```go
// Get account information
acct, err := client.GetAccount()
if err != nil {
  // Print error
  fmt.Printf("Error getting account information: %v", err)
} else {
  // Print account information
  fmt.Printf("Account: %+v\n", *acct)
}
```

```sh
{ID:ee302827-4ced-4321-b5fb-71080392d828 AccountNumber:PA3717PJAYWN CreatedAt:2022-04-19 17:46:03.68585 +0000 UTC UpdatedAt:0001-01-01 00:00:00 +0000 UTC DeletedAt:<nil> Status:ACTIVE Currency:USD Cash:645113.208 CashWithdrawable:0 TradingBlocked:false TransfersBlocked:false AccountBlocked:false ShortingEnabled:true BuyingPower:1290226.416 PatternDayTrader:false DaytradeCount:0 DaytradingBuyingPower:0 RegTBuyingPower:1290226.416 Equity:909637.208 LastEquity:906533.73 Multiplier:2 InitialMargin:0 MaintenanceMargin:0 LastMaintenanceMargin:0 LongMarketValue:264524 ShortMarketValue:0 PortfolioValue:909637.208}
```

The [Trading Account docs](../../api-references/trading-api/account) outline the
property descriptions of the above `Account` object. Now that we're certain our
buying power is sufficient to place trades, let's send a market buy order.

### Placing a Buy Order

Before placing an order, you should define the parameters for it. For a market
buy order, the variables necessary to set are `AssetKey`, `Qty`, `Side`,
`Type`, and `TimeInForce`. Respectively, these variables determine what asset
the order is for, how many units to exchange, whether the order is buy-side or
sell-side, the type of the order, and how long the order should stay active. This
example will set parameters to send a market buy order for 1 unit of Bitcoin (BTC/USD)
expiring at the end of the day.

```go
// Parameters for placing a market buy order for 1 unit of Bitcoin
symbol := "BTC/USD"
qty := decimal.NewFromInt(1)
side := alpaca.Side("buy")
orderType := alpaca.OrderType("market")
timeInForce := alpaca.TimeInForce("day")
```

To place an order, use the client's method `PlaceOrder`. This function takes a
`PlaceOrderRequest` as the only parameter and returns an `Order` object. Pass
your order parameters into the `PlaceOrderRequest` constructor and pass the resulting value
into `PlaceOrder` to send the order. In addition to sending the order, print the
returned `Order` object associated with it.

```go
// Placing an order with the parameters set previously
order, err := client.PlaceOrder(alpaca.PlaceOrderRequest{
  AssetKey: 		&symbol,
  Qty: 			    &qty,
  Side: 			  side,
  Type: 			  orderType,
  TimeInForce: 	timeInForce,
})
if err != nil {
  // Print error
  fmt.Printf("Failed to place order: %v\n", err)
} else {
  // Print resulting order object
  fmt.Printf("Order succesfully sent:\n%+v\n", *order)
}
```

```sh
Order succesfully sent:
{ID:cacccb64-16f0-4062-a603-f5bbed03dea1 ClientOrderID:811cf9a1-f21a-4b73-9792-54ddb947e817 CreatedAt:2022-07-07 04:34:16.826358392 +0000 UTC UpdatedAt:2022-07-07 04:34:16.826418592 +0000 UTC SubmittedAt:2022-07-07 04:34:16.824913502 +0000 UTC FilledAt:<nil> ExpiredAt:<nil> CanceledAt:<nil> FailedAt:<nil> ReplacedAt:<nil> Replaces:<nil> ReplacedBy:<nil> AssetID:64bbff51-59d6-4b3c-9351-13ad85e3c752 Symbol:BTC/USD Exchange: Class:crypto Qty:1 Notional:<nil> FilledQty:0 Type:market Side:buy TimeInForce:day LimitPrice:<nil> FilledAvgPrice:<nil> StopPrice:<nil> TrailPrice:<nil> TrailPercent:<nil> Hwm:<nil> Status:pending_new ExtendedHours:false Legs:<nil>}
```

The order has now been submitted and your trading dashboard will have updated accordingly.
To understand the properties of this `Order` object better, visit the [Trading API docs](../../api-references/trading-api/orders/#order-entity)
to read the property descriptions.

### Viewing open positions

Viewing one’s open positions is key in understanding your current holdings. This can be
done through the SDK very quickly. The client implements a method, `ListPositions` that
returns a `[]Position`.

To view your open positions, call `ListPositions` and print each element in the
resulting list.

```go
// Get open positions
positions, err := client.ListPositions()
if err != nil {
  // Print error
  fmt.Printf("Failed to get open positions: %v\n", err)
} else {
  // Print every position with its index
  for idx, position := range positions {
    fmt.Printf("Position %v: %+v\n", idx, position)
  }
}
```

```sh
Position 0: {AssetID:64bbff51-59d6-4b3c-9351-13ad85e3c752 Symbol:BTC/USD Exchange:FTXU Class:crypto AccountID: EntryPrice:20429 Qty:1 Side:long MarketValue:20423 CostBasis:20429 UnrealizedPL:-6 UnrealizedPLPC:-0.0002937001321651 CurrentPrice:20423 LastdayPrice:20516 ChangeToday:-0.0045330473776565}
```

The output shows that we have a long position for 1 unit of Bitcoin. Visit
the [Positions docs](../../api-references/trading-api/positions/#position-entity)
to view the descriptions of a `Position` entity.

You're now equipped with the basics of placing trades with Alpaca's SDK. Good
luck coding and have fun with your new capabilities!

{{< /tab >}}
{{< /tabs >}}
