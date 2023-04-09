#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -l walltime=00:02:00
#PBS -N semenchenko_integrals

cd $PBS_O_WORKDIR

input_file="input.txt"
output_file="output.txt"

# Check if input file exists
if [ ! -f "$input_file" ]; then
    echo "Input file not found"
    exit 1
fi

while read -r line; do
    # Extract xmin and xmax from line
    xmin=$(echo "$line" | awk '{print $1}')
    xmax=$(echo "$line" | awk '{print $2}')
    # Call integral function and append result to output file
    ./a.out "$xmin" "$xmax" >>"$output_file"

done <"$input_file"
