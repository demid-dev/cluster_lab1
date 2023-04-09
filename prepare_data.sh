#!/bin/bash

if [ $# -lt 3 ]; then
    echo "Usage: $0 xmin xmax steps"
    exit 1
fi

xmin=$1
xmax=$2
steps=$3
scale=10

dx=$(echo "scale=$scale;($xmax-$xmin)/$steps" | bc)
x=$xmin
for i in $(seq 1 $steps); do
    printf "%.*f %.*f\n" $scale $x $scale $(echo "scale=$scale;$x+$dx" | bc)
    x=$(echo "scale=$scale;$x+$dx" | bc)
done >solv.inp
