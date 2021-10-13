BTCneco
========

![BTCneco logo](https://raw.githubusercontent.com/dgarage/btcneco/master/app/assets/images/BTCnecoMedia.png)

Warning: This software is experimental. Any loss of real funds or data are your own responsibility!

## What is BTCneco?

BTCneco is a Bitcoin-based Non-censorable Experimental Crowdfunding Organizer (NECO).

BTCneco allows a way for artists, creators, content producers, programmers, etc. to fund themselves directly by crowdfunding through Bitcoin, 
while providing a platform to manage those customers. In a more broader scope, BTC-Neco aims to eventually solve recurring payments for Bitcoin.

The name comes from the "Maneki-Neko", a Japanese lucky charm in the shape of a cat or "Neko" in Japanese,
commonly placed in front of shops, which beckons customers to come inside the owner's shop. ([wikipedia](https://en.wikipedia.org/wiki/Maneki-neko))

BTCneco functions as an app for [BTCPay Server](https://github.com/btcpayserver/). In a nutshell, BTCPay Server is a free and open-source 
cryptocurrency payment server that allows you to receive Bitcoin directly, with no fees.

## Under the hood

Bitcoin is a push-based payment system, which makes recurring payments difficult. The current solution for BTCneco is sending emails periodically 
for the length of a customer's subscription, with a payment link from a BTCPay Server instance that you control. 
More technically sophisticated solutions involving Lightning payments, are currently being investigated and will be experimentally integrated.

## Requirements:

* A deployed BTCPay Server. Instructions can be found at [their Github](https://github.com/btcpayserver/).

* A server with: Ruby (version 2.5.1), Ruby on Rails (version 5.2.2.1), Postgres (version 9.6.5)

## How to get started:

* TODO

* rails db:setup

* Database initialization

* How to run the test suite: rspec

* ...

## Various settings
Top header pic is a Bootstrap jumbotron, which is locked at 355px height.

## License

This work is licensed under [MIT](https://mit-license.org/).
