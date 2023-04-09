#!/bin/bash

# Count the number of nodes in the cluster
num_nodes=$(pbsnodes -a | grep -c '^s')

# Count the number of nodes with the same number of cores
num_cores=$(pbsnodes -a | awk '/np =/{count[$3]++} END{for (i in count) print count[i], i " cores"}')

# Count the number of nodes with the same amount of memory
num_memory=$(pbsnodes -a | awk '/physmem =/{count[$3]++} END{for (i in count) print count[i], i/1024/1024 " GB"}')

# Calculate the average amount of memory per core
avg_memory_per_core=$(pbsnodes -a | awk '/physmem =/{ if ($10 > 0) { total_mem+=$3; total_cores+=$10 }} END { if (total_cores > 0) { print total_mem/total_cores/1024/1024 " GB/core" } else { print "N/A" } }')

# Count the number of GPUs in the cluster
num_gpus=$(pbsnodes -a | awk '/gpus =/{count++} END{print count}')

echo "Number of nodes in the cluster: $num_nodes"
echo "Number of nodes with the same number of cores: $num_cores"
echo "Number of nodes with the same amount of memory: $num_memory"
echo "Average amount of memory per core: $avg_memory_per_core"
echo "Number of GPUs in the cluster: $num_gpus"
