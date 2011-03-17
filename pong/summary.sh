#!/bin/bash

grep 'Request rate' -rn results/ | sed 's@results/\([^:]*\).*rate: \(.*\) req/s.*@\2 \1@' | sort -n | tac | tee results-summary
