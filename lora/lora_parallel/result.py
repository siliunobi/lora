import re
import sys
INPUT=sys.argv[1]
p= re.compile("Result: (.*)")
out = open(INPUT)

for line in out.readlines():
    m = p.search(line)
    if m:
        result = m.group(1)
	print result
