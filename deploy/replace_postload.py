import sys
import re

path = sys.argv[1]
ip = sys.argv[2]
id = sys.argv[3]
key_mapping=sys.argv[4]

def parseKeyMapping(FILE):
    res = []
    for line in open(FILE).readlines():
        line = line.replace("\n","")
        parts = line.split(",")
        res.append("\"%s\" |-> \"%s\"" % (parts[0], parts[1]))
    return "( "+ ", ".join(res) +" )"


def parsePostLoad(FILE):
    pairs = []
    for line in open(FILE).readlines():
        if not line.startswith("[beg]") or  not line.endswith("[sep]\n"):
	    continue
       	tmp = re.findall("(user\d+)\[eok\](.*?)\[eoa\]", line)
        pairs.extend(tmp)
    res=[]
    for pair in pairs:
        res.append("\"%s\" |-> \"%s\"" % (pair[0], pair[1]))
    return "( "+ ", ".join(res) +" )"

import os
def merge_files(path, ip):
    res = ""
    for name in os.listdir(path):
        if name.startswith(ip+"_"):
            res += open(path+"/"+name).read()
    f = open(path+"/"+ip, "w")
    f.write(res)
    f.close()


content = open(path).read()

content = content.replace("$p1$", ip)
content = content.replace("$p2$", id)

res = parseKeyMapping(key_mapping)

content = content.replace("$p3$", res)

f = open(path,"w")
f.write(content)
f.close()

