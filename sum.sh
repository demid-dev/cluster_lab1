#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -l walltime=00:02:00
#PBS -N semenchenko_grandtotal

cd $PBS_O_WORKDIR

output_dir="result"
output_file="$result.txt"

# Concatenate all output files and calculate sum and average
cat ${output_dir}/solvOut_*.out | awk '/RESULT:/ { sum += $2 } END { printf "Total: %f\nAverage: %f\n", sum, sum/NR }' >"$output_file"

echo "Done."
