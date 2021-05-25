#!/bin/bash
source config.sh

if [ $# != 5 ]
then
        echo "Arguments needed: ip, client_id, #of instances,time_to_start, time_to_end"
        exit 1
fi

echo "postload"
./postload-client.sh $1 $2 $3

echo "run-ycsb"
./run-ycsb.sh $1 $2 $3

echo "run_client"
./run_client.sh $2 $3 $4 & 

echo "kill ycsb"
cd ${script_base}
./kill_ycsb.sh $5 &
