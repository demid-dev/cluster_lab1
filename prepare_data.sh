#!/bin/bash

# Parse command line arguments
if [ $# -ne 3 ]; then
    echo "Usage: $0 xmin xmax steps"
    exit 1
fi

# Assign command line arguments to variables
xmin=$1
xmax=$2
steps=$3

# Calculate step size
scale=10
dx=$(echo "scale=$scale; ($xmax-$xmin)/$steps" | bc)

# Generate input file with awk
awk -v xmin="$xmin" -v dx="$dx" -v steps="$steps" \
    'BEGIN{for(i=0;i<steps;i++){print xmin+i*dx" "xmin+(i+1)*dx}}' \
    >solv.inp
