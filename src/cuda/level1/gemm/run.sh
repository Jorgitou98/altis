#!/bin/sh
set -u
./gemm -s 5 --passes 30 --uvm -m gemm_$1.csv
