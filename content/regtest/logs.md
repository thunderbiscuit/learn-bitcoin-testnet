+++
title = "Exploring the bitcoind logs"
template = "page.html"
weight = 3
+++

# Understanding the bitcoind Logs

_This page is very much a work in progress. Propose improvements [here](https://github.com/thunderbiscuit/learn-bitcoin-testnet)._

If you've fired up a bitcon daemon, you're familiar with the experience of seeing a few hundred lines being printed on your console at breakneck speed, and most likely you're also familiar with not paying much attention to them. This article delves into a lot of those lines and attempts to remove the veil on them.

## A typical log entry

```sh
2020-07-24T20:28:38Z Bitcoin Core version v0.19.1 (release build)
```

The daemon logs are both printed to the console and saved in a file called `debug.log` located in your root `/regtest/` directory. They have two parts: a timestamp and a message.

## Common log messages

`Bitcoin Core version v0.19.1 (release build)`

This states the software version of the daemon.

<br />

`Config file: /config/bitcoin.conf`

This line is very important, as many-a-developer has been caught making changes to the wrong config file. If you've made changes to the config file and are not sure why your daemon doesn't seem to be applying them, check to see that it is using the right config file!

<br />

`Using wallet directory /config/regtest/wallets`

Again, a simple line letting you know the location of the wallets directory.
