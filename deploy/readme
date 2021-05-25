All changes go into init-server.maude and init-client.maude respectively

Start emulab experiment
- Use "	pick-size-type" as your profile
- Use d430 or any other machines available
- Run /users/nobi/setup.sh so that all dependencies are installed

On server nodes:
- Login to server node (let's say node0)
- cd /users/nobi/ramp/maude-ramp/contrib/YCSB/ycsb_scripts
- The logs can be found at, e.g., /proj/Confluence/maude/debug_logs/temp/temp/server_logs0/maude_server0_logs.txt for server on node0

1. ./load-ycsb.sh 155.98.36.123 155.98.36.63 155.98.36.66 155.98.36.128
2. ./replace_load.sh 155.98.36.123 0 9000 1  ---(ip, id, port, instances)
   ./replace_load.sh 155.98.36.63  1 9000 1
3. ./run_server.sh 0 ---(id)
   ./run_server.sh 1
4. turn to client nodes   
5. ./kill_server.sh

Note that:
  - Server ID can be the same as emulab node ID on which you are running the server
  - Initial port is generally 9000 
  - Instances is the number of maude client instances to run on single node
  - The load config is available at /users/nobi/ramp/maude-ramp/contrib/YCSB/workloads/workloada_load
  The records to load are assigned to recordcount parameter. Keep that and txnlen parameters the same. 
  Note that this value also defines the key space for key generation in ycsb
   
On client nodes:
- Login to client node (let's say node5)
- cd /users/nobi/ramp/maude-ramp/contrib/YCSB/ycsb_scripts

4. ./run_client_all.sh 155.98.36.130 0 1 1000 00:00:00 00:01:00  ---(ip, id, instances, txns, start-time, end-time)
   ./run_client_all.sh 155.98.36.65  1 1 1000 00:00:00 00:01:00

Note that:
  - client ID typically starts from 0. Note that it need NOT be the same as emulab node ID
  - instances is number of client instances to create on node
  - The logs for the 1st client instance on 1st client node can be found at: /proj/Confluence/maude/debug_logs/temp/client_logs0/maude_client0_logs_0.txt
  Similarly logs for 2nd client instance on 2nd client node can be found at: /proj/Confluence/maude/debug_logs/temp/client_logs1/maude_client1_logs_1.txt
  and so on....

Computing throughput:
- Login to any node and run: cd /users/nobi/ramp/maude-ramp/contrib/YCSB/ycsb_scripts
- >> python compute_throughput.py 0 3
- The above command requires the initial and final client IDs. E.g., the above command refers to the case that the initial client ID is 0 and the final client ID is 1
- The above command will look at all the client instance log files generated and add up their txns to give a final count of txns completed by all maude client instances
