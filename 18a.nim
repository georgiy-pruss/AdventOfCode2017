import strutils,sequtils,tables

var r = newTable[string,int]() # registers, incl. regs snd and rcv

proc rd( reg: string ): int = (if reg in r: r[reg] else: 0)
proc ov( op: string ): int = (if op.isAlphaAscii(): rd op else: op.parseInt)

let pgm = splitLines strip readFile "18.dat"

var pc = 0
while pc>=0 and pc<pgm.len:
  let o = pgm[pc].split()
  pc+=1
  let o1 = o[1]
  let o2 = if o.len>2: o[2] else: ""
  case o[0]:
  of "set": r[o1] = ov o2
  of "add": r[o1] = ov(o1) + ov o2
  of "mul": r[o1] = ov(o1) * ov o2
  of "mod": r[o1] = ov(o1) mod ov o2
  of "snd": r["snd"] = ov o1
  of "rcv":
    if ov(o1)!=0 and ov("rcv")==0: r["rcv"]=ov "snd"; break
  of "jgz":
    if ov(o1)>0: pc=pc-1+ov o2
  else: echo "? " & $o

echo rd("rcv") # rcv 1187
