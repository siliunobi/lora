# NOTE: This is called by kill_ycsb.sh. This is created as a separate
# file so we can do testing with load/postload and without running 
# txns
kill -USR1 $(ps aux | grep '[i]nit-client' | awk '{print $2}')
kill -9 $(ps aux | grep '[r]un_client.sh' | awk '{print $2}')
kill -9 $(ps aux | grep '[i]nit-client' | awk '{print $2}')
