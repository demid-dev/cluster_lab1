# Count the number of nodes in the cluster
echo "Number of nodes in the cluster:"
pbsnodes -a | awk '/^s/{count++} END{print count}'

# Count the number of nodes with the same number of cores
echo "Nodes with the same number of cores:"
pbsnodes -a | awk '/np =/{print $3}' | sort | uniq -c | awk '{printf "   %d nodes with %d cores\n", $1, $2}'

# Count the number of nodes with the same amount of memory
echo "Nodes with the same amount of memory:"
pbsnodes -a | awk '/physmem =/{print $10}' | sort | uniq -c | awk '{printf "   %d nodes with %d GB of memory\n", $1, $2/$3}'

# Calculate the average amount of memory per core
total_mem=$(pbsnodes -a | awk '/physmem =/{total_mem+=$10} END{print total_mem}')
total_cores=$(pbsnodes -a | awk '/np =/{total_cores+=$3} END{print total_cores}')
avg_mem_per_core=$(echo "scale=2; $total_mem/($total_cores*1024)" | bc)
echo "The average amount of memory per core is $avg_mem_per_core GB"

# Count the number of GPUs on the cluster
num_gpus=$(pbsnodes -a | awk '/gpus =/{total_gpus+=1} END{print total_gpus}')
echo "There are $num_gpus GPUs on the cluster"
