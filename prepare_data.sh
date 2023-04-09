#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <xmin> <xmax> <steps>"
    exit 1
fi

xmin=$1
xmax=$2
steps=$3
scale=10

dx=$(bc <<<"scale=$scale; ($xmax-$xmin)/$steps")
x=$xmin
for ((i = 0; i < $steps; i++)); do
    x1=$(bc <<<"scale=$scale; $x+$dx")
    echo "$x $x1"
    x=$x1
done >solv.inp
