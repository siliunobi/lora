import sys
import re
import os
import random


path=sys.argv[1]
ip=sys.argv[2]
tmp=sys.argv[3]
MAPPING=sys.argv[4]

def all_keys_in_mapping(keys):
    for key in keys:
        if key not in mappings:
            return False
    return True

def parseTxns(FILE):
	txns = []
	lines = open(FILE).readlines()
	random.shuffle(lines)
	for line in lines:
		line = line.replace("\n","")
		requests = [x.strip() for x in line.split(",")]
		keys = []
		ops = []
		for request in requests:
			if len(request)==0:
				continue
			if len(request.split(" "))!=2:
				continue
			t, key = request.split(" ")	
			if t=="0":
				keys.append("read(\"%s\")" % key)
				ops.append(0)
			elif t=="1":
				keys.append("read(\"%s\") write(\"%s\",\"%s\")" % (key, key, "##"))
				ops.append(1)

		if sum(ops)==0 or sum(ops)==len(ops):
			txns.append(" ".join(keys))
	res = []
	for i in range(0, len(txns)):
		id = i+1
		r = "< tid(l(self,clientId),%s) : Txn | operations : %s, latest : empty, txnSqn : %s, readSet : nil >" % (id, txns[i], id)
		res.append(r)
	part1 = len(res)
	part2= "( "+" ;; ".join(res)+" )"
	return (part1, part2)

import os
def merge_files(path, ip):
    res = ""
    for name in os.listdir(path):
        if name.startswith(ip+"_"):
            res += open(path+"/"+name).read()
    f = open(path+"/"+ip, "w")
    f.write(res)
    f.close()

mappings = set()

for line in open(MAPPING).readlines():
    parts = line.split(",")
    mappings.add(parts[0])


content = open(path).read()
res = parseTxns(tmp+"/"+ip+".tx")

content = content.replace("$p4$", str(res[0]))
content = content.replace("$p5$", res[1])

f = open(path,"w")
f.write(content)
f.close()
