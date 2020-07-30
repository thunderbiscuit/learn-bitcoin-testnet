+++
title = "bitcoin-regtest-box"
template = "page.html"
weight = 1
+++

# bitcoin-regtest-box

**In Short:** This project is one of the simplest ways to get a regtest network up and running.  
**Repo:** [bitcoin-regtest-box](https://github.com/bitcoindevkit/bitcoin-regtest-box)  
**Main Developer:** [@notmandatory](https://twitter.com/notmandatory)

This page is very much a _work in progress_. Propose improvements [here](https://github.com/thunderbiscuit/learn-bitcoin-testnet).

## Architecture

<center>
  <img src="/learn-bitcoin-testnet/images/regtest/bitcoin-regtest-box.png" style="width: 50vw; border: 2px solid #888888; border-radius: 8px;"/>
</center>

The image created by docker is used to generate two node containers, together creating the regtest network.

## Requirements

You'll need docker working on your machine. See our page on docker for more info on how to set it up if you need. The total size of the docker image is around 1GB. The following commands create two containers on your local machine, complete with all necessary software for running a bitcoin regtest network.

## Fire it up

You'll need to 

1. Clone the repo
2. Create the image
3. Fire up the containers

```sh
# clone the repo and get in there
git clone https://github.com/bitcoindevkit/bitcoin-regtest-box.git
cd bitcoin-regtest-box

# create the image
docker-compose build

# fire up the two containers
docker-compose up
```

## Using the network

Once your containers are up, you can ssh into one of your nodes (containers) to access the bitcoin daemon and interact with the network.

```sh
docker exec -it bitcoind_1 bash
```

From there you can use `bitcoin-cli` to speak with the daemon and send commands. Examples of this would be:

```sh
# get basic info on your chain
bitcoin-cli -regtest -rpcuser=user -rpcpassword=pass getblockchaininfo

# generate a new address from the node
bitcoin-cli -regtest -rpcuser=user -rpcpassword=pass getnewaddress

# mine 100 blocks and send their mining rewards to a given address
bitcoin-cli -regtest -rpcuser=user -rpcpassword=pass generatetoaddress 100 <newaddress>

# get info on your node's wallet
bitcoin-cli -regtest -rpcuser=user -rpcpassword=pass getwalletinfo
```

If you do have bitcoin-cli installed on your machine, you can interact directly with the daemon in the container since it has opened its rpc port 18443.

```sh
bitcoin-cli -chain=regtest -rpcport=18443 -rpcuser=user -rpcpassword=pass getblockchaininfo
```

Note that the usual way to tell the daemon is open to RPC communications on port 18443 is by taking a look at the `bitcoin.conf` file, which would in this case be in `/opt/bitcoin/regtest/`:

```sh
# log into container 1
docker exec -it bitcoind_1 bash

# print contents of bitcoin.conf file to console
cat /opt/bitcoin/regtest/bitcoin.conf
# file doesn't exist!
```

Turns out the file doesn't exist! In this case the port number if defined in the `docker-compose.yml` file, where the container starts and immediatly calls the bitcoin daemon with the following arguments: 

```sh
bitcoind -regtest -server -txindex=0 -prune=0 -blockfilterindex -peerblockfilters -fallbackfee=0.0002 -rpcallowip=0.0.0.0/0 -rpcbind=0.0.0.0 -addnode=bitcoind_2:18444 -rpcuser=user -rpcpassword=pass --datadir=/opt/bitcoin
```

If you look at the logs that come up when starting the containers (right after running `docker-compose up`), you'll see that the daemon does not find any config files as it boots: 

```sh
timestamp Config file: /opt/bitcoin/bitcon.conf (not found, skipping)
```