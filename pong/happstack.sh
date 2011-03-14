#!/bin/bash -x

./dist/build/happstack/happstack $* &
nx=$!

httperf --hog --server=localhost --port=8000 --uri=/ --rate=1000 --num-conns=200 --num-calls=100 --burst-length=20 > results/happstack
kill $nx
