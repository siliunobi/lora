#!/bin/bash
source config.sh
initial_txn_count=0
client_id=$1
end_client_id=$2

while [ $client_id -le $end_client_id ]
do
	for file in ${debug_log_dir}/client_logs$client_id/*; do
    		result1=$(cat $file | grep -o -P "Monitor \| count : \K[0-9]+")
    		# result2=$(cat $file | grep -o -P -A 1 "Monitor \| count :$")
		result2=$(awk '/Monitor \| count :$/{getline; print}' $file | grep -o -P '\K[0-9]+' | head -1)

    		if [ $result1 ]
    		then
    			echo $result1
        		initial_txn_count=`expr $initial_txn_count + $result1`
    		fi
		if [ $result2 ]
		then
			echo $result2
        		initial_txn_count=`expr $initial_txn_count + $result2`
    		fi
			
	done
	client_id=`expr $client_id + 1`
done

echo "Sum of txns count across all maude client instances on this node is: "
echo $initial_txn_count
