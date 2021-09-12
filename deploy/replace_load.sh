#!/bin/bash
source config.sh


if [ $# != 4 ]
then
	echo "Arguments needed: IP address, server instance ID, inital port for maude clients, #maude clients per node"
	exit 1
fi

# Update the server IP address
cd $maude_server_side
path=init-server$2.maude
cp init-server-rola.maude.original $path

python ${script_base}/replace_load.py $path $1 $3 $4 ${key_mapping}

