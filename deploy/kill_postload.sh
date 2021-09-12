kill -9 $(ps aux | grep '[p]ostload-ycsb.sh' | awk '{print $2}')
kill -9 $(ps aux | grep '[p]ostload' | awk '{print $2}')
