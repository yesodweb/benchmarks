#!/bin/bash -x
DIR="$( cd "$( dirname "$0" )" && pwd )"
d=$(readlink -f $DIR)
source lib.sh

./dist/build/warp/warp $* &

benchmark
