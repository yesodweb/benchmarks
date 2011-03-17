#!/bin/bash -x
DIR="$( cd "$( dirname "$0" )" && pwd )"
d=$(readlink -f $DIR)
source lib.sh

source ~/.rvm/scripts/rvm
rvm use 1.9.2
ruby ruby_goliath.rb -e production -p 3000 &

benchmark
