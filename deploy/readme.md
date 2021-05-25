Performing an experiment on an Emulab cluster:

- Prepare for the experiment:
  - use "	pick-size-type" as your profile
  - use d430 or any other machines available
  - run /users/nobi/setup.sh so that all dependencies are installed

On servers:
- login to a server node (e.g., node0)
- cd /users/nobi/ramp/maude-ramp/contrib/YCSB/ycsb_scripts
- the logs can be found at, e.g., /proj/Confluence/maude/debug_logs/temp/temp/server_logs0/maude_server0_logs.txt for server on node0

Under the hood:
1. ./load-ycsb.sh 155.98.36.123 155.98.36.63 155.98.36.66 155.98.36.128
2. ./replace_load.sh 155.98.36.123 0 9000 1  ---(ip, id, port, Maude instances)
   ./replace_load.sh 155.98.36.63  1 9000 1
3. ./run_server.sh 0 ---(id)
   ./run_server.sh 1
4. turn to client nodes   
5. ./kill_server.sh
   
On clients:
- login to a client node (e.g., node5)
- cd /users/nobi/ramp/maude-ramp/contrib/YCSB/ycsb_scripts

Under the hood:
1. ./run_client_all.sh 155.98.36.130 0 1 1000 00:00:00 00:01:00  ---(ip, id, Maude instances, txns, start-time, end-time)

Computing performance (e.g., throughput):
1. Login to any node and run: cd /users/nobi/ramp/maude-ramp/contrib/YCSB/ycsb_scripts
2. run compute_throughput.py 0 3

Note that
- the above command requires the initial and final client IDs. E.g., the above command refers to the case that the initial client ID is 0 and the final client ID is 1
- the above command will look at all the client instance log files generated and add up their txns to give a final count of txns completed by all maude client instances
