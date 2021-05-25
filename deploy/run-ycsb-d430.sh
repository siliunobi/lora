cd /users/nobi/ramp/maude-ramp/contrib/YCSB
cp keyMappings.txt keyMappings_bak.bak
if [ $# != 5 ]
then
	echo "Arguments needed: IP address, initial port, number of clients, operation count, time to start"
	exit 1
fi

ip=$1
initial_port=$2
num_clients=$3
opcount=$4
sleep_time=$5
iter=0
bash ./ycsb_scripts/sleep_time.sh $sleep_time
retn_val=$?
if [ "$retn_val" == "0" ]
then 
	while [ "$iter" -lt "$num_clients" ]
	do 
		port=`expr $initial_port + $iter` 
		echo `expr $port`
		bin/ycsb run kaiju -p hosts=155.98.36.$ip:$port -p port=$port -P workloads/workloada -p operationcount=$opcount -p maxexecutiontime=30000 -p isolation_level=READ_ATOMIC -p read_atomic_algorithm=KEY_LIST -p threadcount=1 -p time=10000 -p valuesize=1 &
		iter=`expr $iter + 1`
	done
else
	echo "Couldn't run the YCSB client"
fi
