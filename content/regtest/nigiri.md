+++
title = "Nigiri"
template = "page.html"
weight = 2
+++

# Nigiri

**In Short:** Nigiri is a slightly more robust and involved piece of software than the bitcoin-regtest-box, and is easy to set up.  
**Repo:** [nigiri](https://github.com/vulpemventures/nigiri)  
**Main Developer:** [Vulpem Ventures](https://vulpem.com/)  

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
bitcoin-cli -chain=regtest -rpcport=19001 -rpcuser=admin1 -rpcpassword=123 getnewaddress
```

## Logs and Configuration File

You can access the logs for all containers and services using the following commands:

```sh
# bitcoind
nigiri logs node

# electrs
nigiri logs electrs

# chopsticks
nigiri logs chopsticks
```

A quick look at the logs will tell you that the config file for the bitoin daemon is located at `/config/regtest/`. Unfortunately the container does not come with nano or vim installed, so if you wish to change the config file you'll have find another way. You could for example: (1) ssh into the node with VScode, or (2) install nano or vim within the container (note that by default, installing a new package in a container will not persist over sessions).
