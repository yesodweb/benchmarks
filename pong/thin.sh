#!/bin/bash -x
DIR="$( cd "$( dirname "$0" )" && pwd )"
d=$(readlink -f $DIR)
source lib.sh

rvm use 1.9.2
thin -p 3000 -R rack.ru -e production start &

benchmark

killall -KILL thin
