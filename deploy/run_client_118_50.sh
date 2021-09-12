# To run: bash run_client5.sh 44 9910 3
#!/bin/bash
cd /users/nobi/ramp/maude-ramp/contrib/YCSB/maude-middleware/maude_client_side
if [ $# != 5 ]
then 
	echo "Provide 5 arguments: (1) IP address, (2) initial post-load port, (3) initial_txn_port, (4) client ID, (5) #instances"
	exit 1
fi

ip=$1
initial_postload_port=$2
initial_txn_port=$3
clientid=$4
num_client_instances=$5
iter=0

# Empty log directory for clients before starting client processes
rm -rf /proj/Confluence/maude/debug_logs/temp/client_logs"$clientid"
mkdir /proj/Confluence/maude/debug_logs/temp/client_logs"$clientid"

while [ "$iter" -lt "$num_client_instances" ]
do
	postload_port=`expr $initial_postload_port + $iter`
	txn_port=`expr $initial_txn_port + $iter`
	cp init-client.maude init-client"$clientid"_"$iter".maude
	# sed -i -- 's/self = "155.98.39.[0-9]*/self = "155.98.39.'$ip'/g' init-client"$clientid"_"$iter".maude
	sed -i -- 's/self = "[0-9]*.[0-9]*.[0-9]*.[0-9]*"/self = "'$ip'"/g' init-client"$clientid"_"$iter".maude
	
	sed -i -- 's/[0-9]*, 10)    \*\*\* opened for post-load/'$postload_port', 10)    \*\*\* opened for post-load/g' init-client"$clientid"_"$iter".maude
	sed -i -- 's/[0-9]*, 10) .  \*\*\* opened for txns/'$txn_port', 10) .  \*\*\* opened for txns/g' init-client"$clientid"_"$iter".maude
	sed -i -- 's/clientId = [0-9]*/clientId = '$iter'/g' init-client"$clientid"_"$iter".maude	
	../maude-binaries/alpha118-50/maude init-client"$clientid"_"$iter".maude > /proj/Confluence/maude/debug_logs/temp/client_logs"$clientid"/maude_client"$clientid"_logs_"$iter".txt 2>&1 &
	sleep 1
	iter=`expr $iter + 1`
done
