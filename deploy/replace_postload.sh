# To run: bash run_client5.sh 44 9910 3
#!/bin/bash
source config.sh

if [ $# != 3 ]
then 
	echo "Provide 3 arguments: (1) IP address, (4) client ID, (5) #instances"
	exit 1
fi

cd $maude_client_side
ip=$1
clientid=$2
instance_id=$3

path=init-client${clientid}_${instance_id}.maude
cp init-client-rola.maude.original $path

python ${script_base}/replace_postload.py $path $ip $instance_id ${key_mapping}

