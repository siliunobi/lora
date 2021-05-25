#!/bin/bash
source config.sh

if [ $# != 1 ]
then
	echo "Arguments needed: server instance ID"
	exit 1
fi


cd $maude_server_side

server_id=$1

# Clean up server logs directory
rm -rf ${debug_log_dir}/server_logs"$server_id"
mkdir ${debug_log_dir}/server_logs"$server_id"

# Run server
nohup ../maude-binaries/alpha118/maude init-server$server_id.maude > ${debug_log_dir}/server_logs$server_id/maude_server${server_id}_logs.txt 2>&1 &
