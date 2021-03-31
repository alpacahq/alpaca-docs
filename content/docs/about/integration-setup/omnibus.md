---
bookHidden: false
weight: 3
title: Omnibus
---

# Omnibus

If you are a broker-dealer under some jurisdiction, and you are already managing customer accounting, you can integrate with Alpaca Broker API as an omnibus setup. In this category, you manage two main trading accounts for the entire trading flow of your customers, without disclosing them to us.

The two trading accounts represent long and short positions. When you are submitting the customer orders, you need to identify if the order is for the long or short position of each customer. In addition, to meet our regulatory requirements, you will be required to submit “sub-tag” in each order to identify different customer’s order flow. This can be just an arbitrary text string such as UUID or customer ID number. Alpaca, as well as our execution brokers, needs to be able to review each trading activity correctly. If you fail to submit this correctly, in the case Alpaca needs to suspend some malicious activity, we may need to suspend the entire flow coming from you.

As each end customer is not disclosed, you will need to manage the international tax consequences as well.
