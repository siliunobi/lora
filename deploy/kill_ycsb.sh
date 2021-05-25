#!/bin/bash
if [ $# != 1 ]
then
	echo "Arguments needed: time to start"
	exit 1
fi

sleep_time=$1

bash sleep_time.sh $sleep_time
retn_val=$?

if [ "$retn_val" == "0" ]
then
	echo "Killing"
	sh kill_client.sh
else
	echo "Couldn't kill YCSB client"
fi
