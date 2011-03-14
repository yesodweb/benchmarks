mkdir -p results

./snap.sh $*
./warp.sh $*
./php.sh
./python.sh
./node.sh
./nginx.sh
