---
bookHidden: false
weight: 4
title: RIA
---

# RIA (Registered Investment Advisor)

A registered investment advisor (RIA) is a business to manage the assets of your customers on behalf of them. RIA here refers to mainly the one in the USA under the SEC registration, but it could apply to ones under other jurisdictions.

The broker account of the end customer sits on Alpaca, and the customer is introduced to Alpaca on an individual basis. The big difference between this and the fully-disclosed broker case is that you are not authorized to approve the new account opening. You can still own the user experiences on the onboarding process to collect personal information in your own user interfaces, but the information is submitted to Alpaca via Account API by you. We perform KYC checks and accounts are approved by our automated/manual process based on our supervisory procedures.

The Account API works slightly differently from the fully-disclosed case for this setup. Please see the rest of API documentation for more details.

As an RIA, you can communicate with your customers directly. There are a few rules regarding the communication that we need to manage. Please contact our support to discuss details.

Currently, Alpaca does not support order allocation and advisory fee calculation as built-in functionality. These items are on our roadmap.
