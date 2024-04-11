#!/bin/bash

N_ITS=10

sudo nvidia-smi -pm 1 -i 1
sudo nvidia-smi -mig 1 -i 1
sudo nvidia-smi -ac=1593,1200 -i 1
sudo nvidia-smi mig -dci -i 1 ; sudo nvidia-smi mig -dgi -i 1

partition="$1"
test_name="$2"

echo "====$test_name===="

output_file=$(pwd)"/$1.csv"
sudo nvidia-smi mig -cgi "$partition" -C -i 1
curr_path=$(pwd)
echo -n "${test_name}"  >> $output_file
cd "../src/cuda/${test_name}"
for it in $(seq 1 ${N_ITS}); do
	t=$("./run" | cut -d\  -f 4)
	echo -n ",${t}" >> $output_file
done
echo ""  >> $output_file
cd "$curr_path"

sudo nvidia-smi mig -dci -i 1 ; sudo nvidia-smi mig -dgi -i 1
sudo nvidia-smi -mig 0 -i 1
sudo nvidia-smi -pm 0 -i 1
sudo nvidia-smi --gpu-reset -i 1
