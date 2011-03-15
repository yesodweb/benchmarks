#!/bin/bash -x
DIR="$( cd "$( dirname "$0" )" && pwd )"
d=$(readlink -f $DIR)
source lib.sh

rvm use 1.9.2
unicorn -p 3000 -E production rack.ru &

benchmark
