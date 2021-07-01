---
weight: 6
title: Funding
summary: Open brokerage accounts, enable commission-free trading, and manage the ongoing user experience with Alpaca Broker API
---

# Funding

The funding process can vary depending on your setup and region and we support
many cases, but everyone can do the same in the sandbox environment.

## **Sandbox Funding**

In the sandbox environment, Transfer API simulates deposits and withdrawals
to/from an account. The target account is immediately credited or debited upon
such a request. Once an account is credited, the account can start trading with
Order API.

## **ACH (US Domestic)**

For US ACH, you will use Plaid to obtain the user’s bank account information.
You then pass the information to Alpaca using [ACH API]({{< relref
"/api-references/funding/ach.md" >}}) to create a bank link object. Once
such bank information is established, then you can initiate both deposit and
withdrawal transactions using [Transfer API]({{< relref
"/api-references/funding/transfers.md" >}}).

## **Wire (US Domestic)**

You can initiate a withdrawal transaction with wire transfer using [Transfer
API]({{< relref "/api-references/funding/transfers.md" >}}). You need to
create a bank object before that. For US domestic wire transactions, we will
need ABA / routing number and the account number. You can supply additional text
in each transaction.

In order for us to receive the deposits and book automatically, we need an “FFC”
instruction in each incoming wire transaction. Please contact us for more
details.

## **International Wire (SWIFT)**

Alpaca supports international wire transfers and the API endpoint is the same as
the US domestic case. You need to provide the SWIFT code and account number of
the beneficiary, as well as the address and name of the receiving bank.

The FFC instruction works for international wires too.

## **Cash Pooling**

If you wish and are eligible, you can send customer deposits in a bulk to your
firm account first and reconcile later using [Journal API]({{< relref
"/api-references/journals" >}}).

We need to review the entire flow first to allow you to do so, and also you may
need a local license to implement this process. Please check your counsel for
the local requirements.

### Travel Rule

In an effort to fight the criminal financial transactions, FinCEN enacted the
[Travel Rule](https://www.fincen.gov/sites/default/files/advisory/advissu7.pdf)
that applies to fund transfers of more than $3,000. FAFT further adopted this
from FinCEN to set the global standard, to regulate globally distributed crypto
exchanges (virtual asset service providers; VASP) and many countries are due to
implement this locally too.

Under this rule, financial institutions that transmit the funds are required to
submit the following information to the recipient financial institutions
(financial institutions here include banks and nonbanks; essentially any party
that initiates the transfers).

- The name of the transmittor,
- The account number of the transmittor, if used,
- The address of the transmittor,
- The identity of the transmittor’s financial institution,
- The amount of the transmittal order,
- The execution date of the transmittal order, and
- The identity of the recipient’s financial institution

The purpose of this requirement is for the investigators to track the flow of
funds in case they need to. Failure to do so could cause a civil enforcement.

When you use Journal API to bundle a bulk of transfers for the end-users, you
will need to tell about the breakdown and each transmitter information using the
optional fields of the POST request.

Alpaca retains the collected information for at least five years. If the journal
activities are used as part of the money transfer (other than cash movement
within Alpaca), and if the journal requests don't contain the transmitter
information, we may contact you.

## **Instant Deposit (Beta)**

As international money transfers can take days usually, under certain
conditions, Alpaca supports instant deposit for better user experience. Please
contact us for more details.

## **Post-trade Settlement**

We support the post-trade settlement process. Please contact us for more details.

&nbsp;
