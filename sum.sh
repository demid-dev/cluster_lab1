#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -l walltime=00:05:00
#PBS -N Ivanov_GrandTotal

#cd $PBS_O_WORKDIR

output_dir="result"
output_file="result.txt"

# Concatenate all output files and calculate sum and average
awk '/RESULT:/ { sum += $2; count += 1 } END { printf "Total: %f\nAverage: %f\n", sum, sum/count }' ${output_dir}/solvOut_*.out >"$output_file"

echo "Done."
