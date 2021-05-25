cd /users/nobi/ramp/maude-ramp/contrib/YCSB/maude-middleware/maude_client_side
if [ $# != 4 ]
then
	echo "Arguments needed: ClientID, #clients, initialPort, #backlog"
	exit 1 
fi

sed -i -- 's/numberOfServerSockets = [0-9]*/numberOfServerSockets = '$2'/g' client$1.maude
sed -i -- 's/backLog = [0-9]*/backLog = '$4'/g' client$1.maude
sed -i '/createServerTcpSocket/d' client$1.maude
sed -i '/Client | sent : 0, rcved : 0 >/d' client$1.maude
iter=-1
final_iter=`expr $2 - 1`
while [ "$final_iter" -gt "$iter" ]
do
	gawk -i inplace '/ServerShim/{print;print "\t    < l(self,'$final_iter') : Client | sent : 0, rcved : 0 >";next}1' client$1.maude
	final_iter=`expr $final_iter - 1`
done

port=`expr $3 + $2 - 1`
iter=-1
temp_iter=0
final_iter=`expr $2 - 1`
while [ "$final_iter" -gt "$iter" ]
do
	if [ $temp_iter -eq 0 ] 
	then
		gawk -i inplace '/createClientTcpSocket/{print;print "\t    createServerTcpSocket(socketManager, l(self,'$final_iter'), '$port', 5).";next}1' client$1.maude		
	else
		gawk -i inplace '/createClientTcpSocket/{print;print "\t    createServerTcpSocket(socketManager, l(self,'$final_iter'), '$port', 5)";next}1' client$1.maude
	fi

	port=`expr $port - 1`
	final_iter=`expr $final_iter - 1`
	temp_iter=`expr $temp_iter + 1`
done

#sed -i -- 's/addr1 = "155.98.38.[0-9]*/addr1 = "155.98.38.'$2'/g' client$1.maude
#../maude-binaries/maude.linux64 client2.maude > /run/shm/maude_client2_logs.txt
