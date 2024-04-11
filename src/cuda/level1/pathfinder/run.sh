#!/bin/sh
set -u
./pathfinder -s 4 --passes 30 --uvm -m pathfinder_$1.csv
