#!/bin/sh
set -u
./particlefilter_naive -x 8192 -y 8192 --np 100000 -m particlefilternaive_$1.csv
./particlefilter_float -x 8192 -y 8192 --np 100000 -m particlefilterfloat_$1.csv
