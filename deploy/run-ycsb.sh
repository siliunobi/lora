#!/bin/bash
source config.sh

cd $YCSB_dir

if [ $# != 3 ]
then
	echo "Arguments needed: IP address, id of client, number of clients"
	exit 1
fi


ip=$1
client_id=$2
num_clients=$3
opcount=$4
iter=0
retn_val=0
	while [ "$iter" -lt "$num_clients" ]
	do 
		port=`expr $initial_port + $iter` 
		file=${maude_client_side}/init-client${client_id}_${iter}.maude
        python $script_base/replace_transactions.py $file $ip $tmp $key_mapping 
		iter=`expr $iter + 1`
	done
