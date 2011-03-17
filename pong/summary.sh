#!/bin/bash

grep 'Request rate' -rn results/ | sed 's@results/\([^:]*\).*rate: \(.*\) req/s.*@\1 \2@' | tee results-summary
