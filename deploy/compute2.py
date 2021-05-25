import sys
import re
import os

FILE="/users/nobi/ramp/maude-ramp/contrib/YCSB/ycsb_scripts/logs/output"
MAPPING="/users/nobi/ramp/maude-ramp/contrib/YCSB/keyMappings.txt"

mappings = set()

count1=0
count2=0

for line in open(MAPPING).readlines():
    parts = line.split(",")
    mappings.add(parts[0])


for line in open(FILE).readlines():
    if "[beg]" in line and "[sep]" in line:
        count1+=1
	users = re.findall("user\d+", line)
	flag = True
	for user in users:
	    if user not in mappings:
		flag = False
                break
        if flag:
            count2+=1

print("%s\t%s" % (count1, count2))



