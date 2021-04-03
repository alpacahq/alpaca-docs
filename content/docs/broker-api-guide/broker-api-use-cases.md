---
bookFlatSection: true
title: "Broker API Use Cases"
weight: 4
---

# Broker API Use Cases

There are several different use cases for Broker API integration. Below are some common ones, but please do not hesitate to reach out to our sales team if you have a different case in mind. We want our platform to encourage a broad range of use cases.
Trading/investing app (non-financial institution)

- Fully-disclosed broker dealer
- RIA (Registered Investment Advisor)
- Non-disclosed broker dealer
- Omnibus broker dealer

We support most use cases internationally.

Depending on the type of the setup, the API methods you want to use could vary. For example, the Omnibus setup never uses API to open a customer account since the trading accounts are created upfront and you will submit orders to them, and manage your end customer accounting on your end. More details on each setup are described in the following section.

Trading/investing App (Non-financial Institution)
You are building a brand-new trading app as a technology company. Or you could be an established fintech firm which builds a cash management service, neobank, or maybe a payroll company without having a particular financial institution status/license. Alpaca Broker API could be a solution for you. In this case, the account approval process is owned by Alpaca, and you own the user experiences and most of the communications.

There are a few points that we need to make sure when you are marketing your service using Broker API. We closely help you get the service out in a compliant manner when you are ready for going live.

## Fully-disclosed Broker Dealer

The fully-disclosed broker dealer means you are registered as a broker dealer in your jurisdiction and your end customers are introduced to Alpaca to open an individual account. This means Alpaca needs to see each customer's information to open an account and provide our services.

Depending on your license status and regulation in your jurisdiction, you may own the full end-to-end user experiences from account opening, to to trading, and reporting. This would mean you being responsible for KYC and AML, and Alpaca being reliant on your KYC/AML program. To ensure compliance with US regulations, Alpaca would review your KYC/AML program as part of our due diligence on our partnership..

In this setup, you will use most of the API methods such as the Account, Transfer and Trading API. In addition, you can move the cash and securities between your firm account and end-customer accounts using the Journal API to implement features such as reward programs.

## Registered Investment Advisor (RIA)RIA (Registered Investment Advisor)

A registered investment advisor (RIA) is a business with the mandate to manage the assets of customers. The reference to RIAs in this document refers to SEC-registered RIAs. However, for the purpose of explaining the integration approach, the term can be applied for other jurisdictions.

Similar to the fully disclosed approach, the end customer is introduced to Alpaca on an individual basis. And an account is created for them by Alpaca. The big difference between this and the fully-disclosed broker case is that you are not authorized to own the KYC/AML program for approval and opening the broker accounts. You can still own the user experience for the onboarding process to collect personal information in your own user interfaces, but the information is submitted to Alpaca via Account API by you. We perform KYC checks and accounts are approved by our automated/manual process based on our supervisory procedures.

The Account API works slightly differently from the fully-disclosed case for this setup. Please see the rest of API documentation for more details.

As an RIA, you can communicate with your customers directly. There are a few rules regarding the communication that we need to manage. Please contact our support to discuss details.

Currently, Alpaca does not support order allocation and advisory fee calculation as built-in functionality. These items are on our roadmap.

## Omnibus

If you are a non-US broker-dealer under some jurisdiction, and you are already managing customer accounting, you can integrate with Alpaca Broker API as an omnibus setup. In this category, you manage two main trading accounts for the entire trading flow of your customers, one for long positions and one for short positions. Within these two accounts, you will manage all customer level accounting. In the omnibus setup, the end customer is not disclosed to us.

The two trading accounts represent long and short positions. When you are submitting the customer orders, you need to identify if the order is for the long or short position of each customer. In addition, to meet our regulatory requirements, you will be required to submit “sub-tag” in each order to identify different customer’s order flow. This can be just an arbitrary text string such as UUID or customer ID number. Alpaca, as well as our execution brokers, needs to be able to review each trading activity correctly. If you fail to submit this correctly, in the case Alpaca needs to suspend some malicious activity, we may need to suspend the entire flow coming from you.

As each end customer is not disclosed, you will need to manage the international tax consequences as well. If you are a non-US broker-dealer, this will likely require registration with the IRS as a Foreign Financial Institution (FFI) and get certified as a Qualified Intermediary (QI) to be certified to manage taxes on the US-sourced income by foreigners.

## Non-disclosed Broker Dealer

This non-disclosed broker dealer refers to a hybrid setup between the fully-disclosed broker dealer case and omnibus setup. Legally, it is an omnibus setup. Your end customers are not fully known and you are fully responsible for KYC and AML, but from a technical point of view, Alpaca provides the customer accounting functionality by opening and trading within an anonymous account for each customer

The requirements around US taxes are the same as the omnibus setup, requiring registration as a FFI with QI status. However, it can be a bit more complicated as we may withhold income gains at the individual level.
