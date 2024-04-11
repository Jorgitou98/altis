#!/bin/bash
set -u
# MIG-partition
partition=$1

# Enable MIG, fix frequency and delete prvious gpu instances
sudo nvidia-smi -pm 1 -i 1
sudo nvidia-smi -mig 1 -i 1
sudo nvidia-smi -ac=1215,1440 -i 1
sudo nvidia-smi mig -dci -i 1 ; sudo nvidia-smi mig -dgi -i 1

# Create partition
sudo nvidia-smi mig -cgi $partition -C -i 1

# Iterate over run files
run_files=$(find .. -type f -name "run.sh")
for file in $run_files; do
    echo Ejecutando $file
    $file "$partition"
done

# Disable MIG and reset GPU
sudo nvidia-smi mig -dci -i 1 ; sudo nvidia-smi mig -dgi -i 1
sudo nvidia-smi -mig 0 -i 1
sudo nvidia-smi -pm 0 -i 1
sudo nvidia-smi --gpu-reset -i 1

