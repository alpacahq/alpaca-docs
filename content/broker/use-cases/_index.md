---
weight: 2
bookFlatSection: true
title: Use Cases
summary: Open brokerage accounts, enable commission-free trading, and manage the ongoing user experience with Alpaca Broker API
---

# Broker API Use Cases

There are several different use cases for Broker API integration. Below are some
common ones, but please do not hesitate to reach out to our sales team if you
have a different case in mind. We want our platform to encourage a broad range
of use cases.

- Trading/investing app (non-financial institution)
- Broker dealer (fully-disclosed, non-disclosed, omnibus)
- Registered Investment Advisor (RIA)

We support most use cases internationally.

Depending on the case, the API methods you want to use could vary. For
example, the omnibus broker-dealer case never uses API to open a customer
account since the trading accounts are created upfront and you will submit
orders to them, and manage your end customer accounting on your end. More
details on each use case are described in the following sections.

---

## **Trading/Investing App**

(Non-financial Institution)

As a technology company, you are building a brand-new trading or investing app.
You could also be an established fintech firm who offers cash management
services, a neobank, or maybe a payroll company without a financial institution
status/license. Alpaca Broker API could be a solution for you. In this case, the
account approval process is owned by Alpaca, and you own the user experience and
most of the communications. Unless you have a robust CIP/KYC/AML program in
place that has been vetted by Alpaca, your customers will go through Alpaca’s
CIP/KYC/AML process.

Alpaca will work hand-in-hand with you to market your service using Broker API
in a compliant manner.

---

## **Broker-Dealer**

### Fully-Disclosed

You are a registered broker-dealer in your jurisdiction and you introduce your
customers to Alpaca to establish individual accounts on a fully-disclosed basis.
Alpaca receives each customer’s information in order to open an account and
provide our services.

Depending on your registration status and regulations in your jurisdiction, you
may own the full end-to-end user experience from account opening, to trading,
and reporting. You are responsible for maintaining a robust Customer
Identification Program (CIP) and Know Your Customer (KYC) procedures, in
accordance with Anti-Money Laundering (AML) regulations. To ensure compliance
with applicable laws, Alpaca will conduct due diligence on your firm, including
a thorough review of your CIP/KYC/AML program.

In this setup, you will use most of the API methods such as the Account,
Transfer and Trading API. In addition, you can move cash and securities between
your firm account and end-customer accounts using the Journal API to implement
features such as reward programs.

### Omnibus

You are a registered broker-dealer and you manage customer accounting, and two
main trading accounts for the entire trading flow of your customers (one for
long positions and one for short positions). In the omnibus setup, your end
customer information (e.g. name, address) is not disclosed to Alpaca.

When submitting customer orders for your two trading accounts, you will indicate
if the order is for the long or short position of each customer. To meet our
regulatory requirements, you will be required to submit a “sub-tag” in each
order to identify different customer’s order flow. This can be just an arbitrary
text string such as UUID or a customer ID number. Alpaca, as well as our trading
execution venues, need to be able to review and account for all trading
activity. Failure to submit the required trading order flow information may
result in the suspension of the entire order flow.

As each end customer is not disclosed to Alpaca, you are responsible for all tax
reporting in your local jurisdiction. If you are a non-US broker-dealer, this
will likely require registration with the IRS as a Foreign Financial Institution
(FFI) and get certified as a Qualified Intermediary (QI) to be certified to
manage taxes on the US-sourced income by foreigners.

### Non-Disclosed

A non-disclosed broker dealer is a hybrid of a fully-disclosed and omnibus setup.
Legally, it is an omnibus setup. Your end customers are not fully known to
Alpaca and you are fully responsible for CIP/KYC/AML. From a technical point of
view, however, Alpaca provides customer accounting functionality by opening and
trading within an anonymous account for each customer.

The requirements around US taxes are similar to the omnibus setup, requiring registration as a FFI with QI status. Withholding requirements may differ as they may be assessed at the individual level.

##### \*_Limitations apply. Please contact partnership@alpaca.markets for more information._ {#broker-dealer-footnote}

---

## **Registered Investment Advisor (RIA)**

You are a SEC-registered RIA with customers either in or outside the US.

Similar to the Trading/Investing App approach described above, the end customer
is introduced to Alpaca on an individual basis. The account approval process is
owned by Alpaca, and you own the user experience and most of the communications.
Unless you have a robust CIP/KYC/AML program in place that has been vetted by
Alpaca, your customers will go through Alpaca’s CIP/KYC/AML process.

The Account API works slightly differently from the fully-disclosed case for
this setup. Please see the rest of API documentation for more details.

As an RIA, you can communicate with your customers directly. Alpaca will work
hand-in-hand with you to market your service using Broker API in a compliant
manner.

Currently, Alpaca does not support order allocation and advisory fee calculation
as built-in functionality. These items are on our roadmap.

&nbsp;
