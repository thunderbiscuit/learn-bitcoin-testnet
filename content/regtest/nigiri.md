+++
title = "Nigiri"
template = "page.html"
weight = 2
+++

# Nigiri

**In Short:** Nigiri is a slightly more robust and involved piece of software than the bitcoin-regtest-box, and is easy to set up.  
**Repo:** [nigiri](https://github.com/vulpemventures/nigiri)  
**Main Developer:** [Vulpem Ventures](https://vulpem.com/)  

This page is very much a _work in progress_. Propose improvements [here](https://github.com/thunderbiscuit/learn-bitcoin-testnet).

## Architecture

## Overview

Nigiri is a series of docker containers that together form an ecosystem around a bitcoin regtest network. It provides a bitcoin daemon, an electrum Rust server, an Esplora block explorer web interface, and a Liquid daemon.

See their [readme](https://github.com/vulpemventures/nigiri) for how to set it up. You can either download the binaries ready to go at [nigiri.vulpem.com](https://nigiri.vulpem.com/) or you can build them from source. Both are well explained.

The first thing you need to do once you have nigiri installed is to start up the whole box:

```sh
nigiri start

# to stop it, you'd use
nigiri stop
```

From there, a simple way to get started and play with the regtest in nigiri is to get inside the bitcoin node container and use bitcoin-cli directly (note that nigiri sets the RPC port at 19001 in the config file):

```sh
# get inside the container
docker exec -it resources_bitcoin_1 bash

# generate a new address
bitcoin-cli -datadir=config getnewaddress
```

## Logs

You can access the logs for all containers and services using the following commands:

```sh
# bitcoind
nigiri logs node

# electrs
nigiri logs electrs

# chopsticks
nigiri logs chopsticks
```


### Configuration File

Nigiri stores the `bitcoin.conf`  by default in the `~/.nigiri` data directory folder.
To tweak your Bitcoin node configuration:

1. Edit the `~/.nigiri/resources/volumes/regtest/config/bitcoin.conf` file
2. If already started, stop and delete `nigiri stop --delete`
3. Start and mount inside the container the edited configuration file `nigiri start` 