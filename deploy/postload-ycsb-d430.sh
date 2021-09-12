cd /users/nobi/ramp/maude-ramp/contrib/YCSB
cat keyMappings1* > keyMappings.txt

if [ $# != 3 ]
then
	echo "Arguments needed: IP address, initial postload port, number of clients"
	exit 1
fi

ip=$1
initial_port=$2
num_clients=$3
iter=0
while [ "$iter" -lt "$num_clients" ]
do
	port=`expr $initial_port + $iter`
	bin/ycsb load kaiju -p hosts=155.98.39.$ip:$port -p port=$port -P workloads/workloada -p operationcount=1 -p maxexecutiontime=30000 -p isolation_level=READ_ATOMIC -p read_atomic_algorithm=KEY_LIST -p time=10000 -p valuesize=1 -postload -s &
	iter=`expr $iter + 1`
done
