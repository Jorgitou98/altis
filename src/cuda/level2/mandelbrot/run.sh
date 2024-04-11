#!/bin/sh
set -u
./mandelbrot -s 5 --passes 5 --uvm mandelbrot_$1.csv