---
weight: 6
title: Funding
summary: Open brokerage accounts, enable commission-free trading, and manage the ongoing user experience with Alpaca Broker API
---

# Funding

The funding process can vary depending on your setup and region and we support
many cases, but everyone can do the same in the sandbox environment.

## Sandbox Funding

In the sandbox environment, Transfer API simulates deposits and withdrawals
to/from an account. The target account is immediately credited or debited upon
such a request. Once an account is credited, the account can start trading with
Order API.

## ACH (US Domestic)

For US ACH, you will use Plaid to obtain the user’s bank account information.
You then pass the information to Alpaca using [ACH API]({{< relref
"/api-references/funding/ach.md" >}}) to create a bank link object. Once
such bank information is established, then you can initiate both deposit and
withdrawal transactions using [Transfer API]({{< relref
"/api-references/funding/transfers.md" >}}).

## Wire (US Domestic)

You can initiate a withdrawal transaction with wire transfer using [Transfer
API]({{< relref "/api-references/funding/transfers.md" >}}). You need to
create a bank object before that. For US domestic wire transactions, we will
need ABA / routing number and the account number. You can supply additional text
in each transaction.

In order for us to receive the deposits and book automatically, we need an “FFC”
instruction in each incoming wire transaction. Please contact us for more
details.

## International Wire (SWIFT)

Alpaca supports international wire transfers and the API endpoint is the same as
the US domestic case. You need to provide the SWIFT code and account number of
the beneficiary, as well as the address and name of the receiving bank.

The FFC instruction works for international wires too.

## Cash Pooling

If you wish and are eligible, you can send customer deposits in a bulk to your
firm account first and reconcile later using [Journal API]({{< relref
"/api-references/journals.md" >}}).

We need to review the entire flow first to allow you to do so, and also you may
need a local license to implement this process. Please check your counsel for
the local requirements.

## Instant Deposit (beta)

As international money transfers can take days usually, under certain
conditions, Alpaca supports instant deposit for better user experience. Please
contact us for more details. Post-trade Settlement We support the post-trade
settlement process. Please contact us for more details.

&nbsp;
