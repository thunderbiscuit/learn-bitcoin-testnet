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
