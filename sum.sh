#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -l walltime=00:05:00
#PBS -N Ivanov_GrandTotal

cd $PBS_O_WORKDIR

output_dir="result"
output_file="result.txt"

# Concatenate all output files and calculate sum and average
cat ./result/solvOut* | awk 'BEGIN{x=0}{x+=$0}END{print x}' >results.txt

echo "Done."
