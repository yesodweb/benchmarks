benchmark(){
  sleep 5
  nx=$!
  httperf --hog --server=localhost --port=3000 --uri=/ --rate=1000 --num-conns=1000 --num-calls=1000 --burst-length=20 > results/`basename $0 .sh`
  kill $nx
  sleep 2
}
