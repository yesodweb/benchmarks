apt-get install -y build-essential libgmp3-dev zlib1g-dev git-core curl httperf libbsd-dev

# Haskell

## GHC
cd ~
wget http://haskell.org/ghc/dist/7.0.2/ghc-7.0.2-i386-unknown-linux.tar.bz2
tar jxfv ghc-7.0.2-i386-unknown-linux.tar.bz2
cd ghc-7.0.2
./configure
make install

## cabal
cd ~
wget http://hackage.haskell.org/packages/archive/cabal-install/0.10.2/cabal-install-0.10.2.tar.gz
tar zxfv cabal-install-0.10.2.tar.gz
cd cabal-install-0.10.2
sh bootstrap.sh

# nginx (for PHP)
sudo apt-get install -y libprce3-dev libssl-dev
wget http://sysoev.ru/nginx/nginx-0.8.54.tar.gz
tar zxfv nginx-0.8.54.tar.gz
cd nginx-0.8.54
./configure
make
make install

# PHP
apt-get install -y libxml2-dev
wget http://www.php.net/get/php-5.3.5.tar.bz2/from/de.php.net/mirror
mv mirror php-5.3.5.tar.bz2
tar jxfv php-5.3.5.tar.bz2
cd php-5.3.5
./configure --enable-fpm
make all
sudo groupadd nobody

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
apt-get install -y python-setuptools python-pycurl

## Tornado
cd ~
wget --no-check-certficate http://github.com/downloads/facebook/tornado/tornado-1.2.1.tar.gz
tar zxfv tornado-1.2.1.tar.gz

# node.js
cd ~
wget http://nodejs.org/dist/node-v0.4.2.tar.gz
tar zxfv node-v0.4.2.tar.gz
cd node-v0.4.2
./configure --without-ssl
make
make install

# Java
apt-get install -y openjdk-6-jre-headless

# libev for Snap
cd ~
wget http://dist.schmorp.de/libev/libev-4.04.tar.gz
tar zxfv libev-4.04.tar.gz
cd libev-4.04
./configure
make
make install
ldconfig

# Run the benchmarks themselves

## Compile Haskell code
cd ~
git clone https://github.com/snoyberg/benchmarks.git
cd benchmarks/pong
~/.cabal/bin/cabal update
~/.cabal/bin/cabal install snap-server -flibev
~/.cabal/bin/cabal install

## Link in tornado
ln -s ~/tornado-1.2.1/tornado

## Run all benchmarks
./runall.sh
./summary.sh
grep 'Request rate' -rn results/ | sed 's@results/\([^:]*\).*rate: \(.*\) req/s.*@\1 \2@' > results-summary
