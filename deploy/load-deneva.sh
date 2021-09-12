#!/bin/bash
source config.sh

if [ $# -lt 1 ]
then
    echo "Arguments needed: IP address1, IP address2, ..."
    exit 1
fi


cd $deneva_dir
rm ${key_mapping}

python ${script_base}/generate_keymapping.py ${tmp} ${key_mapping} $@



 
