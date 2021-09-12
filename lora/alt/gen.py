import sys
TOTAL=200
FILE=sys.argv[1]
OUT=sys.argv[2]
RC=int(sys.argv[3])
WC=TOTAL-RC
SERVERS=int(sys.argv[4])
KEYS=int(sys.argv[5])
DIST=sys.argv[6]
RO=int(sys.argv[7])
WO=int(sys.argv[8])

file1 = open(FILE)
s = file1.read()
file1.close()
s = s.replace("$1", str(RC))
s = s.replace("$2", str(WC))
s = s.replace("$3", str(SERVERS))
s = s.replace("$4", str(KEYS))
s = s.replace("$5", DIST)
s = s.replace("$6", str(RO))
s = s.replace("$7", str(WO))

file2 = open(OUT, "w")
file2.write(s)
file2.close()
