#!/bin/bash
source config.sh

if [ $# != 3 ]
then
	echo "Arguments needed: client_id, #of instances, time_to_start"
	exit 1
fi


cd $maude_client_side

clientid=$1
num_client_instances=$2
sleep_time=$3
iter=0

# Empty log directory for clients before starting client processes
rm -rf ${debug_log_dir}/client_logs"$clientid"
mkdir ${debug_log_dir}/client_logs"$clientid"
bash ${script_base}/sleep_time.sh $sleep_time
retn_val=$?
if [ "$retn_val" -eq "0" ]
then 
	while [ "$iter" -lt "$num_client_instances" ]
	do
		echo "**********************************"
		../maude-binaries/alpha118/maude init-client"$clientid"_"$iter".maude > ${debug_log_dir}/client_logs"$clientid"/maude_client"$clientid"_logs_"$iter".txt 2>&1 &
		sleep 1
		iter=`expr $iter + 1`
	done	
else
	echo "Couldn't run the YCSB client"
fi
