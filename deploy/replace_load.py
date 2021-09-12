import sys
import re
import os

path = sys.argv[1]
ip = sys.argv[2]
port = int(sys.argv[3])
num = int(sys.argv[4])
key_mapping = sys.argv[5]

def parseLoad(FILE):
    pairs = []
    for line in open(FILE).readlines():
        line = line.replace("\n","")
        k,v = line.split(",")
        if v==ip:
            pairs.append((k, v))
    res1 =[]
    res2=[]
    for pair in pairs:
        res1.append("version(\"%s\",\"%s\", ts(dftOid,0),empty)" % (pair[0], "df"))
        res2.append("\"%s\" |-> ts(dftOid,0)" % pair[0])
    
    part1 = "( "+ "  ".join(res1) +" )" if len(res1)>0 else "empty"
    part2 = "( "+ ",  ".join(res2) +" )" if len(res2)>0 else "empty"
    return part1, part2

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
content = content.replace("$p2$", str(num))


res = parseLoad(key_mapping)

content = content.replace("$p3$", res[0])
content = content.replace("$p4$", res[1])

c = "createServerTcpSocket(socketManager, l(self), %s, 10)\n"
create = ""
for i in range(0, num):
    new_port = port+i
    create+=  c % new_port

content = content.replace("$p5$", create)

f = open(path,"w")
f.write(content)
f.close()

