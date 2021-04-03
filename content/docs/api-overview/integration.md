---
bookHidden: false
weight: 1
title: Integration
---

# Integration

[Diagram of the flow: sign up for dashboard -> sandbox -> build a mock app -> apply for going live -> business onboarding -> go live -> operations]

If you are coming to Alpaca for the first time to build something using Broker API, please sign up for the dashboard. In this dashboard, you can acquire your API key for the sandbox environment and gain access to the test data immediately.

The sandbox behaves the same way as the live environment for most parts with a few mocked parts. With this environment, you should be able to build a complete demo app that you can show to your friends, investors and other community members. Going live from here would be a matter of testing and updating the API calls for the mocked endpoints.

To go live, we will onboard you for the business integration. For more details of this step, please refer to <section>

Once you go live, you can keep using the same dashboard to view customer activity and resolve issues for them. You will also get support for the broker operations and technology support based on the agreement.

## Sandbox

You have full access to the sandbox while developing your integration for free of charge. The sandbox is built with the same code as live with a few different behaviors.

### Account Approval

The account approval process slightly differs depending on your business setup, and you may need to test different scenarios in the sandbox first. The sandbox is fully automated with the account approval simulation with test fixtures, while the live environment may involve manual review and approval steps in some cases.

### Trading

All trades that happen in the sandbox environment are simulated. The simulator engine is the same as our paper trading engine. All assumptions and mock logic follow the paper trading behavior. Please refer to the documentation <link>.

### Funding

The funding integration can vary depending on your country as well as the type of setup. In the sandbox environment, it is simplified with Transfer API. In order to simulate the deposit (credit) or withdrawal (debit) on the user account, simply call the POST method of Transfer API and it will become effective immediately. In the live environment, you may need to use Banks API as well as ACH endpoints if you are using ACH transfer within the USA. More details are described in the <section>.

### Journal Approval

When you make a Journal API request, if the amount exceeds the pre-configured limit amount, it goes into a pending status. In the live environment, Alpaca’s operation team is notified and manually reviews your request. In the sandbox environment, this process is simulated.
