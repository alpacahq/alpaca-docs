# Alpaca Broker API Doc

## Requirements
This document is built using [Hugo](https://gohugo.io/). On Mac, install it using `brew`.

The base theme is [Docsy](https://www.docsy.dev/). It is located under the `theme` directory.

## Setup
At the first time after you clone this repository, you need to download the base theme using `git submodule`.

```sh
$ git submodule update --init --recursive
```

Then, run `hugo` command. It is recommended to specify `--noHTTPCache` to avoid the
browser cache.

```sh
$ hugo server --noHTTPCache
```