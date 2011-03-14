mkdir -p results

cabal configure
cabal build

./snap.sh
./warp.sh
./php.sh
./python.sh
