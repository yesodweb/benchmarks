#!/bin/bash

# This script is intended to be run on a 64-bit Ubuntu server install or a
# 64-bit Ubuntu EC2 instance. The command I use to create that instance is:

#    ec2-run-instances ami-cef405a7 -k ec2-keypair -t c1.xlarge

sudo apt-get update

sudo apt-get install -y build-essential libgmp3-dev zlib1g-dev git-core curl httperf libbsd-dev libpcre3-dev libssl-dev libxml2-dev python-setuptools python-pycurl openjdk-6-jre-headless

# Haskell

## GHC
cd ~
wget http://haskell.org/ghc/dist/7.0.2/ghc-7.0.2-x86_64-unknown-linux.tar.bz2
tar jxfv ghc-7.0.2-x86_64-unknown-linux.tar.bz2
cd ghc-7.0.2
./configure
sudo make install

## cabal
cd ~
wget http://hackage.haskell.org/packages/archive/cabal-install/0.10.2/cabal-install-0.10.2.tar.gz
tar zxfv cabal-install-0.10.2.tar.gz
cd cabal-install-0.10.2
sh bootstrap.sh

# nginx (for PHP)
cd ~
wget http://sysoev.ru/nginx/nginx-0.8.54.tar.gz
tar zxfv nginx-0.8.54.tar.gz
cd nginx-0.8.54
./configure
make
sudo make install

# PHP
cd ~
wget http://www.php.net/get/php-5.3.5.tar.bz2/from/de.php.net/mirror
mv mirror php-5.3.5.tar.bz2
tar jxfv php-5.3.5.tar.bz2
cd php-5.3.5
./configure --enable-fpm
make all
sudo make install
sudo sudo groupadd nobody

# Ruby

## RVM
bash < <( curl http://rvm.beginrescueend.com/releases/rvm-install-head )
echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"' >> ~/.bashrc
source ~/.rvm/scripts/rvm
rvm install 1.9.2
rvm use 1.9.2

## Goliath
gem install goliath

# Python

## Tornado
cd ~
wget http://github.com/downloads/facebook/tornado/tornado-1.2.1.tar.gz --no-check-certificate
tar zxfv tornado-1.2.1.tar.gz
cd tornado-1.2.1
sudo python setup.py install

# node.js
cd ~
wget http://nodejs.org/dist/node-v0.4.2.tar.gz
tar zxfv node-v0.4.2.tar.gz
cd node-v0.4.2
./configure --without-ssl
make
sudo make install

# libev for Snap
cd ~
wget http://dist.schmorp.de/libev/libev-4.04.tar.gz
tar zxfv libev-4.04.tar.gz
cd libev-4.04
./configure
make
sudo make install
sudo ldconfig

# Run the benchmarks themselves

## Compile Haskell code
cd ~
git clone https://github.com/yesodweb/benchmarks.git
cd benchmarks/pong
~/.cabal/bin/cabal update
~/.cabal/bin/cabal install snap-server -flibev
~/.cabal/bin/cabal install

## Link in tornado
ln -s ~/tornado-1.2.1/tornado

## Run all benchmarks
./runall.sh +RTS -A4M -N3
./summary.sh
grep 'Request rate' -rn results/ | sed 's@results/\([^:]*\).*rate: \(.*\) req/s.*@\1 \2@' > results-summary
