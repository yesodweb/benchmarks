#!/bin/bash -x

./dist/build/warp/warp &
nx=$!

httperf --hog --server=localhost --port=3000 --uri=/ --rate=1000 --num-conns=200 --num-calls=100 --burst-length=20
kill $nx

