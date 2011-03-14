#!/bin/bash -x

d=$(readlink -f $(dirname $0))

python tornado.py &
py=$!

sleep 1

httperf --hog --server=localhost --port=3000 --uri=/ --rate=1000 --num-conns=200 --num-calls=100 --burst-length=20 > results/tornado

kill $py
