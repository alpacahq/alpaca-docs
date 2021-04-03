---
bookHidden: false
weight: 4
---

# Watchlists

## Getting a List of Watchlists

GET `/v1/trading/accounts/{account_id}/watchlists`

## Creating a Watchlist

POST `/v1/trading/accounts/{account_id}/watchlists`

## Getting a Watchlist by Watchlist ID

GET `/v1/trading/accounts/{account_id}/watchlists/{watchlist_id}`

## Updating a Watchlist

PUT `/v1/trading/accounts/{account_id}/watchlists/{watchlist_id}`

## Adding an Asset to a Watchlist

POST `/v1/trading/accounts/{account_id}/watchlists/{watchlist_id}`

## Deleting a Watchlist

DELETE `/v1/trading/accounts/{account_id}/watchlists/{watchlist_id}`

## Removing a Symbol from a Watchlist

DELETE `/v1/trading/accounts/{account_id}/watchlists/{watchlist_id}/{symbol}`
