#!/bin/bash

# Count the number of nodes in the cluster
num_nodes=$(pbsnodes -a | grep -c '^s')

# Count the number of nodes with the same number of cores
num_cores=$(pbsnodes -a | awk '/np =/{count[$3]++} END{for (i in count) print count[i], i " cores"}')

# Count the number of nodes with the same amount of memory
num_memory=$(pbsnodes -a | awk '/physmem =/{count[$7]++} END{for (i in count) print count[i], i/1024/1024 " GB"}')

# Calculate the average amount of memory per core
total_mem=0
total_cores=0
while read -r line; do
  mem=$(echo "$line" | awk '{print $1}')
  cores=$(echo "$line" | awk '{print $2}')
  if [[ $cores -gt 0 ]]; then
    total_mem=$(echo "$total_mem + $mem" | bc)
    total_cores=$(echo "$total_cores + $cores" | bc)
  fi
done <<< "$(pbsnodes -a | awk '/physmem =/ && /np =/{print $7/$14/1024/1024, $14}')"
avg_memory_per_core=$(echo "scale=2; $total_mem/$total_cores" | bc)
avg_memory_per_core="${avg_memory_per_core} GB/core"

# Count the number of GPUs in the cluster
num_gpus=$(pbsnodes -a | awk '/gpus =/{count++} END{print count}')

echo "Number of nodes in the cluster: $num_nodes"
echo "Number of nodes with the same number of cores: $num_cores"
echo "Number of nodes with the same amount of memory: $num_memory"
echo "Average amount of memory per core: $avg_memory_per_core"
echo "Number of GPUs in the cluster: $num_gpus"
