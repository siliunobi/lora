import sys
import re
import os

PATH="/users/nobi/deneva/debug_logs"

if len(sys.argv) < 2:
    print("Usage: %s start end" % sys.argv[0])
    sys.exit()

total=0
start=int(sys.argv[1])
end=int(sys.argv[2])+1

for id in range(start, end):
    path = PATH+"/client_logs"+str(id)
    print("****client_logs%s******" % id)
    for f in os.listdir(path):
        content = open(path+"/"+f).read().replace("\n","")
        m = re.search(r'm\s+:\s+Monitor\s+\|\s+count\s+:\s+(\d+)', content)
        if m:
            num = int(m.group(1))
            print(num)
            total+=num
        else:
            print("Count not found")

print("**************")
print("total:%s" % total)
