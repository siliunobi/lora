#!/bin/bash
source config.sh


if [ $# != 3 ]
then
	echo "Arguments needed: IP address, initial client_id, number of clients"
	exit 1
fi


ip=$1
initial_port=9810
client_id=$2
num_clients=$3
iter=0
while [ "$iter" -lt "$num_clients" ]
do
	port=`expr $initial_port + $iter`
        cd $script_base
        ./replace_postload.sh $ip $client_id $iter         	
        iter=`expr $iter + 1`
done
