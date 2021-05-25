#! /bin/bash
host=`hostname -s`
test_file=test.maude

for dist in `cat dist`
do
    for load in `cat load`
    do
        for key in `cat keys`
        do
	    conf="$load-$key-$dist-16-16"
           echo $conf
	    python gen.py test.maude.temp test.maude $load 25 $key  $dist 16 16
		echo `date`
	    java -jar ~/pvesta/pvesta-client.jar -l ~/pvesta/serverlist46 -m ${test_file} -f isCr.quatex -a 0.05 > ${host}-$conf.out 2>&1
	    result=`python result.py ${host}-$conf.out`
	    echo $conf $result
	    echo $conf $result >> result.out
        done
    done
done

for dist in `cat dist`
do
    for load in `cat load`
    do
        for key in `cat keys`
        do
	    conf="$load-$key-$dist-4-4"
            echo $conf
	    python gen.py test.maude.temp test.maude $load 25 $key  $dist 4 4
	    java -jar ~/pvesta/pvesta-client.jar -l ~/pvesta/serverlist46 -m ${test_file} -f isCr.quatex -a 0.05 > ${host}-$conf.out 2>&1
	    result=`python result.py ${host}-$conf.out`
	    echo $conf $result
	    echo $conf $result >> result.out
        done
    done
done

for dist in `cat dist`
do
    for load in `cat load`
    do
        for key in `cat keys`
        do
	    conf="$load-$key-$dist-8-8"
            echo $conf
	    python gen.py test.maude.temp test.maude $load 25 $key  $dist 8 8
	    java -jar ~/pvesta/pvesta-client.jar -l ~/pvesta/serverlist46 -m ${test_file} -f isCr.quatex -a 0.05 > ${host}-$conf.out 2>&1
	    result=`python result.py ${host}-$conf.out`
	    echo $conf $result
	    echo $conf $result >> result.out
        done
    done
done

for dist in `cat dist`
do
    for load in `cat load`
    do
        for key in `cat keys`
        do
	    conf="$load-$key-$dist-16-16"
            echo $conf
	    python gen.py test.maude.temp test.maude $load 25 $key  $dist 16 16
	    java -jar ~/pvesta/pvesta-client.jar -l ~/pvesta/serverlist46 -m ${test_file} -f isCr.quatex -a 0.05 > ${host}-$conf.out 2>&1
	    result=`python result.py ${host}-$conf.out`
	    echo $conf $result
	    echo $conf $result >> result.out
        done
    done
done

