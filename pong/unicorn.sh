#!/bin/bash -x
DIR="$( cd "$( dirname "$0" )" && pwd )"
d=$(readlink -f $DIR)
source lib.sh

rvm use 1.9.2
unicorn -p 3000 rack.ru &

benchmark
