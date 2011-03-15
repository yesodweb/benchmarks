benchmark(){
  sleep 1
  nx=$!
  httperf --hog --server=localhost --port=3000 --uri=/ --rate=1000 --num-conns=200 --num-calls=100 --burst-length=20 > results/`basename $0 .sh`
  kill $nx
}
