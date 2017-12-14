import strutils,sequtils,tables

var t,b: seq[int] = @[]

for line in splitLines strip readFile"13.dat":
  let d = map(split(line,": "),parseInt)
  t.add d[0]
  b.add d[1]

proc v( x,y: int ): int =
  let n = 2*(x-1)
  return if y%%n<x-1: y%%n else: n-y%%n

var s = 0
for i,x in b:
  if v(x,t[i])==0: s+=x*t[i]
echo s

for k in 0..10000000:
  var g = true
  for i,x in b:
    if v(x,t[i]+k)==0:
      g = false; break
  if g: echo k; break
