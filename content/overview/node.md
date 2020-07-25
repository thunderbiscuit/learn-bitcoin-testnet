+++
title = "What's in a node"
template = "page.html"
weight = 2
+++

# Your node

Here is a mental model of what is typically happening with a node and how you can interact with it:

<center>
  <img src="/learn-bitcoin-testnet/images/overview/bitcoin-node.png"" style="width: 50vw; border: 2px solid #888888; border-radius: 8px;"/>
</center>

## 1. The bitcoin daemon

The core piece of software in your node is the bitcoin daemon (`bitcoind`). This is the brain of the operation. It connects to peers, monitors the blockchain, relays transactions, etc. 

Here are some typical ways to start a node is by summoning the daemon (!) and passing it (or not) a list of arguments, which further refine what you expect of it:

```sh
# straight bitcoin daemon
bitcoind

# bitcoin daemon using the test network
bitcoind -chain=testnet
```

The bitcoin daemon listens and respond to commands coming to it using its JSON-RPC interface. It also sends zmq messages, which you can listen to. 

## 2. bitcoin-cli
This is the typical way you interact with the bitcoin daemon—not directly, but through another little piece of software called bitcoin-cli. The role of this command line interface is to provide you with a user-friendlish way to speak to your node, and a way to print for you what comes back from the daemon. A typical interaction with your node might look something like this:

```sh
bitcoin-cli -regtest getnewaddress
```

## 3. ZMQ messages

ZeroMQ messages are messages sent from your node to a specified port. In contrast to `bitcoin-cli` which requires you to poll the daemon for information, zmq messages are broadcasted automatically and do not require authentication. 

The daemon can send out many types of messages, but an example is upon arrival of a new block to your node. The daemon registers the new block, decides upon its validity, and automatically sends out the new block raw data to the specified zmq port, whether someone is listening or not (_verify this_). As a user, you can take advantage of this by writing software that listens to those messages, and can act upon them accordingly.
