import os
import sys
import random
import re

folder=sys.argv[1]
out = sys.argv[2]
servers = sys.argv[3:]
num = len(servers)
print("There are %s servers" % num)

def is_ip(ip):
	try:
		parts = ip.split('.')
		return len(parts) == 4 and all(0 <= int(part) < 256 for part in parts)
	except ValueError:
		return False # one of the 'parts' not convertible to integer
	except (AttributeError, TypeError):
		return False # `ip` isn't even a string

def get_keys(FILE):
	processed = set()
	plist = list()
	keys = set()
	for line in open(FILE).readlines():
		if "[INFO] Transaction query is" not in line:
			continue
		line = line[28:]
		if "," not in line:
			continue
		
		if line in processed:
			break
		else:
			processed.add(line)
			plist.append(line)
		requests = [x.strip() for x in line.split(",")]
		for request in requests:
			if len(request)==0:
				continue
			if len(request.split(" ")) ==2:
				t, key = request.split(" ")
				keys.add(key)
	
	f = open(FILE+".tx", "w")
	for line in plist:
		f.write(line)
	f.close()

	return keys


keys_all=set()
for name in os.listdir(folder):
	if not is_ip(name):
		continue
	keys = get_keys(folder+"/"+name)
	keys_all = keys_all.union(keys)

res = list(keys_all)
random.shuffle(res)

f = open(out, "w")
index = 0
for key in res:
    f.write("%s,%s\n" % (key, servers[index]))
    index = (index+1)%num
f.close()
